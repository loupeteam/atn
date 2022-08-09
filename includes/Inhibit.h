#include <string>
#include "atn.h"

namespace atn{

    class Inhibit
    {
    public:
        void * pParameters = 0;
        size_t sParameters = 0;
        struct AtnAPIState_typ* pCheck  = 0;
        Inhibit( );
        Inhibit( void * pParameters, size_t parameterSize, struct AtnAPIState_typ* pCheck);
        ~Inhibit();
        bool isTrue();
        void print();
    };
}