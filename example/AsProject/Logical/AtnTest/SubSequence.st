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
			(* unregister(name) is task-scoped: it removes everything this task registered
			   on the named topic, so both TestState owners go at once. *)
			internal.removedCount := unregister('TestState');
			IF internal.removedCount <> 2 AND task.status.failedStep = -1 THEN
				task.status.failedStep := 4;
			END_IF
			task.status.sequence := TEST_SEQ_VERIFY_REMAINING;

		TEST_SEQ_VERIFY_REMAINING:
			(* Only the named topic was touched: TestState is now empty, command
			   subscriptions on other topics still work. *)
			internal.readyA := FALSE;
			internal.readyB := FALSE;
			internal.countResult := stateCount('TestState');
			IF internal.countResult <> -1 AND task.status.failedStep = -1 THEN
				task.status.failedStep := 5;
			END_IF
			internal.cmdBit := FALSE;
			internal.execResult := executeCommand('TestCmd');
			IF (NOT internal.execResult OR NOT internal.cmdBit) AND task.status.failedStep = -1 THEN
				task.status.failedStep := 5;
			END_IF
			internal.cmdBit := FALSE;
			task.status.sequence := TEST_SEQ_UNREGISTER_UNKNOWN;

		TEST_SEQ_UNREGISTER_UNKNOWN:
			internal.removedCount := unregister('DoesNotExist');
			IF internal.removedCount <> 0 AND task.status.failedStep = -1 THEN
				task.status.failedStep := 6;
			END_IF
			task.status.sequence := TEST_SEQ_SWEEP_TASK;

		TEST_SEQ_SWEEP_TASK:
			(* No-arg unregisterAll() removes every registration this task made across all
			   remaining topics: TestCmd/OwnerA + TestCmd2/OwnerA = 2 *)
			internal.removedCount := unregisterAll();
			IF internal.removedCount <> 2 AND task.status.failedStep = -1 THEN
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
			task.status.sequence := TEST_SEQ_DIAG_SUBSCRIBE;

		(* --- Diagnostics end-to-end: force a PLCOpen parameter size mismatch and
		   confirm ATN raised a warning through the real LogThat -> ArEventLog path,
		   landing a customer WARNING in the user logbook ($arlogusr). --- *)

		TEST_SEQ_DIAG_SUBSCRIBE:
			(* Sink the diagnostics at the user logbook explicitly (also the default) *)
			(* '$$' escapes to a single '$' in B&R ST string literals -> '$arlogusr' *)
			internal.diagStatusResult := atnSetDiagnosticLogger('$$arlogusr');
			IF internal.diagStatusResult <> 0 AND task.status.failedStep = -1 THEN
				task.status.failedStep := 9;
			END_IF

			(* Subscribe an 8-byte follower; the FUB will later write a 4-byte sender *)
			internal.diagCmdBit := FALSE;
			subscribePLCOpenWithParameters('DiagCmd', 'DiagFollower', ADR(internal.diagFollowerParams), SIZEOF(internal.diagFollowerParams), internal.diagCmdBit, internal.diagPlcStatus);

			(* Snapshot the diagnostics counter and the newest logbook record so the
			   verify step can prove a *new* warning appeared. *)
			internal.diagCountBaseline := atnDiagnosticCount();

			internal.fbGetIdent.Name := '$$arlogusr';
			internal.fbGetIdent.Execute := TRUE;
			internal.fbGetIdent();
			internal.usrIdent := internal.fbGetIdent.Ident;
			internal.fbGetIdent.Execute := FALSE;
			internal.fbGetIdent();
			IF internal.fbGetIdent.Error AND task.status.failedStep = -1 THEN
				task.status.failedStep := 9;
			END_IF

			internal.fbGetLatest.Ident := internal.usrIdent;
			internal.fbGetLatest.Execute := TRUE;
			internal.fbGetLatest();
			internal.baselineRecordID := internal.fbGetLatest.RecordID;
			internal.fbGetLatest.Execute := FALSE;
			internal.fbGetLatest();

			task.status.sequence := TEST_SEQ_DIAG_RAISE;

		TEST_SEQ_DIAG_RAISE:
			(* Drive the parameterized PLCOpen command with a 4-byte sender against the
			   8-byte follower -> size mismatch -> ATN raises one warning. Pump until done. *)
			internal.fbDiagPlcOpen.Command := 'DiagCmd';
			internal.fbDiagPlcOpen.pParameters := ADR(internal.diagSenderParams);
			internal.fbDiagPlcOpen.sParameters := SIZEOF(internal.diagSenderParams);
			internal.fbDiagPlcOpen.Execute := TRUE;
			internal.fbDiagPlcOpen();
			(* No real module drives the follower here, and setTrue() marks it BUSY, so
			   simulate the follower reporting done (status 0) to let the command finish.
			   The mismatch warning is already raised in WRITE_PAR, before this. *)
			internal.diagPlcStatus.status := 0;
			IF internal.fbDiagPlcOpen.Done OR internal.fbDiagPlcOpen.Error OR internal.fbDiagPlcOpen.Aborted THEN
				internal.fbDiagPlcOpen.Execute := FALSE;
				internal.fbDiagPlcOpen();
				task.status.sequence := TEST_SEQ_DIAG_VERIFY;
			END_IF

		TEST_SEQ_DIAG_VERIFY:
			(* The counter advanced by exactly one raise *)
			internal.diagCountAfterRaise := atnDiagnosticCount();
			IF internal.diagCountAfterRaise <> internal.diagCountBaseline + 1 AND task.status.failedStep = -1 THEN
				task.status.failedStep := 11;
			END_IF

			(* Scan back from the newest record (bounded) for a new customer-area
			   warning - that is the entry ATN wrote via LogThat/ArEventLog. *)
			internal.fbGetLatest.Ident := internal.usrIdent;
			internal.fbGetLatest.Execute := TRUE;
			internal.fbGetLatest();
			internal.walkRecordID := internal.fbGetLatest.RecordID;
			internal.fbGetLatest.Execute := FALSE;
			internal.fbGetLatest();

			internal.foundCustomerWarning := FALSE;
			internal.walkGuard := 16;
			WHILE internal.walkGuard > 0 AND NOT internal.foundCustomerWarning AND internal.walkRecordID <> internal.baselineRecordID DO
				internal.fbRead.Ident := internal.usrIdent;
				internal.fbRead.RecordID := internal.walkRecordID;
				internal.fbRead.Execute := TRUE;
				internal.fbRead();
				internal.readEventID := internal.fbRead.EventID;
				internal.fbRead.Execute := FALSE;
				internal.fbRead();

				IF ArEventLogIsWarning(internal.readEventID) AND ArEventLogIsCustomerArea(internal.readEventID) THEN
					internal.foundCustomerWarning := TRUE;
				ELSE
					internal.fbGetPrev.Ident := internal.usrIdent;
					internal.fbGetPrev.RecordID := internal.walkRecordID;
					internal.fbGetPrev.Execute := TRUE;
					internal.fbGetPrev();
					internal.walkRecordID := internal.fbGetPrev.PrevRecordID;
					internal.fbGetPrev.Execute := FALSE;
					internal.fbGetPrev();
					internal.walkGuard := internal.walkGuard - 1;
				END_IF
			END_WHILE

			IF NOT internal.foundCustomerWarning AND task.status.failedStep = -1 THEN
				task.status.failedStep := 11;
			END_IF

			task.status.sequence := TEST_SEQ_DIAG_LATCH;

		TEST_SEQ_DIAG_LATCH:
			(* Re-execute the identical mismatch. The follower's latch persists (the fix
			   for the by-value iteration bug), so no additional diagnostic is raised. *)
			internal.fbDiagPlcOpen.Command := 'DiagCmd';
			internal.fbDiagPlcOpen.pParameters := ADR(internal.diagSenderParams);
			internal.fbDiagPlcOpen.sParameters := SIZEOF(internal.diagSenderParams);
			internal.fbDiagPlcOpen.Execute := TRUE;
			internal.fbDiagPlcOpen();
			internal.diagPlcStatus.status := 0; (* simulate the follower reporting done *)
			IF internal.fbDiagPlcOpen.Done OR internal.fbDiagPlcOpen.Error OR internal.fbDiagPlcOpen.Aborted THEN
				internal.fbDiagPlcOpen.Execute := FALSE;
				internal.fbDiagPlcOpen();
				IF atnDiagnosticCount() <> internal.diagCountAfterRaise AND task.status.failedStep = -1 THEN
					task.status.failedStep := 12;
				END_IF
				task.status.sequence := TEST_SEQ_DIAG_CLEANUP;
			END_IF

		TEST_SEQ_DIAG_CLEANUP:
			internal.removedCount := unregister('DiagCmd');
			task.status.sequence := TEST_SEQ_DONE;

	END_CASE

END_ACTION
