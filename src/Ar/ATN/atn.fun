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

FUNCTION unregister : UDINT (*Remove this owner's registrations, subscriptions, and behaviors from one state, command, or action topic.
  owner must exactly match the moduleName used at registration.
  Returns the number of registrations removed. 0 is not an error.*)
	VAR_INPUT
		name : STRING[80]; (*State, command, or action name*)
		owner : STRING[80]; (*moduleName used at registration*)
	END_VAR
END_FUNCTION

FUNCTION unregisterAll : UDINT (*Remove this owner's registrations, subscriptions, and behaviors from all state, command, and action topics, including in-flight actions.
  Intended for _EXIT so a task's registrations do not dangle across an online transfer.
  owner must exactly match the moduleName used at registration.
  Returns the number of registrations removed. 0 is not an error.*)
	VAR_INPUT
		owner : STRING[80]; (*moduleName used at registration*)
	END_VAR
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

(*Writes a non-fatal diagnostic to the event logger (default: the user logbook, $arlogusr). The logger provides timestamp, ordering, storage, and persistence. Thread-safe: may be called from any task class. The write runs synchronously in the caller's context - raise on events, not every scan. code is a stable ATN diagnostic code (see AtnDiagCode_enum; 0-99 reserved for ATN). source identifies the raising module and is prepended to the logged message. Returns 0 on success, -1 if no director exists (atninit not called), otherwise the ArEventLog/LogThat StatusID (e.g. logbook not found).*)

FUNCTION atnRaise : DINT
	VAR_INPUT
		severity : AtnDiagSeverity_enum;
		code : UINT;
		source : STRING[80];
		message : STRING[120];
	END_VAR
END_FUNCTION

(*Returns the total number of diagnostics raised since startup (monotonic; NOT the number pending anywhere). Includes raises whose logger write failed. Returns 0 if no director exists. The counter is advisory: a concurrent raise from a preempting task class may occasionally lose an increment.*)

FUNCTION atnDiagnosticCount : UDINT
END_FUNCTION

(*Selects the logbook that atnRaise writes to. Defaults to the user logbook ($arlogusr), which always exists. A custom logbook must be created separately (e.g. LogThat's createLogInit in an INIT program) before diagnostics can be written to it. Call after atninit. Returns 0 on success, -1 if no director exists or the name is empty/longer than 80 characters.*)

FUNCTION atnSetDiagnosticLogger : DINT
	VAR_INPUT
		loggerName : STRING[80];
	END_VAR
END_FUNCTION
