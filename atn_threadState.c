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
#include "atnGlobal.h"

#ifdef __cplusplus
	};
#endif

// Manage the state of the thread
plcbit atn_threadState(struct AtnThread_typ* thread)
{	

	// Kill the request if we are told to
	if( thread->forceQuit ){
		//State should be idle after a kill
		thread->state = ATN_IDLE;

		//Write any active behaviors to IDLE..
		atn_setCommand( thread );	

		//We are finished here, let the modules go
		atn_releaseModules( thread );

		//Tell the caller of the action that it was aborted
		atn_setStatus( &thread->activeRequest, ATN_ERROR_ABORTED);

		//Clear out the action to prepare for a new one
		memset( &thread->activeRequest, 0, sizeof(thread->activeRequest) );
		memset( &thread->busyModule, 0, sizeof(thread->busyModule) );
		memset( &thread->errorModule, 0, sizeof(thread->errorModule) );
		memset( &thread->activeActions, 0, sizeof(thread->activeActions) );						
		memset( &thread->blockingModule, 0, sizeof(thread->blockingModule) );
	}
	
	// How to handle state transitions
	switch( thread->state ){

		// We are not busy, accept commands
		case ATN_IDLE:

			//Hurray! We have a new request
			if( strcmp( thread->request.name, "") != 0 ){

				//Tell everyone we are busy so they know we are cool
				thread->status.busy = 1;
				thread->status.done = 0;
				thread->status.error = 0;
				thread->status.blocked = 0;
				
				//Clear out any old modules, that were still here, if this does anything it was a bug somewhere
				memset( &thread->busyModule, 0, sizeof(thread->busyModule) );
				memset( &thread->errorModule, 0, sizeof(thread->errorModule) );
				memset( &thread->activeActions, 0, sizeof(thread->activeActions) );			
				memset( &thread->blockingModule, 0, sizeof(thread->blockingModule) );


				// Get all the behaviors for this action
				if( atn_prepareRequest( thread, thread->request.name) ){

					// There is a behavior required, that is busy
					
					//Clear out the active action that we just found
					memset( &thread->activeActions, 0, sizeof(thread->activeActions) );							
					thread->status.blocked = 1;
					
				}
				else{
					// Looks good..
					
					//Go to the execute state
					thread->state = ATN_EXECUTE;

					//This is a bit of a HACK
					// This just makes sure that the response handler doesn't think we are done now...
					thread->responseStatus = ATN_RESPONSE_ST_BUSY;

					//Copy request to active and clear out the request
					memcpy( &thread->activeRequest,  &thread->request, sizeof(thread->request) );				
					memset( &thread->request, 0, sizeof(thread->request) );				
				
					//Set the callers status to active
					atn_setStatus( &thread->activeRequest, ATN_ERROR_ACTIVE);				
				}

			}
			break;

		case ATN_EXECUTE:
			
			// We are currently executing, but got a new request
			// Abort the current request, then through magic, 
			//	it will call the new one from the idle state after it has aborted
			if( strcmp( thread->request.name, "") != 0 || thread->abort ){
				thread->abort = 0;
				thread->state = ATN_ABORT;
			}
			break;
		default:
			break;
		}
	
	
	// Handle responses from the slaves
	switch( thread->responseStatus ){		
		case ATN_RESPONSE_ST_ERROR:
			//Someone responed that they had an error and want us to abort
			// Here we go again.. GET YOUR ACT TOGETHER!
			thread->state = ATN_ABORT;	
			break;

		case ATN_RESPONSE_ST_STATE_DONE:			
			//Everybody responded that they are done
			switch( thread->state ){
				//If we were requesting Idle it means that the action is completely done.
				// Update statuses and be done
				case ATN_IDLE:
					if( strcmp( thread->activeRequest.name, "") != 0 ){
						//Set the actions to IDLE, if not already, although they should have already
						atn_setCommand( thread );

						//We are finished here, let the modules go
						atn_releaseModules( thread );
						
						//Tell the caller that we finished successfully
						atn_setStatus( &thread->activeRequest, ATN_ERROR_OK);

						//clear out our request data
						memset( &thread->activeRequest, 0, sizeof(thread->activeRequest) );
						memset( &thread->blockingModule, 0, sizeof(thread->blockingModule) );
						memset( &thread->busyModule, 0, sizeof(thread->busyModule) );
						memset( &thread->errorModule, 0, sizeof(thread->errorModule) );
						memset( &thread->activeActions, 0, sizeof(thread->activeActions) );								

						//Set the thread status for 1 cycle
						thread->status.busy = 0;
						thread->status.done = 1;
						thread->status.error = 0;
					}
					else{
						//Clear the thread status after 1 cycle
						thread->status.busy = thread->status.blocked;
						thread->status.done = 0;
						thread->status.error = 0;					
					}
					break;
				
				//We have successfully aborted
				case ATN_ABORT:
					// Go back to the idle state					
					thread->state = ATN_IDLE;

					//Tell all the actions that they should be in idle now
					atn_setCommand( thread );	
					
					//We are finished here, let the modules go
					atn_releaseModules( thread );

					//Tell the caller that they got aborted
					atn_setStatus( &thread->activeRequest, ATN_ERROR_ABORTED);
					
					//Clear out our memory
					memset( &thread->activeRequest, 0, sizeof(thread->activeRequest) );
					memset( &thread->blockingModule, 0, sizeof(thread->blockingModule) );
					memset( &thread->busyModule, 0, sizeof(thread->busyModule) );
					memset( &thread->errorModule, 0, sizeof(thread->errorModule) );
					memset( &thread->activeActions, 0, sizeof(thread->activeActions) );					

					//Set the thread status for 1 cycle
					thread->status.busy = 0;
					thread->status.done = 1;
					thread->status.error = 0;
					break;
				case ATN_EXECUTE:
					//Execute was successful, get everyone to IDLE together before we are really done
					thread->state = ATN_IDLE;
					break;
			}			
			break;
		//Do we need all these? Maybe later!
		case ATN_RESPONSE_ST_NONE:
		case ATN_RESPONSE_ST_NEXT_STEP:
		case ATN_RESPONSE_ST_STEP_DONE:
		case ATN_RESPONSE_ST_BUSY:
			break;
	}
	// Meaningless return		
	return 0;

}
