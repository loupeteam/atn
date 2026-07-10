/*
 * Host shim for the Loupe VarTools library header (vartools.h).
 *
 * ATN declares VarTools as a build dependency (see ANSIC.lby) and the
 * AS-generated ATN.h #includes "vartools.h" under _SG3/_SG4/_SGC. However,
 * none of ATN's C/C++ sources actually call any VarTools function, so for the
 * off-target CMake unit-test build an empty stub is sufficient to satisfy the
 * include. The real VarTools library is linked on the PLC target build.
 */
#ifndef _VARTOOLS_HOST_SHIM_H_
#define _VARTOOLS_HOST_SHIM_H_
#endif /* _VARTOOLS_HOST_SHIM_H_ */
