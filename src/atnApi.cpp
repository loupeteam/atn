#include "atn.h"
#include "../includes/atnApi.h"
#include "../includes/Director.h"
#include <string>
#include <cstring>
#include <iostream>

using namespace atn;

static Director *globalDirector = 0;

class outbuf : public std::streambuf {
	private:
	char * _front;
	char * _current;
	size_t _sz;
	public:
	outbuf( char * data, size_t sz ) : _front(data), _current(data), _sz(sz)  {
		// no buffering, overflow on every char
		setp(0, 0);
	}

	virtual int_type overflow(int_type c = traits_type::eof()) {
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
	void reset(){
		memset( (void*)_front, 0, _sz );	
		_current = _front;
	}
};

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
static outbuf *outstream = 0;

unsigned long atninit( UDINT console, UDINT bufsize ){
	
	if( console ){
		outstream = new outbuf( (char*)console, bufsize );
		std::streambuf *sb = std::cout.rdbuf( outstream );
	}
	
	if( !globalDirector ){
		globalDirector = new Director();
	}

	std::cout <<	"atn initialized\n";

	return (unsigned long)globalDirector;
}

unsigned long atncyclic( UDINT console, UDINT bufsize ){
	
	char *command = (char*) console;

	atn::State *state;
	
	outstream->reset();
	switch (command[0])
	{
		case '?':
			std::cout << "? for this help\n";
			std::cout << "/[actionName] to run an action\n";
			std::cout << "+[actionName] to view an action status\n";
			std::cout << "[statename] to view a state status\n";			
			break;
		case '/':			
			command[0] = '+';
			globalDirector->executeAction( &command[1], 0, 0, 0);
		case '+':			
			globalDirector->printState();
			break;
		default:
			state = globalDirector->getState( &command[0] );
			if( state ){
				state->print();
			}
			else{
				std::cout << "state "<< command << " Not found";
				globalDirector->printActions();
				globalDirector->printStates();
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

plcbit registerState(plcstring* state, plcstring* moduleName, struct AtnAPIState_typ* api){

	strncpy( api->moduleName, (char*)moduleName, sizeof(api->moduleName) );
	globalDirector->addState( std::string((char*)state), api, 0, 0);
	return 0;
}

plcbit registerStateBool(plcstring* state, plcstring* moduleName, plcbit* value){
	globalDirector->addStateBool( std::string((char*)state), (char*)moduleName, value );
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

void readCallState( AtnApiStatusLocal_typ *status){
	if( status ){
		memcpy( status, &(status->remote), sizeof(AtnApiStatus_typ));
		if( status->remote.busy ){
			return;
		}
		memset( &(status->remote), 0, sizeof(AtnApiStatus_typ));
	}
}