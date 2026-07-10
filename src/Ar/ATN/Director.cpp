/*
 * File: Director.cpp
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 *
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 *
 */

#include <iostream>

#include "./includes/Director.h"

using namespace atn;

Director::Director(/* args */)
{
}

Director::~Director()
{

}

void Director::addState( const std::string state,  AtnAPIState_typ* api, void *_pParameters, size_t _sParameters ){

    auto it = states.find(state);

    if (it != states.end()){
        it->second.subscribe( api, _pParameters, _sParameters);
    }
    else{
        State newAction( state );
        newAction.subscribe(api, _pParameters, _sParameters);
        states.insert( std::pair<std::string, State>(state, newAction));
    }
}


void Director::addState( const std::string state, const std::string name, char *moduleStatus, plcbit* moduleByPass, bool* value, void *_pParameters, size_t _sParameters ){

	auto it = states.find(state);

	if (it != states.end()){
		it->second.subscribe( name, value, moduleByPass, moduleStatus, _pParameters, _sParameters);
	}
	else{
		State newAction( state );
		newAction.subscribe( name, value, moduleByPass, moduleStatus, _pParameters, _sParameters);
		states.insert( std::pair<std::string, State>(state, newAction));
	}


}

void Director::addStateBool( const std::string state, const std::string name, bool* value ){

	auto it = states.find(state);

	if (it != states.end()){
		it->second.subscribe( name, value);
	}
	else{
		State newAction( state );
		newAction.subscribe( name, value);
		states.insert( std::pair<std::string, State>(state, newAction));
	}
}

void Director::addResourceBool( const std::string state, const std::string name, unsigned long int *pResourceUid, bool *value ){

	auto it = states.find(state);

	if (it != states.end()){
		it->second.subscribe( name, pResourceUid, value);
	}
	else{
		State newAction( state );
		newAction.subscribe( name, pResourceUid, value);
		states.insert( std::pair<std::string, State>(state, newAction));
	}
}



void Director::addStateBool( const std::string state, const std::string name, bool* value,  void *_pParameters, size_t _sParameters){

	auto it = states.find(state);

	if (it != states.end()){
		it->second.subscribe( name, value, _pParameters, _sParameters);
	}
	else{
		State newAction( state );
		newAction.subscribe( name, value, _pParameters, _sParameters);
		states.insert( std::pair<std::string, State>(state, newAction));
	}
}

//Registers a bool to be automatically monitored, without full API support
void Director::addCommandBool( const std::string command, const std::string moduleName, bool *check ){
	auto it = commands.find(command);

	if (it != commands.end()){
		it->second.subscribe( moduleName, check);
	}
	else{
		State newAction( command );
		newAction.subscribe( moduleName, check);
		commands.insert( std::pair<std::string, State>(command, newAction));
	}
}

//Registers a bool to be automatically monitored, without full API support
void Director::addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBit, AtnPlcOpenStatus * status ){
	auto it = commands.find(command);

	if (it != commands.end()){
		it->second.subscribe( moduleName, commandBit, status);
	}
	else{
		State newAction( command );
		newAction.subscribe( moduleName, commandBit, status);
		commands.insert( std::pair<std::string, State>(command, newAction));
	}
}

//Registers a bool to be automatically monitored, without full API support
void Director::addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBit, AtnPlcOpenStatus * status,  void *_pParameters, size_t _sParameters ){
	auto it = commands.find(command);

	if (it != commands.end()){
		it->second.subscribe( moduleName, commandBit, status, _pParameters, _sParameters);
	}
	else{
		State newAction( command );
		newAction.subscribe( moduleName, commandBit, status, _pParameters, _sParameters);
		commands.insert( std::pair<std::string, State>(command, newAction));
	}
}

bool Director::executeCommand( const std::string command ){

    auto it = commands.find(command);

    if (it != commands.end()){
        it->second.setTrue();
		return true;
    }
    else{
		if( this->outstream ){
			*this->outstream << "Command not found\n";
		}
		return false;
	}
}

void Director::resetCommand( const std::string command ){

    auto it = commands.find(command);

    if (it != commands.end()){
        it->second.setFalse();
    }
    else{
		if( this->outstream ){
			*this->outstream << "Command not found\n";
		}
    }
}

State * Director::getState( const std::string state ){
    auto it = states.find(state);

    if (it != states.end()){
        return &it->second;
    }
    else{
        return 0;
    }
}

State * Director::getCommand( const std::string cmd ){
    auto it = commands.find(cmd);

    if (it != commands.end()){
        return &it->second;
    }
    else{
        return 0;
    }
}

void Director::printStates( std::ostream &out ){
    out << "\nStates:" << "\n";
    for( auto state : states ){
        out << state.first << "\n";
    }

}

void Director::printCommands( std::ostream &out ){
	out << "\nCommands:" << "\n";
	for( auto command : commands ){
		out << command.first << "\n";
	}

}

void Director::printSystemJson( std::ostream &out ){
	bool comma;
	out << "{";
	out << "\"commands\":[";
	comma = 0;
	for( auto command : commands ){
		if(comma) out << ",";
		out << "\"" <<command.first << "\"";
		comma = 1;
	}
	out << "]";
	out << ",\"States\":[";
	comma = 0;
	for( auto state : states ){
		if(comma) out << ",";
		out << "\"" <<state.first << "\"";
		comma = 1;
	}
	out << "]";
	out << "}";
}
