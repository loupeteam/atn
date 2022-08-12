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
        Inhibit( void * pParameters, size_t parameterSize, struct AtnAPIState_typ* pCheck) ;
        Inhibit( std::string Name, bool * value );
        Inhibit( std::string Name, bool * value, void * pParameters, size_t parameterSize );
        ~Inhibit();
        bool isTrue();
        bool set( bool value);
        void print();
    };
}