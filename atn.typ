(*/********************************************************************
 * COPYRIGHT -- Loupe 
 ********************************************************************
 * Library: All Together Now -atn
 * Author: Josh Polansky
 * Created: April 7, 2020
 ********************************************************************
 * Implementation of library All Together now
 ********************************************************************/*)

TYPE
	ATN_SST_enum : 
		(
		ATN_SS_INIT (*0*)
		);
	ATN_ST_enum : 
		(
		ATN_IDLE, (*0*)
		ATN_EXECUTE,
		ATN_ABORT,
		ATN_ERROR,
		ATN_BYPASSED
		);
	ATN_ERROR_enum : 
		(
		ATN_ERROR_OK := 0,
		ATN_ERROR_ACTIVE,
		ATN_ERROR_ABORTED,
		ATN_ERROR_ACTIONS_FULL,
		ATN_ERROR_BUSY := 65535
		);
	ATN_RESPONSE_ST : 
		(
		ATN_RESPONSE_ST_NONE,
		ATN_RESPONSE_ST_ERROR,
		ATN_RESPONSE_ST_STEP_DONE,
		ATN_RESPONSE_ST_NEXT_STEP,
		ATN_RESPONSE_ST_STATE_DONE,
		ATN_RESPONSE_ST_BUSY
		);
	Atn_typ : 	STRUCT 
		in : AtnIn_typ;
		out : AtnOut_typ;
		internal : AtnInternal_typ;
	END_STRUCT;
	AtnIn_typ : 	STRUCT 
		cmd : AtnInCmd_typ;
		par : AtnInPar_typ;
	END_STRUCT;
	AtnInCmd_typ : 	STRUCT 
		abort : BOOL;
		forceQuit : BOOL;
	END_STRUCT;
	AtnInPar_typ : 	STRUCT 
		namespace : STRING[ATN_NAMESPACE_LEN];
		ID : USINT;
	END_STRUCT;
	AtnOut_typ : 	STRUCT 
		activeThreads : ARRAY[0..MAI_ATN_ACT_THREADS]OF AtnActiveThread_typ;
		busy : BOOL;
		done : BOOL;
		error : BOOL;
	END_STRUCT;
	AtnOutStatus_typ : 	STRUCT 
		blocked : BOOL;
		busy : BOOL;
		done : BOOL;
		error : BOOL;
	END_STRUCT;
	AtnApiStatus_typ : 	STRUCT 
		active : BOOL;
		busy : BOOL;
		done : BOOL;
		aborted : BOOL;
		error : BOOL;
	END_STRUCT;
	AtnInternal_typ : 	STRUCT 
		thread : AtnThread_typ;
	END_STRUCT;
	AtnActiveThread_typ : 	STRUCT 
		action : STRING[ATN_ACTION_NAME_LEN];
		busyModule : ARRAY[0..MAI_ATN_ACT_ACTIONS]OF UDINT;
		errorModule : ARRAY[0..MAI_ATN_ACT_ACTIONS]OF UDINT;
		status : AtnOutStatus_typ;
	END_STRUCT;
	AtnThread_typ : 	STRUCT 
		ID : USINT;
		request : AtnActionCmdData_typ;
		activeRequest : AtnActionCmdData_typ;
		state : ATN_ST_enum;
		substate : UDINT;
		nextSubState : UDINT;
		abort : BOOL;
		forceQuit : BOOL;
		responseStatus : ATN_RESPONSE_ST;
		actions : UDINT;
		actionCount : UDINT;
		substateRequestModule : UDINT;
		busyModule : ARRAY[0..MAI_ATN_ACT_ACTIONS]OF UDINT;
		blockingModule : ARRAY[0..MAI_ATN_ACT_ACTIONS]OF UDINT;
		errorModule : ARRAY[0..MAI_ATN_ACT_ACTIONS]OF UDINT;
		activeActions : ARRAY[0..MAI_ATN_ACT_ACTIONS]OF UDINT;
		status : AtnOutStatus_typ;
	END_STRUCT;
	AtnAPI_typ : 	STRUCT 
		moduleName : STRING[80];
		moduleStatus : STRING[80];
		request : STRING[ATN_ACTION_NAME_LEN];
		state : ATN_ST_enum;
		response : ATN_ST_enum;
		subState : UDINT;
		subStateReq : UDINT;
		moduleBypass : BOOL;
		moduleIsBypassed : BOOL;
		activeThread : UDINT;
		waitingThread : UDINT;
		waitingDirectorID : USINT;
	END_STRUCT;
	AtnActionList_typ : 	STRUCT 
		name : STRING[ATN_NAMESPACE_LEN];
		maxActions : UDINT;
		pActions : REFERENCE TO AtnActionData_typ;
	END_STRUCT;
	AtnActionData_typ : 	STRUCT 
		name : STRING[ATN_ACTION_NAME_LEN];
		pParameters : UDINT;
		parametersSize : UDINT;
		pAction : REFERENCE TO AtnAPI_typ;
	END_STRUCT;
	AtnActionCmdData_typ : 	STRUCT 
		name : STRING[ATN_ACTION_NAME_LEN];
		pParameters : UDINT;
		parametersSize : UDINT;
		pStatusStructure : UDINT;
	END_STRUCT;
END_TYPE
