/*
 * File: test_main.cpp
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 *
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 *
 * Unit tests for the ATN command / state / PLCOpen system. These drive the
 * Director C++ API directly (the same engine the IEC-facing functions call).
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

int main(int argc, char const *argv[]) {

	atn::Director director;
	// Not-found paths guard on outstream; keep it null so tests stay quiet.
	director.outstream = nullptr;

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

	///TEST 6: task-scoped unregister via the C API. On the host there is no AR
	// task context; atnSetCurrentTaskName() stands in for ST_name so one thread
	// can act as several tasks. These C-API calls target the same director.
	{
		atnSetDirector( &director );

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
