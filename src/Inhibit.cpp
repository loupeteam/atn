#include <iostream>
#include "../Includes/Inhibit.h"

using namespace atn;

Inhibit::Inhibit( void * _pParameters, size_t _sParameter, struct AtnAPIState_typ* pCheck ){

    this->pParameters = _pParameters;
    this->sParameters = _sParameter;
    this->pCheck = pCheck;
    if( pCheck )
        this->pValue = & (pCheck->active);
        this->name = pCheck->moduleName;
}

Inhibit::Inhibit( std::string Name, bool * value){

    this->pValue = value;
    this->name = Name;
}

Inhibit::Inhibit( std::string Name, bool * value, void * _pParameters, size_t _sParameter){

    this->pValue = value;
    this->name = Name;
    this->pParameters = _pParameters;
    this->sParameters = _sParameter;

}

Inhibit::Inhibit( ){
	pParameters = 0;
	sParameters = 0;
	pCheck  = 0;
    pValue = 0;
};
Inhibit::~Inhibit( ){};

bool Inhibit::isTrue(){

    return *pValue;
    
}

bool Inhibit::set( bool value){
    
    if( pValue ){
        *pValue = value;
        return true;
    }
    return false;    
}


void Inhibit::print(){		
    std::cout << "Module: " << this->name << "\n";
    std::cout << "Value: " << (bool) *pValue << "\n";
}
