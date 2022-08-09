#include <iostream>

#include "State.h"

using namespace atn;

State::State( std:: string name ){

    this->name = name;

}
State::~State(){};

void State::subscribe( AtnAPICheck_typ* api, void *_pParameters, size_t _sParameters ){

    this->inhibits.push_back( Inhibit(pParameters, sParameters, api) );

}

bool State::allTrue(){

    for( auto inhibit : this->inhibits ){
        if( inhibit.pCheck->moduleBypass){
            continue;
        }
        if( !inhibit.isTrue() ){
            return false;
        }
    }

    return true;
}

bool State::allFalse(){

    for( auto inhibit : this->inhibits ){
        if( inhibit.pCheck->moduleBypass){
            continue;
        }
        if( inhibit.isTrue() ){
            return false;
        }
    }

    return true;
}

bool State::anyTrue(){
    
    for( auto inhibit : this->inhibits ){
        if( inhibit.pCheck->moduleBypass){
            continue;
        }
        if( inhibit.isTrue() ){
            return true;
        }
    }

    return false;
}

bool State::anyFalse(){
    
    for( auto inhibit : this->inhibits ){
        if( inhibit.pCheck->moduleBypass){
            continue;
        }
        if( !inhibit.isTrue() ){
            return true;
        }
    }

    return false;
}

void State::print(){
    std::cout << "\nState Check: " << this->name << "\n";
    for( auto inhibit : this->inhibits ){
        inhibit.print();
    }
    std::cout << "\n";

}