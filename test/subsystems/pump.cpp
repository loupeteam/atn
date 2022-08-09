#include <iostream>
#include <unistd.h>

#include "atnApi.h"
#include "../systemcommands.h"

void pump( ){
    AtnAPI_typ runpumpBehavior = {};
    AtnAPI_typ stoppumpBehavior = {};
    AtnAPICheck_typ pumpRunning = {};

	registerBehavior( runpump.c_str(), 		 "Pump", &runpumpBehavior, 0, 0);
	registerBehavior( runpumpandvfd.c_str(), "Pump", &runpumpBehavior, 0, 0);
	registerBehavior( startall.c_str(), 	 "Pump", &runpumpBehavior, 0, 0);
	registerBehavior( startallfail.c_str(),  "Pump", &runpumpBehavior, 0, 0);
	registerBehavior( stop.c_str(), 		 "Pump", &stoppumpBehavior, 0, 0);

	registerState( running.c_str(),          "Pump", &pumpRunning, 0, 0);

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