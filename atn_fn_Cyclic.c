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
#include "atnGlobal.h"

#ifdef __cplusplus
	};
#endif

#include <string.h>


AtnActionList_typ internActionList[MAI_ATN_ACTIONLISTS+1] = {0};
AtnActionData_typ internActions[MAI_ATN_ACTIONLISTS+1][MAI_ATN_ACTIONS+1] = {0}; // This generates warnings because of gcc bug 53119, its fine to ignore

// Run a director, which might have multiple threads
plcbit atnCyclic(struct Atn_typ * director)
{
	// Obvious
	if( director == 0 ){
		return 1;
	}	

	// Assign the actions to the threads so the thread can look them up

	
	AtnActionList_typ *actionList = atnGetActionList( director->in.par.category );
	if( actionList != 0 ){
		//Maybe we should make this use the action structure directly
		// For now let's try not to break things.
		director->internal.thread.actions = actionList->pActions;
		director->internal.thread.actionCount = actionList->maxActions;
	}
	else{
		return 1;
	}

	director->internal.thread.ID = director->in.par.ID;
	
	// Pass in commands to the thread
	director->internal.thread.abort = director->in.cmd.abort;
	director->internal.thread.forceQuit = director->in.cmd.forceQuit;

	// Run the threads (Only 1 for now)
	atnThreadFn( &director->internal.thread );

	strcpy(director->out.activeThreads[0].action, director->internal.thread.activeRequest.name);
	memcpy(&director->out.activeThreads[0].busyModule, &director->internal.thread.busyModule, sizeof(director->out.activeThreads[0].busyModule));
	memcpy(&director->out.activeThreads[0].errorModule, &director->internal.thread.errorModule, sizeof(director->out.activeThreads[0].errorModule));
	memcpy(&director->out.activeThreads[0].status, &director->internal.thread.status, sizeof(director->out.activeThreads[0].status));
	
	// Pass the status from the thread
	director->out.busy = director->internal.thread.status.busy;
	director->out.done = director->internal.thread.status.done;
	director->out.error = director->internal.thread.status.error;
	
	return 0;
	
}

// Run a thread
plcbit atnThreadFn(struct AtnThread_typ* thread){

	// Check if all the actions are complete
	atn_checkResponses( thread );
	
	// Handle what do with the response (doesn't do much at the moment)
	atn_handleResponse( thread );
	
	// Update the state of the thread
	atn_threadState( thread );

	// Send the commands to the actions
	atn_setCommand( thread );

	return 0;
}

#ifndef _NOT_BR

// Add a behavior as a new action by looking up it's local PV name. This will lookup and append the task name
unsigned char atnRegisterActionPVLocal( plcstring* namespace, plcstring* name, plcstring* actionPv, plcstring* paramName){


	varVariable_typ Variable;
	UDINT pAction =0;
	UDINT pParam =0;
	UDINT paramSize =0;
	STRING task[20];
	
	// Get the task name
	ST_name( 0, task, 0);

	//These assume that the lookup worked. If it didn't, it will just add 0 anyway, which is fine.
	
	// If the action PV is given look it up
	if( actionPv ){
		memset(&Variable,0,sizeof(Variable));
		strcpy(Variable.name, task);
		strcat(Variable.name, ":");
		strcat(Variable.name, actionPv);
		varGetInfo(&Variable);
		pAction = Variable.address;
	}

	// If the parameter PV is given look it up
	if( paramName ){
		memset(&Variable,0,sizeof(Variable));
		strcpy(Variable.name, task);
		strcat(Variable.name, ":");
		strcat(Variable.name, paramName);
		varGetInfo(&Variable);
		pParam = Variable.address;
		paramSize = Variable.length;
	}

	// Register the looked up PV's
	return atnRegisterAction( namespace, name, pAction, pParam, paramSize);	
}

// Add a behavior as a new action by looking up it's global PV name
unsigned char atnRegisterActionPV( plcstring* namespace, plcstring* name, plcstring* actionPv, plcstring* paramName){
	
	varVariable_typ Variable;
	UDINT pAction =0;
	UDINT pParam =0;
	UDINT paramSize =0;

	//These assume that the lookup worked. If it didn't, it will just add 0 anyway, which is fine.
	
	// If the action PV is given look it up
	if( actionPv ){
		memset(&Variable,0,sizeof(Variable));
		strcpy(Variable.name, actionPv);
		varGetInfo(&Variable);
		pAction = Variable.address;
	}
	
	// If the parameter PV is given look it up
	if( paramName ){
		memset(&Variable,0,sizeof(Variable));
		strcpy(Variable.name, paramName);
		varGetInfo(&Variable);
		pParam = Variable.address;
		paramSize = Variable.length;
	}

	// Register the looked up PV's
	return atnRegisterAction( namespace, name, pAction, pParam, paramSize);
	
}

#endif

// Add a behavior as a new action
unsigned char atnRegisterAction( plcstring* namespace, plcstring* name, struct AtnAPI_typ* pAction, void * pParameters, unsigned long parameterSize){

	AtnActionList_typ *actionList = atnGetActionList(  namespace );
	
	AtnActionData_typ * pActions = actionList->pActions;
	UDINT MaiAtnAction = actionList->maxActions - 1;
	
	// Go through all the actions and fine an open spot
	
	int a = 0;
	while( pActions[a].pAction != 0 && a < MaiAtnAction ){
		a++;
	}
	if( a < MaiAtnAction){
		pActions[a].pAction = pAction;
		stringlcpy( pActions[a].name, name, sizeof(pActions[0].name) );
		pActions[a].pParameters = pParameters;
		pActions[a].sParameters = parameterSize;
		return ATN_ERROR_OK;
	}
	else{
		//TODO: Log this?
		return ATN_ERROR_ACTIONS_FULL;
	}
}

// Add a behavior as a new action
unsigned char atnRunAction(struct Atn_typ* director, plcstring* action, void* pParameters, unsigned long parameterSize, struct AtnApiStatus_typ* status){

	//Abort any unacknowledged requests
	atn_setStatus( &director->internal.thread.request, ATN_ERROR_ABORTED);

	//Copy request to the thread, it will get processed by the thread
	// This will overwrite any request that was made and not processed.	
	stringlcpy( director->internal.thread.request.name, action, sizeof(director->internal.thread.request.name) );
	director->internal.thread.request.pParameters = pParameters;
	director->internal.thread.request.sParameters = parameterSize;
	director->internal.thread.request.pStatusStructure = status;

	//Set the status of the new request to busy
	atn_setStatus( &director->internal.thread.request, ATN_ERROR_BUSY);

	return 0;
}

// Function block version of run action
void AtnRunAction(struct AtnRunAction* inst){

	//If we see an edge execute the command
	if( inst->execute && !inst->_execute ){
		atnRunAction( inst->director, inst->action, inst->pParameters, inst->parameterSize, &inst->status);
	}

	// Copy the status from the internal status to the external status
	// This is important so that we can guarantee the statuses are true exactly as long as they should be
	inst->busy = inst->status.busy;
	inst->done = inst->status.done;
	inst->error = inst->status.error;
	inst->active = inst->status.active;
	inst->aborted = inst->status.aborted;

	// if the execute is false, set the statuses that aren't auto reset to zero
	if(!inst->execute){
		inst->status.done = 0;
		inst->status.aborted = 0;			
		inst->status.error = 0;			
	}
	
	// Edge detection
	inst->_execute = inst->execute;	
}

// Set the run action status if it exists
plcbit atn_setStatus(struct AtnActionCmdData_typ* cmdData, unsigned long  status){
	
	// if there isn't a command get out
	if( !cmdData ){
		return 1;
	}
	
	// if there is a status structure set the status
	if( cmdData->pStatusStructure ){
		AtnApiStatus_typ* pStatus = cmdData->pStatusStructure;
		pStatus->active = status == ATN_ERROR_ACTIVE;
		pStatus->busy = status == ATN_ERROR_BUSY || pStatus->active;
		pStatus->done = status == ATN_ERROR_OK;
		pStatus->aborted = status == ATN_ERROR_ABORTED;
		pStatus->error = ! (pStatus->done || pStatus->busy || pStatus->aborted);
		return 0;
	}
	return 1;	
}

// Get the global action list
unsigned long atnGetActionList(plcstring* actionListName){

	if( internActionList[0].pActions == 0 ){
		initGlobalActionList();
	}
	
	//If there is not a name given, return the global list
	if( actionListName == 0) return &internActionList[0];
	if( strcmp( actionListName, "" ) == 0 ) return &internActionList[0];

	int l = 0;

	//Search the list for the correct list
	do{
		if( strcasecmp( actionListName, internActionList[l].name ) == 0 ) return &internActionList[l]; // Found the one
		//Found an empty one
		if( strcmp( internActionList[l].name, "" ) == 0 ) {
			//Init the name
			strcpy( internActionList[l].name, actionListName );
			return &internActionList[l];
		}
	} while ( ++l <= MAI_ATN_ACTIONLISTS);		
		
	return 0; //Sorry, we're full
}

// Set the global action list (UNTESTED)
plcbit atnSetActionList(plcstring* namespace, struct AtnActionData_typ* pNewActions, unsigned long size){

	if( !pNewActions ) return 1;

	// Clear out the memory
	memset(pNewActions, 0, size);

	AtnActionList_typ * pActionList = atnGetActionList(namespace);
	if( pActionList == 0 ) return 1;
	
	USINT MaiAtnAction = pActionList->maxActions - 1;
	
	//Copy the old list into the new one
	if( size > (MaiAtnAction + 1) * sizeof(AtnActionData_typ) ){
		memcpy( pNewActions, pActionList->pActions, (MaiAtnAction + 1) * sizeof(AtnActionData_typ) );
		
		//Update the action pointer and max number of actions
		pActionList->pActions = pNewActions;
		MaiAtnAction = (size/sizeof(AtnActionData_typ)) - 1;
		return 0;
	}

	return 1;
}

void initGlobalActionList( void ){
	strcpy( internActionList[0].name, "global" ); 
	int i=0;
	for( i=0; i <= MAI_ATN_ACTIONLISTS; i++ ){
		internActionList[i].maxActions = MAI_ATN_ACTIONS  + 1;
		internActionList[i].pActions = &internActions[i];	
	}
}
