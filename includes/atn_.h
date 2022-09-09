/* Automation Studio generated header file */
/* Do not edit ! */
/* atn 0.03.0 */

#ifndef _ATN_
#define _ATN_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _atn_VERSION
#define _atn_VERSION 0.03.0
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifdef _SG3
		#include "VarTools.h"
		#include "stringext.h"
#endif
#ifdef _SG4
		#include "VarTools.h"
		#include "stringext.h"
#endif
#ifdef _SGC
		#include "VarTools.h"
		#include "stringext.h"
#endif


/* Constants */
#ifdef _REPLACE_CONST
 #define MAI_ATN_ACTIONS 99U
 #define MAI_ATN_ACTIONLISTS 9U
 #define MAI_ATN_ACT_ACTIONS 10U
 #define MAI_ATN_ACT_THREADS 0U
 #define ATN_ACTION_NAME_LEN 20U
 #define ATN_NAMESPACE_LEN 20U
#else
 _GLOBAL_CONST unsigned char MAI_ATN_ACTIONS;
 _GLOBAL_CONST unsigned char MAI_ATN_ACTIONLISTS;
 _GLOBAL_CONST unsigned char MAI_ATN_ACT_ACTIONS;
 _GLOBAL_CONST unsigned char MAI_ATN_ACT_THREADS;
 _GLOBAL_CONST unsigned char ATN_ACTION_NAME_LEN;
 _GLOBAL_CONST unsigned char ATN_NAMESPACE_LEN;
#endif




/* Datatypes and datatypes of function blocks */
typedef enum ATN_SST_enum
{	ATN_SS_INIT
} ATN_SST_enum;

typedef enum ATN_ST_enum
{	ATN_IDLE,
	ATN_EXECUTE,
	ATN_WAITING,
	ATN_DONE,
	ATN_ABORT,
	ATN_ERROR,
	ATN_BYPASSED
} ATN_ST_enum;

typedef enum ATN_ERROR_enum
{	ATN_ERROR_OK = 0,
	ATN_ERROR_ACTIVE,
	ATN_ERROR_ABORTED,
	ATN_ERROR_ACTIONS_FULL,
	ATN_ERROR_BUSY = 65535
} ATN_ERROR_enum;

typedef enum ATN_RESPONSE_ST
{	ATN_RESPONSE_ST_NONE,
	ATN_RESPONSE_ST_ERROR,
	ATN_RESPONSE_ST_STEP_DONE,
	ATN_RESPONSE_ST_NEXT_STEP,
	ATN_RESPONSE_ST_STATE_DONE,
	ATN_RESPONSE_ST_BUSY
} ATN_RESPONSE_ST;

typedef struct AtnInCmd_typ
{	plcbit abort;
	plcbit forceQuit;
} AtnInCmd_typ;

typedef struct AtnInPar_typ
{	plcstring category[21];
	unsigned char ID;
} AtnInPar_typ;

typedef struct AtnIn_typ
{	struct AtnInCmd_typ cmd;
	struct AtnInPar_typ par;
} AtnIn_typ;

typedef struct AtnOutStatus_typ
{	plcbit blocked;
	plcbit busy;
	plcbit done;
	plcbit error;
} AtnOutStatus_typ;

typedef struct AtnActiveThread_typ
{	plcstring action[21];
	unsigned long busyModule[11];
	unsigned long errorModule[11];
	struct AtnOutStatus_typ status;
} AtnActiveThread_typ;

typedef struct AtnOut_typ
{	struct AtnActiveThread_typ activeThreads[1];
	plcbit busy;
	plcbit done;
	plcbit error;
} AtnOut_typ;

typedef struct AtnActionCmdData_typ
{	plcstring name[21];
	unsigned long pParameters;
	unsigned long sParameters;
	unsigned long pStatusStructure;
} AtnActionCmdData_typ;

typedef struct AtnThread_typ
{	unsigned char ID;
	struct AtnActionCmdData_typ request;
	struct AtnActionCmdData_typ activeRequest;
	enum ATN_ST_enum state;
	unsigned long substate;
	unsigned long nextSubState;
	plcbit abort;
	plcbit forceQuit;
	enum ATN_RESPONSE_ST responseStatus;
	unsigned long actions;
	unsigned long actionCount;
	unsigned long substateRequestModule;
	unsigned long busyModule[11];
	unsigned long blockingModule[11];
	unsigned long errorModule[11];
	unsigned long activeActions[11];
	struct AtnOutStatus_typ status;
} AtnThread_typ;

typedef struct AtnInternal_typ
{	struct AtnThread_typ thread;
} AtnInternal_typ;

typedef struct Atn_typ
{	struct AtnIn_typ in;
	struct AtnOut_typ out;
	struct AtnInternal_typ internal;
} Atn_typ;

typedef struct AtnApiStatus_typ
{	plcbit active;
	plcbit busy;
	plcbit done;
	plcbit aborted;
	plcbit error;
	unsigned long errorID;
} AtnApiStatus_typ;

typedef struct AtnApiStatusLocal_typ
{	plcbit active;
	plcbit busy;
	plcbit done;
	plcbit aborted;
	plcbit error;
	unsigned long errorID;
	struct AtnApiStatus_typ remote;
} AtnApiStatusLocal_typ;

typedef struct AtnAPI_typ
{	plcstring moduleName[81];
	plcstring moduleStatus[81];
	plcstring request[21];
	enum ATN_ST_enum state;
	enum ATN_ST_enum response;
	unsigned long subState;
	unsigned long subStateReq;
	plcbit oneShot;
	plcbit moduleBypass;
	plcbit moduleIsBypassed;
	unsigned long* activeThread;
	unsigned long* waitingThread;
	unsigned char waitingDirectorID;
} AtnAPI_typ;

typedef struct AtnAPIState_typ
{	plcstring moduleName[81];
	plcstring moduleStatus[81];
	plcbit moduleBypass;
	plcbit moduleIsBypassed;
	plcbit active;
} AtnAPIState_typ;

typedef struct AtnActionList_typ
{	plcstring name[21];
	unsigned long maxActions;
	struct AtnActionData_typ* pActions;
} AtnActionList_typ;

typedef struct AtnActionData_typ
{	plcstring name[21];
	unsigned long pParameters;
	unsigned long sParameters;
	struct AtnAPI_typ* pAction;
} AtnActionData_typ;

typedef struct AtnRunAction
{
	/* VAR_INPUT (analog) */
	unsigned long director;
	plcstring action[21];
	unsigned long pParameters;
	unsigned long parameterSize;
	/* VAR (analog) */
	struct AtnApiStatus_typ status;
	/* VAR_INPUT (digital) */
	plcbit execute;
	/* VAR_OUTPUT (digital) */
	plcbit busy;
	plcbit done;
	plcbit active;
	plcbit aborted;
	plcbit error;
	/* VAR (digital) */
	plcbit _execute;
} AtnRunAction_typ;


/* Prototyping of functions and function blocks */
_BUR_PUBLIC void AtnRunAction(struct AtnRunAction* inst);
_BUR_PUBLIC unsigned char atnRunAction(struct Atn_typ* director, plcstring* action, unsigned long* pParameters, unsigned long parameterSize, struct AtnApiStatus_typ* status);
_BUR_PUBLIC unsigned char atnCyclic(struct Atn_typ* director);
_BUR_PUBLIC unsigned char atnRegisterActionPV(plcstring* category, plcstring* name, plcstring* actionPv, plcstring* parameterPv);
_BUR_PUBLIC unsigned char atnRegisterActionPVLocal(plcstring* category, plcstring* name, plcstring* actionPv, plcstring* parameterPv);
_BUR_PUBLIC unsigned char atnRegisterAction(plcstring* category, plcstring* name, struct AtnAPI_typ* pAction, unsigned long* pParameters, unsigned long parameterSize);
_BUR_PUBLIC unsigned long atnGetActionList(plcstring* gategory);
_BUR_PUBLIC plcbit atnSetActionList(plcstring* gategory, struct AtnActionData_typ* pActions, unsigned long size);
// _BUR_PUBLIC plcbit registerState(plcstring* state, plcstring* moduleName, AtnAPIState_typ *api);
_BUR_PUBLIC plcbit registerStateBool(plcstring* state, plcstring* moduleName, plcbit* value);
_BUR_PUBLIC plcbit stateAllTrue(plcstring* state, plcbit fallback);
_BUR_PUBLIC plcbit stateAnyTrue(plcstring* state, plcbit fallback);
_BUR_PUBLIC plcbit stateAllFalse(plcstring* state, plcbit fallback);
_BUR_PUBLIC plcbit stateAnyFalse(plcstring* state, plcbit fallback);


#ifdef __cplusplus
};
#endif
#endif /* _ATN_ */

