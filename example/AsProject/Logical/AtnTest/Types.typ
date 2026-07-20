(* ATN unregister API self-test - private types *)
TYPE
	TestState_enum :
		(
		TEST_ST_READY,
		TEST_ST_RUNNING,
		TEST_ST_DONE
		);
	TestSequence_enum :
		(
		TEST_SEQ_READY,              (* 0 *)
		TEST_SEQ_REGISTER,           (* 1 - register fixtures under two owners *)
		TEST_SEQ_BASELINE_STATE,     (* 2 - registered bools aggregate *)
		TEST_SEQ_BASELINE_COMMAND,   (* 3 - executeCommand reaches subscribed bits *)
		TEST_SEQ_UNREGISTER_ONE,     (* 4 - unregister removes this task's entries from one topic *)
		TEST_SEQ_VERIFY_REMAINING,   (* 5 - other topics unaffected *)
		TEST_SEQ_UNREGISTER_UNKNOWN, (* 6 - unknown topic removes nothing *)
		TEST_SEQ_SWEEP_TASK,         (* 7 - no-arg unregisterAll() sweeps all of this task's registrations *)
		TEST_SEQ_VERIFY_EMPTY,       (* 8 - swept topics behave like never-created *)
		TEST_SEQ_DIAG_SUBSCRIBE,     (* 9 - subscribe an 8-byte PLCOpen follower; snapshot logbook + count *)
		TEST_SEQ_DIAG_RAISE,         (* 10 - drive the FUB with a 4-byte sender to force a size mismatch *)
		TEST_SEQ_DIAG_VERIFY,        (* 11 - a customer WARNING landed in $arlogusr and count advanced *)
		TEST_SEQ_DIAG_LATCH,         (* 12 - re-executing the same mismatch does not raise again *)
		TEST_SEQ_DIAG_CLEANUP,       (* 13 - remove the diagnostics fixture *)
		TEST_SEQ_DONE                (* 14 *)
		);
	localInterfaceCommand_typ : 	STRUCT
		run : BOOL; (* Run the self-test *)
		reset : BOOL; (* Return to READY and clear results *)
	END_STRUCT;
	localInterfaceParameters_typ : 	STRUCT
		stopOnFirstFailure : BOOL; (* Abort the sequence at the first failed check *)
	END_STRUCT;
	localInterfaceStatus_typ : 	STRUCT
		ready : BOOL; (* Ready for the run command *)
		done : BOOL; (* Test sequence complete *)
		passed : BOOL; (* All checks passed *)
		failedStep : INT; (* Sequence ordinal of the first failed check, -1 if none *)
		state : TestState_enum;
		sequence : TestSequence_enum;
		statusMessage : STRING[80];
	END_STRUCT;
	localInterface_typ : 	STRUCT
		command : localInterfaceCommand_typ;
		parameters : localInterfaceParameters_typ;
		status : localInterfaceStatus_typ;
	END_STRUCT;
	localInterfaceInternal_typ : 	STRUCT
		newCommand : BOOL;
		consoleBuffer : ARRAY[0..8191] OF USINT; (* ATN console buffer - required by atninit *)
		readyA : BOOL; (* Registered to TestState as OwnerA *)
		readyB : BOOL; (* Registered to TestState as OwnerB *)
		cmdBit : BOOL; (* Subscribed to TestCmd as OwnerA via PLCOpen *)
		cmd2Bit : BOOL; (* Subscribed to TestCmd2 as OwnerA *)
		plcStatus : AtnPlcOpenStatus;
		removedCount : UDINT;
		countResult : INT;
		allTrueResult : BOOL;
		execResult : BOOL;
		(* --- diagnostics end-to-end fixture (steps 9-13) --- *)
		diagFollowerParams : ARRAY[0..1] OF UDINT; (* 8-byte follower parameter buffer *)
		diagSenderParams : UDINT;                  (* 4-byte sender -> deliberate size mismatch *)
		diagCmdBit : BOOL;                          (* command bit for the DiagCmd PLCOpen follower *)
		diagPlcStatus : AtnPlcOpenStatus;
		fbDiagPlcOpen : AtnPLCOpenWithParameters;   (* drives the mismatched parameter write *)
		diagCountBaseline : UDINT;                  (* atnDiagnosticCount before the raise *)
		diagCountAfterRaise : UDINT;                (* atnDiagnosticCount after the first raise *)
		diagStatusResult : DINT;                    (* atnSetDiagnosticLogger return *)
		(* logbook read-back via ArEventLog *)
		fbGetIdent : ArEventLogGetIdent;
		fbGetLatest : ArEventLogGetLatestRecordID;
		fbGetPrev : ArEventLogGetPreviousRecordID;
		fbRead : ArEventLogRead;
		usrIdent : ArEventLogIdentType;             (* $arlogusr logbook ident *)
		baselineRecordID : ArEventLogRecordIDType;  (* latest record before the raise *)
		walkRecordID : ArEventLogRecordIDType;      (* cursor while scanning new records *)
		readEventID : DINT;
		walkGuard : USINT;                          (* bounds the backward scan *)
		foundCustomerWarning : BOOL;                (* a new customer-area warning was found *)
	END_STRUCT;
END_TYPE
