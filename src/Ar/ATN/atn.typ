(*
 * File: atn.typ
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 *
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 *
 *)

TYPE
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
