/*
 * File: atnApiPLCOpen.cpp
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 * 
 */

#include "atn.h"
#include "./includes/atnApi.h"
#include "./includes/Director.h"
#include <string>
#include <cstring>
#include <iostream>

using namespace atn;

extern Director *globalDirector;
extern std::string atnCurrentTaskName();

/* AtnPLCOpenLocal reports this as a hard Error (independent of Fallback) when the
 * command bit matches no ATN registration - so an unwired or mistyped bit fails
 * loud instead of silently reporting Done. A local call owns only its own bit and
 * status; with neither registered there is nothing to command, complete, or abort. */
#define ERR_ATN_LOCAL_NOT_REGISTERED 50100

UDINT subscribePLCOpen(plcstring* commandName, plcstring* moduleName, plcbit* value, AtnPlcOpenStatus *status){
	globalDirector->addCommandPLCOpen( std::string((char*)commandName), (char*)moduleName, value, status, atnCurrentTaskName() );
	return 0;
}

UDINT subscribePLCOpenWithParameters(plcstring* commandName, plcstring* moduleName, unsigned long* pParameters, unsigned long sParameters, plcbit* command,  struct AtnPlcOpenStatus* status){
	globalDirector->addCommandPLCOpen( std::string((char*)commandName), (char*)moduleName, command, status, pParameters, sParameters, atnCurrentTaskName()   );
	return 0;
}

bool forCommandGetPLCOpenStatus(plcstring* state, signed short index, unsigned short *status){
	
	State *s = globalDirector->getCommand(std::string( (char*) state));

	if( s ){
		if( index < s->count() ){
			PLCOpen state = s->PLCOpenState.at(index);

			if( status ){
				*status = state.PLCOpenStatus();
			}
			return 1;
		}
		else{
			return 0;
		}
	}
	else{
		return 0;
	}

}

unsigned short PLCOpenStatus( const STRING *command, unsigned short fallback ){

	State *s = globalDirector->getCommand(std::string( (char*) command));

	if( s ){
		return s->getPLCOpenState( fallback );
	}
	else{
		return fallback;
	}
}


plcbit atnPLCOpenAbort(struct AtnPlcOpenStatus* status){
	
	if( !status ) return 0;

	AtnPlcOpenCall* commandSrc;
	
	//aborted if there is an active PLCOpen Command active
	if( !status->internal.trig ){
		commandSrc = (AtnPlcOpenCall*) (status->internal.fbk);

		if( commandSrc != 0 ){
			commandSrc->abort = 1;
		}		
		status->internal.fbk = 0;
		status->parametersWritten = false;
	}
	status->internal.trig = 0;

	return 1;
}

/* -------------------------------------------------------------------------
 * Shared per-follower steps for the PLCOpen caller FBs.
 *
 * A "command" here is a State whose PLCOpenState vector is the group of
 * followers the caller drives. AtnPLCOpen/AtnPLCOpenWithParameters resolve that
 * State by name (getCommand); AtnPLCOpenLocal resolves it by command bit
 * (resolveByBool). Everything downstream is identical and lives here so the two
 * resolution paths cannot drift. Arbitration between callers - local or remote -
 * runs through each follower's shared status: pCommandSource is &status.internal.fbk,
 * so whichever caller last claimed it owns the follower, and a newcomer aborts it.
 * ------------------------------------------------------------------------- */

/* pCommandSource points at status.internal.fbk, a UDINT that stores the owning
 * AtnPlcOpenCall as an integer (pointer-width on every SG4 target). Read/write it
 * as the integer it is and cast the value - punning it as AtnPlcOpenCall** would
 * break strict aliasing. This matches how atnPLCOpenAbort() reads the same field. */

//Abort whichever *other* caller currently owns each follower in the group.
static void plcopenAbortOthers( State* command, AtnPlcOpenCall* self ){
	if( !command ) return;
	for( auto& follower : command->PLCOpenState ){
		if( follower.pBypass && *follower.pBypass ){
			continue;
		}
		if( follower.pCommandSource ){
			AtnPlcOpenCall* owner = (AtnPlcOpenCall*)( *follower.pCommandSource );
			if( owner != 0 && owner != self ){
				owner->abort = 1;
			}
		}
	}
}

//Claim each follower for `self`, write parameters, and stamp the active command.
static void plcopenClaimAndWrite( State* command, AtnPlcOpenCall* self,
                                  void* pParameters, size_t sParameters, const char* activeName ){
	if( !command ) return;
	for( auto& follower : command->PLCOpenState ){
		if( follower.pBypass && *follower.pBypass ){
			continue;
		}
		follower.writeParameters( pParameters, sParameters );
		if( follower.pFirstCycle ){
			*follower.pFirstCycle = 1;
		}
		if( follower.pCommandSource ){
			*follower.pCommandSource = (unsigned long)self;
		}
		if( follower.pActiveCommand && activeName ){
			strcpy( follower.pActiveCommand, activeName );
		}
	}
}

//Release each follower that `self` still owns, clearing its command source.
static void plcopenRelease( State* command, AtnPlcOpenCall* self ){
	if( !command ) return;
	for( auto& follower : command->PLCOpenState ){
		if( follower.pBypass && *follower.pBypass ){
			continue;
		}
		if( follower.pCommandSource ){
			AtnPlcOpenCall* owner = (AtnPlcOpenCall*)( *follower.pCommandSource );
			if( owner != 0 && owner == self ){
				*follower.pCommandSource = 0;
				follower.writeParameters( 0, 0 );
			}
		}
		if( follower.pActiveCommand ){
			*follower.pActiveCommand = 0;
		}
	}
}

void AtnPLCOpen(AtnPLCOpen_typ* inst){

	//Capture edges
	if( !inst->Execute ){
		inst->_execute = false;
	}

	if( inst->Execute && !inst->_execute){
		inst->_execute = true;
		inst->_state = ATN_PLCOPEN_FUB_NEW_COMMAND;
	}

	State *command = (State *)inst->_command;

	outbuf buf( (char*)&(inst->StatusMessage) , sizeof(inst->StatusMessage) );
	std::ostream out( &buf );

	if( inst->_call.abort ){
		inst->_call.abort = 0;
		inst->_state = ATN_PLCOPEN_FUB_ABORTED;
	}

	switch (inst->_state)
	{
		//IDLE
		case ATN_PLCOPEN_FUB_IDLE:
			inst->Status = ERR_FUB_ENABLE_FALSE;
			inst->Busy = false;
			inst->Done = false;
			inst->Error = false;
			inst->Aborted = false;
			break;

		//Start a new command by getting it
		case ATN_PLCOPEN_FUB_NEW_COMMAND:
			inst->Status = ERR_FUB_BUSY;
			inst->Busy = true;
			inst->Done = false;
			inst->Error = false;
			inst->Aborted = false;
			inst->_command = (unsigned long)globalDirector->getCommand( inst->Command );
			if( inst->_command ){
				inst->_state = ATN_PLCOPEN_FUB_ABORT_OLD;
				command = (State *)inst->_command;
				//No break;
			}
			else{
				inst->_state = ATN_PLCOPEN_FUB_STATUS;
				inst->Status = inst->Fallback;
				break;
			}
			//No break;

		//Abort any commands that was active using the same PLCOpen state
		case ATN_PLCOPEN_FUB_ABORT_OLD:
			plcopenAbortOthers( command, &inst->_call );
			inst->_state = ATN_PLCOPEN_FUB_WRITE_PAR;
		//No break

		//Write any parameters that we need to write
		case ATN_PLCOPEN_FUB_WRITE_PAR:
			plcopenClaimAndWrite( command, &inst->_call, 0, 0, inst->Command );
			inst->_state = ATN_PLCOPEN_FUB_SET_COMMAND;
		//No break;

		//Start the command
		case ATN_PLCOPEN_FUB_SET_COMMAND:
			command->setTrue();
			inst->Busy = true;
			inst->_state = ATN_PLCOPEN_FUB_WORKING;
			// no break

		//Wait for the command to be finished
		case ATN_PLCOPEN_FUB_WORKING:
			inst->Busy = true;
			inst->Status = command->getPLCOpenState( inst->Fallback );
			buf.reset();
			command->plcopenReport( out );
			//No Break;

		//Read the status and update outputs
		case ATN_PLCOPEN_FUB_STATUS:
			if( inst->Status != ERR_FUB_BUSY ){
				inst->Busy = false;
				if( inst->Status == 0 ){
					inst->Done = true;
				}
				else{
					inst->Error = true;
				}
				inst->_state = ATN_PLCOPEN_FUB_CLEANUP;
				//No break
			}
			else{
				break;
			}
			//No break

		//cleanup
		case ATN_PLCOPEN_FUB_CLEANUP:
			plcopenRelease( command, &inst->_call );
			inst->_state = ATN_PLCOPEN_FUB_DONE;
			//Break to force at least 1 cycle with statuses
			break;
		//done
		case ATN_PLCOPEN_FUB_DONE:
			inst->_command = 0;

			if( !inst->Execute ){
				inst->_state = ATN_PLCOPEN_FUB_IDLE;
				inst->Status = ERR_FUB_ENABLE_FALSE;
				inst->Busy = false;
				inst->Done = false;
				inst->Error = false;
				inst->Aborted = false;
				buf.reset();
			}
			break;

		//aborted
		case ATN_PLCOPEN_FUB_ABORTED:
			inst->Status = ERR_OK;
			inst->Busy = false;
			inst->Done = false;
			inst->Error = false;
			inst->Aborted = true;
			inst->_command = 0;
			inst->_state = ATN_PLCOPEN_FUB_DONE;
			break;

	}
}

/* In-task PLCOpen caller: same handshake as AtnPLCOpen, but bound by command BIT
 * instead of by name. The follower's status struct is looked up from the ATN
 * registrations (resolveByBool), so the caller passes only the bit - a command
 * bit and a mismatched status can no longer be wired together. A bit registered
 * more than once resolves to the whole group. Because it claims the same
 * status.internal.fbk that remote callers use, local and remote calls cancel each
 * other automatically. Parameters, when needed, are shared in-task (both sides see
 * the same struct), so there is no WithParameters variant. */
void AtnPLCOpenLocal(AtnPLCOpenLocal_typ* inst){

	//Capture edges
	if( !inst->Execute ){
		inst->_execute = false;
	}

	if( inst->Execute && !inst->_execute){
		inst->_execute = true;
		inst->_state = ATN_PLCOPEN_FUB_NEW_COMMAND;
	}

	State *command = (State *)inst->_command;

	outbuf buf( (char*)&(inst->StatusMessage) , sizeof(inst->StatusMessage) );
	std::ostream out( &buf );

	if( inst->_call.abort ){
		inst->_call.abort = 0;
		inst->_state = ATN_PLCOPEN_FUB_ABORTED;
	}

	switch (inst->_state)
	{
		//IDLE
		case ATN_PLCOPEN_FUB_IDLE:
			inst->Status = ERR_FUB_ENABLE_FALSE;
			inst->Busy = false;
			inst->Done = false;
			inst->Error = false;
			inst->Aborted = false;
			break;

		//Start a new command by resolving the follower group bound to the bit
		case ATN_PLCOPEN_FUB_NEW_COMMAND:
			inst->Status = ERR_FUB_BUSY;
			inst->Busy = true;
			inst->Done = false;
			inst->Error = false;
			inst->Aborted = false;
			inst->_command = (unsigned long)globalDirector->resolveByBool( (bool*)inst->Command );
			if( inst->_command ){
				inst->_state = ATN_PLCOPEN_FUB_ABORT_OLD;
				command = (State *)inst->_command;
				//No break;
			}
			else{
				//Bit matches no registration -> fail loud (ignore Fallback): a local
				//call owns only its own bit+status, and neither is present here.
				inst->Status = ERR_ATN_LOCAL_NOT_REGISTERED;
				buf.reset();
				out << "AtnPLCOpenLocal: command bit is not registered";
				inst->_state = ATN_PLCOPEN_FUB_STATUS;
				break;
			}
			//No break;

		//Abort any commands that was active using the same PLCOpen state
		case ATN_PLCOPEN_FUB_ABORT_OLD:
			plcopenAbortOthers( command, &inst->_call );
			inst->_state = ATN_PLCOPEN_FUB_WRITE_PAR;
		//No break

		//Claim the followers (no parameter copy - shared in-task)
		case ATN_PLCOPEN_FUB_WRITE_PAR:
			plcopenClaimAndWrite( command, &inst->_call, 0, 0, "<local>" );
			inst->_state = ATN_PLCOPEN_FUB_SET_COMMAND;
		//No break;

		//Start the command
		case ATN_PLCOPEN_FUB_SET_COMMAND:
			command->setTrue();
			inst->Busy = true;
			inst->_state = ATN_PLCOPEN_FUB_WORKING;
			// no break

		//Wait for the command to be finished. No Fallback input: a resolved group
		//always has a follower, so the only use of a fallback is the all-bypassed
		//case, which reports 0 (Done) - a bypassed follower is nothing to wait on.
		case ATN_PLCOPEN_FUB_WORKING:
			inst->Busy = true;
			inst->Status = command->getPLCOpenState( 0 );
			buf.reset();
			command->plcopenReport( out );
			//No Break;

		//Read the status and update outputs
		case ATN_PLCOPEN_FUB_STATUS:
			if( inst->Status != ERR_FUB_BUSY ){
				inst->Busy = false;
				if( inst->Status == 0 ){
					inst->Done = true;
				}
				else{
					inst->Error = true;
				}
				inst->_state = ATN_PLCOPEN_FUB_CLEANUP;
				//No break
			}
			else{
				break;
			}
			//No break

		//cleanup
		case ATN_PLCOPEN_FUB_CLEANUP:
			plcopenRelease( command, &inst->_call );
			inst->_state = ATN_PLCOPEN_FUB_DONE;
			//Break to force at least 1 cycle with statuses
			break;
		//done
		case ATN_PLCOPEN_FUB_DONE:
			inst->_command = 0;

			if( !inst->Execute ){
				inst->_state = ATN_PLCOPEN_FUB_IDLE;
				inst->Status = ERR_FUB_ENABLE_FALSE;
				inst->Busy = false;
				inst->Done = false;
				inst->Error = false;
				inst->Aborted = false;
				buf.reset();
			}
			break;

		//aborted
		case ATN_PLCOPEN_FUB_ABORTED:
			inst->Status = ERR_OK;
			inst->Busy = false;
			inst->Done = false;
			inst->Error = false;
			inst->Aborted = true;
			inst->_command = 0;
			inst->_state = ATN_PLCOPEN_FUB_DONE;
			break;

	}
}

void AtnPLCOpenWithParameters(AtnPLCOpenWithParameters_typ* inst){

	//Capture edges
	if( !inst->Execute ){
		inst->_execute = false;
	}

	if( inst->Execute && !inst->_execute){
		inst->_execute = true;
		inst->_state = ATN_PLCOPEN_FUB_NEW_COMMAND;
	}

	State *command = (State *)inst->_command;

	outbuf buf( (char*)&(inst->StatusMessage) , sizeof(inst->StatusMessage) );
	std::ostream out( &buf );

	if( inst->_call.abort ){
		inst->_call.abort = 0;
		inst->_state = ATN_PLCOPEN_FUB_ABORTED;
	}

	switch (inst->_state)
	{
		//IDLE
		case ATN_PLCOPEN_FUB_IDLE:
			inst->Status = ERR_FUB_ENABLE_FALSE;
			inst->Busy = false;
			inst->Done = false;
			inst->Error = false;
			inst->Aborted = false;
			break;

		//Start a new command by getting it
		case ATN_PLCOPEN_FUB_NEW_COMMAND:
			inst->Status = ERR_FUB_BUSY;
			inst->Busy = true;
			inst->Done = false;
			inst->Error = false;
			inst->Aborted = false;
			inst->_command = (unsigned long)globalDirector->getCommand( inst->Command );
			if( inst->_command ){
				inst->_state = ATN_PLCOPEN_FUB_ABORT_OLD;
				command = (State *)inst->_command;
				//No break;
			}
			else{
				inst->_state = ATN_PLCOPEN_FUB_STATUS;
				inst->Status = inst->Fallback;
				break;
			}
		//No break;
		
		//Abort any commands that was active using the same PLCOpen state
		case ATN_PLCOPEN_FUB_ABORT_OLD:
			plcopenAbortOthers( command, &inst->_call );
			inst->_state = ATN_PLCOPEN_FUB_WRITE_PAR;
		//No break

		//Write any parameters that we need to write
		case ATN_PLCOPEN_FUB_WRITE_PAR:
			plcopenClaimAndWrite( command, &inst->_call, inst->pParameters, inst->sParameters, inst->Command );
			inst->_state = ATN_PLCOPEN_FUB_SET_COMMAND;
		//No break;

		//Start the command
		case ATN_PLCOPEN_FUB_SET_COMMAND:
			command->setTrue();
			inst->Busy = true;
			inst->_state = ATN_PLCOPEN_FUB_WORKING;
		// no break

		//Wait for the command to be finished
		case ATN_PLCOPEN_FUB_WORKING:
			inst->Busy = true;
			inst->Status = command->getPLCOpenState( inst->Fallback );
			buf.reset();
			command->plcopenReport( out );
		//No Break;

		//Read the status and update outputs
		case ATN_PLCOPEN_FUB_STATUS:
			if( inst->Status != ERR_FUB_BUSY ){
				inst->Busy = false;
				if( inst->Status == 0 ){
					inst->Done = true;
				}
				else{
					inst->Error = true;
				}
				inst->_state = ATN_PLCOPEN_FUB_CLEANUP;
				//No break
			}
			else{
				break;
			}
		//No break

		//cleanup
		case ATN_PLCOPEN_FUB_CLEANUP:
			plcopenRelease( command, &inst->_call );
			inst->_state = ATN_PLCOPEN_FUB_DONE;
			//Break to force at least 1 cycle with statuses
			break;
		//done
		case ATN_PLCOPEN_FUB_DONE:
			inst->_command = 0;

			if( !inst->Execute ){
				inst->_state = ATN_PLCOPEN_FUB_IDLE;
				inst->Status = ERR_FUB_ENABLE_FALSE;
				inst->Busy = false;
				inst->Done = false;
				inst->Error = false;
				inst->Aborted = false;
				buf.reset();
			}
			break;

		//aborted
		case ATN_PLCOPEN_FUB_ABORTED:
			inst->Status = ERR_OK;
			inst->Busy = false;
			inst->Done = false;
			inst->Error = false;
			inst->Aborted = true;
			inst->_command = 0;
			inst->_state = ATN_PLCOPEN_FUB_DONE;
			break;

	}
}
