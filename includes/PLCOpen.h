#include <string>
#include "atn.h"

namespace atn{

    class PLCOpen
    {
    public:
        void * pParameters;
        size_t sParameters;
        struct AtnAPIState_typ* pCheck;
        bool * pValue;
		signed long * pStatus;
		long unsigned int * pCommandSource;
        std::string name;
        PLCOpen( );
        PLCOpen( std::string Name, bool * value );
        PLCOpen( std::string Name, bool * value, void * pParameters, size_t parameterSize );
        PLCOpen( struct AtnAPIState_typ* pCheck, void * pParameters, size_t parameterSize) ;
        ~PLCOpen();
        bool isTrue();
        void setDisableStatus();
        void setBusyStatus();
        unsigned short PLCOpenStatus();
        bool set( bool value);
        void print();
    };
}