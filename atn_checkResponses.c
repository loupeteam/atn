/********************************************************************
 * COPYRIGHT -- Loupe 
 ********************************************************************
 * Library: All Together Now -atn
 * Author: Josh Polansky
 * Created: April 7, 2020
 ********************************************************************
 * Implementation of library All Together now
 ********************************************************************/

#include <bur/plctypes.h>
#ifdef __cplusplus
	extern "C"
	{
#endif

#include "atn.h"
#include "string.h"

#ifdef __cplusplus
	};
#endif

// Reads the responses from all the actions
plcbit atn_checkResponses(struct AtnThread_typ* thread)
{	
	struct AtnAPI_typ * Module;
	
	int currentPipe = 0;
	int busyMod = 0;
	int errorMod = 0;

	// clear out who is busy and err'd since it may change now
	memset( &thread->busyModule, 0, sizeof(thread->busyModule));
	memset( &thread->errorModule, 0, sizeof(thread->errorModule));

	//Initialize to finished. Will get reset if not
	thread->responseStatus = ATN_RESPONSE_ST_STEP_DONE;
	
	//Initialize next substate to 0 to search for the next one
	thread->nextSubState = 0;
	
	//Go through all the modules and check status
	while ( currentPipe <= MAI_ATN_ACT_ACTIONS && thread->activeActions[currentPipe] != 0 )
	{
		//Get the pipe at current index
		AtnActionData_typ* ActionData = (AtnActionData_typ*)thread->activeActions[currentPipe];
		Module =	(AtnAPI_typ *)(ActionData->pAction);

		//Check if the Pipe should respond in the current step
		//	The modules substate is less than the current, so it has already happened or wasn't requested
		//	If the substatereq is greater than the substate, that is a response, the this module is done
		if(Module->subStateReq <= thread->substate && !Module->moduleBypass ){

			//If any pipe from this step is not done remain here by setting busy
			if( thread->state != Module->response ){

				//Set response status so that Piper doesn't change state
				thread->responseStatus  = ATN_RESPONSE_ST_BUSY;

				//If there is no busy module yet, grab the first one
				thread->busyModule[busyMod++]=	(UDINT)Module;				
			}
		}
		//Figure out if there is a next step that we will need to go to
		//	The modules is requesting a substate, check if it is after the current substate
		// 	Looking for the lowest after the current
		else if(Module->subStateReq > thread->substate && !Module->moduleBypass ){

			//If we haven't found a response step that is greater than our current step, grab the current pipes response step
			//nextSubState should be zero when we get to the first module, so just grab any first item
			if( thread->nextSubState <= thread->substate){
				thread->nextSubState = Module->subStateReq;
				thread->substateRequestModule = (UDINT)Module; 
			}

			//If we currently have a response step that is greater than our current step, use the lower one.
			else if( thread->nextSubState > Module->subStateReq ){
				thread->nextSubState = Module->subStateReq ;
				thread->substateRequestModule = (UDINT)Module;				
			}
		}
		currentPipe+=1;		
	}
	
	currentPipe = 0;
	
	//Check if any module has an error
	while ( currentPipe <= MAI_ATN_ACT_ACTIONS &&  thread->activeActions[currentPipe] != 0 )
	{
		AtnActionData_typ* ActionData = (AtnActionData_typ*)thread->activeActions[currentPipe];
		Module =	(AtnAPI_typ *)(ActionData->pAction);
		
		//If there is an error, set the status and log
		if( Module->response == ATN_ERROR && !Module->moduleBypass )
		{								
			//If there is no busy module yet, grab the first one
			thread->errorModule[errorMod++]=	(UDINT)Module;				
			//Set response status so we know what to do
			thread->responseStatus  = ATN_RESPONSE_ST_ERROR;				

		}
		currentPipe+=1;
	}
		
	return 0;
}
