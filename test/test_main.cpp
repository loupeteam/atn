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


	std::cout << "Passed";
	return 0;
}
