<?xml version="1.0" encoding="utf-8"?>
<?ARNC0 Version="5.12.2"?>
<Root LangModule="ailgcode" Version="1.0">
  <AxesSpec>
  </AxesSpec>
  <!-- avoid primtypes matching when followed by # to avoid conflicts with IEC literals (e.g. TIME#...) -->
  <PrimTypes PatternSuffix=":[^\d\w$#]">
    <!-- Specify what B&R datatypes correspond to the user-language defined types -->
    <!-- If the user declares a variable in their program, and the corresponding PV is
         of a different type, then a warning is issued -->
    <!-- Support for specifying B&R specific types -->
    <BOOL BRType="BOOL" />
    <STRING BRType="STRING" />
    <WSTRING BRType="WSTRING" />
    <TIME BRType="TIME" />
    <SINT BRType="SINT" />
    <INT BRType="INT" />
    <DINT BRType="DINT" />
    <USINT BRType="USINT" />
    <UINT BRType="UINT" />
    <UDINT BRType="UDINT" />
    <REAL BRType="REAL" />
    <LREAL BRType="LREAL" />
    <DATE BRType="DATE" />
    <DATE_AND_TIME BRType="DATE_AND_TIME" />
    <DT BRType="DT" />
    <TIME_OF_DAY BRType="TIME_OF_DAY" />
    <TOD BRType="TIME_OF_DAY" />
    <BYTE BRType="BYTE" />
    <WORD BRType="WORD" />
    <DWORD BRType="DWORD" />
  </PrimTypes>
  <BuiltInProcs>
    <SetCyclicId MinArgs="1" MaxArgs="1" Eval="Early">
      #job->group_id = $[1];
    </SetCyclicId>
    <WaitForCyclic MinArgs="0" MaxArgs="*">
      if ( Defined(:$[1]:) ) 
        WaitForCyclicGroups(:${*}:);  
      else
        WaitForCyclicJob(:#last_job_id:);
      endif
    </WaitForCyclic>
    <!-- Error messaging functions (in order of increasing severity...) -->
    <REPORT MinArgs="2" MaxArgs="2">
      <Arg ref="id" DataType="INT" />
      <Arg ref="msg" DataType="STRING" />
      Info(:${id},${msg}:);
    </REPORT>
     <WARN MinArgs="2" MaxArgs="2">
      <Arg ref="id" DataType="INT" />
      <Arg ref="msg" DataType="STRING" />
      Warn(:${id},${msg}:);
    </WARN>
    <HALT MinArgs="2" MaxArgs="2">
      <Arg ref="id" DataType="INT" />
      <Arg ref="msg" DataType="STRING" />
      Halt(:${id},${msg}:);
    </HALT>
    <ERROR MinArgs="2" MaxArgs="2">
      <Arg ref="id" DataType="INT" />
      <Arg ref="msg" DataType="STRING" />
      Error(:${id},${msg}:);
    </ERROR>
    <LOADBG MinArgs="1" MaxArgs="1" >
      <Arg ref="filename" DataType="STRING" />
        LoadProgBg(:${filename}:);
    </LOADBG>
    <LOAD MinArgs="1" MaxArgs="1" >
      <Arg ref="filename" DataType="STRING" />
        LoadProg(:${filename}:);
    </LOAD>    
    <UNLOAD MinArgs="1" MaxArgs="1" >
      <Arg ref="filename" DataType="STRING" />
      UnloadProg(:${filename}:);
    </UNLOAD>    
    <EXEC MinArgs="1" MaxArgs="5" >
      <Arg ref="filename" DataType="STRING" />
      <Arg ref="arguments" DataType="ANY_DATA" />
      <Arg ref="langId" DataType="INT" />
      <Arg ref="block" DataType="INT" MinCount="0" MaxCount="1" DenyArgs="5" WriteOpts=":" />
      <Arg ref="line" DataType="INT" MinCount="0" MaxCount="1" DenyArgs="4" WriteOpts=":" />
      local rsoff $file_id;

      if (#stack_repositioning_active)
        fcall ${filename}
        return;
      endif

      UnloadProgIfModified(:${filename}:);
      $file_id = LoadProg(:${filename},${langId},${line}:);
      AssignProgArgs(:$file_id,\${arguments}:);

      if (Defined(:${block}:))
        ExecProg(:$file_id, ${block}:);
      elif (Defined(:${line}:))
        ExecProg(:$file_id, ${line}:);
      else
        ExecProg(:$file_id:);
      endif
    </EXEC>
    <EXEC_RPC MinArgs="2" MaxArgs="4" >
      <Arg ref="filename" DataType="STRING" />
      <Arg ref="arguments" DataType="ANY_DATA" />
      <Arg ref="langId" DataType="INT" />
      <Arg ref="rpc" DataType="ANY_DATA" MinCount="1" MaxCount="1" />
      local rsoff $file_id;
      UnloadProgIfModified(:${filename}:);
      $file_id = LoadProg(:${filename},${langId}:);
      AssignProgArgs(:$file_id,\${arguments}:);
      ExecProgRPC(:$file_id, \${rpc}:);
    </EXEC_RPC>
    <EVAL MinArgs="1" MaxArgs="2">
      <Arg ref="expression" DataType="STRING" />
      <Arg ref="langId" DataType="INT" />
      local rsoff $file_id;
      $file_id = LoadProgString(:${expression}, ${langId}:);
      WaitForLoadProg(:$file_id:);
      ExecProg(:$file_id:);
      UnloadProg(:$file_id:); 
    </EVAL>
    <PUSH_PACKET>
      PushPacket(::);
    </PUSH_PACKET>
    <PUSH_PACKET_CMD MinArgs="1" MaxArgs="2">
      <Arg ref="cmd" DataType="INT" />
      <Arg ref="data" DataType="ANY_DATA" />
      #next_motion.Command = ${cmd};
      if Defined(:${data}:)
        MemCpy(:\#next_motion.Data.UI4_value, \${data}:);
      endif
      PushPacket(::);
    </PUSH_PACKET_CMD>
    <DISPATCH_AND_WAIT MinArgs="1" MaxArgs="1">
      <Arg ref="cmd" DataType="INT" />
      DispatchAndWait(:${cmd}:);
    </DISPATCH_AND_WAIT>
    <START_PACKET_LIST>
      #inhibit_mp_list_dispatch = 1;
    </START_PACKET_LIST>
    <END_PACKET_LIST>
      #inhibit_mp_list_dispatch = 0;
    </END_PACKET_LIST>
    <LOG_INFO MinArgs="1" MaxArgs="1">
      <Arg ref="msg" DataType="STRING" />
      LogWrite(:${msg}:);
    </LOG_INFO>
    <SET_BLOCK_NUMBER  MinArgs="1" MaxArgs="1">
      SetCurBlockNr(:$[1]:);
    </SET_BLOCK_NUMBER>    
    <SBLOF_PATH>
      <!-- Inhibit path single step mode -->
      #next_motion.Command = MPCMD_SBL_PATH_INHIBIT;
      PushPacket(::);
    </SBLOF_PATH>
    <SBLON_PATH>
      <!-- Release path single step mode -->
      #next_motion.Command = MPCMD_SBL_PATH_RELEASE;
      PushPacket(::);
    </SBLON_PATH>
  </BuiltInProcs>
  <BuiltInFns>
    <!-- IEC standard functions -->
    <ABS   ReturnType="ANY_NUM" ArgType1="ANY_NUM" Inline="Yes">Abs(:$[1]:)</ABS>
    <SIN   ReturnType="ANY_REAL" ArgType1="ANY_REAL" Inline="Yes">RSin(:$[1]:)</SIN>
    <COS   ReturnType="ANY_REAL" ArgType1="ANY_REAL" Inline="Yes">RCos(:$[1]:)</COS>
    <TAN   ReturnType="ANY_REAL" ArgType1="ANY_REAL" Inline="Yes">RTan(:$[1]:)</TAN>
    <ASIN  ReturnType="ANY_REAL" ArgType1="ANY_REAL" Inline="Yes">RASin(:$[1]:)</ASIN>
    <ACOS  ReturnType="ANY_REAL" ArgType1="ANY_REAL" Inline="Yes">RACos(:$[1]:)</ACOS>
    <ATAN  ReturnType="ANY_REAL" ArgType1="ANY_REAL" Inline="Yes">RATan(:$[1]:)</ATAN>
    <SQRT  ReturnType="ANY_REAL" ArgType1="ANY_REAL" Inline="Yes">Sqrt(:$[1]:)</SQRT>
    <LN    ReturnType="ANY_REAL" ArgType1="ANY_REAL" Inline="Yes">Ln(:$[1]:)</LN>
    <EXP   ReturnType="ANY_REAL" ArgType1="ANY_REAL" Inline="Yes">Exp(:$[1]:)</EXP>
    <LOG   ReturnType="ANY_REAL" ArgType1="ANY_REAL" Inline="Yes">Log(:$[1]:)</LOG>
    <EXPT  ReturnType="ANY_REAL" ArgType1="ANY_REAL" ArgType2="ANY_NUM" Inline="Yes">Pow(:$[1],$[2]:)</EXPT>
    <TRUNC ReturnType="IEC_INT" ArgType1="ANY_REAL" Inline="Yes">ToInt(:Fix(:$[1]:):)</TRUNC>
    <ADR   ReturnType="IEC_UDINT" ArgType1="ANY_DATA" Inline="Yes">Adr(:\$[1]:)</ADR>
    <REF   ReturnType="ANY_DATA" ArgType1="ANY_DATA" Inline="Yes">\$[1]</REF>
    <!-- SIZEOF documented as returning UDINT only but in AS it's really ANY_INT -->
    <!-- Note: Using NumArgs=.. adopts arg type "ANY_DATA" -->
    <SIZEOF ReturnType="IEC_UINT" NumArgs="1" Inline="Yes">Sizeof(:\$[1]:)</SIZEOF>
    <LIMIT ReturnType="ANY_NUM" Inline="No">
      <Arg ref="MIN" DataType="ANY_NUM"/>
      <Arg ref="IN"  DataType="ANY_NUM"/>
      <Arg ref="MAX" DataType="ANY_NUM"/>
      <!-- The IEC-Standard defines LIMIT(MIN, IN, MAX) = MIN(MAX(IN, MIN), MAX) 
           IEC 61131-3 Table 27. -->
      if (${IN} &gt; ${MIN})
        if (${IN} &lt; ${MAX})
          return ${IN};
        else
          return ${MAX};
        endif
      else
        if (${MIN} &lt; ${MAX})
          return ${MIN};
        else
          return ${MAX};
        endif
      endif
    </LIMIT>
    <MIN ReturnType="ANY_NUM" Inline="No">
      <Arg ref="IN1" DataType="ANY_NUM"/>
      <Arg ref="IN2" DataType="ANY_NUM"/>
      if (${IN1} &lt; ${IN2})
        return ${IN1};
      else
        return ${IN2};
      endif
    </MIN>
    <MAX ReturnType="ANY_NUM" Inline="No">
      <Arg ref="IN1" DataType="ANY_NUM"/>
      <Arg ref="IN2" DataType="ANY_NUM"/>
      if (${IN1} &gt; ${IN2})
        return ${IN1};
      else
        return ${IN2};
      endif
    </MAX>
    <!-- Bit manipulation -->
    <ROL ReturnType="ANY_NUM" ArgType1="ANY_NUM" ArgType2="IEC_SINT">BitRotL(:$[1],$[2]:)</ROL>
    <ROR ReturnType="ANY_NUM" ArgType1="ANY_NUM" ArgType2="IEC_SINT">BitRotR(:$[1],$[2]:)</ROR>
    <SHR ReturnType="ANY_NUM" ArgType1="ANY_NUM" ArgType2="IEC_SINT">BitShR(:$[1],$[2]:)</SHR>
    <SHL ReturnType="ANY_NUM" ArgType1="ANY_NUM" ArgType2="IEC_SINT">BitShL(:$[1],$[2]:)</SHL>
    <!-- IEC type conversion library functions -->
    <BIT_TST ReturnType="ANY_NUM" ArgType1="ANY_NUM" ArgType2="IEC_SINT">AsBitTst(:$[1],$[2]:)</BIT_TST>
    <BIT_SET ReturnType="ANY_NUM" ArgType1="ANY_NUM" ArgType2="IEC_SINT">AsBitSet(:$[1],$[2]:)</BIT_SET>
    <BIT_CLR ReturnType="ANY_NUM" ArgType1="ANY_NUM" ArgType2="IEC_SINT">AsBitClr(:$[1],$[2]:)</BIT_CLR>
    <!-- Simplified TO_<TYPE>() conversions -->
    <TO_BOOL    ReturnType="IEC_BOOL"    ArgType1="ANY_DATA"  Inline="Yes">ToBool(:$[1]:)</TO_BOOL>
    <TO_USINT   ReturnType="IEC_USINT"   ArgType1="ANY_DATA"  Inline="Yes">ToUInt(:$[1],1:)</TO_USINT>
    <TO_BYTE    ReturnType="IEC_BYTE"    ArgType1="ANY_DATA"  Inline="Yes">ToUInt(:$[1],1:)</TO_BYTE>
    <TO_SINT    ReturnType="IEC_SINT"    ArgType1="ANY_DATA"  Inline="Yes">ToInt(:$[1],1:)</TO_SINT>
    <TO_UINT    ReturnType="IEC_UINT"    ArgType1="ANY_DATA"  Inline="Yes">ToUInt(:$[1],2:)</TO_UINT>
    <TO_WORD    ReturnType="IEC_WORD"    ArgType1="ANY_DATA"  Inline="Yes">ToUInt(:$[1],2:)</TO_WORD>
    <TO_INT     ReturnType="IEC_INT"     ArgType1="ANY_DATA"  Inline="Yes">ToInt(:$[1],2:)</TO_INT>
    <TO_UDINT   ReturnType="IEC_UDINT"   ArgType1="ANY_DATA"  Inline="Yes">ToUInt(:$[1]:)</TO_UDINT>
    <TO_DWORD   ReturnType="IEC_DWORD"   ArgType1="ANY_DATA"  Inline="Yes">ToUInt(:$[1]:)</TO_DWORD>
    <TO_DINT    ReturnType="IEC_DINT"    ArgType1="ANY_DATA"  Inline="Yes">ToInt(:$[1]:)</TO_DINT>
    <TO_TIME    ReturnType="IEC_TIME"    ArgType1="ANY_DATA"  Inline="Yes">ToTime(:$[1]:)</TO_TIME>
    <TO_DT      ReturnType="IEC_DT"      ArgType1="ANY_DATA"  Inline="Yes">ToDT(:$[1]:)</TO_DT>
    <TO_DATE_AND_TIME ReturnType="IEC_DT" ArgType1="ANY_DATA" Inline="Yes">ToDT(:$[1]:)</TO_DATE_AND_TIME>
    <TO_TOD     ReturnType="IEC_TOD"     ArgType1="ANY_DATA"  Inline="Yes">ToTOD(:$[1]:)</TO_TOD>
    <TO_TIME_OF_DAY ReturnType="IEC_TOD" ArgType1="ANY_DATA"  Inline="Yes">ToTOD(:$[1]:)</TO_TIME_OF_DAY>
    <TO_DATE    ReturnType="IEC_DATE"    ArgType1="ANY_DATA"  Inline="Yes">ToDate(:$[1]:)</TO_DATE>
    <TO_REAL    ReturnType="IEC_REAL"    ArgType1="ANY_DATA"  Inline="Yes">ToFloat(:$[1]:)</TO_REAL>
    <TO_LREAL   ReturnType="IEC_LREAL"   ArgType1="ANY_DATA"  Inline="Yes">ToLReal(:$[1]:)</TO_LREAL>
    <TO_STRING  ReturnType="IEC_STRING"  ArgType1="ANY_DATA"  Inline="Yes">ToString(:$[1]:)</TO_STRING>
    <TO_WSTRING ReturnType="IEC_WSTRING" ArgType1="ANY_DATA"  Inline="Yes">ToWString(:$[1]:)</TO_WSTRING>
    <!-- Legacy type conversion functions -->
    <USINT_TO_BOOL ReturnType="IEC_BOOL" ArgType1="IEC_USINT" Inline="Yes">ToBool(:$[1]:)</USINT_TO_BOOL>
    <SINT_TO_BOOL  ReturnType="IEC_BOOL" ArgType1="IEC_SINT"  Inline="Yes">ToBool(:$[1]:)</SINT_TO_BOOL>
    <UINT_TO_BOOL  ReturnType="IEC_BOOL" ArgType1="IEC_UINT"  Inline="Yes">ToBool(:$[1]:)</UINT_TO_BOOL>
    <INT_TO_BOOL   ReturnType="IEC_BOOL" ArgType1="IEC_INT"   Inline="Yes">ToBool(:$[1]:)</INT_TO_BOOL>
    <UDINT_TO_BOOL ReturnType="IEC_BOOL" ArgType1="IEC_UDINT" Inline="Yes">ToBool(:$[1]:)</UDINT_TO_BOOL>
    <DINT_TO_BOOL  ReturnType="IEC_BOOL" ArgType1="IEC_DINT"  Inline="Yes">ToBool(:$[1]:)</DINT_TO_BOOL>
    <REAL_TO_BOOL  ReturnType="IEC_BOOL" ArgType1="IEC_REAL"  Inline="Yes">ToBool(:$[1]:)</REAL_TO_BOOL>
    <LREAL_TO_BOOL ReturnType="IEC_BOOL" ArgType1="IEC_LREAL" Inline="Yes">ToBool(:$[1]:)</LREAL_TO_BOOL>
    <TIME_TO_BOOL  ReturnType="IEC_BOOL" ArgType1="IEC_TIME"  Inline="Yes">ToBool(:$[1]:)</TIME_TO_BOOL>
    <DT_TO_BOOL    ReturnType="IEC_BOOL" ArgType1="IEC_DT"    Inline="Yes">ToBool(:$[1]:)</DT_TO_BOOL>    
    <TOD_TO_BOOL   ReturnType="IEC_BOOL" ArgType1="IEC_TOD"   Inline="Yes">ToBool(:$[1]:)</TOD_TO_BOOL>
    <BYTE_TO_BOOL  ReturnType="IEC_BOOL" ArgType1="IEC_BYTE"  Inline="Yes">ToBool(:$[1]:)</BYTE_TO_BOOL>
    <WORD_TO_BOOL  ReturnType="IEC_BOOL" ArgType1="IEC_WORD"  Inline="Yes">ToBool(:$[1]:)</WORD_TO_BOOL>
    <DWORD_TO_BOOL ReturnType="IEC_BOOL" ArgType1="IEC_DWORD" Inline="Yes">ToBool(:$[1]:)</DWORD_TO_BOOL>
    <!-- ***_TO_USINT -->
    <BOOL_TO_USINT  ReturnType="IEC_USINT" ArgType1="IEC_BOOL"  Inline="Yes">ToUInt(:$[1],1:)</BOOL_TO_USINT>
    <SINT_TO_USINT  ReturnType="IEC_USINT" ArgType1="IEC_SINT"  Inline="Yes">ToUInt(:$[1],1:)</SINT_TO_USINT>
    <UINT_TO_USINT  ReturnType="IEC_USINT" ArgType1="IEC_UINT"  Inline="Yes">ToUInt(:$[1],1:)</UINT_TO_USINT>
    <INT_TO_USINT   ReturnType="IEC_USINT" ArgType1="IEC_INT"   Inline="Yes">ToUInt(:$[1],1:)</INT_TO_USINT>
    <UDINT_TO_USINT ReturnType="IEC_USINT" ArgType1="IEC_UDINT" Inline="Yes">ToUInt(:$[1],1:)</UDINT_TO_USINT>
    <DINT_TO_USINT  ReturnType="IEC_USINT" ArgType1="IEC_DINT"  Inline="Yes">ToUInt(:$[1],1:)</DINT_TO_USINT>
    <REAL_TO_USINT  ReturnType="IEC_USINT" ArgType1="IEC_REAL"  Inline="Yes">ToUInt(:$[1],1:)</REAL_TO_USINT>
    <LREAL_TO_USINT ReturnType="IEC_USINT" ArgType1="IEC_LREAL" Inline="Yes">ToUInt(:$[1],1:)</LREAL_TO_USINT>
    <!-- ***_TO_SINT -->
    <BOOL_TO_SINT   ReturnType="IEC_SINT"  ArgType1="IEC_BOOL"  Inline="Yes">ToInt(:$[1],1:)</BOOL_TO_SINT>
    <USINT_TO_SINT  ReturnType="IEC_SINT"  ArgType1="IEC_USINT" Inline="Yes">ToInt(:$[1],1:)</USINT_TO_SINT>
    <UINT_TO_SINT   ReturnType="IEC_SINT"  ArgType1="IEC_UINT"  Inline="Yes">ToInt(:$[1],1:)</UINT_TO_SINT>
    <INT_TO_SINT    ReturnType="IEC_SINT"  ArgType1="IEC_INT"   Inline="Yes">ToInt(:$[1],1:)</INT_TO_SINT>
    <UDINT_TO_SINT  ReturnType="IEC_SINT"  ArgType1="IEC_UDINT" Inline="Yes">ToInt(:$[1],1:)</UDINT_TO_SINT>
    <DINT_TO_SINT   ReturnType="IEC_SINT"  ArgType1="IEC_DINT"  Inline="Yes">ToInt(:$[1],1:)</DINT_TO_SINT>
    <REAL_TO_SINT   ReturnType="IEC_SINT"  ArgType1="IEC_REAL"  Inline="Yes">ToInt(:$[1],1:)</REAL_TO_SINT>
    <LREAL_TO_SINT  ReturnType="IEC_SINT"  ArgType1="IEC_LREAL" Inline="Yes">ToInt(:$[1],1:)</LREAL_TO_SINT>
    <!-- ***_TO_UINT -->
    <BOOL_TO_UINT   ReturnType="IEC_UINT"  ArgType1="IEC_BOOL"  Inline="Yes">ToUInt(:$[1],2:)</BOOL_TO_UINT>
    <SINT_TO_UINT   ReturnType="IEC_UINT"  ArgType1="IEC_SINT"  Inline="Yes">ToUInt(:$[1],2:)</SINT_TO_UINT>
    <USINT_TO_UINT  ReturnType="IEC_UINT"  ArgType1="IEC_USINT" Inline="Yes">ToUInt(:$[1],2:)</USINT_TO_UINT>
    <INT_TO_UINT    ReturnType="IEC_UINT"  ArgType1="IEC_INT"   Inline="Yes">ToUInt(:$[1],2:)</INT_TO_UINT>
    <UDINT_TO_UINT  ReturnType="IEC_UINT"  ArgType1="IEC_UDINT" Inline="Yes">ToUInt(:$[1],2:)</UDINT_TO_UINT>
    <DINT_TO_UINT   ReturnType="IEC_UINT"  ArgType1="IEC_DINT"  Inline="Yes">ToUInt(:$[1],2:)</DINT_TO_UINT>
    <REAL_TO_UINT   ReturnType="IEC_UINT"  ArgType1="IEC_REAL"  Inline="Yes">ToUInt(:$[1],2:)</REAL_TO_UINT>
    <LREAL_TO_UINT  ReturnType="IEC_UINT"  ArgType1="IEC_LREAL" Inline="Yes">ToUInt(:$[1],2:)</LREAL_TO_UINT>
    <!-- ***_TO_INT -->
    <BOOL_TO_INT    ReturnType="IEC_INT"   ArgType1="IEC_BOOL"  Inline="Yes">ToInt(:$[1],2:)</BOOL_TO_INT>
    <SINT_TO_INT    ReturnType="IEC_INT"   ArgType1="IEC_SINT"  Inline="Yes">ToInt(:$[1],2:)</SINT_TO_INT>
    <USINT_TO_INT   ReturnType="IEC_INT"   ArgType1="IEC_USINT" Inline="Yes">ToInt(:$[1],2:)</USINT_TO_INT>
    <UINT_TO_INT    ReturnType="IEC_INT"   ArgType1="IEC_UINT"  Inline="Yes">ToInt(:$[1],2:)</UINT_TO_INT>
    <UDINT_TO_INT   ReturnType="IEC_INT"   ArgType1="IEC_UDINT" Inline="Yes">ToInt(:$[1],2:)</UDINT_TO_INT>
    <DINT_TO_INT    ReturnType="IEC_INT"   ArgType1="IEC_DINT"  Inline="Yes">ToInt(:$[1],2:)</DINT_TO_INT>
    <REAL_TO_INT    ReturnType="IEC_INT"   ArgType1="IEC_REAL"  Inline="Yes">ToInt(:$[1],2:)</REAL_TO_INT>
    <LREAL_TO_INT   ReturnType="IEC_INT"   ArgType1="IEC_LREAL" Inline="Yes">ToInt(:$[1],2:)</LREAL_TO_INT>
    <!-- ***_TO_UDINT  Note: AIL calls miss 2nd arg to use default (4) -->
    <BOOL_TO_UDINT  ReturnType="IEC_UDINT" ArgType1="IEC_BOOL"  Inline="Yes">ToUInt(:$[1]:)</BOOL_TO_UDINT>
    <USINT_TO_UDINT ReturnType="IEC_UDINT" ArgType1="IEC_USINT" Inline="Yes">ToUInt(:$[1]:)</USINT_TO_UDINT>
    <SINT_TO_UDINT  ReturnType="IEC_UDINT" ArgType1="IEC_SINT"  Inline="Yes">ToUInt(:$[1]:)</SINT_TO_UDINT>
    <UINT_TO_UDINT  ReturnType="IEC_UDINT" ArgType1="IEC_UINT"  Inline="Yes">ToUInt(:$[1]:)</UINT_TO_UDINT>
    <INT_TO_UDINT   ReturnType="IEC_UDINT" ArgType1="IEC_INT"   Inline="Yes">ToUInt(:$[1]:)</INT_TO_UDINT>
    <DINT_TO_UDINT  ReturnType="IEC_UDINT" ArgType1="IEC_DINT"  Inline="Yes">ToUInt(:$[1]:)</DINT_TO_UDINT>
    <REAL_TO_UDINT  ReturnType="IEC_UDINT" ArgType1="IEC_REAL"  Inline="Yes">ToUInt(:$[1]:)</REAL_TO_UDINT>
    <LREAL_TO_UDINT ReturnType="IEC_UDINT" ArgType1="IEC_LREAL" Inline="Yes">ToUInt(:$[1]:)</LREAL_TO_UDINT>
    <TIME_TO_UDINT  ReturnType="IEC_UDINT" ArgType1="IEC_TIME"  Inline="Yes">ToUInt(:$[1]:)</TIME_TO_UDINT>
    <DT_TO_UDINT    ReturnType="IEC_UDINT" ArgType1="IEC_DT"    Inline="Yes">ToUInt(:$[1]:)</DT_TO_UDINT>
    <!-- ***_TO_DINT -->
    <BOOL_TO_DINT   ReturnType="IEC_DINT"  ArgType1="IEC_BOOL"  Inline="Yes">ToInt(:$[1]:)</BOOL_TO_DINT>
    <USINT_TO_DINT  ReturnType="IEC_DINT"  ArgType1="IEC_USINT" Inline="Yes">ToInt(:$[1]:)</USINT_TO_DINT>
    <SINT_TO_DINT   ReturnType="IEC_DINT"  ArgType1="IEC_SINT"  Inline="Yes">ToInt(:$[1]:)</SINT_TO_DINT>
    <UINT_TO_DINT   ReturnType="IEC_DINT"  ArgType1="IEC_UINT"  Inline="Yes">ToInt(:$[1]:)</UINT_TO_DINT>
    <INT_TO_DINT    ReturnType="IEC_DINT"  ArgType1="IEC_INT"   Inline="Yes">ToInt(:$[1]:)</INT_TO_DINT>
    <UDINT_TO_DINT  ReturnType="IEC_DINT"  ArgType1="IEC_UDINT" Inline="Yes">ToInt(:$[1]:)</UDINT_TO_DINT>
    <REAL_TO_DINT   ReturnType="IEC_DINT"  ArgType1="IEC_REAL"  Inline="Yes">ToInt(:$[1]:)</REAL_TO_DINT>
    <LREAL_TO_DINT  ReturnType="IEC_DINT"  ArgType1="IEC_LREAL" Inline="Yes">ToInt(:$[1]:)</LREAL_TO_DINT>
    <TIME_TO_DINT   ReturnType="IEC_DINT"  ArgType1="IEC_TIME"  Inline="Yes">ToInt(:$[1]:)</TIME_TO_DINT>
    <DT_TO_DINT     ReturnType="IEC_DINT"  ArgType1="IEC_DT"    Inline="Yes">ToInt(:$[1]:)</DT_TO_DINT>
    <!-- ***_TO_TIME -->
    <BOOL_TO_TIME   ReturnType="IEC_TIME"  ArgType1="IEC_BOOL"  Inline="Yes">ToTime(:$[1]:)</BOOL_TO_TIME>
    <DINT_TO_TIME   ReturnType="IEC_TIME"  ArgType1="IEC_DINT"  Inline="Yes">ToTime(:$[1]:)</DINT_TO_TIME>
    <UDINT_TO_TIME  ReturnType="IEC_TIME"  ArgType1="IEC_UDINT" Inline="Yes">ToTime(:$[1]:)</UDINT_TO_TIME>
    <!-- ***_TO_DT -->
    <BOOL_TO_DT     ReturnType="IEC_DT"    ArgType1="IEC_BOOL"  Inline="Yes">ToDT(:$[1]:)</BOOL_TO_DT>
    <DINT_TO_DT     ReturnType="IEC_DT"    ArgType1="IEC_DINT"  Inline="Yes">ToDT(:$[1]:)</DINT_TO_DT>
    <UDINT_TO_DT    ReturnType="IEC_DT"    ArgType1="IEC_UDINT" Inline="Yes">ToDT(:$[1]:)</UDINT_TO_DT>  
    <!-- ***_TO_REAL -->
    <BOOL_TO_REAL  ReturnType="IEC_REAL" ArgType1="IEC_BOOL"  Inline="Yes">ToFloat(:$[1]:)</BOOL_TO_REAL>
    <USINT_TO_REAL ReturnType="IEC_REAL" ArgType1="IEC_USINT" Inline="Yes">ToFloat(:$[1]:)</USINT_TO_REAL>
    <SINT_TO_REAL  ReturnType="IEC_REAL" ArgType1="IEC_SINT"  Inline="Yes">ToFloat(:$[1]:)</SINT_TO_REAL>
    <UINT_TO_REAL  ReturnType="IEC_REAL" ArgType1="IEC_UINT"  Inline="Yes">ToFloat(:$[1]:)</UINT_TO_REAL>
    <INT_TO_REAL   ReturnType="IEC_REAL" ArgType1="IEC_INT"   Inline="Yes">ToFloat(:$[1]:)</INT_TO_REAL>
    <UDINT_TO_REAL ReturnType="IEC_REAL" ArgType1="IEC_UDINT" Inline="Yes">ToFloat(:$[1]:)</UDINT_TO_REAL>
    <DINT_TO_REAL  ReturnType="IEC_REAL" ArgType1="IEC_DINT"  Inline="Yes">ToFloat(:$[1]:)</DINT_TO_REAL>
    <LREAL_TO_REAL ReturnType="IEC_REAL" ArgType1="IEC_LREAL" Inline="Yes">ToFloat(:$[1]:)</LREAL_TO_REAL>
    <TIME_TO_REAL  ReturnType="IEC_REAL" ArgType1="IEC_TIME" Inline="Yes">ToFloat(:$[1]:)</TIME_TO_REAL>
    <!-- ***_TO_LREAL -->
    <BOOL_TO_LREAL  ReturnType="IEC_LREAL" ArgType1="IEC_BOOL"  Inline="Yes">ToLReal(:$[1]:)</BOOL_TO_LREAL>
    <USINT_TO_LREAL ReturnType="IEC_LREAL" ArgType1="IEC_USINT" Inline="Yes">ToLReal(:$[1]:)</USINT_TO_LREAL>
    <SINT_TO_LREAL  ReturnType="IEC_LREAL" ArgType1="IEC_SINT"  Inline="Yes">ToLReal(:$[1]:)</SINT_TO_LREAL>
    <UINT_TO_LREAL  ReturnType="IEC_LREAL" ArgType1="IEC_UINT"  Inline="Yes">ToLReal(:$[1]:)</UINT_TO_LREAL>
    <INT_TO_LREAL   ReturnType="IEC_LREAL" ArgType1="IEC_INT"   Inline="Yes">ToLReal(:$[1]:)</INT_TO_LREAL>
    <UDINT_TO_LREAL ReturnType="IEC_LREAL" ArgType1="IEC_UDINT" Inline="Yes">ToLReal(:$[1]:)</UDINT_TO_LREAL>
    <DINT_TO_LREAL  ReturnType="IEC_LREAL" ArgType1="IEC_DINT"  Inline="Yes">ToLReal(:$[1]:)</DINT_TO_LREAL>
    <REAL_TO_LREAL  ReturnType="IEC_LREAL" ArgType1="IEC_REAL"  Inline="Yes">ToLReal(:$[1]:)</REAL_TO_LREAL>
    <TIME_TO_LREAL  ReturnType="IEC_LREAL" ArgType1="IEC_TIME"  Inline="Yes">ToLReal(:$[1]:)</TIME_TO_LREAL>
    <!-- ***_TO_STRING not supported in AS but IP can do them (safer than using AS's itoa) -->   
    <BOOL_TO_STRING  ReturnType="IEC_STRING" ArgType1="IEC_BOOL"  Inline="Yes">ToString(:ToBool(:$[1]:):)</BOOL_TO_STRING>
    <USINT_TO_STRING ReturnType="IEC_STRING" ArgType1="IEC_USINT" Inline="Yes">ToString(:ToUInt(:$[1],1:):)</USINT_TO_STRING>
    <SINT_TO_STRING  ReturnType="IEC_STRING" ArgType1="IEC_SINT"  Inline="Yes">ToString(:ToInt(:$[1],1:):)</SINT_TO_STRING>
    <UINT_TO_STRING  ReturnType="IEC_STRING" ArgType1="IEC_UINT"  Inline="Yes">ToString(:ToUInt(:$[1],2:):)</UINT_TO_STRING>
    <INT_TO_STRING   ReturnType="IEC_STRING" ArgType1="IEC_INT"   Inline="Yes">ToString(:ToInt(:$[1],2:):)</INT_TO_STRING>
    <UDINT_TO_STRING ReturnType="IEC_STRING" ArgType1="IEC_UDINT" Inline="Yes">ToString(:ToUInt(:$[1]:):)</UDINT_TO_STRING>
    <DINT_TO_STRING  ReturnType="IEC_STRING" ArgType1="IEC_DINT"  Inline="Yes">ToString(:ToInt(:$[1]:):)</DINT_TO_STRING>
    <REAL_TO_STRING  ReturnType="IEC_STRING" ArgType1="IEC_REAL"  Inline="Yes">ToString(:ToFloat(:$[1]:):)</REAL_TO_STRING>
    <LREAL_TO_STRING ReturnType="IEC_STRING" ArgType1="IEC_LREAL" Inline="Yes">ToString(:ToLReal(:$[1]:):)</LREAL_TO_STRING>
    <!-- STRING_TO_*** not supported in AS but IP can do them -->
    <STRING_TO_BOOL  ReturnType="IEC_BOOL"  ArgType1="IEC_STRING"  Inline="Yes">ToBool(:StrToInt(:$[1]:):)</STRING_TO_BOOL>
    <STRING_TO_USINT ReturnType="IEC_USINT" ArgType1="IEC_STRING"  Inline="Yes">ToUInt(:StrToInt(:$[1]:),1:)</STRING_TO_USINT>
    <STRING_TO_SINT  ReturnType="IEC_SINT"  ArgType1="IEC_STRING"  Inline="Yes">ToInt(:StrToInt(:$[1]:),1:)</STRING_TO_SINT>
    <STRING_TO_UINT  ReturnType="IEC_UINT"  ArgType1="IEC_STRING"  Inline="Yes">ToUInt(:StrToInt(:$[1]:),2:)</STRING_TO_UINT>
    <STRING_TO_INT   ReturnType="IEC_INT"   ArgType1="IEC_STRING"  Inline="Yes">ToInt(:StrToInt(:$[1]:),2:)</STRING_TO_INT>
    <STRING_TO_UDINT ReturnType="IEC_UDINT" ArgType1="IEC_STRING"  Inline="Yes">ToUInt(:StrToInt(:$[1]:):)</STRING_TO_UDINT>
    <STRING_TO_DINT  ReturnType="IEC_DINT"  ArgType1="IEC_STRING"  Inline="Yes">ToInt(:StrToInt(:$[1]:):)</STRING_TO_DINT>
    <STRING_TO_REAL  ReturnType="IEC_REAL"  ArgType1="IEC_STRING"  Inline="Yes">ToFloat(:ToLReal(:$[1]:):)</STRING_TO_REAL>
    <STRING_TO_LREAL ReturnType="IEC_LREAL" ArgType1="IEC_STRING"  Inline="Yes">ToLReal(:$[1]:)</STRING_TO_LREAL>
    <!-- STRING handling function from STANDARD library - PLC mapped functions -->
    <LEN     ReturnType="IEC_INT"    ArgType1="IEC_STRING" Inline="Yes">__LEN(:$[1]:)</LEN>
    <LEFT    ReturnType="IEC_STRING" ArgType1="IEC_STRING" ArgType2="IEC_INT"    Inline="Yes">__LEFT(:$[1], $[2]:)</LEFT>
    <RIGHT   ReturnType="IEC_STRING" ArgType1="IEC_STRING" ArgType2="IEC_INT"    Inline="Yes">__RIGHT(:$[1], $[2]:)</RIGHT>
    <MID     ReturnType="IEC_STRING" ArgType1="IEC_STRING" ArgType2="IEC_INT"    ArgType3="IEC_INT" Inline="Yes">__MID(:$[1], $[2], $[3]:)</MID>
    <CONCAT  ReturnType="IEC_STRING" ArgType1="IEC_STRING" ArgType2="IEC_STRING" Inline="Yes">__CONCAT(:$[1], $[2]:)</CONCAT>
    <INSERT  ReturnType="IEC_STRING" ArgType1="IEC_STRING" ArgType2="IEC_STRING" ArgType3="IEC_INT" Inline="Yes">__INSERT(:$[1], $[2], $[3]:)</INSERT>
    <DELETE  ReturnType="IEC_STRING" ArgType1="IEC_STRING" ArgType2="IEC_INT"    ArgType3="IEC_INT" Inline="Yes">__DELETE(:$[1], $[2], $[3]:)</DELETE>
    <REPLACE ReturnType="IEC_STRING" ArgType1="IEC_STRING" ArgType2="IEC_STRING" ArgType3="IEC_INT" ArgType4="IEC_INT" Inline="Yes">__REPLACE(:$[1], $[2], $[3], $[4]:)</REPLACE>
    <FIND    ReturnType="IEC_INT"    ArgType1="IEC_STRING" ArgType2="IEC_STRING" Inline="Yes">__FIND(:$[1], $[2]:)</FIND>
    <!-- Utility functions -->
    <IP_INST_NUM ReturnType="IEC_INT" NumArgs="0" >IpInstNum(::)</IP_INST_NUM>
    <IP_OWNER_ID ReturnType="IEC_INT" NumArgs="0" >IpOwnerId(::)</IP_OWNER_ID>
    <PACKET_DATA_ADR ReturnType="IEC_UDINT" NumArgs="0" Inline="Yes">GetIpInt(:6:)</PACKET_DATA_ADR>
    <PACKET_COMMAND_ADR ReturnType="IEC_UDINT" NumArgs="0" Inline="Yes">GetIpInt(:7:)</PACKET_COMMAND_ADR>
  </BuiltInFns>
  <Parameters>
    <!--Parameters are assumed to be asynchronous unless specified as Synchronous-->
    <QUOTED QuotedName="$R" ValueType="FLOAT" ReturnType="IEC_LREAL">
      <ARG ref="EXPR" DataType="INT" MinValue="0" MaxValue="999"/>
      #sys_vars.R[${EXPR}]
    </QUOTED>
    <QUOTED QuotedName="$P" ValueType="FLOAT" ReturnType="IEC_LREAL">
      <ARG ref="EXPR" DataType="INT" MinValue="0" MaxValue="999"/>
      #sys_vars.R[#sys_vars.R[${EXPR}]]
    </QUOTED>
    <QUOTED QuotedName="$EXB" ValueType="INT" ReturnType="IEC_SINT">
      <ARG ref="EXPR" DataType="INT" MinValue="0" MaxValue="99"/>
      #sys_vars.EXB[${EXPR}]
    </QUOTED>
    <QUOTED QuotedName="$EXW" ValueType="INT" ReturnType="IEC_INT">
      <ARG ref="EXPR" DataType="INT" MinValue="0"  MaxValue="99"/>
      #sys_vars.EXW[${EXPR}]
    </QUOTED>
    <QUOTED QuotedName="$EXL" ValueType="INT" ReturnType="IEC_DINT">
      <ARG ref="EXPR" DataType="INT" MinValue="0" MaxValue="99"/>
      #sys_vars.EXL[${EXPR}]
    </QUOTED>
    <QUOTED QuotedName="$EXF" ValueType="FLOAT" ReturnType="IEC_REAL">
      <ARG ref="EXPR" DataType="INT" MinValue="0" MaxValue="3999" />
      #sys_vars.EXF[${EXPR}]
    </QUOTED>
    <!-- TODO: synchronous M-parameter support -->
    <QUOTED QuotedName="$MW" Synchronous="Yes" ValueType="INT" ReturnType="IEC_INT">
      <ARG ref="EXPR" DataType="INT" MinValue="0" MaxValue="99" />
      @#sys_vars.MW[${EXPR}]
    </QUOTED>
    <QUOTED QuotedName="$ML" Synchronous="Yes" ValueType="INT" ReturnType="IEC_DINT">
      <ARG ref="EXPR" DataType="INT" MinValue="0" MaxValue="99" />
      @#sys_vars.ML[${EXPR}]
    </QUOTED>
    <QUOTED QuotedName="$MF" Synchronous="Yes" ValueType="FLOAT" ReturnType="IEC_REAL">
      <ARG ref="EXPR" DataType="INT" MinValue="0" MaxValue="99" />
      @#sys_vars.MF[${EXPR}]
    </QUOTED>
  </Parameters>
  <ParserData NestedComments="No" DefaultCaseSensitive="Yes" CommentsSpanLines="Yes"
      ReadWholeFileBeforeParsing="Yes" ExpectMainProgStmts="No" UseFubTemplates="No"
      LexerType="IEC" RuntimePreventOverflow="No" RoundRealToInt="No" AllowArrayRefWithoutIndex="Yes"
      DeclareEnumLiteralsAsConstants="No"
      AllowVariableAutoDereference="Yes"
      AllowStructMemberAutoDereference="No"
      AllowPassByRefFnArgAutoReference="No"
      AllowNamedFnArgs="Yes"
      AllowUnnamedFnArgs="Yes"
      AllowFnArgMixedNaming="Yes"
      AllowFnArgsOutOfSequence="No"
      AllowBuiltinFnArgsOutOfSequence="Yes"
      AllowFnArgsOmmitted="Yes"
      AllowIgnoredFnReturn="Yes"
      AllowIgnoredExtraSubArgs="No"
      AllowFnStringInputArgsShort="No"
      RefuseBuiltinFnUnknownArgName="Yes"
      AllowBuiltinFnArgCaseSensitive="Yes"
      >
    <!--Patterns are specified as Perl regular expressions-->
    <!--Token Names should not be changed-->
    <!--Tokens without a Pattern or without TOKEN entry are not in use in this dialect-->
    <!--Restricted means this token can only match on a FollowedBy request-->
    <TKG_OPEN_COMMENT>(*</TKG_OPEN_COMMENT>
    <TKG_CLOSE_COMMENT>*)</TKG_CLOSE_COMMENT>
    <TKG_IEC_LINE_COMMENT>//</TKG_IEC_LINE_COMMENT>
    <TKG_TRUE IsPattern="Yes">TRUE:[^\w\d]</TKG_TRUE>
    <TKG_FALSE IsPattern="Yes">FALSE:[^\w\d]</TKG_FALSE>
    <TKG_PRIM_TYPE IsPattern="Yes" />
    <TKG_OPEN_BRACKET>(</TKG_OPEN_BRACKET>
    <TKG_CLOSE_BRACKET>)</TKG_CLOSE_BRACKET>
    <TKG_OPEN_INDEXBRACKET>[</TKG_OPEN_INDEXBRACKET>
    <TKG_CLOSE_INDEXBRACKET>]</TKG_CLOSE_INDEXBRACKET>
    <TKG_COMMA>,</TKG_COMMA>
    <TKG_SUBRANGE>..</TKG_SUBRANGE>
    
    <TKG_IEC_BINARY_INTEGER IsPattern="Yes">2#_[01][01_]+|2#[01][01_]+|2#_[01]|2#[01]</TKG_IEC_BINARY_INTEGER>    
    <TKG_IEC_OCTAL_INTEGER IsPattern="Yes">8#_[0-7][0-7_]+|8#[0-7][0-7_]+|8#_[0-7]|8#[0-7]</TKG_IEC_OCTAL_INTEGER>
    <TKG_IEC_HEX_INTEGER IsPattern="Yes">16#_[\da-fA-F][\da-fA-F]+|16#[\da-fA-F][\da-fA-F_]+|16#_[\da-fA-F]|16#[\da-fA-F]</TKG_IEC_HEX_INTEGER>
    
      <!-- Use these two special patterns for real numbers in IEC. -->
    <TKG_REAL  IsPattern="Yes">\d[\d_]*\.[\d_]+[Ee][\+\-]\d[\d_]*|\d[\d_]*\.[\d_]+[Ee]\d[\d_]*|\d[\d_]*\.[\d_]+</TKG_REAL> 
    <TKG_REAL_EXP IsPattern="Yes">\d[\d_]*[Ee]\d[\d_]*|\d[\d_]*[Ee][\+\-]\d[\d_]*</TKG_REAL_EXP> 
    <TKG_INTEGER IsPattern="Yes">\d|\d[\d_]+</TKG_INTEGER>
    <TKG_DOT>.</TKG_DOT>
       
    <!-- Path synch exec blocks are named "DO_PATH_SYNCH" to avoid ambiguity with "VAR PATH_SYNCH" token -->
    <TKG_PATHSYNCH_REC_IEC IsPattern="Yes" EndRuleToken="Yes">DO_PATH_SYNCH:[^\w\d]</TKG_PATHSYNCH_REC_IEC>
    <TKG_PATHSYNCH_END    IsPattern="Yes" EndRuleToken="Yes">END_PATH_SYNCH:[^\w\d]</TKG_PATHSYNCH_END>
    <TKG_PATHSYNCH_IPEVAL IsPattern="Yes">IP_EVAL:[^\w\d]</TKG_PATHSYNCH_IPEVAL>

    <TKG_CYCLIC_PATHSYNCH_BLOCKING_IEC  IsPattern="Yes" EndRuleToken="Yes">CYCLIC_PS_BL:[^\w\d]</TKG_CYCLIC_PATHSYNCH_BLOCKING_IEC>
    <TKG_CYCLIC_PATHSYNCH_IEC IsPattern="Yes" EndRuleToken="Yes">CYCLIC_PS:[^\w\d]</TKG_CYCLIC_PATHSYNCH_IEC>
    <TKG_CYCLIC_BLOCKING_IEC IsPattern="Yes" EndRuleToken="Yes">CYCLIC_BL:[^\w\d]</TKG_CYCLIC_BLOCKING_IEC>
    <TKG_CYCLIC_IEC IsPattern="Yes" EndRuleToken="Yes">CYCLIC:[^\w\d]</TKG_CYCLIC_IEC>
    <TKG_CYCLIC_END_IEC IsPattern="Yes" EndRuleToken="Yes">END_CYCLIC:[^\w\d]</TKG_CYCLIC_END_IEC>

    <TKG_REFERENCE  FollowedBy="TKG_IEC_TO" IsPattern="Yes">REFERENCE:[^\w\d]</TKG_REFERENCE>
    <TKG_IEC_TO IsPattern="Yes">TO:[^\w\d]</TKG_IEC_TO>    
    <TKG_IEC_DO IsPattern="Yes" EndRuleToken="Yes">DO:[^\w\d]</TKG_IEC_DO>    

    <TKG_FOR_NOFINALDEC FileXLInvalid="Yes" IsPattern="Yes">FOR:[^\w\d]</TKG_FOR_NOFINALDEC>
    <TKG_FORSTEP FileXLInvalid="Yes" IsPattern="Yes">BY:[^\w\d]</TKG_FORSTEP>
    <TKG_ENDFOR FileXLInvalid="Yes" IsPattern="Yes" EndRuleToken="Yes">END_FOR:[^\w\d]</TKG_ENDFOR>
    
    <TKG_IF IsPattern="Yes">IF:[^\w\d]</TKG_IF>    
    <TKG_THEN IsPattern="Yes" EndRuleToken="Yes">THEN:[^\w\d]</TKG_THEN>
    <TKG_BLOCK_ELSEIF IsPattern="Yes">ELSIF:[^\w\d]</TKG_BLOCK_ELSEIF>
    <TKG_ELSE_AND_DEFAULT IsPattern="Yes" EndRuleToken="Yes">ELSE:[^\w\d]</TKG_ELSE_AND_DEFAULT>
    <TKG_BLOCK_ENDIF IsPattern="Yes" EndRuleToken="Yes">END_IF:[^\w\d]</TKG_BLOCK_ENDIF>
    
    <TKG_SWITCH IsPattern="Yes" FileXLInvalid="Yes">CASE:[^\w\d]</TKG_SWITCH>
    <TKG_ENDSWITCH_NOBREAK FileXLInvalid="Yes" IsPattern="Yes" EndRuleToken="Yes">END_CASE:[^\w\d]</TKG_ENDSWITCH_NOBREAK>
    
    <TKG_WHILE FileXLInvalid="Yes" IsPattern="Yes">WHILE:[^\w\d]</TKG_WHILE>
    <TKG_ENDWHILE FileXLInvalid="Yes" IsPattern="Yes" EndRuleToken="Yes">END_WHILE:[^\w\d]</TKG_ENDWHILE>

    <TKG_DO FileXLInvalid="Yes" IsPattern="Yes" EndRuleToken="Yes">REPEAT:[^\w\d]</TKG_DO>
    <TKG_ENDDO_UNTIL FileXLInvalid="Yes" IsPattern="Yes">UNTIL:[^\w\d]</TKG_ENDDO_UNTIL>
    <TKG_ENDDO_POSTCOND FileXLInvalid="Yes" IsPattern="Yes" EndRuleToken="Yes">END_REPEAT:[^\w\d]</TKG_ENDDO_POSTCOND>
    
    <TKG_BREAK FileXLInvalid="Yes" IsPattern="Yes">EXIT:[^\w\d]</TKG_BREAK>
    <TKG_RETURN FileXLInvalid="Yes" IsPattern="Yes">RETURN:[^\w\d]</TKG_RETURN>

    <TKG_IEC_SEL_FN FileXLInvalid="Yes" IsPattern="Yes">SEL:[^\w\d]</TKG_IEC_SEL_FN>
    <TKG_IEC_MUX_FN FileXLInvalid="Yes" IsPattern="Yes">MUX:[^\w\d]</TKG_IEC_MUX_FN>

    <TKG_TIME_LITERAL CaseSensitive="no" IsPattern="yes">time#\-[dDhHmMsS_\.\d]+|time#[dDhHmMsS_\.\d]+|t#\-[dDhHmMsS_\.\d]+|t#[dDhHmMsS_\.\d]+</TKG_TIME_LITERAL>
    <TKG_DATE_AND_TIME_LITERAL CaseSensitive="no" IsPattern="yes">DT#[12]\d\d\d\-[\d\:\-]*|DATE_AND_TIME#[12]\d\d\d\-[\d\:\-]*</TKG_DATE_AND_TIME_LITERAL>
    <TKG_DATE_LITERAL CaseSensitive="no" IsPattern="yes">D#[12]\d\d\d\-[\d\-]*|DATE#[12]\d\d\d\-[\d\-]*</TKG_DATE_LITERAL>
    <TKG_TIME_OF_DAY_LITERAL CaseSensitive="no" IsPattern="yes">TOD#\d[\d\:\.]*|TIME_OF_DAY#\d[\d\:\.]*</TKG_TIME_OF_DAY_LITERAL>
    
    <TKG_ASSIGN_EQ>:=</TKG_ASSIGN_EQ>    
    <TKG_OPEN_IP_EXTENSION>{</TKG_OPEN_IP_EXTENSION>
    <TKG_CLOSE_IP_EXTENSION>}</TKG_CLOSE_IP_EXTENSION>
    <TKG_IEC_OPEN_TYPE IsPattern="Yes">TYPE:[^\w\d]</TKG_IEC_OPEN_TYPE> 
    <TKG_IEC_CLOSE_TYPE IsPattern="Yes" EndRuleToken="Yes">END_TYPE:[^\w\d]</TKG_IEC_CLOSE_TYPE> 
    <TKG_VAR IsPattern="Yes">VAR:[^\w\d]</TKG_VAR>
    <TKG_VAR_GLOBAL IsPattern="Yes">VAR_GLOBAL:[^\w\d]</TKG_VAR_GLOBAL>
    <TKG_VAR_INPUT IsPattern="Yes">VAR_INPUT:[^\w\d]</TKG_VAR_INPUT>
    <TKG_VAR_OUTPUT IsPattern="Yes">VAR_OUTPUT:[^\w\d]</TKG_VAR_OUTPUT>
    <TKG_VAR_IN_OUT IsPattern="Yes">VAR_IN_OUT:[^\w\d]</TKG_VAR_IN_OUT>
    <TKG_VAR_END IsPattern="Yes" EndRuleToken="Yes">END_VAR:[^\w\d]</TKG_VAR_END>
    <TKG_VAR_RETAIN IsPattern="Yes">RETAIN:[^\d\w]</TKG_VAR_RETAIN>
    <TKG_IP_RETAIN IsPattern="Yes">IP_RETAIN:[^\d\w]</TKG_IP_RETAIN>
    <TKG_AT IsPattern="Yes">AT:[^\d\w]</TKG_AT>
    <TKG_PLC IsPattern="Yes">PLC:[^\d\w]</TKG_PLC>    
    <TKG_PV_UNDECL IsPattern="Yes">UNRETAIN_VAR:[^\d\w]</TKG_PV_UNDECL> <!-- Note: IP-ST extension to remove retained vars -->
    <TKG_VARSYNCH_IP IsPattern="Yes">IP_SYNCH:[^\d\w]</TKG_VARSYNCH_IP>
    <TKG_VARSYNCH_PATH IsPattern="Yes">PATH_SYNCH:[^\d\w]</TKG_VARSYNCH_PATH>    
    <TKG_CONSTANT IsPattern="Yes">CONSTANT:[^\d\w]</TKG_CONSTANT>
    <TKG_VARSCOPE_IP_GLOBAL IsPattern="Yes">IP_GLOBAL:[^\w\d]</TKG_VARSCOPE_IP_GLOBAL>
    <TKG_VARSCOPE_SHARED_IP_GLOBAL IsPattern="Yes">SHARED_IP_GLOBAL:[^\w\d]</TKG_VARSCOPE_SHARED_IP_GLOBAL>
    <TKG_VARSCOPE_NC_GLOBAL IsPattern="Yes">NC_GLOBAL:[^\w\d]</TKG_VARSCOPE_NC_GLOBAL>
    <TKG_VARSCOPE_PLC_GLOBAL IsPattern="Yes">PLC_GLOBAL:[^\w\d]</TKG_VARSCOPE_PLC_GLOBAL>
    <TKG_VARSCOPE_IP_LOCAL IsPattern="Yes">LOCAL:[^\w\d]</TKG_VARSCOPE_IP_LOCAL>
    <TKG_IEC_NAMESPACE_SPEC IsPattern="No">::</TKG_IEC_NAMESPACE_SPEC> 
    <TKG_IEC_DATATYPE_SPEC IsPattern="No">:</TKG_IEC_DATATYPE_SPEC> 
    <TKG_IEC_ARRAY IsPattern="Yes">ARRAY:[^\w\d]</TKG_IEC_ARRAY>
    <TKG_IEC_OF IsPattern="Yes">OF:[^\w\d]</TKG_IEC_OF>
    <TKG_IEC_DELIM EndRuleToken="Yes">;</TKG_IEC_DELIM>
    <TKG_IEC_OPEN_STRUCT IsPattern="Yes">STRUCT:[^\w\d]</TKG_IEC_OPEN_STRUCT>
    <TKG_IEC_CLOSE_STRUCT IsPattern="Yes">END_STRUCT:[^\w\d]</TKG_IEC_CLOSE_STRUCT>
    
    <TKG_BITWISE_LP_BINARY_AND IsPattern="Yes">AND:[^\w\d]</TKG_BITWISE_LP_BINARY_AND>
    <TKG_BITWISE_LP_BINARY_OR IsPattern="Yes">OR:[^\w\d]</TKG_BITWISE_LP_BINARY_OR>
    <TKG_BITWISE_LP_BINARY_XOR IsPattern="Yes">XOR:[^\w\d]</TKG_BITWISE_LP_BINARY_XOR>
    <TKG_BITWISE_UNARY_COMPLEMENT IsPattern="Yes">NOT:[^\w\d]</TKG_BITWISE_UNARY_COMPLEMENT>
    
    <TKG_COMP_EXACT_BINARY_GREATER_THAN_OR_EQ>&gt;=</TKG_COMP_EXACT_BINARY_GREATER_THAN_OR_EQ>
    <TKG_COMP_EXACT_BINARY_LESS_THAN_OR_EQ>&lt;=</TKG_COMP_EXACT_BINARY_LESS_THAN_OR_EQ>
    <TKG_COMP_EXACT_BINARY_EQUAL_TO>=</TKG_COMP_EXACT_BINARY_EQUAL_TO>
    <TKG_COMP_EXACT_BINARY_NOT_EQUAL_TO>&lt;&gt;</TKG_COMP_EXACT_BINARY_NOT_EQUAL_TO>
    <TKG_COMP_EXACT_BINARY_GREATER_THAN>&gt;</TKG_COMP_EXACT_BINARY_GREATER_THAN>
    <TKG_COMP_EXACT_BINARY_LESS_THAN>&lt;</TKG_COMP_EXACT_BINARY_LESS_THAN>

    <TKG_ARITH_BINARY_PLUS>+</TKG_ARITH_BINARY_PLUS>
    <TKG_ARITH_BINARY_MINUS>-</TKG_ARITH_BINARY_MINUS>
    <TKG_ARITH_BINARY_POWER>**</TKG_ARITH_BINARY_POWER>
    <TKG_ARITH_BINARY_MULTIPLY>*</TKG_ARITH_BINARY_MULTIPLY>
    <TKG_ARITH_BINARY_DIVIDE>/</TKG_ARITH_BINARY_DIVIDE>
    <TKG_ARITH_BINARY_MODULO IsPattern="Yes">MOD:[^\w\d]</TKG_ARITH_BINARY_MODULO>
    <TKG_PRAGMA IsPattern="Yes" FollowedBy="TKG_IDENTIFIER">#pragma:[^\w\d]</TKG_PRAGMA>
    <TKG_INCLUDE IsPattern="Yes">#include:[^\w\d]</TKG_INCLUDE>
    <TKG_PROG_START IsPattern="Yes" FollowedBy="TKG_PROG_NAME">PROGRAM:[^\w\d]</TKG_PROG_START>
    <TKG_PROG_NAME IsPattern="Yes" EndRuleToken="Yes">_INIT:[^\w\d]|_CYCLIC:[^\w\d]|_EXIT:[^\w\d]|_MAIN:[^\w\d]|_\d+:[^\w\d]</TKG_PROG_NAME>
    <TKG_PROG_END  IsPattern="Yes"  EndRuleToken="Yes">END_PROGRAM:[^\w\d]</TKG_PROG_END>
    <TKG_SUBPROG_START IsPattern="Yes">FUNCTION:[^\w\d]</TKG_SUBPROG_START>
    <TKG_SUBPROG_END IsPattern="Yes" EndRuleToken="Yes">END_FUNCTION:[^\w\d]</TKG_SUBPROG_END>
    <TKG_FUB_DECL IsPattern="Yes">FUNCTION_BLOCK:[^\w\d]</TKG_FUB_DECL>
    <TKG_FUB_END IsPattern="Yes" EndRuleToken="Yes">END_FUNCTION_BLOCK:[^\w\d]</TKG_FUB_END>
    <TKG_RETURN IsPattern="Yes">RETURN:[^\w\d]</TKG_RETURN>
    <TKG_ACCESS IsPattern="Yes">ACCESS:[^\w\d]</TKG_ACCESS>
    <TKG_DEREF_OP>^</TKG_DEREF_OP>
    <TKG_ACTION IsPattern="Yes">ACTION:[^\w\d]</TKG_ACTION>
    <TKG_ACTION_END IsPattern="Yes" EndRuleToken="Yes">END_ACTION:[^\w\d]</TKG_ACTION_END>
    <!-- Keep those low in the list. When nothing else matches give them a try. -->
    <TKG_IEC_TYPED_VALUE IsPattern="Yes">\w#:[\w\d\+\-]|\w[\w\d]+#:[\w\d\+\-]</TKG_IEC_TYPED_VALUE> 
    <TKG_PARAM_PREFIX IsPattern="Yes">$R:[^\w\d]|$P:[^\w\d]|$MW:[^\w\d]|$ML:[^\w\d]|$MF:[^\w\d]|$EXW:[^\w\d]|$EXL:[^\w\d]|$EXF:[^\w\d]|$EXB:[^\w\d]</TKG_PARAM_PREFIX>
    <TKG_IGNORED_IP_EXTENSION IsPattern="Yes">REDUND_CONTEXT|REDUND_UNREPLICABLE|REDUND_OK</TKG_IGNORED_IP_EXTENSION>
    <TKG_IDENTIFIER IsPattern="Yes">\w|\w[\w\d$]+|$[\w\d$]+</TKG_IDENTIFIER>
    <TKG_INIT_IDENTIFIER IsPattern="Yes" Disabled="Yes">\w|\w[\w\d$]+|$[\w\d$]+</TKG_INIT_IDENTIFIER>    
  </ParserData>
  <StringChars
      AsciiMultilineStringStart="&apos;&apos;&apos;"
      AsciiStringStart="&apos;" AsciiStringEnd="&apos;"
      UTF16StringStart="&quot;" UTF16StringEnd="&quot;" >
    <!-- case sensitive language needs explicit upper and lower case versions -->
    <EscapeSeq Search="$N" CaseSensitive="Yes" ReplaceValue="10" />
    <EscapeSeq Search="$n" CaseSensitive="Yes" ReplaceValue="10" />
    <EscapeSeq Search="$L" CaseSensitive="Yes" ReplaceValue="10" />
    <EscapeSeq Search="$l" CaseSensitive="Yes" ReplaceValue="10" />
    <EscapeSeq Search="$P" CaseSensitive="Yes" ReplaceValue="12" />
    <EscapeSeq Search="$p" CaseSensitive="Yes" ReplaceValue="12" />
    <EscapeSeq Search="$R" CaseSensitive="Yes" ReplaceValue="13" />
    <EscapeSeq Search="$r" CaseSensitive="Yes" ReplaceValue="13" />
    <EscapeSeq Search="$T" CaseSensitive="Yes" ReplaceValue="9" />
    <EscapeSeq Search="$t" CaseSensitive="Yes" ReplaceValue="9" />
    <EscapeSeq Search="$&apos;" CaseSensitive="Yes" ReplaceStr="&apos;" />
    <EscapeSeq Search="$&quot;" CaseSensitive="Yes" ReplaceStr="&quot;" />    
    <EscapeSeq Search="$[\dA-Fa-f]+" IsPattern="Yes" CaseSensitive="Yes" ReplaceEncodingBase="16"/>
    <EscapeSeq Search="$$" ReplaceStr="$"/>
    <EscapeSeq Search="$" ReplaceStr=""/>
  </StringChars>
</Root>
