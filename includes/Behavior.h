#include <string>
#include "atn.h"

namespace atn{

    class Behavior
    {
    public:
        void * pParameters;
        size_t sParameters;
        struct AtnAPI_typ* pAction;
        Behavior( );
        Behavior( void * pParameters, size_t parameterSize, struct AtnAPI_typ* pAction);
        ~Behavior();
        bool updateState( ATN_ST_enum state, void *_pParameters, size_t _sParameters );
        bool updateSubstate( unsigned long state );
        ATN_RESPONSE_ST checkState( ATN_ST_enum state, unsigned long substate  );
        void release();
        void print( std::ostream &);
    };
}
