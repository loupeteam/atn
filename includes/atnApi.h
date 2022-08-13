#include "atn.h"

#ifdef __cplusplus
	extern "C"
	{
#endif

//void atncyclic( void * director );

//Register a behavior to an acc
void registerBehavior( const STRING *action, const STRING *moduleName, AtnAPI_typ *behavior, UDINT *_pParameters, UDINT _sParameters);

bool oneShot( AtnAPI_typ *Behavior );
bool oneShotReset( AtnAPI_typ *Behavior, bool *cmd );
bool oneShotStatus( AtnAPI_typ *Behavior, STRING *status);
// bool oneShot( AtnAPI_typ *Behavior, bool *cmd, STRING *status );
ATN_ST_enum respond( AtnAPI_typ *Behavior );

bool registerState( STRING *state, STRING *moduleName, AtnAPIState_typ *api);
bool registerStateWithParameters( STRING *state, STRING *moduleName, AtnAPIState_typ *api, UDINT * pParameters, UDINT sParameters);
bool registerCommandBool(plcstring* state, plcstring* moduleName, plcbit* value);

//int forState( STRING *State, int index, bool *state, UDINT * pParameters, UDINT sParameters );
//int forStateGetPointer( STRING *state, int index, bool *active, UDINT ** pParameters );
//bool stateAllTrue( const STRING *state, bool );

void executeAction( const STRING *action );
void executeActionReport( const STRING *action, AtnApiStatusLocal_typ *api);
void executeCommand( const STRING *action );

void atnSetDirector( void *director );

void readCallState( AtnApiStatusLocal_typ *status);

#ifdef __cplusplus
	};
#endif
