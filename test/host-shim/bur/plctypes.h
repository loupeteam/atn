/*
 * Host shim for B&R Automation Runtime <bur/plctypes.h>.
 *
 * This file exists ONLY for the off-target CMake unit-test build. On a real
 * Automation Studio build the genuine <bur/plctypes.h> from the AR GCC
 * toolchain is used instead; this shim is never on that include path.
 *
 * It provides just enough of the IEC 61131-3 / B&R base types and the AR
 * linkage macros for ATN's C/C++ sources to compile and link on a PC.
 *
 * NOTE: the host build is configured as 32-bit (Win32) so that `unsigned long`
 * is 4 bytes and matches the SG4 data model the ATN sources assume (several
 * ATN structs store pointers in `unsigned long` fields).
 */
#ifndef _BUR_PLCTYPES_H_
#define _BUR_PLCTYPES_H_

#include <stddef.h>

#ifdef __cplusplus
extern "C" {
#endif

/* --- Automation Runtime linkage / storage-class macros (no-ops on host) --- */
#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#ifndef _BUR_LOCAL
#define _BUR_LOCAL
#endif
#ifndef _GLOBAL
#define _GLOBAL
#endif
#ifndef _LOCAL
#define _LOCAL
#endif
#ifndef _GLOBAL_CONST
#define _GLOBAL_CONST const
#endif
#ifndef _INIT
#define _INIT
#endif
#ifndef _EXIT
#define _EXIT
#endif
#ifndef _CYCLIC
#define _CYCLIC
#endif
#ifndef _WEAK
#define _WEAK
#endif
#ifndef _ROM
#define _ROM
#endif
#ifndef _RAM
#define _RAM
#endif

/* --- Standard AR function-block status codes (subset ATN references) --- */
#ifndef ERR_OK
#define ERR_OK 0
#endif
#ifndef ERR_FUB_ENABLE_FALSE
#define ERR_FUB_ENABLE_FALSE 65534
#endif
#ifndef ERR_FUB_BUSY
#define ERR_FUB_BUSY 65535
#endif

/* --- IEC 61131-3 / B&R base data types --- */
typedef unsigned char  BOOL;
typedef signed char    SINT;
typedef unsigned char  USINT;
typedef short          INT;
typedef unsigned short UINT;
typedef long           DINT;
typedef unsigned long  UDINT;
typedef float          REAL;
typedef double         LREAL;
typedef unsigned char  BYTE;
typedef unsigned short WORD;
typedef unsigned long  DWORD;

/* 64-bit integer types (some AR libraries use these) */
#if defined(_MSC_VER)
typedef signed __int64   LINT;
typedef unsigned __int64 ULINT;
#else
typedef long long          LINT;
typedef unsigned long long ULINT;
#endif

/* --- String / bit types --- */
typedef char           plcstring;   /* single-byte character                */
#ifdef __cplusplus
typedef bool           plcbit;      /* B&R maps plcbit to bool in C++ ...    */
#else
typedef unsigned char  plcbit;      /* ... and to a byte in C                */
#endif
typedef char           STRING;      /* B&R STRING == char (used in ATN API) */
typedef unsigned short  UniChar;    /* wide character placeholder           */
typedef UniChar        plcwstring;

#ifdef __cplusplus
}
#endif

#endif /* _BUR_PLCTYPES_H_ */
