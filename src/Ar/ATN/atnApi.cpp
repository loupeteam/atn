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

using namespace atn;

unsigned int bur_heap_size = 0xFFFFFF;

Director *globalDirector = 0;

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
		default:
			state = globalDirector->getState( &command[0] );
			if( state ){
				state->print( *outstream );
			}
			else{
				*outstream << "state "<< command << " Not found\n";
				globalDirector->printCommands( *outstream );
				globalDirector->printStates( *outstream );
			}
			break;
	}

	return (unsigned long)globalDirector;
}

plcbit executeCommand( STRING *command ){
	return globalDirector->executeCommand( std::string((char*)command));
}

UDINT registerState(plcstring* state, plcstring* moduleName, struct AtnAPIState_typ* api){

	strncpy( api->moduleName, (char*)moduleName, sizeof(api->moduleName) );
	globalDirector->addState( std::string((char*)state), api, 0, 0);
	return 0;
}
UDINT registerStateExt1(plcstring* state, plcstring* moduleName, plcstring* moduleStatus, unsigned long* pParameters, unsigned long sParameters, plcbit* moduleByPass, plcbit* active){
	globalDirector->addState( std::string((char*)state), std::string((char*)moduleName), moduleStatus, moduleByPass, active, pParameters, sParameters);
	return 0;
}

UDINT registerStateBool(plcstring* state, plcstring* moduleName, plcbit* value){
	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, value );
	return 0;
}


UDINT registerStateBoolAdr(plcstring* state, plcstring* moduleName, plcbit* value){
	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, value );
	return 0;
}

UDINT registerToResource(plcstring* state, plcstring* moduleName, UDINT * pResourceUID, plcbit* value){
	globalDirector->addResourceBool( std::string((char*)state), (char*)moduleName, pResourceUID, value );
	return 0;
}

UDINT registerStateParameters( STRING *state, STRING *moduleName, UDINT * pParameters, UDINT sParameters){
	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, 0, pParameters, sParameters);
	return 0;
}

UDINT registerStateApiParameters( STRING *state, STRING *moduleName, AtnAPIState_typ *api, UDINT * pParameters, UDINT sParameters){

	if(api){
		strncpy( api->moduleName, (char*)moduleName, sizeof(api->moduleName) );
	}
	globalDirector->addState( std::string((char*)state), api, pParameters, sParameters);
	return 0;
}

UDINT subscribeCommandBool(plcstring* state, plcstring* moduleName, plcbit* value){
	globalDirector->addCommandBool( std::string((char*)state), (char*)moduleName, value );
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
