#include "atn.h"

#ifdef __cplusplus
	extern "C"
	{
#endif

void atncyclic( void * director );

//Register a behavior to an acc
void registerBehavior( const STRING *action, const STRING *moduleName, AtnAPI_typ *behavior, UDINT *_pParameters, UDINT _sParameters);

bool oneShot( AtnAPI_typ *Behavior );
bool oneShotReset( AtnAPI_typ *Behavior, bool *cmd );
bool oneShotStatus( AtnAPI_typ *Behavior, STRING *status);
// bool oneShot( AtnAPI_typ *Behavior, bool *cmd, STRING *status );
ATN_ST_enum respond( AtnAPI_typ *Behavior );

void registerState( const STRING *start, const STRING *moduleName, AtnAPICheck_typ *api, UDINT *_pParameters, UDINT _sParameters);
bool stateAllTrue( const STRING *state );

void executeAction( const STRING *action );
void executeActionReport( const STRING *action, AtnApiStatusLocal_typ *api);



void readCallState( AtnApiStatusLocal_typ *status);

#ifdef __cplusplus
	};
#endif
