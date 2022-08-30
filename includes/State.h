#include "PLCOpen.h"
#include "atn.h"
#include <vector>
namespace atn{
    class State
    {
    private:
        std::string name;
        AtnApiStatus_typ * pStatus;
        void * pParameters;
        size_t sParameters;

    public:

        std::vector<PLCOpen> PLCOpenState; 

        State( std:: string name);    
        ~State();
        void subscribe(  AtnAPIState_typ* api, void *_pParameters, size_t _sParameters  );
        void subscribe(  const std:: string ModuleName, bool* api);
        void subscribe(  const std:: string ModuleName, bool* api, void *_pParameters, size_t _sParameters  );
        void subscribe(  const std:: string ModuleName,  plcbit* command, AtnPlcOpenStatus *status );
		bool setTrigger(  );
		bool setTrue(  );
        bool setFalse(  );
        bool allTrue( bool fallback );
        bool allFalse( bool fallback );
        bool anyTrue( bool fallback );
        bool anyFalse( bool fallback );
        unsigned short getPLCOpenState( unsigned short fallback );
        void print( std::ostream &);
        unsigned int count();
    };
}