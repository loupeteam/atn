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
	
		public:

		std::ostream *outstream;
		
		Director(/* args */);
		~Director();

		//Call cyclicly to update threads
		void cyclic();

		//Registers an API interface to a state for detailed control
		void addState( const std::string state, AtnAPIState_typ *check, void *_pParameters, size_t _sParameters );
		
		//Registers a bool to be automatically monitored, without full API support
		void addStateBool( const std::string state, const std::string moduleName, bool *check );

		//Registers a bool to be automatically monitored, with parameters, without full API support
		void addStateBool( const std::string state, const std::string moduleName, bool *check, void *_pParameters, size_t _sParameters);

		//Registers a bool to be automatically monitored, without full API support
		void addCommandBool( const std::string command, const std::string moduleName, bool * commandBit );

		//Registers a bool to be automatically monitored, without full API support
		void addCommandPLCOpen( const std::string command, const std::string moduleName, bool * commandBit, AtnPlcOpenStatus *status );

		//Registers a behavior to an action
		void addBehavior( const std::string action, AtnAPI_typ *behavior, void *_pParameters, size_t _sParameters );

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

		//Count of the number of active actions
		unsigned int countActiveThreads();

		//Print things..
		void printState( std::ostream &);

		void printActions( std::ostream &);
		void printStates( std::ostream &);
		void printCommands( std::ostream &);
	};
};
