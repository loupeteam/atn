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

//Send commands out to active actions
plcbit atn_setCommand(struct AtnThread_typ* thread)
{	
	struct AtnAPI_typ * Module;
	
	int currentPipe = 0;

	while ( currentPipe <= MAI_ATN_ACT_ACTIONS && thread->activeActions[currentPipe] != 0 )
	{
		//Get the pipe at current index
		AtnActionData_typ* ActionData = (AtnActionData_typ*)thread->activeActions[currentPipe];
		Module =	(AtnAPI_typ *)(ActionData->pAction);

		//Module should be ignored
		if(!Module->moduleBypass){
			
			// Not bypassed anymore
			Module->moduleIsBypassed = 0;

			//If we are changing states, 
			if(Module->state!=thread->state){
				//reset the response so we know it is real when we see non zero
				Module->response = 0;

				//If there are data pointers on either side, use them if they fit
				if( thread->activeRequest.pParameters && ActionData->pParameters ){
					if( thread->activeRequest.parametersSize <= ActionData->parametersSize ){
						//TODO: Is there anything else to do if it is wrong?
						//TODO: Should this memset either way?
						memset(ActionData->pParameters, 0, ActionData->parametersSize );
						memcpy(ActionData->pParameters, thread->activeRequest.pParameters, thread->activeRequest.parametersSize );
					}					
				}
				// Tell the action what request we called, since they may be subscribed to multiples
				strcpy(Module->request, thread->activeRequest.name);
			}
			
			//Set the current state to the action
			Module->state=		thread->state;
			Module->activeThread = thread; 
			
		} else if (!Module->moduleIsBypassed) {
		
			//Bypass me!
			Module->state = ATN_BYPASSED;
			Module->moduleIsBypassed = 1;
		
		}
		
		currentPipe+=1;
				
	}
	
	return 0;

}

plcbit atn_releaseModules(struct AtnThread_typ* thread)
{	
	struct AtnAPI_typ * Module;
	
	int currentPipe = 0;

	while ( currentPipe <= MAI_ATN_ACT_ACTIONS && thread->activeActions[currentPipe] != 0 )
	{
		//Get the pipe at current index
		AtnActionData_typ* ActionData = (AtnActionData_typ*)thread->activeActions[currentPipe];
		Module =	(AtnAPI_typ *)(ActionData->pAction);

		if( Module->activeThread == thread){
// Maybe someday we should do this, but right now there are too many questions. 
// ei: what would happen if the waiting thread doesn't want to be active anymore			
//			Module->activeThread = Module->waitingThread; 	
			Module->activeThread = 0;		
			Module->waitingThread = 0;		
			memset(	&Module->request, 0, sizeof(Module->request) );		
		}		
		currentPipe+=1;				
	}
	
	return 0;

}
