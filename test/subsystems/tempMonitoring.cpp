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
        unsigned short status;
        bool startCommand = 0;
        for(i=0; i<= forCommandGetPLCOpenStatus(  (char*)heaterTemperatures.c_str(), i, &status); i++){
            switch (status)
            {
            case 65535:
                break;
            case 0:
                break;
            case 65534:
                startCommand = true;
                break;
            default:
                break;
            }            
        }
        if(startCommand){
            executeCommand( (char*)heaterTemperatures.c_str() );  
        }

        for(i=0; i<= stateCount((char*)(heaterTemperatures.c_str())) ; i++){
            forState( (char*)(heaterTemperatures.c_str()), i, &active, (UDINT*)&heater, sizeof(heater) );
        }

        unsigned long sParameters;


        for(i=0; i<= stateCount( (char*)(heaterTemperatures.c_str()) ) ; i++){
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