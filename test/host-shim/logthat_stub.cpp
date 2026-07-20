/* Host-test stub implementation of the LogThat write functions.
 * Captures each call into logThatShimCalls so tests can assert on
 * severity, code, logger name, and formatted message. See LogThat.h.
 */

#include <cstring>

#include <bur/plctypes.h>

extern "C"
{
#include "LogThat.h"
}

LogThatShimCall logThatShimCalls[LOGTHAT_SHIM_MAX_CALLS];
int logThatShimCount = 0;
signed long logThatShimReturn = 0;

extern "C" void logThatShimReset(void)
{
	std::memset(logThatShimCalls, 0, sizeof(logThatShimCalls));
	logThatShimCount = 0;
	logThatShimReturn = 0;
}

static signed long shimCapture(LogThatShimSeverity severity, plcstring* LoggerName,
                               unsigned short ErrorID, plcstring* ErrorString)
{
	if( logThatShimCount < LOGTHAT_SHIM_MAX_CALLS ){
		LogThatShimCall* call = &logThatShimCalls[logThatShimCount];
		call->severity = severity;
		call->code = ErrorID;
		if( LoggerName ){
			std::strncpy(call->loggerName, (const char*)LoggerName, sizeof(call->loggerName) - 1);
		}
		if( ErrorString ){
			std::strncpy(call->message, (const char*)ErrorString, sizeof(call->message) - 1);
		}
	}
	logThatShimCount++;
	return logThatShimReturn;
}

extern "C" signed long logInfo(plcstring* LoggerName, unsigned short ErrorID, plcstring* ErrorString, unsigned long pMsgData)
{
	(void)pMsgData;
	return shimCapture(LOGTHAT_SHIM_INFO, LoggerName, ErrorID, ErrorString);
}

extern "C" signed long logWarning(plcstring* LoggerName, unsigned short ErrorID, plcstring* ErrorString, unsigned long pMsgData)
{
	(void)pMsgData;
	return shimCapture(LOGTHAT_SHIM_WARNING, LoggerName, ErrorID, ErrorString);
}

extern "C" signed long logError(plcstring* LoggerName, unsigned short ErrorID, plcstring* ErrorString, unsigned long pMsgData)
{
	(void)pMsgData;
	return shimCapture(LOGTHAT_SHIM_ERROR, LoggerName, ErrorID, ErrorString);
}

extern "C" signed long logSuccess(plcstring* LoggerName, unsigned short ErrorID, plcstring* ErrorString, unsigned long pMsgData)
{
	(void)pMsgData;
	return shimCapture(LOGTHAT_SHIM_SUCCESS, LoggerName, ErrorID, ErrorString);
}
