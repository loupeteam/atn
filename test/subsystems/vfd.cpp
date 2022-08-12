#include <iostream>
#include <unistd.h>

#include "atnApi.h"
#include "../systemcommands.h"

void vfd(){
	//Start commands
	AtnAPI_typ runvfdBehavior = {};
    registerBehavior( startall.c_str(), "vfd",     &runvfdBehavior, 0, 0);
	registerBehavior( runvfd.c_str(),   "vfd", 		&runvfdBehavior, 0, 0);
	registerBehavior( runpumpandvfd.c_str(), "vfd",&runvfdBehavior, 0, 0);
	registerBehavior( startallfail.c_str(), "vfd", &runvfdBehavior, 0, 0);
	

	//Stop Command
	AtnAPI_typ stopVfd = {};
	registerBehavior( stop.c_str(), "vfd", &stopVfd, 0, 0);


	//Check state
	AtnAPIState_typ vfdRunning = {};
	registerState( running.c_str(),  "vfd", &vfdRunning);

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
