#include "atnApi.h"
#include "Director.h"
#include <string>

using namespace atn;

static Director *globalDirector;

bool oneShot( AtnAPI_typ *Behavior ){
    if( Behavior->response != Behavior->state ){
        Behavior->response = Behavior->state;
        return Behavior->state == ATN_EXECUTE;
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
void atncyclic( void * director ){
    globalDirector = (Director *)director;
    globalDirector->cyclic();

}

void registerBehavior( const STRING *action, const STRING *moduleName, AtnAPI_typ *behavior, UDINT *_pParameters, UDINT _sParameters){
    if( behavior == 0 ){
        return;
    }
    strncpy( behavior->moduleName, (char*)moduleName, sizeof(behavior->moduleName) );

    globalDirector->addBehavior( std::string((char*)action), behavior, _pParameters, _sParameters );
}

void executeAction( const STRING *action ){
    globalDirector->executeAction( std::string((char*)action), 0, 0, 0);
}

void registerState( const STRING *state, const STRING *moduleName, AtnAPICheck_typ *api, UDINT *_pParameters, UDINT _sParameters){

    strncpy( api->moduleName, (char*)moduleName, sizeof(api->moduleName) );
    globalDirector->addState( std::string((char*)state), api, _pParameters, _sParameters);
}

bool stateAllTrue( const STRING *state, bool fallback ){
    State *s = globalDirector->getState(std::string((char*)state));
    if( s ){
        return s->allTrue();
    }
    else{
        return fallback;
    }
}