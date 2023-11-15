<?xml version="1.0" encoding="UTF-8"?>
<CONFIG>

<!--****************************************************************************
    *  Loading IEC type declaration files
    *
    *  IEC type declaration files can be imported here into the interpreter
    *
    *  <LANG_INCLUDE Name="<include filename>"
    *                LangName="<language name>"
    *                Scope="<declaration scope>"
    *                OnError="Error/Warn"
    *                FileDevice="<device name>"
    *                FileExt="<file extension"
    *                DataObject="<boolean>"
    *                IfNotExist="Error/Warn/Ignore" />
    *
    *  Name: Name of type declaration file/data object to include
    *  LangName (or LangId): Name (or Id) of language as configured in SCF
    *   (gmcipsys)
    *  Scope: Defines the scope for declarations loaded from this file
    *   - PLC_GLOBAL - valid for plc/nc/ip_global and local variable declarations
    *   - NC_GLOBAL  - valid for nc/ip_global and local variable declarations
    *   - IP_GLOBAL  - valid for ip_global and local variable declarations
    *  OnError: Reaction to take if errors detected while reading the file
    *   - Error/Warn
    *  FileDevice: Name of the file device to load the configuration file from
    *  FileExt: Specifies the optional filename extension
    *  DataObject: Indicates if the data source for the configuration file is
    *   data object (Yes), or file (No)
    *  IfNotExist: Reaction to take if this file is not found
    *   - Error/Warn/Ignore
    *
    *  Example:
    *  - Recommended format of LANG_INCLUDE directive
    *  - mytypes.typ will be loaded from CNC_PrgDir file device
    *    <LANG_INCLUDE LangName="IEC-ST" Name="mytypes.typ" DataObject="No" />
    ****************************************************************************-->


  <VARIABLES>

<!--****************************************************************************
    *  PLC variable declaration
    *
    *  Declarations of PLC-Variables to be available in the G-code programs
    *  (without need to redeclare).
    *
    *  <PV Alias="<alias name>"
    *      Synch="<synchronization type>"
    *      Type="<type name>"
    *      StrSize="<string size>"
    *      AryDim1="<array 1st dimension>"
    *      AryDim2="<array 2nd dimension>">
    *     plc_variable_name
    *   </PV>
    *
    *  Alias: Alternative name to be used to refer to this PLC variable
    *  Synch: Specify whether variable access should be interpreter ("ip_synch")
    *   or path ("path_synch") synchronous
    *  Type: Type name
    *   - IEC primitive type names (DINT, LREAL, ...)
    *   - User and system library defined types (mystruct, ARNC0CNC_typ)
    *  StrSize: Max number of characters in the string (excluding terminator)
    *  AryDim1..n: Size (number of items) in this array dimension of PLC variable
    *
    *  Example 1:
    *   - Declarations of PLC-Variables to be available in the G-code programs
    *     <PV Type="REAL">myPlcVar</PV>
    *     <PV Alias="my2ndPlcVar" Synch="path_synch" Type="UDINT" AryDim1="10">
    *       task:structure.ten_udints
    *     </PV>
    *
    *  Example 2:
    *   -  Mapping a string variable defined as STRING[31] in AS
    *      <PV Synch="ip" Type="STRING" StrSize="31">filename</PV>
    ****************************************************************************-->

<!--****************************************************************************
    *  Interpreter variable declaration
    *
    *  Internal variables can be declared to exist and be shared in various
    *  different scopes of the interpreter memory.
    *
    *  <VAR Alias="<alias name>"
    *       Scope="<scope type>"
    *       Synch="<synchronization type>"
    *       Type="<type name>"
    *       StrSize="<string size>"
    *       InitialValue="<initial value>"
    *       AryDim1="<array 1st dimension>"
    *       AryDim2="<array 2nd dimension>">
    *     interpreter_variable_name
    *   </VAR>
    *
    *  Alias: Alternative name to be used to refer to this PLC variable
    *  Scope: Scope type
    *   - PLC_GLOBAL - mapped from PLC environment - equivalent to a <PV>
    *   - NC_GLOBAL  - shared between all interpreter instances (CNC channels)
    *   - IP_GLOBAL  - created in interpreter global memory area
    *   - LOCAL      - created local to each program file
    *  Synch: Specify whether variable access should be interpreter ("ip_synch")
    *   or path ("path_synch") synchronous
    *  Type: Type name
    *   - IEC primitive type types (DINT, LREAL, ...)
    *   - User and system library defined names (mystruct, ARNC0CNC_typ)
    *  StrSize: Max number of characters in the string (excluding terminator)
    *  InitialValue: Specific value to assign on creating the variable
    *   - Format for literals is the format of literals in the language
    *   selected as DefaultDataLangId="<num>"
    *  AryDim1..n: Size (number of items) in this array dimension of PLC variable
    *
    *  Example 1:
    *   - NC_GLOBAL scope - variable shared between interpreters
    *     <VAR Scope="nc_global" Type="DINT">ncg_int</VAR>
    *
    *  Example 2:
    *   - IP_GLOBAL scope - variable shared between programs within a channel
    *     <VAR Scope="ip_global" Synch="path_synch" Type="LREAL" AryDim1="5" AryDim2="3">
    *       my2dDoubleArray
    *     </VAR>
    *
    *  Example 3:
    *   - Initial values expressed in IEC syntax
    *     <VAR Scope="ip_global" Type="DINT" InitialValue="25">ipg_int</VAR>
    *     <VAR Scope="ip_global" Type="STRING" StrSize="127" InitialValue="'George'">ip_name</VAR>
    *     <VAR Scope="ip_global" Type="MyStruct_typ"
    *          InitialValue="(item1 := 1, ary2 := [3(5)], strct3 := (subitem1:=4))">
    *       ip_struct
    *     </VAR>
    ****************************************************************************-->

  </VARIABLES>
</CONFIG>