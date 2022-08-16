#include <iostream>
#include "../includes/PLCOpen.h"

using namespace atn;

PLCOpen::PLCOpen( struct AtnAPIState_typ* pCheck, void * _pParameters, size_t _sParameter ) : PLCOpen( ){

    this->pParameters = _pParameters;
    this->sParameters = _sParameter;
    this->pCheck = pCheck;
    if( pCheck ){
        this->pValue = & (pCheck->active);
        this->name = pCheck->moduleName;
    }
}

PLCOpen::PLCOpen( std::string Name, bool * value) : PLCOpen( ){

    this->pValue = value;
    this->name = Name;
}

PLCOpen::PLCOpen( std::string Name, bool * value, void * _pParameters, size_t _sParameter) : PLCOpen( ) {

    this->pValue = value;
    this->name = Name;
    this->pParameters = _pParameters;
    this->sParameters = _sParameter;

}

PLCOpen::PLCOpen( ){
	pParameters = 0;
	sParameters = 0;
	pCheck  = 0;
    pValue = 0;
    pStatus = 0;
};
PLCOpen::~PLCOpen( ){


};

bool PLCOpen::isTrue(){

    return *pValue;
    
}

bool PLCOpen::set( bool value){

    if( value == true ){
        setBusyStatus();
    }
    else{
        setDisableStatus();
    }

    if( pValue ){
        *pValue = value;
        return true;
    }
    return false;    
}

void PLCOpen::setDisableStatus(){
    if( pStatus ){
        *pStatus = 65534;
    }
}

void PLCOpen::setBusyStatus(){
    if( pStatus ){
        *pStatus = 65535;
    }    
}

unsigned short PLCOpen::PLCOpenStatus(){
    if( pStatus ){
        return *pStatus;
    }    
    else{
        return 0;
    }
}

void PLCOpen::print(){		
    std::cout << "Module: " << this->name << "\n";
    std::cout << "Value: " << (bool) *pValue << "\n";
}
