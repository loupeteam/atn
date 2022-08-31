#include "atn.h"
#include "../includes/atnApi.h"
#include "../includes/Director.h"
#include <string>
#include <cstring>
#include <iostream>

using namespace atn;

extern Director *globalDirector;

plcbit stateTrueStatus(plcstring* state, unsigned long buffer, unsigned long sBuffer){

    State *s = globalDirector->getState(std::string((char*)state));

    bool any=0;

	if( s ){

		outbuf buf( (char*)buffer, sBuffer );		
		std::ostream out( &buf );
		buf.reset();
        for( auto state : s->PLCOpenState ){

            if( state.pCheck && state.pCheck->moduleBypass){
                continue;
            }

            if( state.isTrue() ){
				out << state.name << "\n";
				any = true;
            }

        }
        return any;
	}
	else{
		return false;
	}
}

plcbit stateFalseStatus(plcstring* state, unsigned long buffer, unsigned long sBuffer){

    State *s = globalDirector->getState(std::string((char*)state));

    bool any=0;

	if( s ){

		outbuf buf( (char*)buffer, sBuffer );		
		std::ostream out( &buf );
		buf.reset();

        for( auto state : s->PLCOpenState ){

            if( state.pCheck && state.pCheck->moduleBypass){
                continue;
            }

            if( !state.isTrue() ){
				out << state.name << "\n";
                any = true;
            }

        }
        return any;
	}
	else{
		return false;
	}
}

plcbit stateStatus(plcstring* state, unsigned long buffer, unsigned long sBuffer){

	State *s = globalDirector->getState(std::string((char*)state));

	bool any=0;

	if( s ){

		outbuf buf( (char*)buffer, sBuffer );		
		std::ostream out( &buf );
		buf.reset();

		for( auto state : s->PLCOpenState ){

			if( state.pCheck && state.pCheck->moduleBypass){
				continue;
			}
			if( state.isTrue() )
				out << "active   - ";
			else 
				out << "inactive - ";
			out << state.name << "\n";
			any = true;

		}
		return any;
	}
	else{
		return false;
	}
}
