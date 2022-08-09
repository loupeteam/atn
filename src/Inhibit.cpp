#include <iostream>
#include "Inhibit.h"

using namespace atn;

Inhibit::Inhibit( void * pParameters, size_t sParameter, struct AtnAPIState_typ* pCheck ){

    this->pParameters = pParameters;
    this->sParameters = sParameter;
    this->pCheck = pCheck;

}
Inhibit::Inhibit( ){};
Inhibit::~Inhibit( ){};

bool Inhibit::isTrue(){

    return this->pCheck->active;
    
}

void Inhibit::print(){
    std::cout << "Module: " << this->pCheck->moduleName << "\n";
    std::cout << "Value: " << this->pCheck->active << "\n";
}
