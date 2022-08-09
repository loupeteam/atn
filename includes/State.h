#include "Inhibit.h"
#include "atn.h"
#include <vector>
namespace atn{
    class State
    {
    private:
        std::string name;
        std::vector<Inhibit> inhibits; 
        AtnApiStatus_typ * pStatus;
        void * pParameters;
        size_t sParameters;
    public:

        State( std:: string name);    
        ~State();
        void subscribe(  AtnAPIState_typ* api, void *_pParameters, size_t _sParameters  );
        bool allTrue();
        bool allFalse();
        bool anyTrue();
        bool anyFalse();
        void print();
    };
}