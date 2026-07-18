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

Director::Director(/* args */) : outstream(0)
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

State * Director::resolveByBool( bool* commandBit ){

    if( !commandBit ){
        return 0;
    }

    //Collect every command follower registered against this exact bit. One bit may
    //be subscribed under several names / with several status structs (a feature),
    //so we gather them all and drive them as a group - the same way the string path
    //drives a State's PLCOpenState vector. The copies carry the followers' pointers
    //(into their real status structs), so acting through the group hits real memory.
    State group( "" );
    for( auto &kv : commands ){
        for( auto &follower : kv.second.PLCOpenState ){
            if( follower.pValue == commandBit ){
                group.PLCOpenState.push_back( follower );
            }
        }
    }

    if( group.PLCOpenState.empty() ){
        return 0;   //bit not registered -> the local FB reports Error/Fallback
    }

    //Cache by bit so the returned pointer stays valid while the caller runs the
    //command. Reassign in place when the bit is already cached (rather than
    //erase+re-insert) so a second caller resolving the same bit cannot free a group
    //another caller is still holding - only the contents change, not the node.
    auto it = bitGroups.find( commandBit );
    if( it == bitGroups.end() ){
        it = bitGroups.emplace( commandBit, group ).first;
    }
    else{
        it->second = group;
    }
    return &it->second;
}

bool Director::addValue( const std::string state, const std::string name, bool* valid, void* _pData, size_t _sData, size_t sReturn, const std::string& taskName ){

	auto it = values.find(state);

	if (it != values.end()){
		if( it->second.count() > 0 ){
			if( this->outstream ){
				*this->outstream << "ATN value already registered: " << state << "\n";
			}
			return false;
		}
		it->second.subscribe( name, valid, _pData, _sData, taskName );
		it->second.sReturn = sReturn;
		it->second.returnTopic = (sReturn > 0) ? (state + ATN_RETURN_TOPIC_SUFFIX) : "";
	}
	else{
		State newValue( state );
		newValue.subscribe( name, valid, _pData, _sData, taskName );
		newValue.sReturn = sReturn;
		newValue.returnTopic = (sReturn > 0) ? (state + ATN_RETURN_TOPIC_SUFFIX) : "";
		values.insert( std::pair<std::string, State>(state, newValue) );
	}
	return true;
}

State * Director::getValue( const std::string state ){
	auto it = values.find(state);

	if (it != values.end()){
		return &it->second;
	}
	else{
		return 0;
	}
}

unsigned int Director::removeRegistration( const std::string& name, const std::string& taskName ){
	unsigned int removed = 0;

	auto v = values.find(name);
	if( v != values.end() ){
		removed += v->second.removeTask(taskName);
	}

	auto s = states.find(name);
	if( s != states.end() ){
		removed += s->second.removeTask(taskName);
	}

	auto c = commands.find(name);
	if( c != commands.end() ){
		removed += c->second.removeTask(taskName);
	}

	auto a = actions.find(name);
	if( a != actions.end() ){
		removed += a->second.removeTask(taskName);
	}

	return removed;
}

unsigned int Director::removeAllForTask( const std::string& taskName ){
	unsigned int removed = 0;

	for( auto &kv : values ){
		removed += kv.second.removeTask(taskName);
	}

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

    for (auto thread = threads.begin(); thread != threads.end(); ){
        //Run thread
        if( thread->update() ){
            if( this->outstream ){
                thread->print( *this->outstream );
            }
            //If it's done, remove it and advance to the next thread. erase()
            //returns the iterator following the removed element; reusing the
            //old iterator after erase() is undefined behavior.
            thread = threads.erase( thread );
        }
        else {
            ++thread;
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

void Director::printValues( std::ostream &out ){
	out << "\nValues:" << "\n";
	for( auto value : values ){
		out << value.first << "\n";
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
	out << ",\"Values\":[";
	comma = 0;
	for( auto value : values ){
		if(comma) out << ",";
		out << "\"" <<value.first << "\"";
		comma = 1;
	}
	out << "]";
	out << "}";	
}
