#include <iostream>

#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif

	#include "atn.h"
	#include <cstring>
#ifdef __cplusplus
	};
#endif

#include "../Includes/Behavior.h"

using namespace atn;

Behavior::Behavior( ) {
	pParameters = 0;
	sParameters = 0;
	pAction = 0;
};
Behavior::Behavior( void * pParameters, size_t parameterSize, struct AtnAPI_typ* pAction)
{
    this->pParameters = pParameters;
    this->sParameters = parameterSize;
    this->pAction = pAction;
}
Behavior::~Behavior()
{

}

bool Behavior::updateState( ATN_ST_enum state, void *_pParameters, size_t _sParameters ){

        AtnAPI_typ * Module = this->pAction;

        if( !Module->moduleBypass ){
            // Not bypassed anymore
			Module->moduleIsBypassed = 0;

			//If we are changing states, 
			if( Module->state !=state ){
				//reset the response so we know it is real when we see non zero
				Module->response = ATN_IDLE;

				//If there are data pointers on either side, use them if they fit
				if( this->pParameters && _pParameters ){
					if( this->sParameters <= _sParameters ){
						//TODO: Is there anything else to do if it is wrong?
						//TODO: Should this memset either way?
						memset(this->pParameters, 0, this->sParameters );
						memcpy(this->pParameters, _pParameters, this->sParameters );
					}					
				}
				// Tell the action what request we called, since they may be subscribed to multiples
				// strcpy(Module->request, this->name.c_str());
			}
			
			//Set the current state to the action
			Module->state=		state;
			Module->activeThread = (unsigned long*)this; 
			            

        }
        else if (!Module->moduleIsBypassed) {
		
			//Bypass me!
			Module->state = ATN_BYPASSED;
			Module->moduleIsBypassed = 1;

		} 
		return false;
}

bool Behavior::updateSubstate( unsigned long substate ){

        AtnAPI_typ * Module = this->pAction;

        if( !Module->moduleBypass ){
            // Not bypassed anymore
			Module->moduleIsBypassed = 0;
			
			//Set the current substate to the action
			Module->subState =		substate;			        
        }
        else if (!Module->moduleIsBypassed) {
		
			//Bypass me!
			Module->state = ATN_BYPASSED;
			Module->moduleIsBypassed = 1;

		} 
		return false;
}

void Behavior::release(){
	struct AtnAPI_typ * Module = this->pAction;
	
// Maybe someday we should do this, but right now there are too many questions. 
// ei: what would happen if the waiting thread doesn't want to be active anymore			
//			Module->activeThread = Module->waitingThread; 	
	Module->activeThread = 0;
	Module->waitingThread = 0;		
	memset(	&Module->request, 0, sizeof(Module->request) );		
}
ATN_RESPONSE_ST Behavior::checkState( ATN_ST_enum state, unsigned long substate ){

		//Get the pipe at current index
		AtnAPI_typ *Module =	this->pAction;

		//This module is bypassed, respond done
		if( Module->moduleBypass ){

			return ATN_RESPONSE_ST_STATE_DONE;
		}
		else if( Module->response == ATN_ABORT || Module->response == ATN_ERROR ){
			//If we are in the matching state, we are done
			if( state == Module->response ){
				return ATN_RESPONSE_ST_STATE_DONE;
			}
			else{
				return ATN_RESPONSE_ST_ERROR;
			}
		}
		//Check if the Pipe should respond in the current step
		//	The modules substate is less than the current, so it has already happened or wasn't requested
		//	If the substatereq is greater than the substate, that is a response, the this module is done
		else if(Module->subStateReq <= substate ){

			//If any pipe from this step is not done remain here by setting busy
			if( state != Module->response ){

				//Set response status so that Piper doesn't change state
				return ATN_RESPONSE_ST_BUSY;
			}
			else{

				//This modules is complete
				return ATN_RESPONSE_ST_STATE_DONE;
			}
		}
		//Figure out if there is a next step that we will need to go to
		//	The modules is requesting a substate, check if it is after the current substate
		// 	Looking for the lowest after the current
		else {
			return ATN_RESPONSE_ST_NEXT_STEP;
		}
}

void Behavior::print( std::ostream &out ){
	out << "Module       : " << pAction->moduleName << "\n";
	out << "Module status: " << pAction->moduleStatus << "\n";
	out << "state        : " << pAction->state << "\n";
	out << "response     : " << pAction->response << "\n";
}