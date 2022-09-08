#include <iostream>
#include <cstring>
#include "../includes/PLCOpen.h"

using namespace atn;

PLCOpen::PLCOpen( struct AtnAPIState_typ* pCheck, void * _pParameters, size_t _sParameter ) : PLCOpen( ){

    this->pParameters = _pParameters;
    this->sParameters = _sParameter;
    this->pCheck = pCheck;
    if( pCheck ){
        this->pValue = &(pCheck->active);
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
	pFirstCycle = 0;
};
PLCOpen::~PLCOpen( ){


};

bool PLCOpen::isTrue(){

	if(pValue){
		return *pValue;
	}
	else{
		return 0;
	}
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

void PLCOpen::writeParameters( void *pParameters, size_t sParameters){
	if( pParameters && this->pParameters && sParameters == this->sParameters){
		std::memcpy(this->pParameters, pParameters, this->sParameters);
		if( this->pParameterWritten ){
			*this->pParameterWritten = 1;
		}
	}
	else{
		if( this->pParameterWritten ){
			*this->pParameterWritten = 0;
		}
	}
}

void PLCOpen::print( std::ostream &out ){		
   	out << "Module: " << this->name << "\n";
	if(pValue){
		out << "Active: " << (bool) *pValue << "\n";
	}
	else{
		out << "Active: None\n";
	}
	if( pParameters ){
		out << "ParameterSize: " << sParameters << "\n";		
	}
}
