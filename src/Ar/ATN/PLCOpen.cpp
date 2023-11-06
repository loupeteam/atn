/*
 * File: PLCOpen.cpp
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 * 
 */

#include <iostream>
#include <cstring>
#include "../includes/PLCOpen.h"

using namespace atn;

PLCOpen::PLCOpen( struct AtnAPIState_typ* pCheck, void * _pParameters, size_t _sParameter ) : PLCOpen( ){

    this->pParameters = _pParameters;
    this->sParameters = _sParameter;
    if( pCheck ){
        this->pValue = &(pCheck->active);
		this->name = pCheck->moduleName;
		this->pBypass = &pCheck->moduleBypass;
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
	pParameterWritten = 0;	
	pParameters = 0;
	sParameters = 0;
	pBypass  = 0;
	pValue = 0;
	pStatusString = 0;
	pActiveCommand = 0;
	pStatus = 0;
	pFirstCycle = 0;
	pCommandSource = 0;	
	pResourceUser = 0;	
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
	out << "Module: " << this->name;
	if(pBypass && *pBypass){
		out << " | Bypassed\n";
		return;
	}
	if(pValue){
		out << " | Active: " << (bool) *pValue << "\n";
	}
	else{
		out << " | Active: None\n";
	}
	if( pStatusString ){
		out << "- Status: " << this->pStatusString << "\n";
	}
	if( pParameters ){
		out << "- ParameterSize: " << sParameters << "\n";		
	}
}
