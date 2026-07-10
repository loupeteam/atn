/*
 * File: Director.h
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 *
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 *
 */

#include <unordered_map>
#include "atn.h"
#include "State.h"

namespace atn{

	class Director
	{

		private:
		std::unordered_map<std::string, State> commands;	//These are commands that have been subscribed
		std::unordered_map<std::string, State> states;		//These are states that have been registered

		public:

		std::ostream *outstream;

		Director(/* args */);
		~Director();

		//Registers an API interface to a state for detailed control
		void addState( const std::string state, AtnAPIState_typ *check, void *_pParameters, size_t _sParameters );

		//Registers an API interface to a state for detailed control
		void addState( const std::string state, const std::string moduleName, char *moduleStatus, bool* moduleByPass, bool *check, void *_pParameters, size_t _sParameters );

		//Registers a bool to be automatically monitored, without full API support
		void addStateBool( const std::string state, const std::string moduleName, bool *check );

		//Registers a bool to be automatically monitored, with parameters, without full API support
		void addStateBool( const std::string state, const std::string moduleName, bool *check, void *_pParameters, size_t _sParameters);

		//Registers a bool to be automatically monitored, without full API support
		void addResourceBool( const std::string state, const std::string moduleName, unsigned long int *pResourceUid, bool *check );

		//Registers a bool to be automatically monitored, without full API support
		void addCommandBool( const std::string command, const std::string moduleName, bool * commandBit );

		//Registers a bool to be automatically monitored, without full API support
		void addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBit, AtnPlcOpenStatus *status );

		//Registers a bool to be automatically monitored, without full API support
		void addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBit, AtnPlcOpenStatus *status,  void *_pParameters, size_t _sParameters);

		//Sets command bits that are registered to true
		bool executeCommand( const std::string command );

		//reset command bits that are registered to true
		void resetCommand( const std::string command );

		//Search for a state
		State *getState( const std::string state);

		//Search for a command
		State *getCommand( const std::string cmd);

		//Print things..
		void printStates( std::ostream &);
		void printCommands( std::ostream &);
		void printSystemJson( std::ostream &);

	};
};
