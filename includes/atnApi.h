#include "atn.h"

#ifdef __cplusplus
	extern "C"
	{
#endif

//void atncyclic( void * director );

//Register a behavior to an acc
void registerBehavior( const STRING *action, const STRING *moduleName, AtnAPI_typ *behavior, UDINT *_pParameters, UDINT _sParameters);

void executeAction( const STRING *action );
void executeActionReport( const STRING *action, AtnApiStatusLocal_typ *api);

bool oneShot( AtnAPI_typ *Behavior );
bool oneShotReset( AtnAPI_typ *Behavior, bool *cmd );
bool oneShotStatus( AtnAPI_typ *Behavior, STRING *status);
// bool oneShot( AtnAPI_typ *Behavior, bool *cmd, STRING *status );
ATN_ST_enum respond( AtnAPI_typ *Behavior );
void readCallState( AtnApiStatusLocal_typ *status);

void atnSetDirector( void *director );



//bool registerState( STRING *state, STRING *moduleName, AtnAPIState_typ *api);
//bool registerStateWithParameters( STRING *state, STRING *moduleName, AtnAPIState_typ *api, UDINT * pParameters, UDINT sParameters);

//bool subscribeCommandBool(plcstring* state, plcstring* moduleName, plcbit* value);
//bool subscribePLCOpen(plcstring* state, plcstring* moduleName, plcbit* command, AtnPlcOpenStatus *status );

//void executeCommand( const STRING *action );
unsigned short PLCOpenStatus( const STRING *action );

bool forCommandGetPLCOpenStatus(plcstring* command, signed short index, unsigned short *status);

#ifdef __cplusplus
	};
#endif

#include <iostream>

class outbuf : public std::streambuf {
	private:
	char * _front;
	char * _current;
	size_t _sz;
	bool rolled;
	bool hasBeenReset;
	public:
	outbuf( char * data, size_t sz );

	virtual int_type overflow(int_type c = traits_type::eof());
	void reset();
};