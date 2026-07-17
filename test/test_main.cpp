/*
 * File: test_main.cpp
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 *
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 *
 * Unit tests for the ATN command / state / PLCOpen / diagnostics system. The
 * REQUIRE-based checks drive the Director C++ API directly; the throw-based
 * diagnostics checks drive the IEC-facing C API (the same engine). A thrown
 * message is reported by the catch handler instead of aborting silently.
 */

#include <iostream>
#include <cstring>

#ifdef __cplusplus
extern "C" {
#endif

#include "atn.h"

#ifdef __cplusplus
}
#endif

#include "LogThat.h"
#include "Director.h"
#include "atnApi.h"

using namespace std;

static int failures = 0;

#define REQUIRE( cond, msg )                                        \
	do {                                                            \
		if( !(cond) ){                                              \
			std::cout << "FAIL: " << (msg) << "\n";                 \
			++failures;                                             \
		}                                                           \
	} while( 0 )

int main(int argc, char const *argv[]) try {

	atn::Director director;
	// Not-found paths guard on outstream; keep it null so tests stay quiet.
	director.outstream = nullptr;

	///TEST DIAG 0: diagnostics API with no director set
	// (must run before atnSetDirector below)
	if( atnRaise( ATN_DIAG_WARNING, 1, (plcstring*)"src", (plcstring*)"msg" ) != -1 ){
		throw "atnRaise without director should return -1";
	}
	if( atnDiagnosticCount() != 0 ){
		throw "atnDiagnosticCount without director should return 0";
	}
	if( atnSetDiagnosticLogger( (plcstring*)"mylog" ) != -1 ){
		throw "atnSetDiagnosticLogger without director should return -1";
	}
	if( logThatShimCount != 0 ){
		throw "no log writes expected without a director";
	}

	///TEST 1: State aggregation (allTrue / anyTrue / allFalse / anyFalse)
	{
		bool a = false;
		bool b = false;
		director.addStateBool( "running", "ModA", &a );
		director.addStateBool( "running", "ModB", &b );

		atn::State *running = director.getState( "running" );
		REQUIRE( running != 0, "state 'running' should be found after registration" );
		REQUIRE( running->count() == 2, "state 'running' should have two subscribed modules" );

		// both false
		REQUIRE( running->allTrue( true ) == false,  "allTrue should be false when all members are false" );
		REQUIRE( running->anyTrue( true ) == false,  "anyTrue should be false when all members are false" );
		REQUIRE( running->allFalse( false ) == true, "allFalse should be true when all members are false" );

		// one true
		a = true;
		REQUIRE( running->allTrue( true ) == false, "allTrue should be false when only one member is true" );
		REQUIRE( running->anyTrue( false ) == true, "anyTrue should be true when one member is true" );
		REQUIRE( running->anyFalse( false ) == true, "anyFalse should be true when one member is false" );

		// both true
		b = true;
		REQUIRE( running->allTrue( false ) == true,  "allTrue should be true when all members are true" );
		REQUIRE( running->anyFalse( true ) == false, "anyFalse should be false when all members are true" );
	}

	///TEST 2: Bypassed members are ignored by aggregation
	{
		bool live    = true;
		bool bypVal  = false;   // false, but bypassed, so it must not drag allTrue down
		bool bypass  = true;
		char status[81] = { 0 };

		director.addStateBool( "mix", "ModLive", &live );
		director.addState( "mix", "ModBypassed", status, &bypass, &bypVal, 0, 0 );

		atn::State *mix = director.getState( "mix" );
		REQUIRE( mix != 0, "state 'mix' should be found" );
		REQUIRE( mix->allTrue( false ) == true, "allTrue should skip bypassed members" );

		// Un-bypass: now the false member counts and allTrue must drop to false.
		bypass = false;
		REQUIRE( mix->allTrue( false ) == false, "un-bypassed false member should make allTrue false" );
	}

	///TEST 3: Command bits (execute / reset)
	{
		bool startBit = false;
		director.addCommandBool( "start", "ModA", &startBit );

		REQUIRE( director.executeCommand( "start" ) == true, "executeCommand should succeed for a registered command" );
		REQUIRE( startBit == true, "executeCommand should set the registered command bit true" );

		director.resetCommand( "start" );
		REQUIRE( startBit == false, "resetCommand should clear the registered command bit" );

		REQUIRE( director.executeCommand( "does-not-exist" ) == false, "executeCommand should fail for an unknown command" );
	}

	///TEST 4: Resource sharing (allFalseExcept)
	{
		unsigned long userId = 0;
		bool held = false;
		director.addResourceBool( "conveyor", "ModA", &userId, &held );

		atn::State *res = director.getState( "conveyor" );
		REQUIRE( res != 0, "resource 'conveyor' should be found" );

		// Nothing holding it -> available for anyone.
		REQUIRE( res->allFalseExcept( true, 12345 ) == true, "free resource should be available" );

		// ModA takes it. userId was seeded with its own address by addResourceBool.
		held = true;
		REQUIRE( res->allFalseExcept( true, userId ) == true,  "holder should still see the resource as available to itself" );
		REQUIRE( res->allFalseExcept( true, userId + 1 ) == false, "a different user should see the resource as taken" );
	}

	///TEST 5: PLCOpen command status reporting
	{
		AtnPlcOpenStatus st = {};
		bool cmdBit = false;
		director.addCommandPLCOpen( "home", "ModAxis", &cmdBit, &st );

		atn::State *home = director.getCommand( "home" );
		REQUIRE( home != 0, "PLCOpen command 'home' should be found" );

		// Idle module reports 0 (done) as the group status.
		st.status = 0;
		REQUIRE( home->getPLCOpenState( 0 ) == 0, "idle PLCOpen command should report 0" );

		// Executing the command sets the bit and marks the module busy (65535).
		REQUIRE( director.executeCommand( "home" ) == true, "executeCommand should succeed for a PLCOpen command" );
		REQUIRE( cmdBit == true, "executeCommand should set the PLCOpen command bit" );
		REQUIRE( home->getPLCOpenState( 0 ) == 65535, "an executing PLCOpen command should report busy (65535)" );

		// A module-reported error dominates the group status.
		st.status = 42;
		REQUIRE( home->getPLCOpenState( 0 ) == 42, "PLCOpen group status should surface a module error code" );
	}

	// Wire the C API to this director for the diagnostics and unregister tests.
	atnSetDirector( &director );

	///TEST DIAG 1: atnRaise forwards to the event logger
	logThatShimReset();
	if( atnRaise( ATN_DIAG_WARNING, 42, (plcstring*)"unittest", (plcstring*)"hello" ) != 0 ){
		throw "atnRaise should return 0 on success";
	}
	if( logThatShimCount != 1 ){
		throw "atnRaise should produce exactly one log write";
	}
	if( logThatShimCalls[0].severity != LOGTHAT_SHIM_WARNING ){
		throw "severity should map to logWarning";
	}
	if( logThatShimCalls[0].code != 42 ){
		throw "code should be forwarded as the logger error ID";
	}
	if( strcmp( logThatShimCalls[0].loggerName, "$arlogusr" ) != 0 ){
		throw "default logbook should be $arlogusr";
	}
	if( strcmp( logThatShimCalls[0].message, "[unittest] hello" ) != 0 ){
		throw "message should be formatted as [source] message";
	}
	if( atnDiagnosticCount() != 1 ){
		throw "diagnostic count should be 1";
	}
	atnRaise( ATN_DIAG_INFO, 1, (plcstring*)"unittest", (plcstring*)"i" );
	if( logThatShimCalls[1].severity != LOGTHAT_SHIM_INFO ){
		throw "severity should map to logInfo";
	}
	atnRaise( ATN_DIAG_ERROR, 1, (plcstring*)"unittest", (plcstring*)"e" );
	if( logThatShimCalls[2].severity != LOGTHAT_SHIM_ERROR ){
		throw "severity should map to logError";
	}
	if( atnDiagnosticCount() != 3 ){
		throw "diagnostic count should be 3";
	}
	if( atnSetDiagnosticLogger( (plcstring*)"mylog" ) != 0 ){
		throw "atnSetDiagnosticLogger should return 0 on success";
	}
	atnRaise( ATN_DIAG_WARNING, 1, (plcstring*)"unittest", (plcstring*)"w" );
	if( strcmp( logThatShimCalls[3].loggerName, "mylog" ) != 0 ){
		throw "raise should write to the configured logbook";
	}
	logThatShimReturn = 4711;
	if( atnRaise( ATN_DIAG_WARNING, 1, (plcstring*)"unittest", (plcstring*)"w" ) != 4711 ){
		throw "logger status should propagate out of atnRaise";
	}
	if( atnDiagnosticCount() != 5 ){
		throw "count should include raises whose logger write failed";
	}
	logThatShimReturn = 0;
	if( atnSetDiagnosticLogger( (plcstring*)"" ) != -1 ){
		throw "empty logger name should be rejected";
	}
	atnSetDiagnosticLogger( (plcstring*)"$arlogusr" );

	///TEST DIAG 2: writeParameters mismatch latch on a bare PLCOpen
	{
		char followerBuf[8] = {};
		char senderSmall[4] = {1,2,3,4};
		char senderOk[8] = {5,6,7,8,9,10,11,12};
		bool poValue = false;
		atn::PLCOpen po( "unitpo", &poValue, followerBuf, sizeof(followerBuf) );

		if( po.writeParameters( senderSmall, sizeof(senderSmall) ) != atn::PLCOpen::WRITE_PARAMS_MISMATCH ){
			throw "first mismatch should report WRITE_PARAMS_MISMATCH";
		}
		if( po.writeParameters( senderSmall, sizeof(senderSmall) ) != atn::PLCOpen::WRITE_PARAMS_MISMATCH_LATCHED ){
			throw "repeated mismatch should be latched";
		}
		if( po.writeParameters( 0, 0 ) != atn::PLCOpen::WRITE_PARAMS_CLEARED ){
			throw "null write should report WRITE_PARAMS_CLEARED";
		}
		if( po.writeParameters( senderSmall, sizeof(senderSmall) ) != atn::PLCOpen::WRITE_PARAMS_MISMATCH_LATCHED ){
			throw "clear path must not re-arm the mismatch latch";
		}
		if( po.writeParameters( senderOk, sizeof(senderOk) ) != atn::PLCOpen::WRITE_PARAMS_WRITTEN ){
			throw "matching write should report WRITE_PARAMS_WRITTEN";
		}
		if( memcmp( followerBuf, senderOk, sizeof(senderOk) ) != 0 ){
			throw "matching write should copy the parameters";
		}
		if( po.writeParameters( senderSmall, sizeof(senderSmall) ) != atn::PLCOpen::WRITE_PARAMS_MISMATCH ){
			throw "successful write should re-arm the mismatch latch";
		}
	}

	///TEST DIAG 3: FUB integration - persistent mismatch logs once per occurrence
	// (regression test for the by-value PLCOpenState iteration bug)
	{
		char followerParams[8] = {};
		char senderSmall[4] = {1,2,3,4};
		char senderOk[8] = {5,6,7,8,9,10,11,12};
		plcbit moveCmd = 0;
		AtnPlcOpenStatus moveStatus = {};
		subscribePLCOpenWithParameters( (plcstring*)"movecmd", (plcstring*)"unitmod",
			(unsigned long*)followerParams, sizeof(followerParams), &moveCmd, &moveStatus );

		AtnPLCOpenWithParameters_typ fub = {};
		strcpy( (char*)fub.Command, "movecmd" );
		fub.pParameters = (unsigned long*)senderSmall;
		fub.sParameters = sizeof(senderSmall);

		logThatShimReset();

		// Drives one full Execute cycle: start (parameters written, follower
		// forced busy), follower reports done (status 0), FUB completes,
		// Execute released back to idle.
		auto runCommand = [&]() {
			fub.Execute = 1;
			AtnPLCOpenWithParameters( &fub );
			if( !fub.Busy ){
				throw "FUB should be busy after execute";
			}
			moveStatus.status = 0;
			AtnPLCOpenWithParameters( &fub );
			if( !fub.Done ){
				throw "FUB should complete after the follower reports status 0";
			}
			fub.Execute = 0;
			AtnPLCOpenWithParameters( &fub );
		};

		runCommand();
		if( logThatShimCount != 1 ){
			throw "first mismatch should log exactly once";
		}
		if( logThatShimCalls[0].severity != LOGTHAT_SHIM_WARNING ){
			throw "mismatch should log a warning";
		}
		if( logThatShimCalls[0].code != ATN_DIAG_CODE_PARAM_MISMATCH ){
			throw "mismatch should use ATN_DIAG_CODE_PARAM_MISMATCH";
		}
		if( strstr( logThatShimCalls[0].message, "size mismatch" ) == 0 ){
			throw "mismatch message should describe the size mismatch";
		}
		if( strstr( logThatShimCalls[0].message, "[unitmod]" ) == 0 ){
			throw "mismatch message should name the follower module";
		}
		if( moveStatus.parametersWritten ){
			throw "mismatched parameters must not be marked written";
		}

		// Re-execute with the mismatch still present: latch must persist
		runCommand();
		if( logThatShimCount != 1 ){
			throw "persistent mismatch must not log again (latch lost - by-value iteration?)";
		}

		// Fix the size: write succeeds, no new log, latch re-arms
		fub.pParameters = (unsigned long*)senderOk;
		fub.sParameters = sizeof(senderOk);
		runCommand();
		if( logThatShimCount != 1 ){
			throw "successful write should not log";
		}
		if( memcmp( followerParams, senderOk, sizeof(senderOk) ) != 0 ){
			throw "matching write should copy the parameters to the follower";
		}

		// Break it again: exactly one new log
		fub.pParameters = (unsigned long*)senderSmall;
		fub.sParameters = sizeof(senderSmall);
		runCommand();
		if( logThatShimCount != 2 ){
			throw "new mismatch after a successful write should log exactly once more";
		}

		// Clean up so later task-identity tests only see their own registrations
		if( unregister( (plcstring*)"movecmd" ) != 1 ){
			throw "diagnostics test cleanup should remove the movecmd subscription";
		}
	}

	///TEST 6: task-scoped unregister via the C API. On the host there is no AR
	// task context; atnSetCurrentTaskName() stands in for ST_name so one thread
	// can act as several tasks. The C API is already wired to this director above.
	{
		char stateTopic[]   = "TestState";
		char cmdTopic[]     = "TestCmd";
		char unknownTopic[] = "DoesNotExist";
		char ownerA[]       = "OwnerA";
		char ownerB[]       = "OwnerB";
		plcbit readyA = false;
		plcbit readyB = false;
		plcbit cmdBit = false;

		atnSetCurrentTaskName( "TaskA" );
		registerStateBool( stateTopic, ownerA, &readyA );
		subscribeCommandBool( cmdTopic, ownerA, &cmdBit );

		atnSetCurrentTaskName( "TaskB" );
		registerStateBool( stateTopic, ownerB, &readyB );

		REQUIRE( stateCount( stateTopic ) == 1, "both tasks should be registered on the shared state topic" );

		// unregister(name) removes only the calling task's entries on the named topic
		REQUIRE( unregister( stateTopic ) == 1, "unregister should remove the calling task's registration" );
		REQUIRE( stateCount( stateTopic ) == 0, "unregister must not touch another task's registration" );
		REQUIRE( unregister( unknownTopic ) == 0, "unregister should remove nothing for an unknown topic" );

		// unregisterAll() sweeps the calling task's registrations across all topics
		atnSetCurrentTaskName( "TaskA" );
		REQUIRE( unregisterAll() == 2, "unregisterAll should remove all of the calling task's registrations" );

		// Without an override, the thread id identifies the caller the same way
		atnSetCurrentTaskName( 0 );
		registerStateBool( stateTopic, ownerA, &readyA );
		REQUIRE( unregisterAll() == 1, "thread-id task identity should group registrations" );
	}

	if( failures == 0 ){
		std::cout << "Passed\n";
		return 0;
	}

	std::cout << failures << " check(s) failed\n";
	return 1;
}
catch( const char* msg ) {
	std::cerr << "FAILED: " << msg << std::endl;
	return 1;
}
