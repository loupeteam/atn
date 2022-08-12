#include <iostream>
#include "../Includes/Inhibit.h"

using namespace atn;

Inhibit::Inhibit( void * pParameters, size_t sParameter, struct AtnAPIState_typ* pCheck ){

    this->pParameters = pParameters;
    this->sParameters = sParameter;
    this->pCheck = pCheck;
    if( pCheck )
        this->pValue = & (pCheck->active);
        this->name = pCheck->moduleName;
}
Inhibit::Inhibit( std::string Name, bool * value){

    this->pValue = value;
    this->name = Name;
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

void Inhibit::print(){		
    std::cout << "Module: " << this->name << "\n";
    std::cout << "Value: " << (bool) *pValue << "\n";
}
