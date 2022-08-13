#include <iostream>
#include <unistd.h>

#include "atn.h"
#include "atnApi.h"
#include "../systemcommands.h"

void tempMonitoring(){
    int i;
    bool active;
    HeaterCommand heater;
    HeaterCommand *pHeater;
    while(1){
        std::cout << "\r\t\t\t\t\t\t\t\t\t\t\t\rTemps: " << std::flush;

        for(i=0; i<= stateCount((char*)(heaterTemperatures.c_str())) ; i++){
            forState( (char*)(heaterTemperatures.c_str()), i, &active, (UDINT*)&heater, sizeof(heater) );
        }

        for(i=0; i<= stateCount( (char*)(heaterTemperatures.c_str()) ) ; i++){
            unsigned long sParameters;
            forStateGetPointer( (char*)(heaterTemperatures.c_str()), i, &active, (UDINT*)&pHeater, &sParameters);
            if( pHeater != 0 && sParameters == sizeof(*pHeater)){
                std::cout << "active: " << active << " temp: "<< pHeater->actTemp << " ";
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