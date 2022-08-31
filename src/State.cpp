#include <iostream>

#include "../Includes/State.h"

using namespace atn;

State::State( std:: string name ){

    this->name = name;
	pStatus = 0;
	pParameters = 0;
	sParameters = 0;

}
State::~State(){};


void State::subscribe( AtnAPIState_typ* api, void *_pParameters, size_t _sParameters ){

    PLCOpen state;
    state.pParameters = _pParameters;
    state.sParameters = _sParameters;
    state.pCheck =  api;
    if( api ){
        state.name = api->moduleName;
        state.pValue = &(api->active);
    }

    this->PLCOpenState.push_back( state );
}

void State::subscribe(  const std:: string ModuleName, bool* value ){
    PLCOpen state;
    state.name = ModuleName;
    state.pValue = value;

    this->PLCOpenState.push_back( state );
}

void State::subscribe(  const std:: string ModuleName, bool* value, void *_pParameters, size_t _sParameters ){

    PLCOpen state;
    state.name = ModuleName;
    state.pValue = value;
    state.pParameters = _pParameters;
    state.sParameters = _sParameters;

    this->PLCOpenState.push_back( state );
}

void State::subscribe(  const std:: string ModuleName,  plcbit* command, AtnPlcOpenStatus *status ){

    PLCOpen state;
    state.name = ModuleName;
    state.pValue = command;
    state.pStatus = &(status->status);
	state.pCommandSource = &(status->internal.fbk);
	state.pFirstCycle = &(status->internal.trig);
	this->PLCOpenState.push_back( state );
}

bool State::allTrue( bool fallback ){

    for( auto state : this->PLCOpenState ){
        if( state.pCheck && state.pCheck->moduleBypass){
            continue;
        }
        if( !state.isTrue() ){
            return false;
        }
		//If we got here at least 1 was true
		fallback = true;
	}

    return fallback;
}

bool State::allFalse( bool fallback ){

    for( auto state : this->PLCOpenState ){
        if( state.pCheck && state.pCheck->moduleBypass){
            continue;
        }
        if( state.isTrue() ){
            return false;
        }
		//If we got here, at least one was false
		fallback = true;
    }

    return fallback;
}

bool State::anyTrue( bool fallback ){
    
    for( auto state : this->PLCOpenState ){
        if( state.pCheck && state.pCheck->moduleBypass){
            continue;
        }
        if( state.isTrue() ){
            return true;
        }
		//If we got here at least 1 was false
		fallback = false;
    }

    return fallback;
}

bool State::anyFalse( bool fallback ){
    
    for( auto state : this->PLCOpenState ){
        if( state.pCheck && state.pCheck->moduleBypass){
            continue;
        }
        if( !state.isTrue() ){
            return true;
        }
		//If we got here at least 1 was true
		fallback = false;		
    }

    return fallback;
}

bool State::setTrue(){
    bool set = 0;
    for( auto state : this->PLCOpenState ){
        if( state.pCheck && state.pCheck->moduleBypass){
            continue;
        }
        state.set(true);
        set = true;
    }
    return set;
}

bool State::setFalse(){
    bool set = 0;
    for( auto state : this->PLCOpenState ){
        if( state.pCheck && state.pCheck->moduleBypass){
            continue;
        }
        state.set(false);
        set = true;
    }
    return set;
}

unsigned short State::getPLCOpenState( unsigned short fallback){

    //We need an internal group status to default to 0 because fallback may not be zero.
    // That means we couldn't detect a non-zero
    unsigned short groupStatus  = 0;

    for( auto state : this->PLCOpenState ){
        if( (state.pCheck && state.pCheck->moduleBypass) || !state.pStatus ){
            continue;
        }
        //Figure out the group status.
        // Priority:
        //  1. Error
        //  2. Busy
        //  3. Not Enabled
        //  4. OK

        unsigned short plcopenstatus  = *(state.pStatus);
        switch ( plcopenstatus )
        {
            //Done
            case 0:                
                //Do nothing, default is done
                break;

            //Busy overrides not enabled and done
            case 65535:
                if( groupStatus == 0 || groupStatus == 65534){
                    groupStatus = plcopenstatus;
                }
                break;        

            //Not enabled overrides done
            case 65534:
                if( groupStatus == 0){
                    groupStatus = plcopenstatus;
                }
                break;        

            //Error overrides all others. We can only report 1 error
            default:
                groupStatus = plcopenstatus;
                break;
        }

        fallback = groupStatus;
	}

    return fallback;
       
}

unsigned int State::count(){
    return this->PLCOpenState.size();
}

void State::print( std::ostream &outbuf){
    outbuf << "\nState Check: " << this->name << "\n";
    for( auto state : this->PLCOpenState ){
        state.print( outbuf );
    }
    outbuf << "\n";

}

void State::plcopenReport( std::ostream &outbuf){

	for( auto state : this->PLCOpenState ){
		if( (state.pCheck && state.pCheck->moduleBypass) || !state.pStatus ){
			continue;
		}
		outbuf << state.name << " : " << *(state.pStatus);
	}
	
}
