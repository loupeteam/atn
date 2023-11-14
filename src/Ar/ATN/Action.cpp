/*
 * File: Action.cpp
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 * 
 */

#include <iostream>
#include "../includes/Action.h"
//#include "atn.h"

using namespace atn;

Action::Action( std::string name ) : name(name)
{

}

Action::~Action()
{

}

void Action::subscribe( AtnAPI_typ* api, void *_pParameters, size_t _sParameters ){

    for( auto behavior : this->behaviors ){
        if( behavior.pAction == api ){
            throw "action added twice to same behavior";
        }        
    }

    this->behaviors.push_back( Behavior(pParameters, sParameters, api) );

}

void Action::start( ){
    
    if( isReady() ){
        updateState( ATN_EXECUTE );
    }
    else{
        actionState = ATN_WAITING;
    }
    updateStatus( actionState );
}

void Action::updateStatus( ATN_ST_enum state ){
    if( pStatus == 0 ){
        return;        
    }

    pStatus->aborted = 0;
    pStatus->active = 0;
    pStatus->busy = 0;
    pStatus->done = 0;
    pStatus->error = 0;

    switch (state)
    {
        case ATN_IDLE:

        break;
        case ATN_ABORT:
            pStatus->aborted = true;
        break;
        case ATN_ERROR:
            pStatus->error = true;
        break;
        // case ATN_:
        case ATN_EXECUTE:
            pStatus->active = true;
            pStatus->busy = true;
            break;
        case ATN_WAITING:
            pStatus->busy = true;
        break;
        case ATN_DONE:
            pStatus->done = true;
        case ATN_BYPASSED:
        break;
    }
}

void Action::start( AtnApiStatus_typ* _pStatus, void *_pParameters, size_t _sParameters){

    pStatus = _pStatus;
    pParameters = _pParameters;
    sParameters = _sParameters;

    start();
}

bool Action::update(){
        if( actionState != ATN_WAITING ){
            ATN_RESPONSE_ST state = checkState( this->actionState );

            switch (state)
            {
                case ATN_RESPONSE_ST_NEXT_STEP:
                case ATN_RESPONSE_ST_STEP_DONE:
                    updateSubstate( ATN_IDLE );
                    break;
                case ATN_RESPONSE_ST_STATE_DONE:
                    updateState( ATN_IDLE );
                    release();
                    updateStatus( ATN_DONE );
                    //We are done..
                    return 1;
                    break;
                case ATN_RESPONSE_ST_ERROR:
                    updateState( ATN_ABORT );
                    updateStatus( ATN_ERROR );
                    break;
                case ATN_RESPONSE_ST_BUSY:
                case ATN_RESPONSE_ST_NONE:
                    /* code */
                    break;        
            }
        }
        else{
            start();
        }
        //We have more work to do
        return 0;

}

bool Action::isReady(  ){

    ATN_RESPONSE_ST state = ATN_RESPONSE_ST_STATE_DONE;

    for ( Behavior it : this->behaviors ){
        if( it.pAction->state != ATN_IDLE ){
            return false;
        }
    }
    return true;
}

ATN_RESPONSE_ST Action::checkState( ATN_ST_enum stateToCheck ){

    ATN_RESPONSE_ST state = ATN_RESPONSE_ST_STATE_DONE;

    for ( Behavior it : this->behaviors ){

        switch ( it.checkState( stateToCheck, this->substate ) )
        {
        case ATN_RESPONSE_ST_NONE:
        case ATN_RESPONSE_ST_BUSY:
            //If a block is busy, we need to wait, so we don't 
            state = ATN_RESPONSE_ST_BUSY;            
            continue;
        case ATN_RESPONSE_ST_STEP_DONE:
        case ATN_RESPONSE_ST_NEXT_STEP:
            if( state == ATN_RESPONSE_ST_STATE_DONE ){
                state = ATN_RESPONSE_ST_NEXT_STEP;
            }
            continue;
        case ATN_RESPONSE_ST_STATE_DONE:
            continue; 
        case ATN_RESPONSE_ST_ERROR:
            state = ATN_RESPONSE_ST_ERROR;
            break;
        }
        break;
    }
    return state;
}

void Action::updateState( ATN_ST_enum state ){
    this->actionState = state;

    for ( Behavior it : this->behaviors ){

       it.updateState( this->actionState, this->pParameters, this->sParameters );
    }
}

void Action::updateSubstate( unsigned long substate ){

    for ( Behavior it : this->behaviors ){

       it.updateSubstate( substate );

    }
}

void Action::release(  ){
    
    for ( Behavior it : this->behaviors ){

       it.release(  );
    }
}

void Action::print( std::ostream &out ){
    out << "\nAction: "<< this->name << "\n";
    for ( Behavior it : this->behaviors ){
        it.print( out );
    }
    out << "\n";
}