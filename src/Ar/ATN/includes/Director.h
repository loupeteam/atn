/*
 * File: Director.h
 * Copyright (c) 2023 Loupe
 * https://loupe.team
 *
 * This file is part of All Together Now - ATN, licensed under the MIT License.
 *
 */

#include <unordered_map>
#include <string>
#include <ostream>
#include "atn.h"
#include "State.h"

namespace atn{

	class Director
	{

		private:
		std::unordered_map<std::string, State> commands;	//These are commands that have been subscribed
		std::unordered_map<std::string, State> states;		//These are states that have been registered
		std::unordered_map<std::string, State> values;		//Single-publisher value topics
		std::unordered_map<bool*, State> boolGroups;		//By-bool follower index backing resolveByBool()

		//By-bool index maintenance. Called only from the register/unregister paths, so the
		//index is frozen during cyclic operation and resolveByBool() is a pure read.
		State* boolGroupFor( bool* commandBool );      //find-or-create a bool's group (register)
		void   rebuildBoolGroup( bool* commandBool );  //re-derive a bool's group from `commands` (unregister)

		public:

		std::ostream *outstream;

		Director(/* args */);
		~Director();

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
		void addCommandBool( const std::string command, const std::string moduleName, bool * commandBool, const std::string& taskName = "" );

		//Registers a bool to be automatically monitored, without full API support
		void addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBool, AtnPlcOpenStatus *status, const std::string& taskName = "" );

		//Registers a bool to be automatically monitored, without full API support
		void addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBool, AtnPlcOpenStatus *status,  void *_pParameters, size_t _sParameters, const std::string& taskName = "");

		//Sets command bits that are registered to true
		bool executeCommand( const std::string command );

		//reset command bits that are registered to true
		void resetCommand( const std::string command );

		//Search for a state
		State *getState( const std::string state);

		//Search for a command
		State *getCommand( const std::string cmd);

		//Resolve, by command bool, the group of PLCOpen followers that share it.
		//Backs in-task PLCOpen calls (AtnPLCOpenLocal): the caller passes only the
		//command bool and we return every follower registered against that exact bool
		//- so one local call drives them all and arbitrates against remote callers
		//through their shared status structs, with no string lookup. Returns 0 when
		//the bool has no registered followers. The by-bool index is built in the
		//register/unregister paths, so this call never mutates boolGroups - it is a
		//pure read. Concurrent local callers are therefore safe against each other
		//without a lock PROVIDED registration/unregistration stay in _INIT/_EXIT (the
		//ATN convention) so nothing mutates the index during cyclic operation.
		State *resolveByBool( bool* commandBool );

		//Single-publisher value topic (one producer per topic name)
		bool addValue( const std::string state, const std::string moduleName, bool *valid, void *_pData, size_t _sData, size_t sReturn = 0, const std::string& taskName = "" );
		State *getValue( const std::string state );

		//Registration lifecycle (online transfer): remove a task's registrations from one
		// named topic, or from all topics, by the task name captured at registration.
		// Both return the number of registrations removed.
		unsigned int removeRegistration( const std::string& name, const std::string& taskName );
		unsigned int removeAllForTask( const std::string& taskName );

		//Print things..
		void printStates( std::ostream &);
		void printCommands( std::ostream &);
		void printValues( std::ostream &);
		void printSystemJson( std::ostream &);

		//Write a non-fatal diagnostic to the event logger.
		// Returns 0 on success, otherwise the logger StatusID.
		signed long raise( AtnDiagSeverity_enum severity, unsigned short code, const char* source, const char* message );

		//Total number of diagnostics raised since startup (including failed writes)
		unsigned long diagnosticCount();

		//Select the logbook that raise() writes to. Defaults to the user logbook ($arlogusr).
		// Returns 0 on success, -1 on an invalid name.
		signed long setDiagnosticLogger( const char* loggerName );

	private:
		static const int DIAG_LOGGER_NAME_MAX = 80;
		char diagLoggerName[DIAG_LOGGER_NAME_MAX + 1];
		unsigned long raiseCount;

	};
};
