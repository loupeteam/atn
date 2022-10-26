#include "atn.h"
#include "../includes/atnApi.h"
#include "../includes/Director.h"
#include <string>
#include <cstring>
#include <iostream>

using namespace atn;

extern Director *globalDirector;

bool stateAllTrue( STRING *state, bool fallback ){
	State *s = globalDirector->getState(std::string((char*)state));
	if( s ){
		return s->allTrue( fallback );
	}
	else{
		return fallback;
	}
}

bool stateAnyTrue( STRING *state, bool fallback ){
	State *s = globalDirector->getState(std::string((char*)state));
	if( s ){
		return s->anyTrue( fallback );
	}
	else{
		return fallback;
	}
}

bool stateAllFalse( STRING *state, bool fallback ){
	State *s = globalDirector->getState(std::string((char*)state));
	if( s ){
		return s->allFalse( fallback );
	}
	else{
		return fallback;
	}
}

bool stateAnyFalse( STRING *state, bool fallback ){
	State *s = globalDirector->getState(std::string((char*)state));
	if( s ){
		return s->anyFalse( fallback );
	}
	else{
		return fallback;
	}
}

bool isInhibited( STRING *state ){
	State *s = globalDirector->getState(std::string((char*)state));
	if( s ){
		return s->allFalse( false );
	}
	else{
		return false;
	}
}

bool resourceIsAvailable( STRING *state, unsigned long ID ){
	State *s = globalDirector->getState(std::string((char*)state));
	if( s ){
		return s->allFalseExcept( true, ID );
	}
	else{
		return true;
	}
}


void stateAllTrueFb(struct stateAllTrueFb* inst){
	if( inst->update || inst->cache == 0){	
		inst->cache = (UDINT*)globalDirector->getState(std::string((char*)inst->state));
	}
	State *s = (State *)inst->cache;
	if( s ){
		inst->value = s->allTrue( inst->fallback );
	}
	else{
		inst->value = inst->fallback;
	}
}
void stateAnyTrueFb(struct stateAnyTrueFb* inst){
	if( inst->update || inst->cache == 0){	
		inst->cache = (UDINT*)globalDirector->getState(std::string((char*)inst->state));
	}
	State *s = (State *)inst->cache;
	if( s ){
		inst->value = s->anyTrue( inst->fallback );
	}
	else{
		inst->value = inst->fallback;
	}
}
void stateAllFalseFb(struct stateAllFalseFb* inst){
	if( inst->update || inst->cache == 0){	
		inst->cache = (UDINT*)globalDirector->getState(std::string((char*)inst->state));
	}
	State *s = (State *)inst->cache;
	if( s ){
		inst->value = s->allFalse( inst->fallback );
	}
	else{
		inst->value = inst->fallback;
	}
}
void stateAnyFalseFb(struct stateAnyFalseFb* inst){
	if( inst->update || inst->cache == 0){	
		inst->cache = (UDINT*)globalDirector->getState(std::string((char*)inst->state));
	}
	State *s = (State *)inst->cache;
	if( s ){
		inst->value = s->anyFalse( inst->fallback );
	}
	else{
		inst->value = inst->fallback;
	}
}
