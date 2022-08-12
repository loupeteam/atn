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

    this->inhibits.push_back( Inhibit(pParameters, sParameters, api) );

}

void State::subscribe(  std:: string ModuleName, bool* api ){

    this->inhibits.push_back( Inhibit( ModuleName, api) );

}

bool State::allTrue( bool fallback ){

    for( auto inhibit : this->inhibits ){
        if( inhibit.pCheck->moduleBypass){
            continue;
        }
        if( !inhibit.isTrue() ){
            return false;
        }
		//If we got here at least 1 was true
		fallback = true;
	}

    return fallback;
}

bool State::allFalse( bool fallback ){

    for( auto inhibit : this->inhibits ){
        if( inhibit.pCheck->moduleBypass){
            continue;
        }
        if( inhibit.isTrue() ){
            return false;
        }
		//If we got here, at least one was false
		fallback = true;
    }

    return fallback;
}

bool State::anyTrue( bool fallback ){
    
    for( auto inhibit : this->inhibits ){
        if( inhibit.pCheck->moduleBypass){
            continue;
        }
        if( inhibit.isTrue() ){
            return true;
        }
		//If we got here at least 1 was false
		fallback = false;
    }

    return fallback;
}

bool State::anyFalse( bool fallback ){
    
    for( auto inhibit : this->inhibits ){
        if( inhibit.pCheck->moduleBypass){
            continue;
        }
        if( !inhibit.isTrue() ){
            return true;
        }
		//If we got here at least 1 was true
		fallback = false;		
    }

    return fallback;
}

void State::print(){
    std::cout << "\nState Check: " << this->name << "\n";
    for( auto inhibit : this->inhibits ){
        inhibit.print();
    }
    std::cout << "\n";

}