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

		std::vector<std::string> DependentState; 
		std::vector<PLCOpen> PLCOpenState; 

        State( std:: string name);    
        ~State();
        void subscribe(  AtnAPIState_typ* api, void *_pParameters, size_t _sParameters  );
        void subscribe(  const std:: string ModuleName, bool* active);
        void subscribe(  const std:: string ModuleName, bool* active, void *_pParameters, size_t _sParameters  );
		void subscribe(  const std:: string ModuleName, bool* active, bool* bypass, char * statusString, void *_pParameters, size_t _sParameters  );
		void subscribe(  const std:: string ModuleName, unsigned long int * pUid, bool* value );
		
		void subscribe(  const std:: string ModuleName,  bool* command, AtnPlcOpenStatus *status );
		void subscribe(  const std:: string ModuleName,  bool* command, AtnPlcOpenStatus *status, void *_pParameters, size_t _sParameters  );
		void subscribe(  const std:: string ModuleName,  const std::string state );
		bool setTrigger(  );
		bool setTrue(  );
        bool setFalse(  );
        bool allTrue( bool fallback );
        bool allFalse( bool fallback );
        bool anyTrue( bool fallback );
        bool anyFalse( bool fallback );
		bool allFalseExcept( bool fallback, unsigned long ID );
		unsigned short getPLCOpenState( unsigned short fallback );
        void print( std::ostream &);
		void plcopenReport( std::ostream &);
		unsigned int count();
    };
}