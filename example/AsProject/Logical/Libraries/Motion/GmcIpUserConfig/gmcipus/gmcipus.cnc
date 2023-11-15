<?xml version="1.0" encoding="UTF-8"?>
<LANGS>

<!--****************************************************************************
    *  Memory configuration
    *
    *  <MEM LimitMB="<max memory usage>"
    *       LimitPercent="<max memory usage>%"
    *       ReserveMB="<reserve memory size>" />
    *
    *  LimitMB: Maximum memory consumption limit for the interpreter system
    *   - If no limit specified, all free RAM in the target system is available
    *     to the interpreter
    *  LimitPercent: Maximum memory consumption limit for the interpreter system
    *   - If no limit specified, all free RAM in the target system is available
    *     to the interpreter
    *  ReserveMB: Number of megabytes of memory to be reserved for the interpreter
    *   system during system startup
    *
    *  Example:
    *   - Default settings
    *     <MEM ReserveMB="5" LimitPercent="80%" />
    *   - Minimum of memory reserved at startup, occupy max. 60% of free memory
    *     <MEM LimitPercent="60%" />
    ****************************************************************************-->

<!--****************************************************************************
    *  Execution configuration
    *
    *  <EXEC InstrBurstBG="<number of opcodes>"
    *        CycleBurstBG="<max cycle burst length>"
    *        Stack="<size in bytes>"
    *        MinorStack="<size in bytes>"
    *        CStack="<cyclic thread stack size>"
    *        PStack="<path-synch thread stack size>"
    *        EStack="<eval thread stack size>" />
    *
    *  InstrBurstBG: Maximum number of opcode instructions to execute at once by
    *   the main interpreter thread
    *  CycleBurstBG: Maximum number of consecutive execution cycles allowed
    *   - If non-zero, then after the specified number of cycles, the interpreter
    *     will idle for 1 cycle
    *   - If zero (default), the feature is disabled and the interpreter will
    *     occupy the CPU without restriction
    *  Stack: Stack size for the main interpreter thread
    *  MinorStack: Stack size for all minor execution threads
    *   - Path-execution
    *   - Cyclic-execution
    *   - Debug-eval execution
    *  CStack: Stack size for cyclic execution thread
    *  PStack: Stack size for path-synchronous execution thread
    *  EStack: Stack size for debug evaluation execution thread
    *
    *  Example:
    *   - Default settings
    *     <EXEC InstrBurstBG="50" CycleBurstBG="0" Stack="16384"
    *           MinorStack="2048" EStack="1024" />
    *   - Idle after 500 of opcode instructions
    *     <EXEC InstrBurstBG="50" CycleBurstBG="10" Stack="16384"
    *           MinorStack="2048" EStack="1024" />
    ****************************************************************************-->

<!--****************************************************************************
    *  Loader configuration
    *
    *  <LOAD ReadLineBurstMax="<number of lines>"
    *        ReadLineBurstMin="<number of lines>"
    *        ParseLineBurstMax="<number of lines>"
    *        ParseLineBurstMin="<number of lines>" 
    *        AutoProgNrIfNDef="<boolean>"
    *        ForceFileXLfromSize="<size in bytes>" />
    *
    *  ReadLineBurstMax: Number of lines to read from the input buffer at once
    *   when loader has full CPU - e.g. during pre-loading file
    *  ReadLineBurstMin: Number of lines to read from the input buffer at once
    *   when loader is sharing CPU with execution
    *  ParseLineBurstMax: Number of lines to parse at once when loader has full
    *   CPU - e.g. while pre-loading file
    *  ParseLineBurstMin: Number of lines to parse at once when loader is sharing
    *   CPU with execution
    *  AutoProgNrIfNDef: Use the automatic generated (unique) program number if
    *   not specified in NC program (default value: "No")
    *  ForceFileXLfromSize: Force the start_mode=ncFILE_XL if the program size
    *   exceed the specified size limit in bytes (default value: 2147483647)
    *
    *  Example:
    *   - Default settings:
    *     <LOAD ReadLineBurstMax="100" ReadLineBurstMin="20"
    *           ParseLineBurstMax="10" ParseLineBurstMin="2" />
    ****************************************************************************-->

<!--****************************************************************************
    *  Disabling warning messages
    *
    *  <DISABLE_MSG>number, number, ... </DISABLE_MSG>
    *
    *  List of interpreter error codes that should not be issued with severity
    *  INFO or WARNING. Fatal errors on any error code will always be reported.
    *  Only interpreter-originated warnings can be disabled here.
    *  Messages from system startup phase can be disabled too.
    *
    *  Example:
    *   - Disable warning 15725: "Programs unloaded for CNC reconfiguration"
    *     <DISABLE_MSG>15725</DISABLE_MSG>
    ****************************************************************************-->

<!--****************************************************************************
    *  Language configurations
    *
    *  <LANG LangId="<number>" LangName="<lang. name>" LangModule="<mod. name>">
    *    <LANGCONFIG/>
    *    <FILEEXT/>
    *    <MAINSEARCHPATH/>
    *    <INCLUDEPATH/>
    *  </LANG>
    *
    *  The <LANG ...> section is the parent structure to all information for
    *  a language configuration. Empty language section can be used to remove
    *  languages that have already been configured (e.g. in gmcipsys).
    *  LangId: Unique identifying number for this language (any positive integer)
    *  LangName: Descriptive name
    *  LangModule: Only language module available is "ailgcode"
    *
    *  <LANGCONFIG Name="<file name>" DataObject="<boolean>"
    *              FileDevice="<device name>"/>
    *   Specifies a language configuration file (LCF) to load
    *
    *  <FILEEXT Name="<extension1>"/>
    *   Associates a filename extension with this language, multiple filename
    *   extensions can be specified
    *
    *  <MAINSEARCHPATH Name="<pattern>" DataObject="<boolean>"
    *                  FileDevice="<device name>" DeepSearch="<boolean>"/>
    *   Specifies the search locations (in order of precedence) for main program
    *   files
    *
    *  <INCLUDEPATH Name="<pattern>" DataObject="<boolean>"
    *               FileDevice="<device name>" DeepSearch="<boolean>"/>
    *   Specifies the search locations (in order of precedence) for included or
    *   called program files (e.g. subprograms)
    *
    *  Example 1:
    *    Remove "Alternative language 1" configuration to save system memory
    *    <LANG langId="2" langName="" langModule=""></LANG>
    *
    *  Example 2:
    *    Configure "Alternative language 1" without prefixes and with standard
    *    extensions only. Do not allow main programs to be NC data modules
    *    <LANG langId="2" langName="G-code" langModule="ailgcode">
    *      <LANGCONFIG Name="gmciplsm" />
    *      <LANGCONFIG Name="gmcipcbr" />
    *      <LANGCONFIG Name="gmcipcsm" />
    *      <LANGCONFIG Name="gmcipusm" />
    *      <FILEEXT>.MPF</FILEEXT>
    *      <FILEEXT>.SPF</FILEEXT>
    *      <MAINSEARCHPATH FileDevice="CNC_PrgDir">\$</MAINSEARCHPATH>
    *      <INCLUDEPATH FileDevice="CNC_PrgDir">\$</INCLUDEPATH>
    *      <INCLUDEPATH DataObject="1">$</INCLUDEPATH>
    *    </LANG>
    *
    *  Example 3:
    *    MP logging playback language configuration
    *    Note: the channel-ID wildcard character '*' is substituted for the channel 
    *    identity character 'A' (1st channel), 'B' (2nd channel), ...     
    *    <LANG langId="5" langName="MPLog" langModule="ailgcode">
    *      <LANGCONFIG Name="gmciplog" />
    *      <FILEEXT Name=".mpl" />
    *      <MAINSEARCHPATH Name="\$" FileDevice="mplog*" DataObject="No" />
    *      <INCLUDEPATH Name="\$" FileDevice="mplog*" DataObject="No" />
    *    </LANG>
    ****************************************************************************-->

</LANGS>