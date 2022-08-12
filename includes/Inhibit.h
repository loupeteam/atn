#include <string>
#include "atn.h"

namespace atn{

    class Inhibit
    {
    public:
        void * pParameters;
        size_t sParameters;
        struct AtnAPIState_typ* pCheck;
        bool * pValue;
        std::string name;
        Inhibit( );
        Inhibit( void * pParameters, size_t parameterSize, struct AtnAPIState_typ* pCheck);
        Inhibit( std::string Name, bool * value);
        ~Inhibit();
        bool isTrue();
        void print();
    };
}