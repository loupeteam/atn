#include <iostream>
#include <unistd.h>

//#include "atn.h"
#include "atnApi.h"
#include "../systemcommands.h"

void tempMonitoring(){
    int i;
    bool active;
    HeaterCommand heater;
    HeaterCommand *pHeater;
    while(1){
        std::cout << "\r\t\t\t\t\t\t\t\t\t\t\t\rTemps: " << std::flush;

        for(i=0; i<= forState( (char*)(heaterTemperatures.c_str()), i, &active, (UDINT*)&heater, sizeof(heater) ) ; i++){
            // std::cout << heater.actTemp << " ";
            // if( heater.actTemp > 15.02 && stateAnyTrue( (plcstring*) enableHeater.c_str(), false) ){
                // executeCommand( disableHeater.c_str() );
            // }
        }

        for(i=0; i<= forStateGetPointer( (char*)(heaterTemperatures.c_str()), i, &active, (UDINT**)&pHeater ) ; i++){
                if( pHeater != 0){
                    std::cout << pHeater->actTemp << " ";
                    pHeater->setTemp = 16;

                    if( pHeater->actTemp > 15.0  ){
                        pHeater->disable = true;
                    }
                    if( pHeater->actTemp < 14.0  ){
                        pHeater->enable= true;
                    }

                    if( pHeater->actTemp > 16.0 && stateAnyTrue( (plcstring*) enableHeater.c_str(), false) ){
                        executeCommand( disableHeater.c_str() );
                    }
                }            
        }
		usleep(  20000 );	
    }
}