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
		TEST_SEQ_UNREGISTER_ONE,     (* 4 - unregister removes exactly one owner's entry *)
		TEST_SEQ_VERIFY_REMAINING,   (* 5 - other owner unaffected *)
		TEST_SEQ_UNREGISTER_UNKNOWN, (* 6 - unknown topic removes nothing *)
		TEST_SEQ_SWEEP_OWNERA,       (* 7 - unregisterAll sweeps command subscriptions *)
		TEST_SEQ_VERIFY_SWEPT,       (* 8 - swept bits no longer written *)
		TEST_SEQ_SWEEP_OWNERB,       (* 9 - owners sweep independently *)
		TEST_SEQ_VERIFY_EMPTY,       (* 10 - emptied topic behaves like never-created *)
		TEST_SEQ_DONE                (* 11 *)
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
	END_STRUCT;
END_TYPE
