#include "atn.h"

#ifdef __cplusplus
	extern "C"
	{
#endif

void atncyclic( void * director );

//Register a behavior to an acc
void registerBehavior( const STRING *action, const STRING *moduleName, AtnAPI_typ *behavior, UDINT *_pParameters, UDINT _sParameters);
void executeAction( const STRING *action );

void registerState( const STRING *start, const STRING *moduleName, AtnAPICheck_typ *api, UDINT *_pParameters, UDINT _sParameters);
bool stateAllTrue( const STRING *state );

bool oneShot( AtnAPI_typ *Behavior );
bool oneShotStatus( AtnAPI_typ *Behavior, STRING *status);
ATN_ST_enum respond( AtnAPI_typ *Behavior );

#ifdef __cplusplus
	};
#endif
