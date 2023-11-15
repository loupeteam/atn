<?xml version="1.0" encoding="UTF-8"?>
<?ARNC0 Version="5.12.2"?>
<CONFIG>

  <!-- Include user configuration data for variables, functions and function blocks -->
  <LANG_INCLUDE Name="gmcipmxd" LangName="IEC-ST" DataObject="Yes" IfNotExist="Error" Scope="NC_GLOBAL" RequireFnIgnore="MXConvertOrient" />
  <XML_INCLUDE Name="gmcipvar" IfNotExist="Warn" />
  <XML_INCLUDE Name="gmcipfun" IfNotExist="Warn" />
  <XML_INCLUDE Name="gmcipfub" IfNotExist="Warn" />

  <!-- Motion packet queue configuration -->
  <MPQUEUE NumPackets="200" LookaheadMinBlocks="5" LookaheadMaxBlocks="20" LookaheadMode="any" MaxPathJobs="256" CheckForNaNs="1" />

  <!-- Extended block monitor configuration -->
  <MONITOR MaxPathStackEvents="1024" />

  <!-- Motion Packet Logging configuration -->
  <MPLOG MaxBuffers="10" MinBuffers="4" EarlyCircleBufferLookahead="2" DefaultBufferSize="131072" TaskCycleDelay="1"
         FileDevice="mplog*" MaxLogFiles="20" MaxLogFileSize="1048576" CopyLineTextMaxChars="80" />

  <!-- Import axis configuration from CNC user data -->
  <AXES StandardCNCAxes="Yes">
  </AXES>

  <!-- Define standard function block output rules -->
  <FUBOutputs>
    <FUBOutput Name="PLCOpen">
      <ERROR condition="$Error == 1"/>
      <BUSY condition="$Busy == 1"/>
    </FUBOutput>
    <FUBOutput Name="BuR">
      <ERROR condition="$status != 65535 &amp;&amp; $status != 0"/>
      <BUSY condition="$status == 65535"/>
    </FUBOutput>
  </FUBOutputs>

  <FUNCTIONS>
  	<!--
  	     standard conversion functions (for IEC)
    <FUNC Name="H_TO_NINT"   RetType="INT">  <ARG Name="IN" Type="INT"   /></FUNC>
    <FUNC Name="H_TO_NUINT"  RetType="UINT"> <ARG Name="IN" Type="UINT"  /></FUNC>
    <FUNC Name="H_TO_NDINT"  RetType="DINT"> <ARG Name="IN" Type="DINT"  /></FUNC>
    <FUNC Name="H_TO_NUDINT" RetType="UDINT"><ARG Name="IN" Type="UDINT" /></FUNC>
    <FUNC Name="H_TO_NREAL"  RetType="REAL"> <ARG Name="IN" Type="REAL"  /></FUNC>
    <FUNC Name="H_TO_NLREAL" RetType="LREAL"><ARG Name="IN" Type="LREAL" /></FUNC>
    <FUNC Name="H_TO_NTIME"  RetType="TIME"> <ARG Name="IN" Type="TIME"  /></FUNC>
    <FUNC Name="H_TO_NDT"    RetType="DATE_AND_TIME"><ARG Name="IN" Type="DATE_AND_TIME" /></FUNC>
       skip AS3.0.90 DATE and TOD
    <FUNC Name="N_TO_HINT"   RetType="INT">  <ARG Name="IN" Type="INT"   /></FUNC>
    <FUNC Name="N_TO_HUINT"  RetType="UINT"> <ARG Name="IN" Type="UINT"  /></FUNC>
    <FUNC Name="N_TO_HDINT"  RetType="DINT"> <ARG Name="IN" Type="DINT"  /></FUNC>
    <FUNC Name="N_TO_HUDINT" RetType="UDINT"><ARG Name="IN" Type="UDINT" /></FUNC>
    <FUNC Name="N_TO_HREAL"  RetType="REAL"> <ARG Name="IN" Type="REAL"  /></FUNC>
    <FUNC Name="N_TO_HLREAL" RetType="LREAL"><ARG Name="IN" Type="LREAL" /></FUNC>
    <FUNC Name="N_TO_HTIME"  RetType="TIME"> <ARG Name="IN" Type="TIME"  /></FUNC>
    <FUNC Name="N_TO_HDT"    RetType="DATE_AND_TIME"><ARG Name="IN" Type="DATE_AND_TIME" /></FUNC>
      swap fn's
    <FUNC Name="swapINT"     RetType="INT">  <ARG Name="IN" Type="INT"   /></FUNC>
    <FUNC Name="swapUINT"    RetType="UINT"> <ARG Name="IN" Type="UINT"  /></FUNC>
    <FUNC Name="swapDINT"    RetType="DINT"> <ARG Name="IN" Type="DINT"  /></FUNC>
    <FUNC Name="swapUDINT"   RetType="UDINT"><ARG Name="IN" Type="UDINT" /></FUNC>
    <FUNC Name="swapREAL"    RetType="REAL"> <ARG Name="IN" Type="REAL"  /></FUNC>
    <FUNC Name="swapLREAL"   RetType="LREAL"><ARG Name="IN" Type="LREAL" /></FUNC>
    -->

    <!-- Definitions of functions from library STANDARD -->
    <FUNC Name="LEN" DeclareName="__LEN" AlwaysDeclare="Yes" RetType="INT">
       <ARG Name="IN" Type="STRING"/>
    </FUNC>
    <FUNC Name="LEFT" DeclareName="__LEFT" AlwaysDeclare="Yes" RetType="STRING" RetRef="Yes">
       <ARG Name="IN" Type="STRING"/>
       <ARG Name="L" Type="INT"/>
    </FUNC>
    <FUNC Name="RIGHT" DeclareName="__RIGHT" AlwaysDeclare="Yes" RetType="STRING" RetRef="Yes">
       <ARG Name="IN" Type="STRING"/>
       <ARG Name="L" Type="INT"/>
    </FUNC>
    <FUNC Name="MID" DeclareName="__MID" AlwaysDeclare="Yes" RetType="STRING" RetRef="Yes">
       <ARG Name="IN" Type="STRING"/>
       <ARG Name="L" Type="INT"/>
       <ARG Name="P" Type="INT"/>
    </FUNC>
    <FUNC Name="CONCAT" DeclareName="__CONCAT" AlwaysDeclare="Yes" RetType="STRING" RetRef="Yes">
       <ARG Name="IN1" Type="STRING"/>
       <ARG Name="IN2" Type="STRING"/>
    </FUNC>
    <FUNC Name="INSERT" DeclareName="__INSERT" AlwaysDeclare="Yes" RetType="STRING" RetRef="Yes">
       <ARG Name="IN1" Type="STRING"/>
       <ARG Name="IN2" Type="STRING"/>
       <ARG Name="P" Type="INT"/>
    </FUNC>
    <FUNC Name="DELETE" DeclareName="__DELETE" AlwaysDeclare="Yes" RetType="STRING" RetRef="Yes">
       <ARG Name="IN" Type="STRING"/>
       <ARG Name="L" Type="INT"/>
       <ARG Name="P" Type="INT"/>
    </FUNC>
    <FUNC Name="REPLACE" DeclareName="__REPLACE" AlwaysDeclare="Yes" RetType="STRING" RetRef="Yes">
       <ARG Name="IN1" Type="STRING"/>
       <ARG Name="IN2" Type="STRING"/>
       <ARG Name="L" Type="INT"/>
       <ARG Name="P" Type="INT"/>
    </FUNC>
    <FUNC Name="FIND" DeclareName="__FIND" AlwaysDeclare="Yes" RetType="INT">
       <ARG Name="IN1" Type="STRING"/>
       <ARG Name="IN2" Type="STRING"/>
    </FUNC>
  </FUNCTIONS>

  <!-- Include user interpreter configuraration file for overriding settings above -->
  <XML_INCLUDE Name="gmcipuc" IfNotExist="Warn" />
</CONFIG>