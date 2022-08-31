(*/********************************************************************
 * COPYRIGHT -- Loupe 
 ********************************************************************
 * Library: All Together Now -atn
 * Author: Josh Polansky
 * Created: April 7, 2020
 ********************************************************************
 * Implementation of library All Together now
 ********************************************************************/*)

FUNCTION atninit : UDINT
	VAR_INPUT
		buff : UDINT;
		bufsize : UDINT;
	END_VAR
END_FUNCTION

FUNCTION atncyclic : UDINT
	VAR_INPUT
		buff : UDINT;
		bufsize : UDINT;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK AtnRunAction
	VAR_INPUT
		execute : BOOL;
		director : {REDUND_UNREPLICABLE} UDINT;
		action : {REDUND_UNREPLICABLE} STRING[ATN_ACTION_NAME_LEN];
		pParameters : {REDUND_UNREPLICABLE} UDINT;
		parameterSize : {REDUND_UNREPLICABLE} UDINT;
	END_VAR
	VAR_OUTPUT
		busy : BOOL;
		done : BOOL;
		active : BOOL;
		aborted : BOOL;
		error : BOOL;
	END_VAR
	VAR
		status : AtnApiStatus_typ;
		_execute : BOOL;
	END_VAR
END_FUNCTION_BLOCK
(*
Actions interface
*)

FUNCTION atnRunAction : USINT
	VAR_INPUT
		director : Atn_typ;
		action : STRING[ATN_ACTION_NAME_LEN];
		pParameters : REFERENCE TO UDINT;
		parameterSize : UDINT;
		status : AtnApiStatus_typ;
	END_VAR
END_FUNCTION

FUNCTION atnCyclic : USINT
	VAR_INPUT
		director : Atn_typ;
	END_VAR
END_FUNCTION

FUNCTION atnRegisterActionPV : USINT
	VAR_INPUT
		category : STRING[ATN_NAMESPACE_LEN];
		name : STRING[ATN_ACTION_NAME_LEN];
		actionPv : STRING[80];
		parameterPv : STRING[80];
	END_VAR
END_FUNCTION

FUNCTION atnRegisterActionPVLocal : USINT
	VAR_INPUT
		category : STRING[ATN_NAMESPACE_LEN];
		name : STRING[ATN_ACTION_NAME_LEN];
		actionPv : STRING[80];
		parameterPv : STRING[80];
	END_VAR
END_FUNCTION

FUNCTION atnRegisterAction : USINT
	VAR_INPUT
		category : STRING[ATN_NAMESPACE_LEN];
		name : STRING[ATN_ACTION_NAME_LEN];
		pAction : AtnAPI_typ;
		pParameters : REFERENCE TO UDINT;
		parameterSize : UDINT;
	END_VAR
END_FUNCTION

FUNCTION atnGetActionList : UDINT
	VAR_INPUT
		gategory : STRING[ATN_NAMESPACE_LEN];
	END_VAR
END_FUNCTION

FUNCTION atnSetActionList : BOOL
	VAR_INPUT
		gategory : STRING[ATN_NAMESPACE_LEN];
		pActions : AtnActionData_typ;
		size : UDINT;
	END_VAR
END_FUNCTION

FUNCTION populateActionList : BOOL
	VAR_INPUT
		listname : STRING[80];
	END_VAR
END_FUNCTION
(*
State/Command Interface
*)
(*Registering*)

FUNCTION registerState : BOOL
	VAR_INPUT
		state : STRING[80];
		moduleName : STRING[80];
		api : AtnAPIState_typ;
	END_VAR
END_FUNCTION

FUNCTION registerStateBool : BOOL
	VAR_INPUT
		state : STRING[80];
		moduleName : STRING[80];
	END_VAR
	VAR_IN_OUT
		value : BOOL;
	END_VAR
END_FUNCTION

FUNCTION registerStateBoolAdr : BOOL
	VAR_INPUT
		state : STRING[80];
		moduleName : STRING[80];
		value : REFERENCE TO BOOL;
	END_VAR
END_FUNCTION
(*Subscribing*)

FUNCTION subscribeCommandBool : BOOL
	VAR_INPUT
		commandName : STRING[80];
		moduleName : STRING[80];
	END_VAR
	VAR_IN_OUT
		command : BOOL;
	END_VAR
END_FUNCTION

FUNCTION subscribePLCOpen : BOOL
	VAR_INPUT
		commandName : STRING[80];
		moduleName : STRING[80];
	END_VAR
	VAR_IN_OUT
		command : BOOL;
		status : AtnPlcOpenStatus;
	END_VAR
END_FUNCTION
(*PLCOpen*)

FUNCTION atnPLCOpenAbort : BOOL
	VAR_IN_OUT
		status : AtnPlcOpenStatus;
	END_VAR
END_FUNCTION
(*
Combined State check
*)

FUNCTION stateAllTrue : BOOL
	VAR_INPUT
		state : STRING[80];
		fallback : BOOL;
	END_VAR
END_FUNCTION

FUNCTION stateAnyTrue : BOOL
	VAR_INPUT
		state : STRING[80];
		fallback : BOOL;
	END_VAR
END_FUNCTION

FUNCTION stateAllFalse : BOOL
	VAR_INPUT
		state : STRING[80];
		fallback : BOOL;
	END_VAR
END_FUNCTION

FUNCTION stateAnyFalse : BOOL
	VAR_INPUT
		state : STRING[80];
		fallback : BOOL;
	END_VAR
END_FUNCTION
(*
Individual State check
*)

FUNCTION stateCount : INT
	VAR_INPUT
		State : STRING[80];
	END_VAR
END_FUNCTION

FUNCTION forState : BOOL
	VAR_INPUT
		State : STRING[80];
		indexer : INT;
		active : REFERENCE TO BOOL;
		pParameters : REFERENCE TO UDINT;
		sParameters : UDINT;
	END_VAR
END_FUNCTION

FUNCTION forStateGetPointer : BOOL
	VAR_INPUT
		State : STRING[80];
		indexer : INT;
		active : REFERENCE TO BOOL;
		pParameters : REFERENCE TO UDINT;
		sParameters : REFERENCE TO UDINT;
	END_VAR
END_FUNCTION
(*
Executing Commands*)

FUNCTION executeCommand : BOOL
	VAR_INPUT
		Command : STRING[80];
	END_VAR
END_FUNCTION

FUNCTION_BLOCK AtnPLCOpen
	VAR_INPUT
		Command : STRING[80];
		Execute : BOOL;
		Fallback : DINT;
	END_VAR
	VAR_OUTPUT
		Status : DINT;
		StatusMessage : ARRAY[0..9] OF STRING[80];
		Busy : BOOL;
		Done : BOOL;
		Aborted : BOOL;
		Error : BOOL;
	END_VAR
	VAR
		_state : USINT;
		_execute : BOOL;
		_command : {REDUND_UNREPLICABLE} UDINT;
	END_VAR
END_FUNCTION_BLOCK
(*Reading Status*)

FUNCTION stateTrueStatus : BOOL
	VAR_INPUT
		state : STRING[80];
		buffer : UDINT;
		sBuffer : UDINT;
	END_VAR
END_FUNCTION

FUNCTION stateFalseStatus : BOOL
	VAR_INPUT
		state : STRING[80];
		buffer : UDINT;
		sBuffer : UDINT;
	END_VAR
END_FUNCTION

FUNCTION stateStatus : BOOL
	VAR_INPUT
		state : STRING[80];
		buffer : UDINT;
		sBuffer : UDINT;
	END_VAR
END_FUNCTION
