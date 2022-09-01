#include "atn.h"
#include "../includes/atnApi.h"
#include "../includes/Director.h"
#include <string>
#include <cstring>
#include <iostream>

using namespace atn;

Director *globalDirector = 0;

outbuf::outbuf( char * data, size_t sz ) : _front(data), _current(data), _sz(sz)  {
	// no buffering, overflow on every char
	setp(0, 0);
}
int outbuf::overflow(int_type c ) {
	// add the char to wherever you want it, for example:
		
	if(_current - _front > _sz){
		_current = _front;
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
	memset( (void*)_front, 0, _sz );	
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
			else{
				*outstream << "state "<< command << " Not found\n";
				globalDirector->printCommands( *outstream );
				globalDirector->printStates( *outstream );
				globalDirector->printActions( *outstream );
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

	globalDirector->addBehavior( std::string((char*)action), behavior, _pParameters, _sParameters );
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

plcbit registerState(plcstring* state, plcstring* moduleName, struct AtnAPIState_typ* api){

	strncpy( api->moduleName, (char*)moduleName, sizeof(api->moduleName) );
	globalDirector->addState( std::string((char*)state), api, 0, 0);
	return 0;
}

plcbit registerStateBool(plcstring* state, plcstring* moduleName, plcbit* value){
	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, value );
	return 0;
}

plcbit registerStateBoolAdr(plcstring* state, plcstring* moduleName, plcbit* value){
	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, value );
	return 0;
}

bool registerStateParameters( STRING *state, STRING *moduleName, UDINT * pParameters, UDINT sParameters){
	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, 0, pParameters, sParameters);
	return 0;
}

bool registerStateApiParameters( STRING *state, STRING *moduleName, AtnAPIState_typ *api, UDINT * pParameters, UDINT sParameters){

	if(api){
		strncpy( api->moduleName, (char*)moduleName, sizeof(api->moduleName) );
	}
	globalDirector->addState( std::string((char*)state), api, pParameters, sParameters);
	return 0;
}

// bool registerStateBoolWithParameters( STRING *state, STRING *moduleName, AtnAPIState_typ *api, UDINT * pParameters, UDINT sParameters){
// 	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, 
// 	return 0;
// }

plcbit subscribeCommandBool(plcstring* state, plcstring* moduleName, plcbit* value){
	globalDirector->addCommandBool( std::string((char*)state), (char*)moduleName, value );
	return 0;
}


bool stateAllTrue( STRING *state, bool fallback ){
	State *s = globalDirector->getState(std::string((char*)state));
	if( s ){
		return s->allTrue( fallback );
	}
	else{
		return fallback;
	}
}

bool stateAnyTrue( STRING *state, bool fallback ){
	State *s = globalDirector->getState(std::string((char*)state));
	if( s ){
		return s->anyTrue( fallback );
	}
	else{
		return fallback;
	}
}

bool stateAllFalse( STRING *state, bool fallback ){
	State *s = globalDirector->getState(std::string((char*)state));
	if( s ){
		return s->allFalse( fallback );
	}
	else{
		return fallback;
	}
}

bool stateAnyFalse( STRING *state, bool fallback ){
	State *s = globalDirector->getState(std::string((char*)state));
	if( s ){
		return s->anyFalse( fallback );
	}
	else{
		return fallback;
	}
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