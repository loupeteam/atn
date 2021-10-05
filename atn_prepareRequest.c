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

#include "string.h"
#include "atn.h"
#include "atnGlobal.h"

#ifdef __cplusplus
	};
#endif

// Collect all the actions that need to run for this request
plcbit atn_prepareRequest(struct AtnThread_typ* thread, unsigned long request)
{

	// get the actions
	AtnActionData_typ *actions = thread->actions;

	// Clean up actions so they are case insensitive
	STRING cRequest[ATN_ACTION_NAME_LEN];
	strcpy( cRequest, request );
	ToLower( cRequest );
	
	int i;
	plcbit busy = 0;
	for( i = 0; i < thread->actionCount; i++) {

		// Clean up actions so they are case insensitive
		STRING cAction[ATN_ACTION_NAME_LEN];
		strcpy( cAction, actions[i].name );
		ToLower( cAction );

		// If the action name matches, add it to the list of active actions
		if( strcmp( cRequest, cAction) == 0 ){
			AtnActionData_typ * pAction = &actions[i];

			// Check if this action is used by any other threads
			if( pAction->pAction
				&& pAction->pAction->state != ATN_BYPASSED
				&& pAction->pAction->activeThread != 0
				&& pAction->pAction->activeThread != thread){
				pAction->pAction->waitingThread = thread;
				pAction->pAction->waitingDirectorID = thread->ID;
				busy = 1;				
				int a;
				// search for an empty slot
				for( a = 0; a < MAI_ATN_ACT_ACTIONS; a++ ) {
					// This behavior was already added by another action, maybe clean up your application? ;)
					if( thread->blockingModule[a] == pAction ){
						break;
					}
						//found an empty slot
					else if( thread->blockingModule[a] == 0 ){
						thread->blockingModule[a] = pAction;					 ;
						break;				
					}
				}
			}
			else{			
				int a;
				// search for an empty slot
				for( a = 0; a < MAI_ATN_ACT_ACTIONS; a++ ) {
					// This behavior was already added by another action, maybe clean up your application? ;)
					if( thread->activeActions[a] == pAction ){
						break;
					}
						//found an empty slot
					else if( thread->activeActions[a] == 0 ){
						thread->activeActions[a] = pAction;					 ;
						break;				
					}
				}
			}

			//TODO: If we get hear and haven't assigned it a slot, it won't get called..
			// We should probably let someone know...
		}		
	}
				
	return busy;
}


//plcbit atn_prepareGroupRequest(struct AtnThread_typ* thread, unsigned long request)
//{
//
//	//	thread->
//	
//	char *Line = request;
//	STRING action[ATN_ACTION_NAME_LEN];
//
//	UDINT cellLength = 0;
//	AtnActionData_typ *actions = thread->actions;
//	
//	while( csvGetNextCell( &Line, &cellLength, ',') == CSV_CORE_ERR_OK ){
//
//		//Copy in the next cell
//		memset( &action, 0, sizeof(action) );		
//		memcpy( &action, Line, cellLength);		
//		
//		atn_prepareRequest( thread, action);
//				
//	}
//				
//	return 0;
//
//}
