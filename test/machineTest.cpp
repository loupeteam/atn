#include <iostream>
#include <cstring>
#include <thread>
#include <unistd.h>
#include "systemcommands.h"
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

atn::Director director;
void vfd();
void pump();
void heater();
void tempMonitoring();

void machine( ){

	while(1){
		director.cyclic();
		director.printState();		
		usleep(  10000 );
	}

}

void processControl(){

	struct CMD_typ {		
		bool start;
		bool stop;
		bool pause;
	};
	struct internal_typ {		
		int state;
		AtnApiStatusLocal_typ status;
	};
	struct{		
		CMD_typ cmd;
		internal_typ internal;
	} processControl = {};

	struct processApi
	{
		AtnAPI_typ startProcess;
		AtnAPI_typ pauseProcess;
		AtnAPI_typ stopProcess;
	} processApi = {};
	
	registerBehavior( startprocess.c_str(), "ProcessControl", &processApi.startProcess, 0, 0);
	registerBehavior( stopprocess.c_str(), "ProcessControl", &processApi.stopProcess, 0, 0);
	registerBehavior( pauseprocess.c_str(), "ProcessControl", &processApi.pauseProcess, 0, 0);

	executeAction( startprocess.c_str() );

	while(1){


		//Handle incoming commands
		if( oneShotReset( &processApi.startProcess,  &processControl.cmd.start ) ){
			//Do something if you want
		}
		oneShotReset( &processApi.stopProcess,  &processControl.cmd.stop );
		oneShotReset( &processApi.pauseProcess,  &processControl.cmd.pause );


		//Handle outgoing command statuses by updating the local call state and clearing the remote state
		readCallState( &processControl.internal.status );

		//Handle any general error
		if( processControl.internal.status.error ){
			processControl.internal.state = 99;
			executeAction( stop.c_str() );
		}

		
		switch ( processControl.internal.state )
		{

		case 0:
			if( processControl.cmd.start ){
				processControl.internal.state = 1;				
			}
			break;
			
		case 1:
			if( processControl.internal.status.done ){
				processControl.internal.state = 2;
			}
			else if( processControl.internal.status.aborted ){
				processControl.internal.state = 0;
			}
			else if(!processControl.internal.status.busy ){
				executeActionReport( startall.c_str(), &processControl.internal.status);
			}
			break;

		case 2:

			if( processControl.internal.status.done ){
				processControl.internal.state =0;
			}
			else if( processControl.internal.status.aborted ){
				processControl.internal.state = 0;
			}
			else if(!processControl.internal.status.busy ){
				executeActionReport( startall.c_str(), &processControl.internal.status);
			}

		break;		
		case 99:
		
		break;
		default:
		break;
		}


		memset( &processControl.cmd, 0, sizeof(processControl.cmd));

		usleep(  10000 );

	}

}

void cyclicInput(  ){
	std::cout << "Machine Ready\n";
	while( 1 ){
		std::string command;
		std::cin >> command;
		atn::State *state;
		int i;
		bool active;
		switch (command[0])
		{
		case '?':
			director.printActions();
			director.printStates();
		case ':':
			state = director.getState( &command[1] );
			if( state ){
				state->print();
			}
			break;
		case '/':	
			director.executeAction( &command[1], 0, 0, 0);
			director.printState();
			break;
		case 'p':
			std::cout << "state: " << (char*)&(command.c_str())[1] << "\n";
			for(i=0; i<= forState( (char*)&(command.c_str())[1], i, &active, 0, 0); i++){
				std::cout << active <<"\t";
			}
			break;
		default:
			director.printState();
			break;
		}


	}
}

int main(int argc, char const *argv[]) {

	int it =0;

	int * cyc;
	atnSetDirector( &director );

	vector<std::thread> threads;
	std::thread heaterth( heater );
	usleep(  20000 );	
	std::thread heaterth2( heater );
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
	std::thread tempMonitoringth( tempMonitoring );
	usleep(  20000 );	
	std::thread processControlth( processControl );
	usleep(  20000 );	
	std::thread inputth( cyclicInput );

	inputth.join();
	// machineth.join();
	// pumpth.join();
	// vfdth.join();

	return 0;
}
