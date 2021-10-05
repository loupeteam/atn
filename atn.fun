(*/********************************************************************
 * COPYRIGHT -- Loupe 
 ********************************************************************
 * Library: All Together Now -atn
 * Author: Josh Polansky
 * Created: April 7, 2020
 ********************************************************************
 * Implementation of library All Together now
 ********************************************************************/*)

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

FUNCTION atnRunAction : USINT
	VAR_INPUT
		director : Atn_typ;
		action : STRING[ATN_ACTION_NAME_LEN];
		pParameters : UDINT;
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
		namespace : STRING[ATN_NAMESPACE_LEN];
		name : STRING[ATN_ACTION_NAME_LEN];
		actionPv : STRING[80];
		parameterPv : STRING[80];
	END_VAR
END_FUNCTION

FUNCTION atnRegisterActionPVLocal : USINT
	VAR_INPUT
		namespace : STRING[ATN_NAMESPACE_LEN];
		name : STRING[ATN_ACTION_NAME_LEN];
		actionPv : STRING[80];
		parameterPv : STRING[80];
	END_VAR
END_FUNCTION

FUNCTION atnRegisterAction : USINT
	VAR_INPUT
		namespace : STRING[ATN_NAMESPACE_LEN];
		name : STRING[ATN_ACTION_NAME_LEN];
		pAction : AtnAPI_typ;
		pParameters : UDINT;
		parameterSize : UDINT;
	END_VAR
END_FUNCTION

FUNCTION atnGetActionList : UDINT
	VAR_INPUT
		namespace : STRING[ATN_NAMESPACE_LEN];
	END_VAR
END_FUNCTION

FUNCTION atnSetActionList : BOOL
	VAR_INPUT
		namespace : STRING[ATN_NAMESPACE_LEN];
		pActions : AtnActionData_typ;
		size : UDINT;
	END_VAR
END_FUNCTION
