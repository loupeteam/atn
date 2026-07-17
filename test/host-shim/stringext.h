/*
 * Host shim for the Loupe StringExt library header (stringext.h).
 *
 * ATN declares StringExt as a build dependency (see ANSIC.lby) and the
 * AS-generated ATN.h #includes "stringext.h" under _SG3/_SG4/_SGC. However,
 * none of ATN's C/C++ sources actually call any StringExt function, so for the
 * off-target CMake unit-test build an empty stub is sufficient to satisfy the
 * include. The real StringExt library is linked on the PLC target build.
 */
#ifndef _STRINGEXT_HOST_SHIM_H_
#define _STRINGEXT_HOST_SHIM_H_
#endif /* _STRINGEXT_HOST_SHIM_H_ */
