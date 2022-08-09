#include <string>
#include "atn.h"

namespace atn{

    class Inhibit
    {
    public:
        void * pParameters;
        size_t sParameters;
        struct AtnAPIState_typ* pCheck;
        Inhibit( );
        Inhibit( void * pParameters, size_t parameterSize, struct AtnAPIState_typ* pCheck);
        ~Inhibit();
        bool isTrue();
        void print();
    };
}