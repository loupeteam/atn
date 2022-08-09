#include "Inhibit.h"
#include "atn.h"
#include <vector>
namespace atn{
    class State
    {
    private:
        std::string name;
        std::vector<Inhibit> inhibits; 
        AtnApiStatus_typ * pStatus = 0;
        void * pParameters = 0;
        size_t sParameters = 0;
    public:

        State( std:: string name);    
        ~State();
        void subscribe(  AtnAPICheck_typ* api, void *_pParameters, size_t _sParameters  );
        bool allTrue();
        bool allFalse();
        bool anyTrue();
        bool anyFalse();
        void print();
    };
}