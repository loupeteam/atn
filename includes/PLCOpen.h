#include <string>
#include "atn.h"

namespace atn{

    class PLCOpen
    {
    public:
		std::string name;
		char * pStatusString;
		bool * pValue;
		
		void * pParameters;
        size_t sParameters;

		signed long * pStatus;
		bool * pBypass;
		long unsigned int * pCommandSource;

		bool * pFirstCycle;
		bool * pParameterWritten;
		//        struct AtnAPIState_typ* pCheck;
		PLCOpen( );
        PLCOpen( std::string Name, bool * value );
        PLCOpen( std::string Name, bool * value, void * pParameters, size_t parameterSize );
        PLCOpen( struct AtnAPIState_typ* pCheck, void * pParameters, size_t parameterSize) ;
        ~PLCOpen();
        bool isTrue();
        void setDisableStatus();
        void setBusyStatus();
		unsigned short PLCOpenStatus();
		void writeParameters( void *pParameters, size_t parameterSize);
        bool set( bool value);
        void print( std::ostream & );
    };
}