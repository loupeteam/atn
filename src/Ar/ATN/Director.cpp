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

unsigned int Director::countActiveThreads(){
    return threads.size();
}

void Director::addBehavior( const std::string action,  AtnAPI_typ* api, void *_pParameters, size_t _sParameters, const std::string& taskName ){

    auto it = actions.find(action);

    if (it != actions.end()){
        it->second.subscribe( api,_pParameters, _sParameters, taskName);
    }
    else{
        Action newAction(action);
        newAction.subscribe(api,_pParameters, _sParameters, taskName);
        actions.insert( std::pair<std::string, Action>(action, newAction));
    }
}

void Director::addState( const std::string state,  AtnAPIState_typ* api, void *_pParameters, size_t _sParameters, const std::string& taskName ){

    auto it = states.find(state);

    if (it != states.end()){
        it->second.subscribe( api, _pParameters, _sParameters, taskName);
    }
    else{
        State newAction( state );
        newAction.subscribe(api, _pParameters, _sParameters, taskName);
        states.insert( std::pair<std::string, State>(state, newAction));
    }
}


void Director::addState( const std::string state, const std::string name, char *moduleStatus, plcbit* moduleByPass, bool* value, void *_pParameters, size_t _sParameters, const std::string& taskName ){

	auto it = states.find(state);

	if (it != states.end()){
		it->second.subscribe( name, value, moduleByPass, moduleStatus, _pParameters, _sParameters, taskName);
	}
	else{
		State newAction( state );
		newAction.subscribe( name, value, moduleByPass, moduleStatus, _pParameters, _sParameters, taskName);
		states.insert( std::pair<std::string, State>(state, newAction));
	}


}

void Director::addStateBool( const std::string state, const std::string name, bool* value, const std::string& taskName ){

	auto it = states.find(state);

	if (it != states.end()){
		it->second.subscribe( name, value, taskName);
	}
	else{
		State newAction( state );
		newAction.subscribe( name, value, taskName);
		states.insert( std::pair<std::string, State>(state, newAction));
	}
}

void Director::addResourceBool( const std::string state, const std::string name, unsigned long int *pResourceUid, bool *value, const std::string& taskName ){

	auto it = states.find(state);

	if (it != states.end()){
		it->second.subscribe( name, pResourceUid, value, taskName);
	}
	else{
		State newAction( state );
		newAction.subscribe( name, pResourceUid, value, taskName);
		states.insert( std::pair<std::string, State>(state, newAction));
	}
}
		


void Director::addStateBool( const std::string state, const std::string name, bool* value,  void *_pParameters, size_t _sParameters, const std::string& taskName){

	auto it = states.find(state);

	if (it != states.end()){
		it->second.subscribe( name, value, _pParameters, _sParameters, taskName);
	}
	else{
		State newAction( state );
		newAction.subscribe( name, value, _pParameters, _sParameters, taskName);
		states.insert( std::pair<std::string, State>(state, newAction));
	}
}

//Registers a bool to be automatically monitored, without full API support
void Director::addCommandBool( const std::string command, const std::string moduleName, bool *check, const std::string& taskName ){
	auto it = commands.find(command);

	if (it != commands.end()){
		it->second.subscribe( moduleName, check, taskName);
	}
	else{
		State newAction( command );
		newAction.subscribe( moduleName, check, taskName);
		commands.insert( std::pair<std::string, State>(command, newAction));
	}
}

//Registers a bool to be automatically monitored, without full API support
void Director::addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBit, AtnPlcOpenStatus * status, const std::string& taskName ){
	auto it = commands.find(command);

	if (it != commands.end()){
		it->second.subscribe( moduleName, commandBit, status, taskName);
	}
	else{
		State newAction( command );
		newAction.subscribe( moduleName, commandBit, status, taskName);
		commands.insert( std::pair<std::string, State>(command, newAction));
	}
}

//Registers a bool to be automatically monitored, without full API support
void Director::addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBit, AtnPlcOpenStatus * status,  void *_pParameters, size_t _sParameters, const std::string& taskName ){
	auto it = commands.find(command);

	if (it != commands.end()){
		it->second.subscribe( moduleName, commandBit, status, _pParameters, _sParameters, taskName);
	}
	else{
		State newAction( command );
		newAction.subscribe( moduleName, commandBit, status, _pParameters, _sParameters, taskName);
		commands.insert( std::pair<std::string, State>(command, newAction));
	}
}

void Director::executeAction( const std::string action,  AtnApiStatus_typ* _pStatus, void *_pParameters, size_t _sParameters){

    auto it = actions.find(action);

    if (it != actions.end()){
        threads.push_back(it->second); 
        ///TODO: check if it's OK to start
        threads.back().start( _pStatus, _pParameters, _sParameters );
    }
    else{
		if( this->outstream ){
			*this->outstream << "Action not found\n";
		}
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
			*this->outstream << "Action not found\n";
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
			*this->outstream << "Action not found\n";
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

unsigned int Director::removeRegistration( const std::string name, const std::string owner ){
	unsigned int removed = 0;

	auto s = states.find(name);
	if( s != states.end() ){
		removed += s->second.removeOwner(owner);
	}

	auto c = commands.find(name);
	if( c != commands.end() ){
		removed += c->second.removeOwner(owner);
	}

	auto a = actions.find(name);
	if( a != actions.end() ){
		removed += a->second.removeOwner(owner);
	}

	return removed;
}

unsigned int Director::removeAllForTask( const std::string& taskName ){
	unsigned int removed = 0;

	for( auto &kv : states ){
		removed += kv.second.removeTask(taskName);
	}
	for( auto &kv : commands ){
		removed += kv.second.removeTask(taskName);
	}
	for( auto &kv : actions ){
		removed += kv.second.removeTask(taskName);
	}
	//In-flight actions hold copies of the registered behaviors.
	// Sweep them too, but do not count them as additional registrations.
	for( auto &thread : threads ){
		thread.removeTask(taskName);
	}

	return removed;
}

void Director::cyclic(){

    for (auto thread = threads.begin(); thread != threads.end(); ++thread){
        //Run thread
        if( thread->update() ){
            thread->print( *this->outstream );
            //If it's done, remove it            
            threads.erase( thread );
        }
    }
}

void Director::printState( std::ostream &out ){
    for (auto thread = threads.begin(); thread != threads.end(); ++thread){
        thread->print( out );   
    }
}

void Director::printActions( std::ostream &out ){
    out << "\nActions:" << "\n";
    for( auto action : actions ){
        out << action.first << "\n";
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
