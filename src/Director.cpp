#include <iostream>

#include "../includes/Director.h"

using namespace atn;

unsigned long bur_heap_size = 0xfffff;

Director::Director(/* args */)
{
}

Director::~Director()
{

}

unsigned int Director::countActiveThreads(){
    return threads.size();
}

void Director::addBehavior( const std::string action,  AtnAPI_typ* api, void *_pParameters, size_t _sParameters ){

    auto it = actions.find(action);

    if (it != actions.end()){
        it->second.subscribe( api,_pParameters, _sParameters);
    }
    else{
        Action newAction(action);
        newAction.subscribe(api,_pParameters, _sParameters);
        actions.insert( std::pair<std::string, Action>(action, newAction));        
    }
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
