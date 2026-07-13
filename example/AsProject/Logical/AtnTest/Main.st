
PROGRAM _INIT

	(* Wiring only - registrations are made by the REGISTER sequence step so runs are repeatable *)
	atninit(ADR(internal.consoleBuffer), SIZEOF(internal.consoleBuffer));

	task.status.failedStep := -1;
	task.status.state := TEST_ST_READY;

END_PROGRAM

PROGRAM _CYCLIC

	(* Command handling *)
	IF task.command.run AND task.status.state <> TEST_ST_RUNNING THEN
		internal.newCommand := TRUE;
		task.status.state := TEST_ST_RUNNING;
	END_IF

	IF task.command.reset THEN
		internal.newCommand := TRUE;
		task.status.state := TEST_ST_READY;
	END_IF

	(* Centralized new command cleanup *)
	IF internal.newCommand THEN
		task.status.sequence := TEST_SEQ_READY;
		task.status.done := FALSE;
		task.status.passed := FALSE;
		task.status.failedStep := -1;
		internal.newCommand := FALSE;
	END_IF

	(* Logic *)
	CASE task.status.state OF

		TEST_ST_READY:
			task.status.ready := TRUE;
			task.status.statusMessage := 'Ready - set command.run to start';

		TEST_ST_RUNNING:
			task.status.ready := FALSE;
			task.status.statusMessage := 'Running';
			CASE task.status.sequence OF
				TEST_SEQ_READY:
					task.status.sequence := TEST_SEQ_REGISTER;
				TEST_SEQ_DONE:
					task.status.done := TRUE;
					task.status.passed := task.status.failedStep = -1;
					task.status.state := TEST_ST_DONE;
				ELSE
					IF task.parameters.stopOnFirstFailure AND task.status.failedStep <> -1 THEN
						task.status.sequence := TEST_SEQ_DONE;
					ELSE
						TestSequence;
					END_IF
			END_CASE

		TEST_ST_DONE:
			task.status.ready := TRUE;
			IF task.status.passed THEN
				task.status.statusMessage := 'PASSED';
			ELSE
				task.status.statusMessage := 'FAILED - see status.failedStep';
			END_IF

	END_CASE

	(* Reset all commands unconditionally *)
	task.command.run := FALSE;
	task.command.reset := FALSE;

END_PROGRAM
