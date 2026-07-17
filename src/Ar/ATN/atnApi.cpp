/*
 * File: atnApi.cpp
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

#ifndef _NOT_BR
#include <sys_lib.h>
#else
#include <sstream>
#include <thread>
#endif

using namespace atn;

unsigned int bur_heap_size = 0xFFFFFF;

Director *globalDirector = 0;

#ifdef _NOT_BR
// Host test hook: per-thread override of the reported task name, so a
// single-threaded unit test can simulate registrations from multiple tasks.
static std::string &hostTaskNameOverride(){
	static thread_local std::string name;
	return name;
}

void atnSetCurrentTaskName( const char *name ){
	hostTaskNameOverride() = name ? name : "";
}
#endif

// Returns the name of the task currently executing this call (AR sys_lib ST_name).
// Captured at registration so a task can later remove all of its own registrations by name.
// On the host test build (_NOT_BR) there is no task context; the calling thread stands in
// for the task, identified by its thread id unless overridden via atnSetCurrentTaskName().
std::string atnCurrentTaskName(){
#ifdef _NOT_BR
	if( !hostTaskNameOverride().empty() ){
		return hostTaskNameOverride();
	}
	std::ostringstream name;
	name << "thread-" << std::this_thread::get_id();
	return name.str();
#else
	char nameBuf[128] = {0};
	USINT grp = 0;
	ST_name( 0, nameBuf, &grp );
	return std::string( nameBuf );
#endif
}

outbuf::outbuf( char * data, size_t sz ) : _front(data), _current(data), _sz(sz)  {
	// track first reset after initialization
	hasBeenReset = false;
	// no buffering, overflow on every char
	setp(0, 0);
}
int outbuf::overflow(int_type c ) {
	// add the char to wherever you want it, for example:
		
	if(_current - _front > _sz){
		_current = _front;
		rolled = true;
	}

	switch(c){
		case '\n':
			if(_current - _front < _sz){
				(*_current) = 0;
			}
			_current = (char*) ((((((UDINT)_current - (UDINT)_front)/81)+1)*81) + (UDINT)_front);
			return c;
		default:
			(*_current) = c;
			_current++;
			break;			
	}
	return c;
}
void outbuf::reset(){
	if(rolled || !hasBeenReset){
		// clear whole buffer if overflowed or first reset after initialization
		rolled = false;
		hasBeenReset = true;
		memset( (void*)_front, 0, _sz );	
	}		
	else{
		memset( (void*)_front, 0, _current - _front );	
	}
	_current = _front;
}

bool oneShot( AtnAPI_typ *Behavior ){
	if( Behavior->response != Behavior->state ){
		Behavior->response = Behavior->state;
		return Behavior->state == ATN_EXECUTE;
	}
	return false;
}

bool oneShotReset( AtnAPI_typ *Behavior, bool *cmd ){
	if( Behavior->response != Behavior->state ){
		Behavior->response = Behavior->state;
		if( cmd ){
			Behavior->oneShot = true;
			*cmd = true;
		}
		return Behavior->state == ATN_EXECUTE;
	}
	if( Behavior->oneShot ){
		Behavior->oneShot = false;
		if( cmd ){
			*cmd = false;
		}        
	}
	return false;
}

bool oneShotStatus( AtnAPI_typ *Behavior, STRING *status){
	if( Behavior->response != Behavior->state ){
		Behavior->response = Behavior->state;
		strncpy( Behavior->moduleStatus, status, sizeof(Behavior->moduleStatus) );
		return Behavior->state == ATN_EXECUTE;
	}
	return false;
}

ATN_ST_enum respond( AtnAPI_typ *Behavior ){
	Behavior->response = Behavior->state;
	return Behavior->state;
}
static outbuf *obuf = 0;

void atnSetDirector( void *director ){
	globalDirector = (Director*)director;
}

unsigned long atninit( UDINT console, UDINT bufsize ){
	
	
	if( !globalDirector ){
		globalDirector = new Director();
	}

	if( console ){
		obuf = new outbuf( (char*)console, bufsize );		
		globalDirector->outstream = new std::ostream(obuf);
	}

	*globalDirector->outstream <<	"atn initialized\n";

	return (unsigned long)globalDirector;
}

unsigned long atncyclic( UDINT console, UDINT bufsize ){
	
	char *command = (char*) console;

	atn::State *state;
	std::ostream *outstream = globalDirector->outstream;
		
	obuf->reset();
	switch (command[0])
	{
		case '?':
			*outstream << "? for this help\n";
			*outstream << "\\[commandName] to run a command\n";
			*outstream << "=[commandName] to view a command status\n";
			*outstream << "/[actionName] to run an action\n";
			*outstream << "+[actionName] to view an action status\n";
			*outstream << "[statename] to view a state status\n";			
			break;
		case '\\':			
			command[0] = '=';
			globalDirector->executeCommand( &command[1] );
		case '=':
			state = globalDirector->getCommand( &command[1] );
			if( state ){
				state->plcopenReport( *outstream );
			}
			else{
				*outstream << "state "<< command << " Not found\n";
			}
			break;
		case '/':			
			command[0] = '+';
			globalDirector->executeAction( &command[1], 0, 0, 0);
		case '+':			
			globalDirector->printState( *outstream );
			break;
		default:
			state = globalDirector->getState( &command[0] );
			if( state ){
				state->print( *outstream );
			}
			else if( ( state = globalDirector->getValue( &command[0] ) ) ){
				state->printValue( *outstream );
			}
			else{
				*outstream << "state "<< command << " Not found\n";
				globalDirector->printCommands( *outstream );
				globalDirector->printStates( *outstream );
				globalDirector->printActions( *outstream );
				globalDirector->printValues( *outstream );
			}
			break;
	}


	globalDirector->cyclic();
	return (unsigned long)globalDirector;
}

void registerBehavior( const STRING *action, const STRING *moduleName, AtnAPI_typ *behavior, UDINT *_pParameters, UDINT _sParameters){
	if( behavior == 0 ){
		return;
	}
	strncpy( behavior->moduleName, (char*)moduleName, sizeof(behavior->moduleName) );

	globalDirector->addBehavior( std::string((char*)action), behavior, _pParameters, _sParameters, atnCurrentTaskName() );
}

void executeActionReport( const STRING *action, AtnApiStatusLocal_typ *api){
	globalDirector->executeAction( std::string((char*)action), &api->remote, 0, 0);
}

void executeAction( const STRING *action ){
	globalDirector->executeAction( std::string((char*)action), 0, 0, 0);
}

plcbit executeCommand( STRING *command ){
	return globalDirector->executeCommand( std::string((char*)command));
}

UDINT registerState(plcstring* state, plcstring* moduleName, struct AtnAPIState_typ* api){

	strncpy( api->moduleName, (char*)moduleName, sizeof(api->moduleName) );
	globalDirector->addState( std::string((char*)state), api, 0, 0, atnCurrentTaskName());
	return 0;
}
UDINT registerStateExt1(plcstring* state, plcstring* moduleName, plcstring* moduleStatus, unsigned long* pParameters, unsigned long sParameters, plcbit* moduleByPass, plcbit* active){
	globalDirector->addState( std::string((char*)state), std::string((char*)moduleName), moduleStatus, moduleByPass, active, pParameters, sParameters, atnCurrentTaskName());
	return 0;
}

UDINT registerStateBool(plcstring* state, plcstring* moduleName, plcbit* value){
	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, value, atnCurrentTaskName() );
	return 0;
}


UDINT registerStateBoolAdr(plcstring* state, plcstring* moduleName, plcbit* value){
	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, value, atnCurrentTaskName() );
	return 0;
}

UDINT registerToResource(plcstring* state, plcstring* moduleName, UDINT * pResourceUID, plcbit* value){
	globalDirector->addResourceBool( std::string((char*)state), (char*)moduleName, pResourceUID, value, atnCurrentTaskName() );
	return 0;
}

UDINT registerStateParameters( STRING *state, STRING *moduleName, UDINT * pParameters, UDINT sParameters){
	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, 0, pParameters, sParameters, atnCurrentTaskName());
	return 0;
}

UDINT registerValue( STRING *state, STRING *owner, UDINT * pData, UDINT sData, plcbit *valid, UDINT sReturn, UDINT returnTopic ){
	bool ok = globalDirector->addValue( std::string((char*)state), std::string((char*)owner), valid, pData, sData, sReturn, atnCurrentTaskName() );
	if( returnTopic != 0 ){
		char *out = (char*)returnTopic;
		if( ok && sReturn > 0 ){
			std::string derived = std::string((char*)state) + ATN_RETURN_TOPIC_SUFFIX;
			strncpy( out, derived.c_str(), 80 );
			out[80] = '\0';
		}
		else{
			out[0] = '\0';
		}
	}
	return ok ? 0 : 1;
}

UDINT unregister( STRING *name ){
	if( !globalDirector ){ return 0; }
	return globalDirector->removeRegistration( std::string((char*)name), atnCurrentTaskName() );
}

UDINT unregisterAll(){
	if( !globalDirector ){ return 0; }
	return globalDirector->removeAllForTask( atnCurrentTaskName() );
}

UDINT registerStateApiParameters( STRING *state, STRING *moduleName, AtnAPIState_typ *api, UDINT * pParameters, UDINT sParameters){

	if(api){
		strncpy( api->moduleName, (char*)moduleName, sizeof(api->moduleName) );
	}
	globalDirector->addState( std::string((char*)state), api, pParameters, sParameters, atnCurrentTaskName());
	return 0;
}
// bool registerStateBoolWithParameters( STRING *state, STRING *moduleName, AtnAPIState_typ *api, UDINT * pParameters, UDINT sParameters){
// 	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, 
// 	return 0;
// }

UDINT subscribeCommandBool(plcstring* state, plcstring* moduleName, plcbit* value){
	globalDirector->addCommandBool( std::string((char*)state), (char*)moduleName, value, atnCurrentTaskName() );
	return 0;
}

signed short stateCount( STRING* state ){
	State *s = globalDirector->getState(std::string( (char*) state ));
	if( s ){
		return s->count() - 1;
	}
	else{
		return -1;
	}
}

signed short commandCount( STRING* state ){
	State *s = globalDirector->getState(std::string( (char*) state ));
	if( s ){
		return s->count() - 1;
	}
	else{
		return -1;
	}
}
bool forState( STRING* state, signed short index, plcbit* active, unsigned long* pParameters, unsigned long sParameters){
	
	State *s = globalDirector->getState(std::string( (char*) state ));

	if( s ){
		if( index < s->count() ){
			PLCOpen state = s->PLCOpenState.at(index);
			if( active ){
				*active = state.isTrue();
			}
			if( pParameters && state.pParameters && sParameters == state.sParameters){
				memcpy(pParameters, state.pParameters, sParameters);				
			}
			else{
				if( pParameters ){
					memset( pParameters, 0, sParameters );
				}
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

bool forStateGetPointer(plcstring* state, signed short index, plcbit* active, unsigned long* pParameters, unsigned long* sParameters){
	
	State *s = globalDirector->getState(std::string( (char*) state));

	if( s ){
		if( index < s->count() ){
			PLCOpen state = s->PLCOpenState.at(index);
			if( active ){
				*active = state.isTrue();
			}

			if( pParameters != 0){
				if( state.pParameters ){
					*(UDINT**)pParameters = (UDINT*)state.pParameters;
				}
				else{
					*pParameters = 0;
				}
			}

			if( sParameters != 0){
				*sParameters = state.sParameters;
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

void readCallState( AtnApiStatusLocal_typ *status){
	if( status ){
		memcpy( status, &(status->remote), sizeof(AtnApiStatus_typ));
		if( status->remote.busy ){
			return;
		}
		memset( &(status->remote), 0, sizeof(AtnApiStatus_typ));
	}
}