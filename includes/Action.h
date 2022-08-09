#include "Behavior.h"
#include "atn.h"
#include <vector>
namespace atn{
    class Action
    {
    private:
        std::string name;
        ATN_ST_enum actionState = ATN_IDLE;
        int substate = 0;
        std::vector<Behavior> behaviors; 
        void updateState( int state );
        AtnApiStatus_typ * pStatus = 0;
        void * pParameters = 0;
        size_t sParameters = 0;
    public:

        Action( std:: string name);    
        ~Action();
        void subscribe(  AtnAPI_typ* api, void *_pParameters, size_t _sParameters  );
        void start( );
        void start( AtnApiStatus_typ* pStatus, void *pParameters, size_t sParameters );
        bool update();
        bool isReady();
        void updateState( ATN_ST_enum state );
        void updateStatus( ATN_ST_enum state );
        void updateSubstate( unsigned long substate );
        ATN_RESPONSE_ST checkState( ATN_ST_enum stateToCheck );
        void release();
        void abort();
        void print();

    };
}