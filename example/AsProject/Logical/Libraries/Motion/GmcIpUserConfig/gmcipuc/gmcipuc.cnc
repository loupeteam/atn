<?xml version="1.0" encoding="UTF-8"?>
<CONFIG>

<!--****************************************************************************
    *  Default language configuration
    *
    *  <DEFAULT_LANG LangId="<number>"/>
    *
    *  LangId: Language ID as defined in <LANG> sections in gmcipsys
    *
    *  Example:
    *   - Set "Alternative language 1" to be default language
    *     <DEFAULT_LANG LangId="2"/>
    ****************************************************************************-->

<!--****************************************************************************
    *  Motion packet queue configuration
    *
    *  <MPQUEUE NumPackets = "<number of packets>"
    *           LookaheadMinBlocks = "<number>"
    *           LookaheadMaxBlocks = "<number>"
    *           LookaheadMode = "<mode name>"
    *           MaxPathJobs= "<number>"/>
    *
    *  NumPackets: Number of individual packets in the motion packet queue
    *  LookaheadMinBlocks: The interpreter will aim to ensure that there is
    *   always at least this number of NC-blocks in the motion packet queue.
    *  LookaheadMaxBlocks: The maximum NC-block-lookahead target
    *  LookaheadMode: "any"/"motion"
    *   - Specify which type of nc-blocks should count as lookahead
    *  MaxPathJobs: Specifies the maximum number of path synchronous execution
    *   jobs that can be in the block buffer simultaneously
    *
    * Example:
    *  - Default settings:
    *    <MPQUEUE NumPackets="200" LookaheadMinBlocks="5" LookaheadMaxBlocks="20"
    *    LookaheadMode="any" MaxPathJobs="256" />
    *  - Increase max. number of path-synchronous jobs to 512
    *    <MPQUEUE ... MaxPathJobs="512" />
    ****************************************************************************-->

<!--****************************************************************************
    *  Motion packet logging configuration
    *
    *  <MPLOG FileDevice="<device name pattern>"
    *         MaxLogFiles="<number>"
    *         MaxLogFileSize="<number>"
    *         MaxLogFileSpan="<number>"
    *         MaxBuffers="<number>"
    *         MinBuffers="<number>"
    *         EarlyCircleBufferLookahead="<number>"
    *         WriteBlock="<number>"
    *         CopyLineTextMaxChars="<number>"
    *         DefaultBufferSize="<number>"
    *         TaskCycleDelay="<number>"/>
    *
    *  FileDevice: Device name for writing log files to
    *   - The channel wildcard character "*" serves for 'A' - 'Z'
    *   - Default is "mplog*"
    *  MaxLogFiles: Specifies the limit to the number of historic log files that
    *   may be kept on disk
    *  MaxLogFileSize: The limit to the size of a single log file
    *  MaxLogFileSpan: Max number of log files to write for a single program run
    *   - Defualt is 0 (no-limit)
    *  MaxBuffers: Max allowed log buffer count (e.g. iplogA00 - iplogAxx)
    *  MinBuffers: Minimum number of buffers to pre-allocate
    *  EarlyCircleBufferLookahead: The number of free buffers that the interpreter
    *   aims to maintain ahead of the current log writing position
    *  WriteBlock: Max number of bytes written to disk in one FileWrite()
    *   operation
    *  CopyLineTextMaxChars: Max characters to copy to the log from user program
    *   line
    *  DefaultBufferSize: Size of one MP-log buffer
    *  TaskCycleDelay: Specifies the number of system cycles between execution
    *   cycles of the task to save motion packet log files to disk.
    *   - Default: 1 (1 save per cycle)
    *   - Min: 0 (unlimited saves per cycle)
    *   - Max: 100 (1 save every 100 cycles)
    *
    *  Examples
    *   - Default settings:
    *     <MPLOG MaxBuffers="10" MinBuffers="4" EarlyCircleBufferLookahead="2"
    *            DefaultBufferSize="131072" TaskCycleDelay="1"
    *            FileDevice="mplog*" MaxLogFiles="20" MaxLogFileSize="1048576"
    *            CopyLineTextMaxChars="80" />
    *   - Enable longer source lines in MP-log:
    *     <MPLOG ... CopyLineTextMaxChars="1024">
    ****************************************************************************-->

<!--****************************************************************************
    *  Direct variable access configuration
    *
    *  <DBG_IPVAR_ACCESS TableSize="<max. number of request>" />
    *
    *  TableSize: Max. number of simultaneously active requests
    *
    *  Example:
    *   - Default settings:
    *     <DBG_IPVAR_ACCESS TableSize="20" />
    ****************************************************************************-->

<!--****************************************************************************
    *  Breakpoint configuration
    *
    *  <DBG_BREAKPOINTS TableSize="<max. number of breakpoints>" />
    *
    *  TableSize: Max. number of simultaneously active breakpoints
    *
    * Example:
    *  - Default settings:
    *    <DBG_BREAKPOINTS TableSize="16" />
    ****************************************************************************-->

<!--****************************************************************************
    * Extended block monitor configuration options
    *
    *  <MONITOR MaxPathStackEvents="<number>" MaxPathStackEventMem="<number>" />
    *
    *  MaxPathStackEvents: Max number of EBM stack change events (~28bytes), or...
    *  MaxPathStackEventMem: Max memory usage (in bytes) for EBM stack change data
    *
    *  Examples:
    *   - Default settings:
    *     <MONITOR MaxPathStackEvents="1024" />
    ****************************************************************************-->

</CONFIG>