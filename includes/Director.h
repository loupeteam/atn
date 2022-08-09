#include <deque>
#include <map>

#include "Action.h"
#include "State.h"
namespace atn{

    class Director
    {

    private:
        std::deque<Action> threads;
        std::map<std::string, Action> actions;
        std::map<std::string, State> states;
    public:
        Director(/* args */);
        ~Director();
        void cyclic();
        void addState( const std::string state, AtnAPICheck_typ *check, void *_pParameters, size_t _sParameters );
        void addBehavior( const std::string action, AtnAPI_typ *behavior, void *_pParameters, size_t _sParameters );
        void executeAction( const std::string actions, AtnApiStatus_typ* _pStatus, void *_pParameters, size_t _sParameters );
        bool stateIsTrue( const std::string actions );

        State *getState( const std::string state);
        void printState();
        void printActions();
        void printStates();
        unsigned int countActiveThreads();
    };
};
