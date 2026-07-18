/*
 * File: Director.h
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 * 
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 * 
 */

#include <deque>
#include <unordered_map>
#include "atn.h"
#include "Action.h"
#include "State.h"

namespace atn{

	class Director
	{

		private:
		std::deque<Action> threads;					//Keep active threads here
		std::unordered_map<std::string, Action> actions;	//These are actions that have been registered
		std::unordered_map<std::string, State> commands;	//These are commands that have been subscribed
		std::unordered_map<std::string, State> states;		//These are states that have been registered
		std::unordered_map<std::string, State> values;		//Single-publisher value topics
		std::unordered_map<bool*, State> bitGroups;		//By-bit follower index backing resolveByBool()

		//By-bit index maintenance. Called only from the register/unregister paths, so the
		//index is frozen during cyclic operation and resolveByBool() is a pure read.
		State* bitGroupFor( bool* commandBit );      //find-or-create a bit's group (register)
		void   rebuildBitGroup( bool* commandBit );  //re-derive a bit's group from `commands` (unregister)
	
		public:

		std::ostream *outstream;
		
		Director(/* args */);
		~Director();

		//Call cyclicly to update threads
		void cyclic();

		//Registers an API interface to a state for detailed control
		void addState( const std::string state, AtnAPIState_typ *check, void *_pParameters, size_t _sParameters, const std::string& taskName = "" );
		
		//Registers an API interface to a state for detailed control
		void addState( const std::string state, const std::string moduleName, char *moduleStatus, bool* moduleByPass, bool *check, void *_pParameters, size_t _sParameters, const std::string& taskName = "" );

		//Registers a bool to be automatically monitored, without full API support
		void addStateBool( const std::string state, const std::string moduleName, bool *check, const std::string& taskName = "" );

		//Registers a bool to be automatically monitored, with parameters, without full API support
		void addStateBool( const std::string state, const std::string moduleName, bool *check, void *_pParameters, size_t _sParameters, const std::string& taskName = "");

		//Registers a bool to be automatically monitored, without full API support
		void addResourceBool( const std::string state, const std::string moduleName, unsigned long int *pResourceUid, bool *check, const std::string& taskName = "" );
		
		//Registers a bool to be automatically monitored, without full API support
		void addCommandBool( const std::string command, const std::string moduleName, bool * commandBit, const std::string& taskName = "" );

		//Registers a bool to be automatically monitored, without full API support
		void addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBit, AtnPlcOpenStatus *status, const std::string& taskName = "" );

		//Registers a bool to be automatically monitored, without full API support
		void addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBit, AtnPlcOpenStatus *status,  void *_pParameters, size_t _sParameters, const std::string& taskName = "");

		//Registers a behavior to an action
		void addBehavior( const std::string action, AtnAPI_typ *behavior, void *_pParameters, size_t _sParameters, const std::string& taskName = "" );

		//Starts execution of an action.
		// Cyclic calls must be made to finish the action
		void executeAction( const std::string actions, AtnApiStatus_typ* _pStatus, void *_pParameters, size_t _sParameters );

		//Sets command bits that are registered to true
		bool executeCommand( const std::string actions );

		//reset command bits that are registered to true
		void resetCommand( const std::string actions );

		//Search for a state
		State *getState( const std::string state);

		//Search for a command
		State *getCommand( const std::string cmd);

		//Resolve, by command bit, the group of PLCOpen followers that share it.
		//Backs in-task PLCOpen calls (AtnPLCOpenLocal): the caller passes only the
		//command bit and we return every follower registered against that exact bit
		//- so one local call drives them all and arbitrates against remote callers
		//through their shared status structs, with no string lookup. Returns 0 when
		//the bit has no registered followers. The by-bit index is built in the
		//register/unregister paths, so this is a PURE READ at cyclic time (safe for
		//concurrent callers across cores without a lock).
		State *resolveByBool( bool* commandBit );

		//Single-publisher value topic (one producer per topic name)
		bool addValue( const std::string state, const std::string moduleName, bool *valid, void *_pData, size_t _sData, size_t sReturn = 0, const std::string& taskName = "" );
		State *getValue( const std::string state );

		//Registration lifecycle (online transfer): remove a task's registrations from one
		// named topic, or from all topics, by the task name captured at registration.
		// Both return the number of registrations removed.
		unsigned int removeRegistration( const std::string& name, const std::string& taskName );
		unsigned int removeAllForTask( const std::string& taskName );

		//Count of the number of active actions
		unsigned int countActiveThreads();

		//Print things..
		void printState( std::ostream &);

		void printActions( std::ostream &);
		void printStates( std::ostream &);
		void printCommands( std::ostream &);
		void printValues( std::ostream &);
		void printSystemJson( std::ostream &);

	};
};
