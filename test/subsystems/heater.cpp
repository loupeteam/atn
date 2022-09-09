#include <iostream>
#include <unistd.h>

#include "atnApi.h"
#include "../systemcommands.h"

void heater(){
	AtnAPI_typ enableHeaterBehavior = {};
	AtnAPI_typ enableHeaterFailBehavior = {};
	AtnAPI_typ disableHeaterBehavior = {};

	registerBehavior( enableHeater.c_str(), "Heater", 	&enableHeaterBehavior, 0, 0);
	registerBehavior( startallfail.c_str(), "Heater", 	&enableHeaterFailBehavior, 0, 0);
	registerBehavior( disableHeater.c_str(), "Heater", 	&disableHeaterBehavior, 0, 0);
	registerBehavior( startall.c_str(), "Heater", 		&enableHeaterBehavior, 0, 0);
	registerBehavior( stop.c_str(), "Heater", 			&disableHeaterBehavior, 0, 0);



	AtnAPIState_typ heaterCheck = {};
	registerState( (char*)enableHeater.c_str(), "Heater", &heaterCheck);
	HeaterCommand heaterCommand;

	heaterCommand.setTemp = 10;	
	subscribeCommandBool( (char*)enableHeater.c_str(),  "Heater", &heaterCommand.enable);
	subscribeCommandBool( (char*)disableHeater.c_str(),  "Heater", &heaterCommand.disable);

	AtnAPIState_typ TemperatureStatus = {};
	registerStateWithParameters( (char*)heaterTemperatures.c_str(),"Heater x", &TemperatureStatus , (UDINT*)&heaterCommand, sizeof(heaterCommand));

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

		if( heaterCommand.disable ){
			heaterCommand.disable =  false;
			heaterCheck.active = false;
		}

		if( heaterCommand.enable ){
			heaterCommand.enable =  false;
			heaterCheck.active = true;
		}

		if( heaterCheck.active ){
			heaterCommand.actTemp += 0.1;
		}
		else{
			heaterCommand.actTemp -= 0.1;
		}

		if( heaterCommand.actTemp > heaterCommand.setTemp) heaterCommand.actTemp = heaterCommand.setTemp;
		if( heaterCommand.actTemp < 0) heaterCommand.actTemp = 0;

		usleep(  20000 );	
	}
}
