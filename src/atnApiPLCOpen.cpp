#include "atn.h"
#include "../includes/atnApi.h"
#include "../includes/Director.h"
#include <string>
#include <cstring>
#include <iostream>

using namespace atn;

extern Director *globalDirector;

UDINT subscribePLCOpen(plcstring* commandName, plcstring* moduleName, plcbit* value, AtnPlcOpenStatus *status){
	globalDirector->addCommandPLCOpen( std::string((char*)commandName), (char*)moduleName, value, status );
	return 0;
}

UDINT subscribePLCOpenWithParameters(plcstring* commandName, plcstring* moduleName, unsigned long* pParameters, unsigned long sParameters, plcbit* command,  struct AtnPlcOpenStatus* status){
	globalDirector->addCommandPLCOpen( std::string((char*)commandName), (char*)moduleName, command, status, pParameters, sParameters   );
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

	int i = 0;	
	State *command = (State *)inst->_command;;
	AtnPlcOpenCall* commandSrc;

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
			if(command){
				for( auto state : command->PLCOpenState ){
					if( state.pBypass && *state.pBypass ){
						continue;
					}
					if( state.pCommandSource ){
						commandSrc = *(AtnPlcOpenCall**) (state.pCommandSource);

						if( commandSrc != 0 && commandSrc != &inst->_call ){
							commandSrc->abort = 1;
						}		
					}
				}
			}
		
			inst->_state = ATN_PLCOPEN_FUB_WRITE_PAR;
		//No break	
		
		//Write any parameters that we need to write
		case ATN_PLCOPEN_FUB_WRITE_PAR:
			for( auto state : command->PLCOpenState ){
				if( state.pBypass && *state.pBypass ){
					continue;
				}
				state.writeParameters( 0, 0 );
				if( state.pFirstCycle ){
					*state.pFirstCycle = 1;
				}
				if( state.pCommandSource ){				
					*((AtnPlcOpenCall**)state.pCommandSource) = (AtnPlcOpenCall*)&(inst->_call);
				}
				if( state.pActiveCommand ){
					strcpy( state.pActiveCommand, inst->Command ); 
				}			
			}
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
			//Remove self from the source command
			if(command){
				for( auto state : command->PLCOpenState ){
					if( state.pBypass && *state.pBypass ){
						continue;
					}
					if( state.pCommandSource ){
						commandSrc = *(AtnPlcOpenCall**) (state.pCommandSource);

						if( commandSrc != 0 && commandSrc == &inst->_call ){
							*((AtnPLCOpen_typ**)state.pCommandSource) = 0;
							state.writeParameters(0,0);
						}		
					}
					if( state.pActiveCommand ){
						*state.pActiveCommand = 0;						
					}					
				}
			}
			
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

	int i = 0;	
	State *command = (State *)inst->_command;;
	AtnPlcOpenCall* commandSrc;

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
			if(command){
				for( auto state : command->PLCOpenState ){
					if( state.pBypass && *state.pBypass ){
						continue;
					}
					if( state.pCommandSource ){
						commandSrc = *(AtnPlcOpenCall**) (state.pCommandSource);

						if( commandSrc != 0 && commandSrc != &inst->_call ){
							commandSrc->abort = 1;
						}		
					}
				}
			}
			
			inst->_state = ATN_PLCOPEN_FUB_WRITE_PAR;
		//No break	
		
		//Write any parameters that we need to write
		case ATN_PLCOPEN_FUB_WRITE_PAR:
			for( auto state : command->PLCOpenState ){
				if( state.pBypass && *state.pBypass ){
					continue;
				}
				state.writeParameters( inst->pParameters, inst->sParameters );
				if( state.pFirstCycle ){
					*state.pFirstCycle = 1;
				}
				if( state.pCommandSource ){				
					*((AtnPlcOpenCall**)state.pCommandSource) = (AtnPlcOpenCall*)&(inst->_call);
				}
				if( state.pActiveCommand ){
					strcpy( state.pActiveCommand, inst->Command ); 
				}			
			}
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
			//Remove self from the source command
			if(command){
				for( auto state : command->PLCOpenState ){
					if( state.pBypass && *state.pBypass ){
						continue;
					}
					if( state.pCommandSource ){
						commandSrc = *(AtnPlcOpenCall**) (state.pCommandSource);

						if( commandSrc != 0 && commandSrc == &inst->_call ){
							*((AtnPLCOpen_typ**)state.pCommandSource) = 0;
							state.writeParameters(0,0);							
						}		
					}
					if( state.pActiveCommand ){
						*state.pActiveCommand = 0;						
					}
				}
			}
			
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
