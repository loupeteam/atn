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

#ifdef __cplusplus
	};
#endif

/* This function looks at the response state and decides what Step or State to enter next */
plcbit atn_handleResponse(struct AtnThread_typ* thread)
{

	struct AtnAPI_typ * Module;
	
	//If we are done with the last step, check if there is another
	switch (thread->responseStatus)
	{
		case ATN_RESPONSE_ST_STEP_DONE:
			
			//If the next step is greater than our current step, go to the next step	
			if( thread->substate < thread->nextSubState ){
						
				//Grab the next step
				thread->substate= 		thread->nextSubState;

				//Next step is decided in checkResponses
				thread->nextSubState =	0;

				//Set response status
				thread->responseStatus = ATN_RESPONSE_ST_NEXT_STEP;
				
				//Log the data if we can
//				if(Piper->OUT.SubStateRequestModule != 0){
//					Module = (Module_Interface_typ *)(Piper->OUT.SubStateRequestModule);
//					LogData.i[0] =  Piper->OUT.SubState;
//					LogData.s[0] =  (UDINT)&(Module->ModuleName);
//					logInfo(Piper->IN.CFG.LoggerName,0,"Substate %i requested by %s",(UDINT)&LogData);					
//				}			
			}
			//If the next step is not greater than our current step, this state is done
			else{

				//We are done with this state
				thread->responseStatus = ATN_RESPONSE_ST_STATE_DONE;
				thread->substate= 			ATN_IDLE;
				thread->nextSubState =	0;

			}				
			break;
		
		case ATN_RESPONSE_ST_ERROR:
			
			//Log the data if we can
			// TODO: check them all			
			if(thread->errorModule[0] != 0 ){
				Module = (AtnAPI_typ *) thread->errorModule[0];

				if(thread->state != ATN_ABORT ){
//					LogData.s[0] =  (UDINT)&(Module->ModuleName);
//					logInfo(Piper->IN.CFG.LoggerName,0,"%s requested an abort due to error",(UDINT)&LogData);				
				}
			
			}			
			break;
		
		default:
			break;
	}
	
	return 1;
	
}
