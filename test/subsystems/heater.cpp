#include <iostream>
#include <unistd.h>

#include "atnApi.h"
#include "../systemcommands.h"

void heater(){
	AtnAPI_typ enableHeaterBehavior = {};
	AtnAPI_typ enableHeaterFailBehavior = {};
	AtnAPI_typ disableHeaterBehavior = {};

	AtnAPIState_typ heaterCheck = {};
	registerBehavior( enableHeater.c_str(), "Heater", 	&enableHeaterBehavior, 0, 0);
	registerBehavior( startallfail.c_str(), "Heater", 	&enableHeaterFailBehavior, 0, 0);
	registerBehavior( disableHeater.c_str(), "Heater", 	&disableHeaterBehavior, 0, 0);
	registerBehavior( startall.c_str(), "Heater", 		&enableHeaterBehavior, 0, 0);
	registerBehavior( stop.c_str(), "Heater", 			&disableHeaterBehavior, 0, 0);

	registerState( enableHeater.c_str(), "Heater", &heaterCheck);
	while( 1 ){

		if( oneShotStatus( &enableHeaterBehavior, "Heating") ){
			std::cout << "Heater Started";
			heaterCheck.active = true;
		}		

		if( oneShotStatus( &disableHeaterBehavior, "stop heating") ){
			std::cout << "Heater Stopped";
			heaterCheck.active = false;
		}

		switch ( respond(&enableHeaterFailBehavior)   )
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
