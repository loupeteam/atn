/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _VISAPI_
#define _VISAPI_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define vaATTRIBUTE_ALPHA 128U
 #define vaALS_CURRENT 65536U
 #define vaALS_NOTBYPASSSED 512U
 #define vaALS_BYPASSSED 256U
 #define vaALS_NOTACKNOWLEDGED 32U
 #define vaALS_ACKNOWLEDGED 16U
 #define vaALS_ACTIVE 2U
 #define vaALS_INACTIVE 1U
 #define vaERR_EMPTY_HISTORYLIST 248U
 #define vaERR_BUSY 7000U
 #define vaERR_EMPTY_ALARMLIST 240U
 #define vaERR_NOALARMQUIT 245U
 #define vaERR_DELHISLIST 246U
 #define vaERR_BUSY_ALARMSYSTEM 247U
 #define vaERR_INTERPRETER_NOT_READY 7010U
 #define vaERR_DRIVER_NOT_FOUND 7020U
 #define vaERR_WRONG_MODULE_NAME 7030U
 #define vaERR_UNDEFINED_ERROR_CODE 7050U
 #define vaERR_FONTMODULE_NOT_FOUND 7060U
 #define vaERR_KEYMATRIX_NOT_VALID 7070U
 #define vaERR_NOT_SUPPORTED 7080U
 #define vaERR_PARAMETER 7090U
 #define vaERR_CREATE_TASK_FAILED 7100U
 #define vaERR_EXISTS 7101U
 #define vaERR_NO_ACCESS 7110U
 #define vaERR_ACCESS 7111U
 #define vaERR_OVERFLOW 7120U
 #define vaERR_CONNECTION_LOST 7130U
 #define vaERR_TIMEOUT 7140U
 #define vaERR_ARGUMENT 7150U
 #define vaERR_VERSION 7160U
 #define vaERR_MEMORY 7170U
 #define vaERR_RESOURCES 7180U
 #define vaERR_ALREADY 7190U
 #define vaERR_NO_MORE 7195U
 #define vaERR_RESOURCE_NOT_FOUND 7196U
 #define vaERR_RESOURCE_WRONG_FORMAT 7197U
 #define vaERR_VISAPI_NOT_INITIALIZED 100U
#else
 _IEC_CONST unsigned char vaATTRIBUTE_ALPHA = 128U;
 _IEC_CONST unsigned long vaALS_CURRENT = 65536U;
 _IEC_CONST unsigned long vaALS_NOTBYPASSSED = 512U;
 _IEC_CONST unsigned long vaALS_BYPASSSED = 256U;
 _IEC_CONST unsigned long vaALS_NOTACKNOWLEDGED = 32U;
 _IEC_CONST unsigned long vaALS_ACKNOWLEDGED = 16U;
 _IEC_CONST unsigned long vaALS_ACTIVE = 2U;
 _IEC_CONST unsigned long vaALS_INACTIVE = 1U;
 _IEC_CONST unsigned short vaERR_EMPTY_HISTORYLIST = 248U;
 _IEC_CONST unsigned short vaERR_BUSY = 7000U;
 _IEC_CONST unsigned short vaERR_EMPTY_ALARMLIST = 240U;
 _IEC_CONST unsigned short vaERR_NOALARMQUIT = 245U;
 _IEC_CONST unsigned short vaERR_DELHISLIST = 246U;
 _IEC_CONST unsigned short vaERR_BUSY_ALARMSYSTEM = 247U;
 _IEC_CONST unsigned short vaERR_INTERPRETER_NOT_READY = 7010U;
 _IEC_CONST unsigned short vaERR_DRIVER_NOT_FOUND = 7020U;
 _IEC_CONST unsigned short vaERR_WRONG_MODULE_NAME = 7030U;
 _IEC_CONST unsigned short vaERR_UNDEFINED_ERROR_CODE = 7050U;
 _IEC_CONST unsigned short vaERR_FONTMODULE_NOT_FOUND = 7060U;
 _IEC_CONST unsigned short vaERR_KEYMATRIX_NOT_VALID = 7070U;
 _IEC_CONST unsigned short vaERR_NOT_SUPPORTED = 7080U;
 _IEC_CONST unsigned short vaERR_PARAMETER = 7090U;
 _IEC_CONST unsigned short vaERR_CREATE_TASK_FAILED = 7100U;
 _IEC_CONST unsigned short vaERR_EXISTS = 7101U;
 _IEC_CONST unsigned short vaERR_NO_ACCESS = 7110U;
 _IEC_CONST unsigned short vaERR_ACCESS = 7111U;
 _IEC_CONST unsigned short vaERR_OVERFLOW = 7120U;
 _IEC_CONST unsigned short vaERR_CONNECTION_LOST = 7130U;
 _IEC_CONST unsigned short vaERR_TIMEOUT = 7140U;
 _IEC_CONST unsigned short vaERR_ARGUMENT = 7150U;
 _IEC_CONST unsigned short vaERR_VERSION = 7160U;
 _IEC_CONST unsigned short vaERR_MEMORY = 7170U;
 _IEC_CONST unsigned short vaERR_RESOURCES = 7180U;
 _IEC_CONST unsigned short vaERR_ALREADY = 7190U;
 _IEC_CONST unsigned short vaERR_NO_MORE = 7195U;
 _IEC_CONST unsigned short vaERR_RESOURCE_NOT_FOUND = 7196U;
 _IEC_CONST unsigned short vaERR_RESOURCE_WRONG_FORMAT = 7197U;
 _IEC_CONST unsigned short vaERR_VISAPI_NOT_INITIALIZED = 100U;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct display_info
{	unsigned short width;
	unsigned short height;
	unsigned long func1;
	unsigned long func2;
	unsigned char bpp;
} display_info;

typedef struct TouchAction
{	unsigned long status;
	unsigned long y;
	unsigned long x;
} TouchAction;

typedef struct sVCBitmap
{	unsigned long vpInternalData;
	unsigned long vpData;
	signed long iBPP;
	signed long iHeight;
	signed long iWidth;
	unsigned long ulFlags;
} sVCBitmap;

typedef unsigned long VCHANDLE;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC unsigned short VA_Attach(plcbit enable, unsigned long VCHandle, unsigned long uiType, unsigned long uiPara);
_BUR_PUBLIC unsigned short VA_BlitBitmap(plcbit enable, unsigned long VCHandle, unsigned long pBitmap, signed long iDestX, signed long iDestY, signed long iClipX1, signed long iClipY1, signed long iClipX2, signed long iClipY2, unsigned long uiFlags);
_BUR_PUBLIC unsigned short VA_Configure(plcbit enable, plcstring* ucProjectName, unsigned long uiOption, unsigned long uiValue);
_BUR_PUBLIC unsigned short VA_CopyScreenRect(plcbit enable, unsigned long VCHandle, unsigned short x1, unsigned short y1, unsigned short x2, unsigned short y2, signed short dx, signed short dy);
_BUR_PUBLIC unsigned short VA_DelAlarmHistory(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_GetActiveAlarmCount(plcbit enable, unsigned long VCHandle, unsigned long AlarmCount);
_BUR_PUBLIC unsigned short VA_GetAlarmCount(plcbit enable, unsigned long VCHandle, unsigned long filter, unsigned long AlarmCount);
_BUR_PUBLIC unsigned short VA_Detach(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_DrawBitmap(plcbit enable, unsigned long VCHandle, unsigned short index, unsigned short x, unsigned short y);
_BUR_PUBLIC unsigned short VA_Ellipse(plcbit enable, unsigned long VCHandle, unsigned short x, unsigned short y, unsigned short heigth, unsigned short width, unsigned short fill, unsigned short color);
_BUR_PUBLIC unsigned short VA_ExchangeFont(plcbit enable, unsigned long VCHandle, unsigned char cIndex, unsigned char cNewIndex);
_BUR_PUBLIC unsigned short VA_ExtractKeyMatrix(plcbit enable, unsigned long VCHandle, unsigned long pKeyMatrix, unsigned long uiKeysToRead, unsigned long puiKeyRead, unsigned long uiTimeoutInMsec, unsigned long puiAgeInMsec);
_BUR_PUBLIC unsigned short VA_FreeBitmap(plcbit enable, unsigned long VCHandle, unsigned long pBitmap);
_BUR_PUBLIC unsigned short VA_GetActAlarmList(plcbit enable, unsigned long VCHandle, signed long pcAlarmLine, signed long plLen, unsigned short iFunction, unsigned char cSeperator, unsigned char cDateTimeFormat);
_BUR_PUBLIC unsigned short VA_GetAlCurPos(plcbit enable, unsigned long VCHandle, signed long pGroupNumber, signed long pAlarmNumber);
_BUR_PUBLIC unsigned short VA_GetAlarmList(plcbit enable, unsigned long VCHandle, signed long pcAlarmLine, signed long plLen, unsigned short iFunction);
_BUR_PUBLIC unsigned short VA_GetBrightness(plcbit enable, unsigned long VCHandle, unsigned long pValue);
_BUR_PUBLIC unsigned short VA_GetCalStatus(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_GetContrast(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_GetDisplayInfo(plcbit enable, unsigned long VCHandle, unsigned long InfoType, unsigned long pValue);
_BUR_PUBLIC unsigned short VA_GetExAlarmList(plcbit enable, unsigned long VCHandle, signed long pcAlarmLine, signed long plLen, unsigned short iFunction, unsigned char cSeperator, unsigned char cDateTimeFormat);
_BUR_PUBLIC unsigned short VA_GetKeyMatrix(plcbit enable, unsigned long VCHandle, unsigned long pKeyMatrix, unsigned long KeysToRead, unsigned long pKeysRead);
_BUR_PUBLIC unsigned long VA_GetPaletteColor(plcbit enable, unsigned long VCHandle, unsigned char uiIndex);
_BUR_PUBLIC unsigned short VA_GetPanelStatus(plcbit enable, unsigned long VCHandle, unsigned long puiPanelStatus);
_BUR_PUBLIC unsigned short VA_GetTextByTextGroup(plcbit enable, unsigned long VCHandle, unsigned long TG_id, unsigned short TGT_id, unsigned long pcText, unsigned long psTextlength);
_BUR_PUBLIC unsigned short VA_GetTouchAction(plcbit enable, unsigned long VCHandle, unsigned long uiType, unsigned long pStatus);
_BUR_PUBLIC unsigned short VA_LangIsAvailable(plcbit enable, unsigned long VCHandle, unsigned long uiIndex, unsigned long pucIsInstalled);
_BUR_PUBLIC unsigned short VA_Line(plcbit enable, unsigned long VCHandle, unsigned short x1, unsigned short y1, unsigned short x2, unsigned short y2, unsigned short color);
_BUR_PUBLIC unsigned short VA_LoadBitmap(plcbit enable, unsigned long VCHandle, plcstring* ucDevice, plcstring* ucPath, unsigned long ppBitmap);
_BUR_PUBLIC unsigned short VA_NGetAlCurPos(plcbit enable, unsigned long VCHandle, signed long pGroupNumber, signed long pAlarmNumber);
_BUR_PUBLIC unsigned short VA_NGetCalStatus(plcbit enable, unsigned long VCHandle, unsigned long pValue);
_BUR_PUBLIC unsigned short VA_NGetContrast(plcbit enable, unsigned long VCHandle, unsigned long pValue);
_BUR_PUBLIC unsigned long VA_NGetPaletteColor(plcbit enable, unsigned long VCHandle, unsigned char uiIndex, unsigned long pValue);
_BUR_PUBLIC unsigned short VA_Quit(plcbit enable, unsigned long VCHandle, unsigned short usGroupNumber, unsigned short usAlarmNumber);
_BUR_PUBLIC unsigned short VA_QuitAlarms(plcbit enable, unsigned long VCHandle, unsigned short wGroupNumber);
_BUR_PUBLIC unsigned short VA_Rect(plcbit enable, unsigned long VCHandle, unsigned short x1, unsigned short y1, unsigned short width, unsigned short height, unsigned short fill, unsigned short color);
_BUR_PUBLIC unsigned short VA_Redraw(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_Saccess(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_SaveSettings(plcbit enable, unsigned long VCHandle, unsigned short uiAction);
_BUR_PUBLIC unsigned short VA_SetBacklight(plcbit enable, unsigned long VCHandle, plcbit bSet);
_BUR_PUBLIC unsigned short VA_SetBrightness(plcbit enable, unsigned long VCHandle, unsigned long uiPercent);
_BUR_PUBLIC unsigned short VA_SetClipRegion(plcbit enable, unsigned long VCHandle, unsigned long uiX1, unsigned long uiY1, unsigned long uiX2, unsigned long uiY2);
_BUR_PUBLIC unsigned short VA_SetContrast(plcbit enable, unsigned long VCHandle, unsigned long uiPercent);
_BUR_PUBLIC unsigned short VA_SetPaletteColor(plcbit enable, unsigned long VCHandle, unsigned char index, unsigned long color);
_BUR_PUBLIC unsigned short VA_SetUserParam(plcbit enable, unsigned long VCHandle, unsigned char Type, unsigned long pParameter);
_BUR_PUBLIC unsigned long VA_Setup(plcbit enable, plcstring* pProjectName);
_BUR_PUBLIC unsigned short VA_SetupX(plcbit enable, unsigned long VCHandle, plcstring* pProjectName);
_BUR_PUBLIC unsigned short VA_Shutdown(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_Srelease(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_StartProject(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_StartVisuByName(plcbit enable, plcstring* pProjectName);
_BUR_PUBLIC unsigned short VA_StartTouchCal(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_StopProject(plcbit enable, unsigned long VCHandle);
_BUR_PUBLIC unsigned short VA_Textout(plcbit enable, unsigned long VCHandle, unsigned short font_index, unsigned short x, unsigned short y, unsigned char fC, unsigned char bC, plcstring* pText);
_BUR_PUBLIC unsigned short VA_TimeSynchronize(plcbit enable, unsigned long VC_Handle);
_BUR_PUBLIC unsigned short VA_wcAlarmGetList(plcbit enable, unsigned long VCHandle, signed long pcAlarmLine, signed long plLen, unsigned short iFunction);
_BUR_PUBLIC unsigned short VA_wcGetActAlarmList(plcbit enable, unsigned long VCHandle, signed long pcAlarmLine, signed long plLen, unsigned short iFunction, unsigned short usSeperator, unsigned char cDateTimeFormat);
_BUR_PUBLIC unsigned short VA_wcGetExAlarmList(plcbit enable, unsigned long VCHandle, signed long pcAlarmLine, signed long plLen, unsigned short iFunction, unsigned short usSeperator, unsigned char cDateTimeFormat);
_BUR_PUBLIC unsigned short VA_wcGetTextByTextGroup(plcbit enable, unsigned long VCHandle, unsigned long TG_id, unsigned short TGT_id, unsigned long pwText, unsigned long psTextLength);
_BUR_PUBLIC unsigned short VA_wcTextout(plcbit enable, unsigned long VCHandle, unsigned short font_index, unsigned short x, unsigned short y, unsigned char fC, unsigned char bC, unsigned long pwText);
_BUR_PUBLIC unsigned short VA_GetActualLang(void);
_BUR_PUBLIC unsigned short VA_ClearTouchEventBuffer(void);
_BUR_PUBLIC unsigned short VA_RegisterClient(void);
_BUR_PUBLIC unsigned short VA_StartProcess(plcbit enable, unsigned long VCHandle, unsigned long uiProcessID, unsigned long psArguments, unsigned long puiExtendedErrorCode);
_BUR_PUBLIC unsigned short VA_TerminateProcess(plcbit enable, unsigned long VCHandle, unsigned long uiProcessID, unsigned long puiExtendedErrorCode);
_BUR_PUBLIC unsigned short VA_GetProcessExitCode(plcbit enable, unsigned long VCHandle, unsigned long uiProcessID, unsigned long puiExitCode, unsigned long puiExtendedErrorCode);
_BUR_PUBLIC unsigned short VA_SetProcessZOrder(plcbit enable, unsigned long VCHandle, unsigned long uiProcessID, unsigned long uiZOrderFlags);
_BUR_PUBLIC unsigned short VA_SetVisualizationZOrder(plcbit enable, unsigned long VCHandle, unsigned long uiZOrderFlags);
_BUR_PUBLIC unsigned short VA_RunJScript(plcbit enable, unsigned long VCHandle, unsigned long uiJSStatusDP, unsigned long pScriptName);
_BUR_PUBLIC unsigned short VA_SetBeep(plcbit enable, unsigned long VCHandle, unsigned long uiFrequency, unsigned long uiBeepTime);


#ifdef __cplusplus
};
#endif
#endif /* _VISAPI_ */

