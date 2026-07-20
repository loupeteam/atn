/* Host-test stub of the LogThat library header.
 *
 * On target, "LogThat.h" resolves to the header generated from the LogThat
 * dependency (github.com/loupeteam/LogThat) and the log* functions write to
 * the Automation Runtime Logger. Off-target, this stub captures every call so
 * tests can assert on what ATN would have logged. Signatures match LogThat's
 * C sources (logInfo.c / logWarning.c / logError.c / logSuccess.c).
 */
#ifndef _LOGTHAT_
#define _LOGTHAT_

#include <bur/plctypes.h>

#ifdef __cplusplus
extern "C"
{
#endif

signed long logInfo(plcstring* LoggerName, unsigned short ErrorID, plcstring* ErrorString, unsigned long pMsgData);
signed long logWarning(plcstring* LoggerName, unsigned short ErrorID, plcstring* ErrorString, unsigned long pMsgData);
signed long logError(plcstring* LoggerName, unsigned short ErrorID, plcstring* ErrorString, unsigned long pMsgData);
signed long logSuccess(plcstring* LoggerName, unsigned short ErrorID, plcstring* ErrorString, unsigned long pMsgData);

/* --- test instrumentation (host only, not part of the real LogThat API) --- */

typedef enum LogThatShimSeverity
{	LOGTHAT_SHIM_INFO,
	LOGTHAT_SHIM_WARNING,
	LOGTHAT_SHIM_ERROR,
	LOGTHAT_SHIM_SUCCESS
} LogThatShimSeverity;

typedef struct LogThatShimCall
{	LogThatShimSeverity severity;
	unsigned short code;
	char loggerName[81];
	char message[321];   /* LogThat's LOG_STRLEN_MESSAGE is 320 */
} LogThatShimCall;

#define LOGTHAT_SHIM_MAX_CALLS 32

extern LogThatShimCall logThatShimCalls[LOGTHAT_SHIM_MAX_CALLS];
extern int logThatShimCount;          /* total calls since reset (may exceed MAX_CALLS) */
extern signed long logThatShimReturn; /* value the log* stubs return (0 = OK) */

void logThatShimReset(void);

#ifdef __cplusplus
}
#endif

#endif /* _LOGTHAT_ */
