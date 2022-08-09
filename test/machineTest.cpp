#include <iostream>
#include <cstring>
#include <thread>
#include <unistd.h>

#ifdef __cplusplus
extern "C" {
#endif

#include "atn.h"
#include "atnApi.h"
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
const std::string enableHeater = "enableHeater";
const std::string disableHeater = "disableHeater";
const std::string startall = "startall";
const std::string startallfail = "startallfail";

atn::Director director;

void vfd(){
	//Start commands
	AtnAPI_typ runvfdBehavior = {};
	director.addBehavior( startall, 	&runvfdBehavior, 0, 0);
	director.addBehavior( runvfd, 		 &runvfdBehavior, 0, 0);
	director.addBehavior( runpumpandvfd, &runvfdBehavior, 0, 0);
	director.addBehavior( startallfail, &runvfdBehavior, 0, 0);
	

	//Stop Command
	AtnAPI_typ stopVfd = {};
	director.addBehavior( stop, &stopVfd, 0, 0);


	//Check state
	AtnAPICheck_typ vfdRunning = {};
	director.addState( running,  &vfdRunning, 0, 0);

	strcpy(runvfdBehavior.moduleName, "vfd");
	strcpy(stopVfd.moduleName, "vfd");
	strcpy(vfdRunning.moduleName, "vfd");

	while( 1 ){
		switch (runvfdBehavior.state)
		{
			case ATN_EXECUTE:
				std::cout << "Run vfd executed\n";
				strcpy(runvfdBehavior.moduleStatus, "running");
				vfdRunning.active = true;
				runvfdBehavior.response = runvfdBehavior.state;
				break;
			case ATN_ABORT:
				std::cout << "Run vfd aborted\n";
				vfdRunning.active = false;
				strcpy(runvfdBehavior.moduleStatus, "not running");				
				runvfdBehavior.response = runvfdBehavior.state;
				break;
			default:
				runvfdBehavior.response = runvfdBehavior.state;
				break;
		}
		switch (stopVfd.state)
		{
			case ATN_EXECUTE:
				std::cout << "stop vfd executed\n";
				strcpy(stopVfd.moduleStatus, "not running");
				vfdRunning.active = false;
			default:
				stopVfd.response = stopVfd.state;
				break;
		}
		usleep(  10000 );
	}	
}

void pump( ){

	AtnAPI_typ runpumpBehavior = {};
	AtnAPI_typ stoppumpBehavior = {};

	director.addBehavior( runpump, 			&runpumpBehavior, 0, 0);
	director.addBehavior( runpumpandvfd, 	&runpumpBehavior, 0, 0);
	director.addBehavior( startall, 		&runpumpBehavior, 0, 0);
	director.addBehavior( startallfail, 	&runpumpBehavior, 0, 0);
	director.addBehavior( stop, 			&stoppumpBehavior, 0, 0);

	AtnAPICheck_typ pumpRunning = {};
	director.addState( running,  &pumpRunning, 0, 0);

	strcpy(runpumpBehavior.moduleName, "pump");
	strcpy(stoppumpBehavior.moduleName, "pump");
	strcpy(pumpRunning.moduleName, "pump");

	while ( 1 )
	{
		switch (runpumpBehavior.state)
		{
			case ATN_EXECUTE:
				std::cout << "Run pump executed\n";
				pumpRunning.active = true;
				strcpy(runpumpBehavior.moduleStatus, "running");
				runpumpBehavior.response = runpumpBehavior.state;
				break;
			case ATN_ABORT:
				std::cout << "Run pump aborted\n";
				pumpRunning.active = false;
				strcpy(runpumpBehavior.moduleStatus, "not running");				
			default:
				runpumpBehavior.response = runpumpBehavior.state;
				break;
		}

		switch (stoppumpBehavior.state)
		{
			case ATN_EXECUTE:
				std::cout << "Stop pump executed\n";
				pumpRunning.active = false;
				strcpy(stoppumpBehavior.moduleStatus, "not running");
			default:
				stoppumpBehavior.response = stoppumpBehavior.state;
				break;
		}

		usleep(  20000 );	
	}

}

void heater(){
	AtnAPI_typ enableHeaterBehavior = {};
	AtnAPI_typ enableHeaterFailBehavior = {};
	AtnAPI_typ disableHeaterBehavior = {};

	AtnAPICheck_typ heaterCheck = {};
	registerBehavior( enableHeater.c_str(), "Heater", 	&enableHeaterBehavior, 0, 0);
	registerBehavior( startallfail.c_str(), "Heater", 	&enableHeaterFailBehavior, 0, 0);
	registerBehavior( disableHeater.c_str(), "Heater", 	&disableHeaterBehavior, 0, 0);
	registerBehavior( startall.c_str(), "Heater", 		&enableHeaterBehavior, 0, 0);
	registerBehavior( stop.c_str(), "Heater", 			&disableHeaterBehavior, 0, 0);

	registerState( enableHeater.c_str(), "Heater", &heaterCheck, 0, 0);
	while( 1 ){

		if( oneShotStatus( &enableHeaterBehavior, "Heating") ){
			std::cout << "Heater Started";
			heaterCheck.active = true;
		}		

		if( oneShotStatus( &disableHeaterBehavior, "stop heating") ){
			std::cout << "Heater Stopped";
			heaterCheck.active = false;
		}

		switch ( enableHeaterFailBehavior.state  )
		{
			case ATN_EXECUTE:
				enableHeaterFailBehavior.response = ATN_ABORT;
				break;
			case ATN_ABORT:
				strncpy( enableHeaterBehavior.moduleStatus, "Abort Heating", sizeof(enableHeaterBehavior.moduleStatus));
				std::cout << "Heater Stopped";
				heaterCheck.active = false;
				enableHeaterFailBehavior.response = enableHeaterFailBehavior.state;
				break;
			default:
				enableHeaterFailBehavior.response = enableHeaterFailBehavior.state;
				break;
		}

		usleep(  20000 );	
	}
}

void machine( ){

	while(1){
		director.cyclic();

		director.printState();

		usleep(  10000 );
	}

}

void cyclicInput(  ){
	std::cout << "Machine Ready\n";
	while( 1 ){
		std::string command;
		std::cin >> command;
		switch (command[0])
		{
		case '?':
			director.printActions();
			director.printStates();
			break;
		default:
			director.executeAction( command, 0, 0, 0);
			director.printState();
			break;
		}


	}
}


int main(int argc, char const *argv[]) {

	int it =0;

	int * cyc;
	atncyclic( &director );

	vector<std::thread> threads;
	std::thread heaterth( heater );
	usleep(  20000 );	
	std::thread vfdth1( vfd );
	usleep(  20000 );	
	std::thread vfdth2( vfd );
	usleep(  20000 );	
	std::thread pumpth1( pump );
	usleep(  20000 );	
	std::thread pumpth2( pump );
	usleep(  20000 );	
	std::thread pumpth3( pump );
	usleep(  20000 );	
	std::thread machineth( machine );
	usleep(  20000 );	
	std::thread inputth( cyclicInput );

	inputth.join();
	// machineth.join();
	// pumpth.join();
	// vfdth.join();

	return 0;
}
