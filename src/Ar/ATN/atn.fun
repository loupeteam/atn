(*
 * File: atn.fun
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 *
 *)

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
(*
State/Command Interface
*)
(*Registering*)

FUNCTION registerStateBool : UDINT
	VAR_INPUT
		state : STRING[80];
		moduleName : STRING[80];
	END_VAR
	VAR_IN_OUT
		value : BOOL;
	END_VAR
END_FUNCTION

FUNCTION registerStateBoolAdr : UDINT
	VAR_INPUT
		state : STRING[80];
		moduleName : STRING[80];
		value : REFERENCE TO BOOL;
	END_VAR
END_FUNCTION

FUNCTION registerStateParameters : UDINT
	VAR_INPUT
		state : STRING[80];
		moduleName : STRING[80];
		pParameters : REFERENCE TO UDINT;
		sParameters : UDINT;
	END_VAR
END_FUNCTION

FUNCTION registerStateExt1 : UDINT
	VAR_INPUT
		state : STRING[80];
		moduleName : STRING[80];
		pModuleStatus : STRING[80];
		pParameters : REFERENCE TO UDINT;
		sParameters : UDINT;
	END_VAR
	VAR_IN_OUT
		pModuleByPass : BOOL;
		pActive : BOOL;
	END_VAR
END_FUNCTION

FUNCTION registerToResource : UDINT
	VAR_INPUT
		resource : STRING[80];
		moduleName : STRING[80];
	END_VAR
	VAR_IN_OUT
		pResourceUserId : UDINT;
		pResourceActive : BOOL;
	END_VAR
END_FUNCTION
(*Lifecycle*)

FUNCTION registerValue : UDINT
	VAR_INPUT
		state : STRING[80];
		owner : STRING[80];
		pData : REFERENCE TO UDINT;
		sData : UDINT;
		valid : REFERENCE TO BOOL;
		sReturn : UDINT;
		returnTopic : UDINT;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK valueRefFb
	VAR_INPUT
		update : BOOL;
		state : {REDUND_UNREPLICABLE} STRING[80];
		sData : {REDUND_UNREPLICABLE} UDINT;
		owner : {REDUND_UNREPLICABLE} STRING[80];
		pStatus : UDINT;
		sStatus : UDINT;
	END_VAR
	VAR_OUTPUT
		bound : BOOL;
		valid : BOOL;
		sizeMismatch : BOOL;
		returnBound : BOOL;
		data : UDINT;
	END_VAR
	VAR
		cache : REFERENCE TO UDINT;
		registered : BOOL;
		registeredTopic : STRING[80];
	END_VAR
END_FUNCTION_BLOCK

FUNCTION unregister : UDINT (*Remove the calling task's registrations, subscriptions, and behaviors from one state, command, or action topic.
  The calling task is identified automatically via its task name (ST_name), the same way as unregisterAll().
  Returns the number of registrations removed. 0 is not an error.*)
	VAR_INPUT
		name : STRING[80]; (*State, command, or action name*)
	END_VAR
END_FUNCTION

FUNCTION unregisterAll : UDINT (*Remove all registrations, subscriptions, and behaviors created by the calling task, across all state, command, and action topics, including in-flight actions.
  The calling task is identified automatically via its task name (ST_name), so no arguments are required.
  Intended for _EXIT so a task's registrations do not dangle across an online transfer.
  Returns the number of registrations removed. 0 is not an error.*)
END_FUNCTION
(*Subscribing*)

FUNCTION subscribeCommandBool : UDINT
	VAR_INPUT
		commandName : STRING[80];
		moduleName : STRING[80];
	END_VAR
	VAR_IN_OUT
		command : BOOL;
	END_VAR
END_FUNCTION

FUNCTION subscribePLCOpen : UDINT
	VAR_INPUT
		commandName : STRING[80];
		moduleName : STRING[80];
	END_VAR
	VAR_IN_OUT
		command : BOOL;
		status : AtnPlcOpenStatus;
	END_VAR
END_FUNCTION

FUNCTION subscribePLCOpenWithParameters : UDINT
	VAR_INPUT
		commandName : STRING[80];
		moduleName : STRING[80];
		pParameters : REFERENCE TO UDINT;
		sParameters : UDINT;
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

FUNCTION_BLOCK stateAllTrueFb
	VAR_INPUT
		update : BOOL;
		state : {REDUND_UNREPLICABLE} STRING[80];
		fallback : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		value : BOOL;
	END_VAR
	VAR
		cache : REFERENCE TO UDINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK stateAnyTrueFb
	VAR_INPUT
		update : BOOL;
		state : {REDUND_UNREPLICABLE} STRING[80];
		fallback : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		value : BOOL;
	END_VAR
	VAR
		cache : REFERENCE TO UDINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK stateAllFalseFb
	VAR_INPUT
		update : BOOL;
		state : {REDUND_UNREPLICABLE} STRING[80];
		fallback : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		value : BOOL;
	END_VAR
	VAR
		cache : REFERENCE TO UDINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK stateAnyFalseFb
	VAR_INPUT
		update : BOOL;
		state : {REDUND_UNREPLICABLE} STRING[80];
		fallback : {REDUND_UNREPLICABLE} BOOL;
	END_VAR
	VAR_OUTPUT
		value : BOOL;
	END_VAR
	VAR
		cache : REFERENCE TO UDINT;
	END_VAR
END_FUNCTION_BLOCK
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
		_command : {REDUND_UNREPLICABLE} UDINT;
		_execute : BOOL;
		_call : AtnPlcOpenCall;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK AtnPLCOpenWithParameters
	VAR_INPUT
		Command : STRING[80];
		Execute : BOOL;
		Fallback : DINT;
		pParameters : REFERENCE TO UDINT;
		sParameters : {REDUND_UNREPLICABLE} UDINT;
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
		_command : {REDUND_UNREPLICABLE} UDINT;
		_execute : BOOL;
		_call : AtnPlcOpenCall;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK AtnPLCOpenLocal (*In-task PLCOpen caller. Same handshake as AtnPLCOpen but bound by the command BOOL, not a name: the follower's status struct is resolved from the ATN registrations, so only the bool is wired (a mismatched status is impossible) and no string lookup runs. A local call owns only its own bool and status; if the same bool is registered more than once it drives all of those, but never a sibling bool under the same command name. Local and remote calls cancel each other automatically through the shared status. Parameters, when needed, are shared in-task. A bool that matches no registration is a hard Error (Status 50100), never a silent Done.*)
	VAR_INPUT
		Command : REFERENCE TO BOOL; (*the follower's command bool; its status struct is resolved automatically*)
		Execute : BOOL;
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
		_command : {REDUND_UNREPLICABLE} UDINT;
		_execute : BOOL;
		_call : AtnPlcOpenCall;
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

FUNCTION systemJson : BOOL
	VAR_INPUT
		buffer : UDINT;
		sBuffer : UDINT;
	END_VAR
END_FUNCTION
(*Application Functions*)

FUNCTION resourceIsAvailable : BOOL
	VAR_INPUT
		resourceName : STRING[80];
		resourceUserId : UDINT;
	END_VAR
END_FUNCTION

FUNCTION isInhibited : BOOL
	VAR_INPUT
		inhibit : STRING[80];
	END_VAR
END_FUNCTION
