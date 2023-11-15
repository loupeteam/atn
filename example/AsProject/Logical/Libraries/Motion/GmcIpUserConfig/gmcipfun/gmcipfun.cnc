<?xml version="1.0" encoding="UTF-8"?>
<CONFIG>
  <FUNCTIONS>

<!--****************************************************************************
    *  Function prototypes
    *
    *  External (compiled) AS library functions may be called directly from
    *  NC programs when prototyped here.
    *
    *  <FUNC Name="<function name>"
    *        RetType="<return type>"
    *        RetRef="<boolean>"
    *        ZeroPad="<boolean>"
    *        Synch="<synchronization type>"
    *        ExecuteInSimulation="<boolean>">
    *    <ARG Name="<argument name>" Type="type" Ref="boolean" />
    *    ...
    *  </FUNC>
    *
    *  <FUNC> attributes
    *  Name: Name of the function
    *  RetType: Function return type
    *   - NONE - Function does not return a value
    *   - IEC primitive type names (DINT, LREAL, ...)
    *   - User and library defined types (mystruct), function returning structure
    *    should also specify RetRef="Y"
    *  RetRef: If true, indicates that the return type of this function is a
    *  reference (pointer) to the named type.
    *  ZeroPad: If true, then if a call to this function does not provide values
    *   for all arguments, then this is not an error, and all unspecified arguments
    *   are set to zero for the call.
    *  Synch: Specifies whether this function should be called interpreter
    *  ("ip_synch") or path ("path_synch") synchronous
    *  ExecuteInSimulation: Specifies whether the function should be executed
    *   during a simulation run to gather restart information.
    *   - Yes/No
    *
    *  <ARG> attributes
    *  Name: Name of the argument (used to report any errors only)
    *  Type: Argument type
    *   - IEC primitive type names (DINT, LREAL, ...)
    *   - User and library defined types (mystruct)
    *  Ref:  Indicates if this argument should be passed by reference
    *   - Yes/No
    *
    *  Example 1:
    *   - RTC_gettime(ptr) from standard library: "SYS_LIB"
    *     <FUNC Name="RTC_gettime" RetType="UINT" ExecuteInSimulation="No">
    *       <ARG Name="RTCtime_struct" Type="UDINT" />
    *     </FUNC>
    *
    *  Example 2:
    *   - ncaction(ncobj,subject,action) from standard library: "Ncglobal"
    *     <FUNC Name="ncaction" RetType="UINT" ExecuteInSimulation="Yes">
    *       <ARG Name="nc_object" Type="UDINT" />
    *       <ARG Name="subject" Type="UINT" />
    *       <ARG Name="action" Type="UINT" />
    *     </FUNC>
    *
    *  Example 3:
    *   - User defined library function
    *     <FUNC Name="myFun">
    *       <ARG Name="mode" Type="USINT" />
    *       <ARG Name="value" Type="UDINT" ref="Yes" />
    *     </FUNC>
    ****************************************************************************-->

  </FUNCTIONS>
</CONFIG>