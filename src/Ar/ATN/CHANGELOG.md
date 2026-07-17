2.0.0 - Remove deprecated Actions and Threads (breaking)
		- Remove the Action/Behavior execution engine and Director thread handling
		- Remove the action C-API (registerBehavior, executeAction, executeActionReport, oneShot, respond, readCallState)
		- Remove action/thread types (AtnAPI_typ, AtnApiStatus_typ, AtnApiStatusLocal_typ, ATN_ST_enum, ATN_RESPONSE_ST, ATN_ERROR_enum) and the ATN_ACTION_NAME_LEN constant
		- Replace the developer test suite with command/state/PLCOpen coverage
1.0.0 - Update project to AS6, add publish workflow
0.09.0 - Add non-fatal diagnostics channel backed by the event logger (LogThat)
		- atnRaise writes to the user logbook ($arlogusr) by default; atnSetDiagnosticLogger overrides the logbook
		- atnDiagnosticCount reports the total diagnostics raised since startup
		- PLCOpen parameter size mismatches raise a warning once per occurrence instead of silently dropping the write
		- Iterate PLCOpenState by reference in the PLCOpen FUB loops
0.08.0 - Surface single-publisher value topics in the interactive console and system JSON
0.07.0 - Add lifecycle cleanup APIs: register/subscribe now capture the calling task name (ST_name); unregisterAll() takes no arguments and removes all of the calling task's registrations for transfer-safe _EXIT cleanup; unregister(name) removes the calling task's registrations from a single topic
0.06.2 - Update for oss release
0.06.1 - Remove bur_heap_size from director.cpp
0.06.0 - Remove depricated functionality
0.05.1 - Add tlsf dependency
0.04.7 - Fix memory handling
0.04.6 - Fully clear buffers on first reset after initialization
0.04.5 - Fix isInhibited logic
0.04.4 - Add improved User facing functions for inhibit and resource sharing
0.04.3 - Fix uninitialized bool
0.04.2 - Add function to read out the system as json
0.04.1 - Add active command string to PLCOpen structure
0.04.0 - Add new Apis for statuses and commands
0.03.0 - Fix some namespaces lengths
		- Add support for multiple action namespaces
		- Add support for multiple threads
		- Update documentation 
0.02.0 - Add activeThread information to output
0.01.0 - Initial release!
0.00.2 - pre-release
0.00.1 - pre-release

