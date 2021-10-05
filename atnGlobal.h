/********************************************************************
 * COPYRIGHT -- Loupe 
 ********************************************************************
 * Library: All Together Now -atn
 * Author: Josh Polansky
 * Created: April 7, 2020
 ********************************************************************
 * Implementation of library All Together now
 ********************************************************************/

#include <bur/plctypes.h>

plcbit atnThreadFn(struct AtnThread_typ* thread);
plcbit atn_checkResponses(struct AtnThread_typ* thread);
plcbit atn_handleResponse(struct AtnThread_typ* thread);
plcbit atn_setCommand(struct AtnThread_typ* thread);
plcbit atn_releaseModules(struct AtnThread_typ* thread);
plcbit atn_threadState(struct AtnThread_typ* thread);
plcbit atn_prepareRequest(struct AtnThread_typ* thread, unsigned long request);
plcbit atn_setStatus(struct AtnActionCmdData_typ* cmdData, unsigned long  status);
void initGlobalActionList( void );