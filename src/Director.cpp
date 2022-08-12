#include <iostream>

#include "../Includes/Director.h"

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
        it->second.subscribe( api,_pParameters, _sParameters);
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

void Director::executeAction( const std::string action,  AtnApiStatus_typ* _pStatus, void *_pParameters, size_t _sParameters){

    auto it = actions.find(action);

    if (it != actions.end()){
        threads.push_back(it->second); 
        ///TODO: check if it's OK to start
        threads.back().start( _pStatus, _pParameters, _sParameters );
    }
    else{
        std::cout << "Action not found\n";
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

void Director::cyclic(){

    for (auto thread = threads.begin(); thread != threads.end(); ++thread){
        //Run thread
        if( thread->update() ){
            thread->print();
            //If it's done, remove it            
            threads.erase( thread );
        }
    }
}

void Director::printState(){
    for (auto thread = threads.begin(); thread != threads.end(); ++thread){
        thread->print();   
    }
}

void Director::printActions(){
    std::cout << "\nActions:" << "\n";
    for( auto action : actions ){
        std::cout << action.first << "\n";
    }
}
void Director::printStates(){
    std::cout << "\nStates:" << "\n";
    for( auto state : states ){
        std::cout << state.first << "\n";
    }

}
