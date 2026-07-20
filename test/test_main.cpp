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

typedef enum MOVE_Enumeration
{	MOVE_SS_INIT = 0,
	CHECK_INHIBITS = 1,
	EXECUTE_LOAD = 2
} MOVE_Enumeration;

typedef struct MovePinPars_typ
{	float Position;
	float moveTime;
} MovePinPars_typ;


const std::string stop = "stopall";
const std::string runpump = "runpump";
const std::string runvfd = "runvfd";
const std::string runpumpandvfd = "runpumpandvfd";

const std::string running = "running";

atn::Director director;

int main(int argc, char const *argv[]) {

	int it =0;

	bool finished;
	bool finished2;

	
	AtnAPI_typ runpumpBehavior = {};
	AtnAPI_typ runvfdBehavior = {};
	const std::string runpump = "runpump";
	const std::string runvfd = "runvfd";
	const std::string runpumpandvfd = "runpumpandvfd";
	director.addBehavior( runpump, &runpumpBehavior, 0, 0);
	director.addBehavior( runvfd, &runvfdBehavior, 0, 0);
	director.addBehavior( runpumpandvfd, &runpumpBehavior, 0, 0);
	director.addBehavior( runpumpandvfd, &runvfdBehavior, 0, 0);

	//Run for a bit
	while( it++ < 10 ){

		director.cyclic();

	}
	switch (runpumpBehavior.state)
	{
		case ATN_IDLE:
			break;			
		default:
			throw "Behavior not in idle";
			break;
	}

	director.executeAction( runpump , 0, 0, 0);
	if( director.countActiveThreads() != 1 ){
		throw "Thread not started";
	}

	///TEST 1: Single behavior
	switch (runpumpBehavior.state)
	{
		case ATN_EXECUTE:
			break;			
		default:
			throw "Thread not started";
			break;
	}
	finished = false;
	while( 1 ){

		director.cyclic();

		switch (runpumpBehavior.state)
		{
			case ATN_EXECUTE:
				if(finished){
					throw "Extra calls";
				}
				finished = true;
				runpumpBehavior.response = runpumpBehavior.state;				
				break;
			
			case ATN_IDLE:
				if(!finished){
					throw "Thread not started";
				}
				break;
			default:				
				throw "Thread not started";
				break;
		}

		if( director.countActiveThreads() == 0 ){
			break;
		}

	}
	switch (runpumpBehavior.state)
	{
		case ATN_IDLE:
			break;			
		default:
			throw "Thread not finished";
			break;
	}

	///TEST 2: 2 Behavior
	director.executeAction( runpumpandvfd , 0, 0, 0);
	if( director.countActiveThreads() != 1 ){
		throw "Thread not started";
	}


	switch (runpumpBehavior.state)
	{
		case ATN_EXECUTE:
			break;			
		default:
			throw "Thread not started";
			break;
	}
	switch (runvfdBehavior.state)
	{
		case ATN_EXECUTE:
			break;			
		default:
			throw "Thread not started";
			break;
	}

	finished = false;
	finished2 = false;
	while( 1 ){

		director.cyclic();

		switch (runpumpBehavior.state)
		{
			case ATN_EXECUTE:
				if(finished){
					throw "Extra calls";
				}
				finished = true;
				runpumpBehavior.response = runpumpBehavior.state;				
				break;
			
			case ATN_IDLE:
				if(!finished){
					throw "Thread not started";
				}
				break;
			default:				
				throw "Thread not started";
				break;
		}

		switch (runvfdBehavior.state)
		{
			case ATN_EXECUTE:
				if(finished2){
					throw "Extra calls";
				}
				finished2 = true;
				runvfdBehavior.response = runvfdBehavior.state;				
				break;
			
			case ATN_IDLE:
				if(!finished2){
					throw "Thread not started";
				}
				break;
			default:				
				throw "Thread not started";
				break;
		}

		if( director.countActiveThreads() == 0 ){
			break;
		}

	}
	switch (runpumpBehavior.state)
	{
		case ATN_IDLE:
			break;			
		default:
			throw "Thread not finished";
			break;
	}

	switch (runvfdBehavior.state)
	{
		case ATN_IDLE:
			break;			
		default:
			throw "Thread not finished";
			break;
	}

	///TEST 3: 2 Behavior interupt
	director.executeAction( runpump , 0, 0, 0);
	director.executeAction( runpumpandvfd , 0, 0, 0);

	if( director.countActiveThreads() != 2 ){
		throw "Thread not started";
	}


	switch (runpumpBehavior.state)
	{
		case ATN_EXECUTE:
			break;			
		default:
			throw "Thread not started";
			break;
	}
	switch (runvfdBehavior.state)
	{
		case ATN_IDLE:
			break;			
		default:
			throw "Thread started";
			break;
	}

	finished = false;
	finished2 = false;
	while( 1 ){

		director.cyclic();

		switch (runpumpBehavior.state)
		{
			case ATN_EXECUTE:
				runpumpBehavior.response = runpumpBehavior.state;				
				break;
			
			case ATN_IDLE:
				break;
			default:				
				break;
		}

		switch (runvfdBehavior.state)
		{
			case ATN_EXECUTE:
				runvfdBehavior.response = runvfdBehavior.state;				
				break;
			
			case ATN_IDLE:
				break;
			default:				
				break;
		}

		if( director.countActiveThreads() == 0 ){
			break;
		}

	}
	switch (runpumpBehavior.state)
	{
		case ATN_IDLE:
			break;			
		default:
			throw "Thread not finished";
			break;
	}

	switch (runvfdBehavior.state)
	{
		case ATN_IDLE:
			break;			
		default:
			throw "Thread not finished";
			break;
	}


	///TEST 4: task-scoped unregister via the C API. On the host there is no AR task
	// context; atnSetCurrentTaskName() stands in for ST_name so one thread can act
	// as several tasks.
	atnSetDirector( &director );

	char stateTopic[] = "TestState";
	char cmdTopic[] = "TestCmd";
	char unknownTopic[] = "DoesNotExist";
	char ownerA[] = "OwnerA";
	char ownerB[] = "OwnerB";
	plcbit readyA = false;
	plcbit readyB = false;
	plcbit cmdBit = false;

	atnSetCurrentTaskName( "TaskA" );
	registerStateBool( stateTopic, ownerA, &readyA );
	subscribeCommandBool( cmdTopic, ownerA, &cmdBit );

	atnSetCurrentTaskName( "TaskB" );
	registerStateBool( stateTopic, ownerB, &readyB );

	if( stateCount( stateTopic ) != 1 ){
		throw "Registrations missing";
	}

	// unregister(name) only removes the calling task's entries on the named topic
	if( unregister( stateTopic ) != 1 ){
		throw "unregister did not remove the calling task's registration";
	}
	if( stateCount( stateTopic ) != 0 ){
		throw "unregister touched another task's registration";
	}
	if( unregister( unknownTopic ) != 0 ){
		throw "unregister removed something for an unknown topic";
	}

	// unregisterAll() sweeps the calling task's registrations across all topics
	atnSetCurrentTaskName( "TaskA" );
	if( unregisterAll() != 2 ){
		throw "unregisterAll did not remove all of the calling task's registrations";
	}

	// Without an override, the thread id identifies the caller the same way
	atnSetCurrentTaskName( 0 );
	registerStateBool( stateTopic, ownerA, &readyA );
	if( unregisterAll() != 1 ){
		throw "thread-id task identity did not group registrations";
	}

	///TEST 5: AtnPLCOpenLocal drives a registered follower to Done by command BOOL
	// (no topic name, no status wiring - the status is resolved from the registration).
	atnSetCurrentTaskName( "TaskLocal" );
	{
		char name[]  = "Local.Cmd";
		char owner[] = "OwnerLocal";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		subscribePLCOpen( name, owner, &cmd, &st );

		AtnPLCOpenLocal_typ fb = {};
		fb.Command = &cmd;
		fb.Execute = true;

		bool done = false;
		for( int c = 0; c < 10 && !done; c++ ){
			AtnPLCOpenLocal( &fb );
			if( cmd ){ st.status = 0; }          // follower reports complete
			if( fb.Error ){ throw "Local: unexpected Error driving a registered bool"; }
			done = fb.Done;
		}
		if( !done ){ throw "Local: never reached Done"; }
		unregisterAll();
	}

	///TEST 6: an unregistered bool is a hard Error, never a silent Done. A local call
	// owns only its own bool+status; a miss must never no-op (there is no Fallback).
	{
		plcbit orphan = false;
		AtnPLCOpenLocal_typ fb = {};
		fb.Command = &orphan;
		fb.Execute = true;
		AtnPLCOpenLocal( &fb );                  // NEW_COMMAND: resolveByBool -> 0
		AtnPLCOpenLocal( &fb );                  // STATUS: hard Error
		if( fb.Done ){ throw "Local: unregistered bool silently reported Done"; }
		if( !fb.Error || fb.Status == 0 ){ throw "Local: unregistered bool did not report Error"; }
	}

	///TEST 7: a local call takes over an in-flight remote call, and the remote sees the
	// abort - the mutual-cancel arbitration through the shared status.internal.fbk.
	{
		char name[]  = "Shared.Cmd";
		char owner[] = "OwnerShared";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		subscribePLCOpen( name, owner, &cmd, &st );

		AtnPLCOpen_typ remote = {};
		strcpy( remote.Command, name );
		remote.Execute = true;
		AtnPLCOpen( &remote );                   // remote claims the follower
		if( !remote.Busy ){ throw "Remote: expected Busy after claim"; }

		AtnPLCOpenLocal_typ local = {};
		local.Command = &cmd;
		local.Execute = true;
		AtnPLCOpenLocal( &local );               // local takes over -> aborts the remote

		AtnPLCOpen( &remote );                    // remote observes the abort
		if( !remote.Aborted ){ throw "Remote: local takeover did not abort the remote call"; }
		if( local.Error ){ throw "Local: takeover unexpectedly errored"; }

		bool done = false;
		for( int c = 0; c < 10 && !done; c++ ){
			AtnPLCOpenLocal( &local );
			if( cmd ){ st.status = 0; }
			done = local.Done;
		}
		if( !done ){ throw "Local: did not complete after taking over"; }
		unregisterAll();
	}

	///TEST 8: one command bool registered twice (two status structs) drives BOTH
	// followers as a group - Done only once every follower has reported.
	{
		char nameA[] = "Multi.A";
		char nameB[] = "Multi.B";
		char owner[] = "OwnerMulti";
		plcbit cmd = false;
		AtnPlcOpenStatus stA = {};
		AtnPlcOpenStatus stB = {};
		subscribePLCOpen( nameA, owner, &cmd, &stA );
		subscribePLCOpen( nameB, owner, &cmd, &stB );

		AtnPLCOpenLocal_typ fb = {};
		fb.Command = &cmd;
		fb.Execute = true;

		AtnPLCOpenLocal( &fb );                   // claim + start: both followers busy
		AtnPLCOpenLocal( &fb );
		if( fb.Done ){ throw "Multi: Done before either follower reported"; }

		stA.status = 0;                           // only A complete
		AtnPLCOpenLocal( &fb );
		if( fb.Done ){ throw "Multi: Done while a follower was still busy (group not aggregated)"; }

		stB.status = 0;                           // now both complete
		bool done = false;
		for( int c = 0; c < 10 && !done; c++ ){
			AtnPLCOpenLocal( &fb );
			done = fb.Done;
		}
		if( !done ){ throw "Multi: group did not complete when all followers reported"; }
		unregisterAll();
	}

	///TEST 9: the reverse of TEST 7 - a remote call takes over an in-flight LOCAL call,
	// and the local call sees the abort. Arbitration is symmetric across bool/name.
	{
		char name[]  = "Rev.Cmd";
		char owner[] = "OwnerRev";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		subscribePLCOpen( name, owner, &cmd, &st );

		AtnPLCOpenLocal_typ local = {};
		local.Command = &cmd; local.Execute = true;
		AtnPLCOpenLocal( &local );                 // local claims
		if( !local.Busy ){ throw "Rev: expected local Busy after claim"; }

		AtnPLCOpen_typ remote = {};
		strcpy( remote.Command, name );
		remote.Execute = true;
		AtnPLCOpen( &remote );                      // remote takes over -> aborts local

		AtnPLCOpenLocal( &local );                  // local observes the abort
		if( !local.Aborted ){ throw "Rev: remote takeover did not abort the local call"; }
		if( remote.Error ){ throw "Rev: remote takeover unexpectedly errored"; }

		bool done = false;
		for( int c = 0; c < 10 && !done; c++ ){
			AtnPLCOpen( &remote );
			if( cmd ){ st.status = 0; }
			done = remote.Done;
		}
		if( !done ){ throw "Rev: remote did not complete after taking over"; }
		unregisterAll();
	}

	///TEST 10: two local callers on the same bool - the second takes over and the first is
	// aborted (also exercises the in-place group-cache reassignment for a shared bool).
	{
		char name[]  = "L2L.Cmd";
		char owner[] = "OwnerL2L";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		subscribePLCOpen( name, owner, &cmd, &st );

		AtnPLCOpenLocal_typ a = {};
		a.Command = &cmd; a.Execute = true;
		AtnPLCOpenLocal( &a );                      // A claims
		if( !a.Busy ){ throw "L2L: expected A Busy after claim"; }

		AtnPLCOpenLocal_typ b = {};
		b.Command = &cmd; b.Execute = true;
		AtnPLCOpenLocal( &b );                      // B takes over -> aborts A

		AtnPLCOpenLocal( &a );                      // A observes the abort
		if( !a.Aborted ){ throw "L2L: second local caller did not abort the first"; }
		if( b.Error ){ throw "L2L: takeover caller errored"; }

		bool done = false;
		for( int c = 0; c < 10 && !done; c++ ){
			AtnPLCOpenLocal( &b );
			if( cmd ){ st.status = 0; }
			done = b.Done;
		}
		if( !done ){ throw "L2L: takeover caller did not complete"; }
		unregisterAll();
	}

	///TEST 11: a follower reporting a non-zero status makes the FB report Error, not Done.
	{
		char name[]  = "ErrCase.Cmd";
		char owner[] = "OwnerErrCase";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		subscribePLCOpen( name, owner, &cmd, &st );

		AtnPLCOpenLocal_typ fb = {};
		fb.Command = &cmd; fb.Execute = true;
		AtnPLCOpenLocal( &fb );                     // claim + start
		st.status = 7;                              // follower reports an error
		AtnPLCOpenLocal( &fb );
		if( fb.Done ){ throw "ErrCase: reported Done on a follower error"; }
		if( !fb.Error || fb.Status != 7 ){ throw "ErrCase: did not surface the follower error status"; }
		unregisterAll();
	}

	///TEST 12: lifecycle reuse - after Done, dropping Execute returns to idle and a fresh
	// rising edge runs the command again.
	{
		char name[]  = "Reuse.Cmd";
		char owner[] = "OwnerReuse";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		subscribePLCOpen( name, owner, &cmd, &st );

		AtnPLCOpenLocal_typ fb = {};
		fb.Command = &cmd;

		for( int run = 0; run < 2; run++ ){
			fb.Execute = true;
			bool done = false;
			for( int c = 0; c < 10 && !done; c++ ){
				AtnPLCOpenLocal( &fb );
				if( cmd ){ st.status = 0; }
				done = fb.Done;
			}
			if( !done ){ throw "Reuse: command did not complete"; }

			fb.Execute = false;
			for( int c = 0; c < 5; c++ ){ AtnPLCOpenLocal( &fb ); }   // return to idle
			if( fb.Done || fb.Busy ){ throw "Reuse: did not return to idle after Execute dropped"; }
			st.status = 0;
		}
		unregisterAll();
	}

	///TEST 13: AtnPLCOpenWithParameters copies parameters into the follower buffer and
	// completes - covers the shared claim/write helpers on the parameter path.
	{
		char name[]  = "Par.Cmd";
		char owner[] = "OwnerPar";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		long followerParam = 0;
		subscribePLCOpenWithParameters( name, owner, (unsigned long*)&followerParam, sizeof(long), &cmd, &st );

		long srcParam = 123;
		AtnPLCOpenWithParameters_typ fb = {};
		strcpy( fb.Command, name );
		fb.pParameters = (unsigned long*)&srcParam;
		fb.sParameters = sizeof(long);
		fb.Execute = true;

		bool done = false;
		for( int c = 0; c < 10 && !done; c++ ){
			AtnPLCOpenWithParameters( &fb );
			if( cmd ){ st.status = 0; }
			done = fb.Done;
		}
		if( followerParam != 123 ){ throw "Par: parameters were not written to the follower"; }
		if( !done ){ throw "Par: parameterized command did not complete"; }
		unregisterAll();
	}

	///TEST 14: the same bool registered twice sharing ONE status struct behaves like a
	// single follower (idempotent claim/aggregate).
	{
		char nameA[] = "Shr.A";
		char nameB[] = "Shr.B";
		char owner[] = "OwnerShr";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		subscribePLCOpen( nameA, owner, &cmd, &st );
		subscribePLCOpen( nameB, owner, &cmd, &st );   // same bool, same status

		AtnPLCOpenLocal_typ fb = {};
		fb.Command = &cmd; fb.Execute = true;
		AtnPLCOpenLocal( &fb );
		AtnPLCOpenLocal( &fb );
		if( fb.Done ){ throw "Shr: Done before the shared follower reported"; }
		st.status = 0;                              // one write completes both entries
		bool done = false;
		for( int c = 0; c < 10 && !done; c++ ){
			AtnPLCOpenLocal( &fb );
			done = fb.Done;
		}
		if( !done ){ throw "Shr: shared-status group did not complete"; }
		unregisterAll();
	}

	///TEST 15: a bypassed follower is skipped - the bool is not driven and the FB completes
	// immediately (the all-bypassed -> Done default that replaced Fallback).
	{
		char name[]  = "Byp.Cmd";
		char owner[] = "OwnerByp";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		st.bypass = 1;                              // follower bypassed
		subscribePLCOpen( name, owner, &cmd, &st );

		AtnPLCOpenLocal_typ fb = {};
		fb.Command = &cmd; fb.Execute = true;
		AtnPLCOpenLocal( &fb );
		AtnPLCOpenLocal( &fb );
		if( cmd ){ throw "Byp: drove the bool of a bypassed follower"; }
		if( !fb.Done || fb.Error ){ throw "Byp: bypassed follower did not complete cleanly"; }
		unregisterAll();
	}

	///TEST 16: resolveByBool re-scans each command, so once a follower unregisters the
	// same bool resolves to nothing -> Error (no stale group is served from the cache).
	{
		char name[]  = "Unreg.Cmd";
		char owner[] = "OwnerUnreg";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		subscribePLCOpen( name, owner, &cmd, &st );

		AtnPLCOpenLocal_typ fb = {};
		fb.Command = &cmd; fb.Execute = true;
		bool done = false;
		for( int c = 0; c < 10 && !done; c++ ){
			AtnPLCOpenLocal( &fb );
			if( cmd ){ st.status = 0; }
			done = fb.Done;
		}
		if( !done ){ throw "Unreg: initial command did not complete"; }

		fb.Execute = false;
		for( int c = 0; c < 5; c++ ){ AtnPLCOpenLocal( &fb ); }   // back to idle
		unregisterAll();                            // follower goes away

		fb.Execute = true;
		AtnPLCOpenLocal( &fb );                     // resolveByBool -> 0 now
		AtnPLCOpenLocal( &fb );
		if( !fb.Error ){ throw "Unreg: bool still resolved after unregister (stale group)"; }
	}

	///TEST 17: atnPLCOpenAbort() is the follower's "abort whoever is driving me" call.
	// The trig guard means a command issued THIS cycle (trig == 1) is left alone and only
	// disarmed; on a later cycle (trig == 0) the lingering owner is aborted. (This assumes
	// a local and a remote command do not arrive on the very same scan.) Owner is remote here.
	{
		char name[]  = "Fab.Cmd";
		char owner[] = "OwnerFab";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		subscribePLCOpen( name, owner, &cmd, &st );

		AtnPLCOpen_typ remote = {};
		strcpy( remote.Command, name );
		remote.Execute = true;
		AtnPLCOpen( &remote );                      // remote claims: fbk = &remote._call, trig = 1
		if( !remote.Busy ){ throw "Fab: expected remote Busy after claim"; }

		atnPLCOpenAbort( &st );                      // trig == 1 -> guard: disarm only, no abort
		AtnPLCOpen( &remote );
		if( remote.Aborted ){ throw "Fab: aborted a command on its guarded first cycle"; }
		if( !remote.Busy ){ throw "Fab: remote should still be driving after the guarded call"; }

		atnPLCOpenAbort( &st );                      // trig == 0 -> abort the active command
		AtnPLCOpen( &remote );
		if( !remote.Aborted ){ throw "Fab: atnPLCOpenAbort did not abort the active remote command"; }
		unregisterAll();
	}

	///TEST 18: the same follower-side abort works on an AtnPLCOpenLocal owner - the local
	// FB registers in status.internal.fbk exactly like a remote caller.
	{
		char name[]  = "FabL.Cmd";
		char owner[] = "OwnerFabL";
		plcbit cmd = false;
		AtnPlcOpenStatus st = {};
		subscribePLCOpen( name, owner, &cmd, &st );

		AtnPLCOpenLocal_typ local = {};
		local.Command = &cmd; local.Execute = true;
		AtnPLCOpenLocal( &local );                  // local claims: fbk = &local._call, trig = 1
		atnPLCOpenAbort( &st );                      // guard: disarm (trig -> 0)
		AtnPLCOpenLocal( &local );
		if( local.Aborted ){ throw "FabL: aborted the local caller on its guarded first cycle"; }

		atnPLCOpenAbort( &st );                      // trig == 0 -> abort the local caller
		AtnPLCOpenLocal( &local );
		if( !local.Aborted ){ throw "FabL: atnPLCOpenAbort did not abort the local caller"; }
		unregisterAll();
	}

	///TEST 19: single-topic unregister rebuilds the by-bool index precisely. The same bool
	// is registered under two names; unregistering one must drop only that follower and
	// leave the other, so the bool still resolves and drives via the survivor's status.
	{
		char nameA[] = "Reg.A";
		char nameB[] = "Reg.B";
		char owner[] = "OwnerReg";
		plcbit cmd = false;
		AtnPlcOpenStatus stA = {};
		AtnPlcOpenStatus stB = {};
		subscribePLCOpen( nameA, owner, &cmd, &stA );
		subscribePLCOpen( nameB, owner, &cmd, &stB );   // same bool, two names, two statuses

		unregister( nameA );                             // drop only nameA's follower

		AtnPLCOpenLocal_typ fb = {};
		fb.Command = &cmd; fb.Execute = true;
		bool done = false;
		for( int c = 0; c < 10 && !done; c++ ){
			AtnPLCOpenLocal( &fb );
			if( cmd ){ stB.status = 0; }                 // only nameB's follower remains to complete
			done = fb.Done;
		}
		// Done proves the survivor (nameB/stB) is still in the group AND the removed one
		// (nameA/stA, never completed) is gone - otherwise the group would hang or be empty.
		if( !done ){ throw "Reg: single-topic unregister broke the by-bool index (lost survivor or kept the removed)"; }
		unregisterAll();
	}

	std::cout << "Passed";
	return 0;
}
