(* Test sequence - each step is self-contained and advances the sequence.
   A failed check records the sequence ordinal in task.status.failedStep (first failure wins). *)
ACTION TestSequence:

	CASE task.status.sequence OF

		TEST_SEQ_REGISTER:
			(* Sweep any leftovers from a prior aborted run so counts start clean.
			   No-arg unregisterAll() removes everything this task registered, regardless of owner. *)
			internal.removedCount := unregisterAll();
			internal.readyA := FALSE;
			internal.readyB := FALSE;
			internal.cmdBit := FALSE;
			internal.cmd2Bit := FALSE;
			registerStateBool('TestState', 'OwnerA', internal.readyA);
			registerStateBool('TestState', 'OwnerB', internal.readyB);
			subscribePLCOpen('TestCmd', 'OwnerA', internal.cmdBit, internal.plcStatus);
			subscribeCommandBool('TestCmd2', 'OwnerA', internal.cmd2Bit);
			task.status.sequence := TEST_SEQ_BASELINE_STATE;

		TEST_SEQ_BASELINE_STATE:
			internal.readyA := TRUE;
			internal.readyB := TRUE;
			internal.countResult := stateCount('TestState');
			internal.allTrueResult := stateAllTrue('TestState', FALSE);
			IF (internal.countResult <> 1 OR NOT internal.allTrueResult) AND task.status.failedStep = -1 THEN
				task.status.failedStep := 2;
			END_IF
			task.status.sequence := TEST_SEQ_BASELINE_COMMAND;

		TEST_SEQ_BASELINE_COMMAND:
			internal.execResult := executeCommand('TestCmd');
			IF (NOT internal.execResult OR NOT internal.cmdBit) AND task.status.failedStep = -1 THEN
				task.status.failedStep := 3;
			END_IF
			internal.cmdBit := FALSE;
			internal.execResult := executeCommand('TestCmd2');
			IF (NOT internal.execResult OR NOT internal.cmd2Bit) AND task.status.failedStep = -1 THEN
				task.status.failedStep := 3;
			END_IF
			internal.cmd2Bit := FALSE;
			task.status.sequence := TEST_SEQ_UNREGISTER_ONE;

		TEST_SEQ_UNREGISTER_ONE:
			internal.removedCount := unregister('TestState', 'OwnerA');
			IF internal.removedCount <> 1 AND task.status.failedStep = -1 THEN
				task.status.failedStep := 4;
			END_IF
			task.status.sequence := TEST_SEQ_VERIFY_REMAINING;

		TEST_SEQ_VERIFY_REMAINING:
			internal.readyA := FALSE;
			internal.countResult := stateCount('TestState');
			internal.allTrueResult := stateAllTrue('TestState', FALSE);
			IF (internal.countResult <> 0 OR NOT internal.allTrueResult) AND task.status.failedStep = -1 THEN
				task.status.failedStep := 5;
			END_IF
			task.status.sequence := TEST_SEQ_UNREGISTER_UNKNOWN;

		TEST_SEQ_UNREGISTER_UNKNOWN:
			internal.removedCount := unregister('DoesNotExist', 'OwnerA');
			IF internal.removedCount <> 0 AND task.status.failedStep = -1 THEN
				task.status.failedStep := 6;
			END_IF
			task.status.sequence := TEST_SEQ_SWEEP_TASK;

		TEST_SEQ_SWEEP_TASK:
			(* No-arg unregisterAll() removes every registration this task made, regardless of
			   owner: TestState/OwnerB + TestCmd/OwnerA + TestCmd2/OwnerA = 3 *)
			internal.removedCount := unregisterAll();
			IF internal.removedCount <> 3 AND task.status.failedStep = -1 THEN
				task.status.failedStep := 7;
			END_IF
			task.status.sequence := TEST_SEQ_VERIFY_EMPTY;

		TEST_SEQ_VERIFY_EMPTY:
			(* Swept command subscriptions are no longer written *)
			internal.cmdBit := FALSE;
			internal.cmd2Bit := FALSE;
			internal.execResult := executeCommand('TestCmd');
			IF internal.cmdBit AND task.status.failedStep = -1 THEN
				task.status.failedStep := 8;
			END_IF
			internal.execResult := executeCommand('TestCmd2');
			IF internal.cmd2Bit AND task.status.failedStep = -1 THEN
				task.status.failedStep := 8;
			END_IF
			(* Emptied state topic behaves like never-created *)
			internal.countResult := stateCount('TestState');
			IF internal.countResult <> -1 AND task.status.failedStep = -1 THEN
				task.status.failedStep := 8;
			END_IF
			internal.allTrueResult := stateAllTrue('TestState', TRUE);
			IF NOT internal.allTrueResult AND task.status.failedStep = -1 THEN
				task.status.failedStep := 8;
			END_IF
			internal.allTrueResult := stateAllTrue('TestState', FALSE);
			IF internal.allTrueResult AND task.status.failedStep = -1 THEN
				task.status.failedStep := 8;
			END_IF
			task.status.sequence := TEST_SEQ_DONE;

	END_CASE

END_ACTION
