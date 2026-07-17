#include <iostream>
#include <cstring>

#ifdef __cplusplus
extern "C" {
#endif

#include "atn.h"
#include "LogThat.h"

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

// Tests signal failure by throwing a message; report it instead of aborting
// silently so CI logs show which check failed.
int main(int argc, char const *argv[]) try {

	int it =0;

	bool finished;
	bool finished2;

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
		if( logThatShimCalls[0].code != ATN_DIAG_CODE_PARAM_SIZE_MISMATCH ){
			throw "mismatch should use ATN_DIAG_CODE_PARAM_SIZE_MISMATCH";
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
	}

	
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


	std::cout << "Passed";
	return 0;
}
catch( const char* msg ) {
	std::cerr << "FAILED: " << msg << std::endl;
	return 1;
}
