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
	ATN_ST_enum : 
		(
		ATN_IDLE, (*0*)
		ATN_EXECUTE,
		ATN_WAITING,
		ATN_DONE,
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
	AtnApiStatusLocal_typ : 	STRUCT 
		active : BOOL;
		busy : BOOL;
		done : BOOL;
		aborted : BOOL;
		error : BOOL;
		errorID : UDINT;
		remote : AtnApiStatus_typ;
	END_STRUCT;
	AtnApiStatus_typ : 	STRUCT 
		active : BOOL;
		busy : BOOL;
		done : BOOL;
		aborted : BOOL;
		error : BOOL;
		errorID : UDINT;
	END_STRUCT;
	AtnAPI_typ : 	STRUCT 
		moduleName : STRING[80];
		moduleStatus : STRING[80];
		request : STRING[ATN_ACTION_NAME_LEN];
		state : ATN_ST_enum;
		response : ATN_ST_enum;
		subState : UDINT;
		subStateReq : UDINT;
		oneShot : BOOL;
		moduleBypass : BOOL;
		moduleIsBypassed : BOOL;
		activeThread : REFERENCE TO UDINT;
		waitingThread : REFERENCE TO UDINT;
		waitingDirectorID : USINT;
	END_STRUCT;
	AtnAPIState_typ : 	STRUCT 
		moduleName : STRING[80];
		moduleStatus : STRING[80];
		moduleBypass : BOOL;
		moduleIsBypassed : BOOL;
		active : BOOL;
	END_STRUCT;
	AtnPlcOpenCall : 	STRUCT 
		abort : BOOL;
	END_STRUCT;
	AtnPlcOpenStatus : 	STRUCT 
		activeCommand : STRING[80];
		status : DINT;
		parametersWritten : BOOL;
		bypass : BOOL;
		internal : AtnPlcOpenInternal;
	END_STRUCT;
	AtnPlcOpenInternal : 	STRUCT 
		fbk : UDINT;
		trig : BOOL;
	END_STRUCT;
	ATN_PLCOPEN_FUB_STATE_enum : 
		(
		ATN_PLCOPEN_FUB_IDLE,
		ATN_PLCOPEN_FUB_NEW_COMMAND,
		ATN_PLCOPEN_FUB_ABORT_OLD,
		ATN_PLCOPEN_FUB_WRITE_PAR,
		ATN_PLCOPEN_FUB_SET_COMMAND,
		ATN_PLCOPEN_FUB_WORKING,
		ATN_PLCOPEN_FUB_STATUS,
		ATN_PLCOPEN_FUB_CLEANUP,
		ATN_PLCOPEN_FUB_DONE,
		ATN_PLCOPEN_FUB_ABORTED
		);
END_TYPE
