<?xml version="1.0" encoding="UTF-8"?>
<CONFIG>
  <FUBOutputs>

<!--****************************************************************************
    *  Function block output rule definitions
    *
    *  <FUBOutput Name="<name of the rule>"
    *             Template="<LCF AIL template>"
    *             ExecuteInSimulation="<boolean>">
    *    <BUSY Condition="<statement>" />
    *    <ERROR Condition="<statement>" />
    *  </FUBOutput>
    *
    *  Name: Name of the output rule
    *  Template: Name of the LCF-defined AIL code template
    *  ExecuteInSimulation: Specifies whether the FuB should be executed during
    *   a simulation run to gather restart information
    *  <BUSY Condition>: Conditional expression to identify this function block
    *   as being busy
    *  <ERROR Condition>: Condition expression to identify this function block
    *   as being in error
    *
    *  Example:
    *   - Standard PLCOpen function block behaviour (defined in gmcipcfg)
    *     <FUBOutput Name="PLCOpen">
    *       <BUSY Condition="$busy == 1" />
    *       <ERROR Condition="$error == 1" />
    *     </FUBOutput>
    *   - Standard AS-library function block behaviour (defined in gmcipcfg)
    *     <FUBOutput Name="BuR">
    *       <BUSY Condition="$status == 65535" />
    *       <ERROR Condition="$status != 0 && $status != 65535" />
    *     </FUBOutput>
    ****************************************************************************-->

  </FUBOutputs>
  <FUBS>

<!--****************************************************************************
    *  Function block declarations
    *
    *  <FUB Name="<name of the FUB>"
    *       OutType="<FUB output rule name>"
    *       Template="<LCF AIL template>"
    *       ExecuteInSimulation="<boolean>">
    *    <BUSY Condition="<statement>" />
    *    <ERROR Condition="<statement>" />
    *  </FUB>
    *
    *  Name: Name of the function block
    *  OutType: Name of the FUB output rule
    *  Template: Name of the LCF-defined AIL code template
    *  ExecuteInSimulation: Specifies whether the FuB should be executed during
    *   a simulation run to gather restart information
    *  <BUSY Condition>: Conditional expression to identify this function block
    *   as being busy
    *  <ERROR Condition>: Condition expression to identify this function block
    *   as being in error
    *
    *  Example:
    *   - FUB declarations using predefined output rules
    *    <FUB Name="AsArLogWrite" OutType="BuR" />
    *    <FUB Name="MC_MoveAbsolute" OutType="PLCOpen" />
    *  - FUB declaration of user FUB with specific output rules
    *    <FUB Name="MyFub" ExecuteInSimulation="Yes" >
    *      <ERROR condition="$status == -1"/>
    *      <BUSY condition="$status == 1"/>
    *    </FUB>
    *    <FUB Name="myFUB" OutType="BuR">
    *      <ERROR Condition="$status != 0 && $status != 1 && $status != 2 && $status != 65535" />
    *    </FUB >
    ****************************************************************************-->

  </FUBS>
  <VARIABLES>

<!--****************************************************************************
    *  Function block instance declaration
    *
    *  Declarations of FUB-Instances to be available in the G-code programs
    *  (without need to redeclare).
    *
    *  Note: FUB instances can be declared only after function block declaration 
    *
    *  <FUB_INST Alias="<alias name>"
    *       Scope="<scope type>"
    *       Synch="<synchronization type>"
    *       Type="<type name>"
    *       AryDim1="<array 1st dimension>"
    *       AryDim2="<array 2nd dimension>">
    *       Blocking="<boolean>" 
    *       ErrLevel="<error level number>">
    *     plc_variable_name
    *   </FUB_INST>
    *
    *  Alias: Alternative name to be used to refer to this FUB instance
    *  Scope: Scope type
    *   - PLC_GLOBAL - PV variable for FUB instance is mapped from PLC environment
    *   - other scope types are not supported 
    *  Synch: Specify whether variable / FUB-Instance access should be
    *   interpreter ("ip_synch") or path ("path_synch") synchronous
    *  Type: Function block type
    *   - user and system library defined names (MyFub, FileWrite)
    *   - prototype has to be defined in advance in the section FUBS
    *  AryDim1..n: Size (number of items) in this array dimension of FUB instance
    *  Blocking: Specify whether FUB-Instance is blocking ("1") or non-blocking ("0")
    *  ErrLevel: Determines the reaction to an error while the function block is executed 
    *   - error_level_1 - program and movement are immediately stopped
    *   - error_level_2 - program and movement are aborted
    *   - error_level_3 - program and movement are halted
    *   - error_level_4 - a warning is output (program sequence and the movement are continued 
    *   note: the error level may also be specified by the number only (e.g. "4")
    *
    *  Example:
    *         <FUB_INST Alias="fWrite_0" 
    *                   Scope="plc_global" 
    *                   Synch="ip_synch" 
    *                   Type="FileWrite" 
    *                   Blocking="1" 
    *                   ErrLevel="4">
    *           FileHandli:Handling.Functionblock.FileWrite_0
    *         </FUB_INST>
    ****************************************************************************-->

  </VARIABLES>
</CONFIG>