<?xml version="1.0" encoding="utf-8"?>
<?ARNC0 Version="5.12.2"?>
<Root LangModule="ailgcode" Version="1.0">
  <PrimTypes CaseSensitive="No" >
    <!-- Specify what B&R datatypes correspond to the user-language defined types -->
    <!-- If the user declares a variable in their program, and the corresponding PV is
         of a different type, then a warning is issued -->
    <REAL BRType="LREAL" />
    <INT  BRType="DINT" />
    <CHAR BRType="USINT" />
    <BOOL BRType="BOOL" />
    <STRING BRType="STRING" />
    <AXIS BRType="AXIS" />
    <!-- Support for specifying B&R specific types -->
    <BR_LREAL BRType="LREAL" />
    <BR_REAL  BRType="REAL" />
    <BR_UDINT BRType="UDINT" />
    <BR_DINT  BRType="DINT" />
    <BR_UINT  BRType="UINT" />
    <BR_INT   BRType="INT" />
    <BR_USINT BRType="USINT" />
    <BR_SINT  BRType="SINT" />
    <BR_BOOL  BRType="BOOL" />
    <BR_TIME  BRType="TIME" />
    <BR_DATE_AND_TIME BRType="DATE_AND_TIME" />
    <!-- For extended IEC type support
      <WSTRING BRType="WSTRING" />
    -->
  </PrimTypes>
  <Preprocess>
    <!-- Support for AltLang1 system-global (NCK), and interpreter-global (CHAN) variable scope specifiers -->
    <PP_RULE_NCK Search="NCK " Replace="nc_global " />
    <PP_RULE_CHAN Search="CHAN " Replace="ip_global " />
    <PP_RULE_FRAME_I Search="$FRAME_I" Replace="(1,0,0,0,1,0,0,0,1,0,0,0)"/>
    <PP_RULE_FRAME_DEF IsPattern="Yes" Search="FRAME:[^\w\d]" Replace="REAL[12]"/>
  </Preprocess>
  <BuiltInProcs>
    <cancel MinArgs="1" MaxArgs="*">
      beginpathsynch
        StopCyclicGroups(:${*}:);
      endpathsynch
    </cancel>
    <RET MinArgs="0" MaxArgs="4" Eval="Early" Inline="Yes">
      <!-- ReturnTo(: dest_string, num_lines_after_dest, num_return_levels, return_to_start :) ... all args are optional -->
      <!-- Send M17 and return -->
      #next_motion.Command = MPCMD_SET_M_FCT;
      #next_motion.Data.I4_value = 17;
      PushPacket(::);
      ReturnTo(:${*}:); 
    </RET>
  </BuiltInProcs> 
  <BuiltInFns>
    <ABS   NumArgs="1" Inline="Yes">Abs(:$[1]:)</ABS>
    <SIN   NumArgs="1" Inline="Yes">Sin(:$[1]:)</SIN>
    <COS   NumArgs="1" Inline="Yes">Cos(:$[1]:)</COS>
    <TAN   NumArgs="1" Inline="Yes">Tan(:$[1]:)</TAN>
    <ASIN  NumArgs="1" Inline="Yes">ASin(:$[1]:)</ASIN>
    <ACOS  NumArgs="1" Inline="Yes">ACos(:$[1]:)</ACOS>
    <ATAN  NumArgs="1" Inline="Yes">ATan(:$[1]:)</ATAN>
    <ATAN2 NumArgs="2" Inline="Yes">ATan2(:$[1],$[2]:)</ATAN2>
    <SQRT  NumArgs="1" Inline="Yes">Sqrt(:$[1]:)</SQRT>
    <POT   NumArgs="1" Inline="Yes">(($[1])*($[1]))</POT>
    <TRUNC NumArgs="1" Inline="Yes">Fix(:$[1]:)</TRUNC>
    <ROUND NumArgs="1" Inline="Yes">Round(:$[1]:)</ROUND>
    <LN    NumArgs="1" Inline="Yes">Ln(:$[1]:)</LN>
    <EXP   NumArgs="1" Inline="Yes">Exp(:$[1]:)</EXP>
    <MINVAL   NumArgs="2" Inline="Yes">MinVal(:$[1], $[2]:)</MINVAL>
    <MAXVAL   NumArgs="2" Inline="Yes">MaxVal(:$[1], $[2]:)</MAXVAL>
    <BOUND    NumArgs="3" Inline="Yes">Bounds(:$[1], $[2], $[3]:)</BOUND>
    <!-- Type conversion functions -->
    <TO_BOOL  NumArgs="1" Inline="Yes">ToBool(:$[1]:)</TO_BOOL>
    <TO_INT   NumArgs="1" Inline="Yes">ToInt(:$[1]:)</TO_INT>
    <TO_CHAR  NumArgs="1" Inline="Yes">ToChar(:$[1]:)</TO_CHAR>
    <TO_REAL  NumArgs="1" Inline="Yes">ToLReal(:$[1]:)</TO_REAL>
    <TO_FLOAT NumArgs="1" Inline="Yes">ToFloat(:$[1]:)</TO_FLOAT>
    <DEFINED  NumArgs="1" Inline="Yes">Defined(:$[1]:)</DEFINED>
    <!-- compare against undef value -->
    <TIME_MS  NumArgs="0">TimeMs(::)</TIME_MS>
    <!-- Array functions now mixed in with regular functions -->
    <!-- SET: just return the arg list as passed in and allow the assign instruction to assign the values to the array -->
    <SET MinArgs="0" MaxArgs="*" Inline="Yes">${*}</SET>
    <REP MinArgs="1" MaxArgs="2" Inline="Yes">ArrayRep(:${*}:)</REP>
    <!-- Adr, Sizeof etc. -->
    <ADR NumArgs="1" Inline="Yes">Adr(:\$[1]:)</ADR>
    <SIZEOF NumArgs="1" Inline="Yes">Sizeof(:\$[1]:)</SIZEOF>            
    <!-- system information functions -->
    <NUM_LOADED_FILES NumArgs="0">NumLoadedFiles(::)</NUM_LOADED_FILES>
    <NUM_LOADED_PROG_FILES NumArgs="0">NumLoadedProgFiles(::)</NUM_LOADED_PROG_FILES>
    <MEM_SIZE_IP_ALL NumArgs="0">MemSizeIpInstAll(::)</MEM_SIZE_IP_ALL>
    <MEM_SIZE_IP_LIB NumArgs="0">MemSizeIpInst(::)</MEM_SIZE_IP_LIB>
    <MEM_SIZE_SHLIB NumArgs="0">MemSizeShLib(::)</MEM_SIZE_SHLIB>
    <MEM_SIZE_FILE MinArgs="0" MaxArgs="1">MemSizeFile(:$[1]:)</MEM_SIZE_FILE>
    <MEM_SIZE_IP_STACK_SPACE NumArgs="0">MemStackSpace(::)</MEM_SIZE_IP_STACK_SPACE>
  </BuiltInFns>
  <AxesSpec>
    <!-- additional axis name patterns -->
    <AxisRef Mode="3">$\s*=\s*AC</AxisRef>
    <AxisRef Mode="4">$\s*=\s*IC</AxisRef>
  </AxesSpec>
  <PVMacros> <!-- Syntax that looks like PV refs, but is actually mapped to a defined bit of AIL -->
    <!-- Subprogram attributes "PROC myproc( ... ) SAVE SBLOF" etc, but also valid in N blocks -->
    <SBLOF ArrayDims="0" Group="500" >
      <CALL Inline="Yes">
        #call->forbid_stepping = 1;
      </CALL>
    </SBLOF>
    <SBLON ArrayDims="0" Group="500" >
      <CALL Inline="Yes">
        #call->forbid_stepping = 0;
      </CALL>
    </SBLON>
    <DISPLOF ArrayDims="0" Group="500" >
      <CALL Inline="Yes">
        #call->forbid_display = 1;
      </CALL>
    </DISPLOF>
    <DISPLON ArrayDims="0" Group="500" >
      <CALL Inline="Yes">
        #call->forbid_display = 0;
      </CALL>
    </DISPLON>
    <RDISABLE ArrayDims="0" Group="500" >
      <CALL Inline="Yes">
        @#job->sa.keep_alive = 1;
        @#thread.sa_keep_alive = 1;
      </CALL>
    </RDISABLE>
    <P_SUBPAR Name="$P_SUBPAR" ArrayDims="1" Group="500" >
      <!-- $P_SUBPAR[1] means: is the first subproc argument defined?: TRUE/FALSE -->
      <GET>
        return ArgNumIsDefined(:$[1]:);
      </GET>
    </P_SUBPAR>
    <P_STACK Name="$P_STACK">
      <GET>
        return UserCallDepth(::);
      </GET>
    </P_STACK>
  </PVMacros>
  <FubTemplates>
      <StdFubTemplate IsDefault="Yes" Inline="Yes" >
        <!-- a precompiled FubTemplate instance is created for each defined FubType from the ICF file
              o AIL code snippets (e.g. conditions) are text-substituted from the ICF content
                before precompilation occurs
          * This template function is called once for each FUB call in the user program
             o The template starts the cyclic execution of the fub
             o if the fub is configured as blocking, then the block is done in this template
        -->
        <Arg ref="FUBINST" DataType="FLOAT" /> <!-- VAR -->
        <Arg ref="FUBERRLEV" DataType="FLOAT" />
        <Arg ref="PATHSYNCH" DataType="FLOAT" />
        <Arg ref="BLOCKING"  DataType="FLOAT" />
        <!-- string substitution from the ICF FUB entry is done on the following vars:
           ${ERRORCOND} ${BUSYCOND} ${FN} ${REPORT_ERROR}

          For path synchronous FUB calls we use "beginpathsynch" which is different to "recordpathsynch"
            beginpathsynch : saves the stack (with the args to this template fn.) without recording the path-data
            recordpathsynch : records a new instruction stream with ip-synch vars replaced by their value
         -->
        #job->error_level = ${FUBERRLEV};
        #job->enable = 1;
        #job->group_id = -2;
        #job->is_fub = 1;
        if (${BLOCKING})
          #job->mp_command = MPCMD_PATH_SYNC_EXEC_WAIT;
          #job->is_blocking = 1;
        endif
        if (${PATHSYNCH})
          beginpathsynch
        endif
        begincyclic
          ${FN}(:${FUBINST}:);
          if (${ERRORCOND})
            #job->eval_status = ERR_FUB_ERROR;
            ${REPORT_ERROR};
            #job->terminate = 1;
          elif (${BUSYCOND})
            #job->eval_status = ERR_FUB_BUSY;
          else
            #job->eval_status = ERR_OK;
            #job->terminate = 1;
          endif
       endcyclic
       if (${BLOCKING})
         WaitForCyclicJob(:#last_job_id:);
       endif
       endpathsynch
    </StdFubTemplate>
  </FubTemplates>
  <SynchActions>
    <SABlocks>
      <!-- synch action code templates...
           * Prepare a path-synch evaluation packet to:
              (a) define the cyclic behaviour of this SA
                   o Content of "cyclic ... endcyclic" block
              (b) if modal group specified, activate the SA immediately
                   o Set the cyclic.enable flag before the cyclic block start instr.
      -->
      <default IsDefault="Yes"> <!-- default SA is used when no temporal condition specified -->
        <cyclic Inline="Yes"> <!-- essential to call INLINE as any ip-synch vars in the ACTIONS must be resolved to values -->
          <Arg ref="ACTIONS" DataType="STATEMENTS" />
          <Arg ref="ID" DataType="FLOAT" DefaultInt="-1" MinCount="0" MaxCount="1" />
        #job->is_sa = 1;
        #job->group_id = ${ID};
        #job->is_blocking = 1;
        if (#job->group_id &gt;= 0)
          #job->enable = 1;
        else
          #mplist.trigger_nmsa = 1;
          #mplist.delay_trigger_nmsa = 1;
        endif
        recordpathsynch
          if (#job->group_id &gt;= 0)
            StopCyclicGroups(:(:#job->group_id:):);
          endif
          begincyclic
            ${ACTIONS}
          endcyclic
        endpathsynch
        </cyclic>
      </default>
      <whenever>
        <cyclic Inline="Yes">
          <Arg ref="COND" DataType="FLOAT" />
          <Arg ref="ACTIONS" DataType="STATEMENTS" />
          <Arg ref="ID" DataType="FLOAT" DefaultInt="-1" MinCount="0" MaxCount="1" />
        #job->is_sa = 1;
        #job->group_id = ${ID};
        #job->is_blocking = 1;
        if (#job->group_id &gt;= 0)
          #job->enable = 1;
        else
          #mplist.trigger_nmsa = 1;
          #mplist.delay_trigger_nmsa = 1;
        endif
        recordpathsynch
          if (#job->group_id &gt;= 0)
            StopCyclicGroups(:(:#job->group_id:):);
          endif
          begincyclic
            @#job->sa.cond = ${COND};
            if (@#job->sa.cond)
              ${ACTIONS}
            endif
          endcyclic
        endpathsynch
        </cyclic>
      </whenever>
      <when>
        <cyclic Inline="Yes">
          <Arg ref="COND" DataType="FLOAT" />
          <Arg ref="ACTIONS" DataType="STATEMENTS" />
          <Arg ref="ID" DataType="FLOAT" DefaultInt="-1" MinCount="0" MaxCount="1" />
        #job->is_sa = 1;
        #job->group_id = ${ID};
        #job->is_blocking = 1;
        if (#job->group_id &gt;= 0)
          #job->enable = 1;
        else
          #mplist.trigger_nmsa = 1;
          #mplist.delay_trigger_nmsa = 1;
        endif
        recordpathsynch
          if (#job->group_id &gt;= 0)
            StopCyclicGroups(:(:#job->group_id:):);
          endif
          begincyclic
            @#job->sa.cond = ${COND};
            if (@#job->sa.cond)
              ${ACTIONS}
              @#job->terminate = 1;
            endif
          endcyclic
        endpathsynch
        </cyclic>
      </when>
      <every>
        <cyclic Inline="Yes">
          <Arg ref="COND" DataType="FLOAT" />
          <Arg ref="ACTIONS" DataType="STATEMENTS" />
          <Arg ref="ID" DataType="FLOAT" DefaultInt="-1" MinCount="0" MaxCount="1" />
        #job->is_sa = 1;
        #job->group_id = ${ID};
        #job->is_blocking = 1;
        if (#job->group_id &gt;= 0)
          #job->enable = 1;
        else
          #mplist.trigger_nmsa = 1;
          #mplist.delay_trigger_nmsa = 1;
        endif
        recordpathsynch
          if (#job->group_id &gt;= 0)
            StopCyclicGroups(:(:#job->group_id:):);
          endif
          begincyclic
            @#job->sa.cond_prev = @#job->sa.cond;
            @#job->sa.cond = ${COND};
            if (!@#job->sa.cond_prev &amp;&amp; @#job->sa.cond)
              ${ACTIONS}
            endif
          endcyclic
        endpathsynch
        </cyclic>
      </every>
      <from>
        <cyclic Inline="Yes">
          <Arg ref="COND" DataType="FLOAT" />
          <Arg ref="ACTIONS" DataType="STATEMENTS" />
          <Arg ref="ID" DataType="FLOAT" DefaultInt="-1" MinCount="0" MaxCount="1" />
        #job->is_sa = 1;
        #job->group_id = ${ID};
        #job->is_blocking = 1;
        if (#job->group_id &gt;= 0)
          #job->enable = 1;
        else
          #mplist.trigger_nmsa = 1;
          #mplist.delay_trigger_nmsa = 1;
        endif
        recordpathsynch
          if (#job->group_id &gt;= 0)
            StopCyclicGroups(:(:#job->group_id:):);
          endif
          begincyclic
            @#job->sa.cond = @#job->sa.cond || ${COND};
            if (@#job->sa.cond)
              ${ACTIONS}
            endif
          endcyclic
        endpathsynch
        </cyclic>
      </from>
    </SABlocks>
    <NonModalActivation>
      <!-- Start & Stop commands are executed path synchronous immediately before and after a triggering block
         (a triggering block is the first MPList that is dispatched with the following vars set:
           #thread.trigger_nmsa = 1;
           #thread.delay_nmsa_trigger = 0;

          Note: modal SA usage does not use these commands (start is automatic and they run until explicitly stopped)
      -->
      <Start>
        @#thread.sa_last_keep_alive = 1;
        ActivateCyclicGroup(:-1:);
      </Start>
      <!-- TryStop... will stop the cyclic jobs unless they have set keep_alive in last complete eval cycle -->
      <Stop>
        WaitStopCyclicGroups(:(:-1:):);
      </Stop>
    </NonModalActivation>
  </SynchActions>
  <ParserData NestedComments="Yes" DefaultCaseSensitive="No" CommentsSpanLines="No"
     SubDeclsLocalToFile="Yes" ProgDeclsLocalToFile="Yes" AllowUnprefixedFileCalls="Yes" AllowUnprefixedSubCalls="Yes"
     LocalVarScopeForMainProg="No" FileScopeVarsVisibleInSub="Yes" MainPrgReturnAtNextMainPrgHdr="Yes"
     AllowVarReadBeforeAssign="No" AllowArrayRefWithoutIndex="Yes"
     AllowNamedFnArgs="Yes" AllowBuiltinFnArgsOutOfSequence="Yes"
     AllowBuiltInProcCallWithoutBrackets="Yes" AllowBuiltInFnCallWithoutBrackets="No" AllowPLCFnCallWithoutBrackets="No"
     AllowStructMemberAutoDereference="Yes" AllowVariableAutoDereference="Yes"
     EnableStringCharacterIndexing="Yes" AllowIgnoredExtraSubArgs="Yes"
     OnMacroRedefinition="Error" CheckFileTimestampBeforeCalls="Yes"     
     >
     <!-- For local type decls: ReadWholeFileBeforeParsing="Yes" FinalizeDeclaredTypes="Yes" DefaultTypeDeclScope="IP_LOCAL" -->
    <!--Patterns are specified as Perl regular expressions-->
    <!--Token Names should not be changed-->
    <!--Tokens without a Pattern or without TOKEN entry are not in use in this dialect-->
    <!--Restricted means this token can only match on a FollowedBy request-->
    <TKG_END_OF_LINE IsPattern="No">\n</TKG_END_OF_LINE>
    <TKG_LINE_CONTINUE IsPattern="No" FileXLInvalid="Yes">\</TKG_LINE_CONTINUE>
    <TKG_LINE_BREAK>@@</TKG_LINE_BREAK>
    <TKG_OPEN_COMMENT>;</TKG_OPEN_COMMENT>
    <TKG_CLOSE_COMMENT />
    <TKG_TRUE IsPattern="Yes">TRUE:\W</TKG_TRUE>
    <TKG_FALSE IsPattern="Yes">FALSE:\W</TKG_FALSE>
    <TKG_PAREVAL_MODAL_ID FileXLInvalid="Yes" IsPattern="Yes">ID:[\s=]</TKG_PAREVAL_MODAL_ID>
    <TKG_MACRO_DEFINE_GLOBAL IsPattern="Yes" FollowedBy="TKG_MACRO_NAME">define\s+ip_global:\s</TKG_MACRO_DEFINE_GLOBAL>
    <TKG_MACRO_DEFINE IsPattern="Yes" FollowedBy="TKG_MACRO_NAME">define\s+local:\s|define:\s</TKG_MACRO_DEFINE>
    <TKG_MACRO_UNDEFINE IsPattern="Yes" FollowedBy="TKG_MACRO_NAME">undefine:\s</TKG_MACRO_UNDEFINE>
    <TKG_MACRO_AS IsPattern="Yes" FollowedBy="TKG_MACRO_TEXT">as:[\s\n]</TKG_MACRO_AS>
    <TKG_PROG_START IsPattern="Yes" CaseSensitive="Yes" FollowedBy="TKG_PROG_NAME">%:[^L]</TKG_PROG_START>
    <TKG_PROG_NAME IsPattern="Yes" Restricted="Yes">[\w\d]+</TKG_PROG_NAME>
    <TKG_SET_MODAL_SUB FileXLInvalid="Yes" IsPattern="Yes">MCALL:\W</TKG_SET_MODAL_SUB>
    <TKG_INDIR_PROG_CALL IsPattern="Yes">CALL:\s</TKG_INDIR_PROG_CALL>
    <TKG_INDIR_PROG_BLOCK FileXLInvalid="Yes" IsPattern="Yes">BLOCK:\s</TKG_INDIR_PROG_BLOCK>
    <TKG_PROC_START FileXLInvalid="Yes" IsPattern="Yes" FollowedBy="TKG_PROC_NAME">PROC:\s</TKG_PROC_START>
    <TKG_PROC_NAME IsPattern="Yes" Restricted="Yes">\w[\w\d]+</TKG_PROC_NAME>
    <TKG_ARG_PASSBYREF IsPattern="Yes">VAR:\s</TKG_ARG_PASSBYREF>
    <!-- NCIP 04m new definitions -->
    <TKG_SUBPROG_PROTO IsPattern="Yes" FollowedBy="TKG_SUBPROG_NAME">INTERN:\s</TKG_SUBPROG_PROTO>
    <TKG_SUBPROG_START FileXLInvalid="Yes" IsPattern="Yes" CaseSensitive="Yes" FollowedBy="TKG_SUBPROG_NAME">SUB\s|%:L</TKG_SUBPROG_START>
    <TKG_SUBPROG_NAME IsPattern="Yes" Restricted="Yes">\w[\w\d]+</TKG_SUBPROG_NAME>
    <!-- END 04m new definitions -->
    <!-- subprog calls done without prefix -->
    <TKG_EXTERN IsPattern="Yes" FollowedBy="TKG_PROG_FILE_NAME">EXTERN:\s</TKG_EXTERN>
    <TKG_PROG_FILE_NAME IsPattern="Yes" Restricted="Yes">[\^#&amp;@']?[\w\d\./\:]+</TKG_PROG_FILE_NAME>
    <!-- AltLang1 subprog/main-prog calls are done without prefix -->
    <TKG_PV_DECL IsPattern="Yes">def:\s</TKG_PV_DECL>
    <TKG_PV_UNDECL IsPattern="Yes">~def:\s</TKG_PV_UNDECL>
    <TKG_VAR_RETAIN IsPattern="Yes">retain:\s</TKG_VAR_RETAIN>
    <TKG_VARSCOPE_IP_LOCAL IsPattern="Yes">local:[\s\n]</TKG_VARSCOPE_IP_LOCAL>
    <TKG_VARSCOPE_IP_GLOBAL IsPattern="Yes">ip_global:[\s\n]</TKG_VARSCOPE_IP_GLOBAL>
    <TKG_VARSCOPE_NC_GLOBAL IsPattern="Yes">nc_global:[\s\n]</TKG_VARSCOPE_NC_GLOBAL>
    <TKG_VARSCOPE_PLC_GLOBAL IsPattern="Yes">plc_global:[\s\n]</TKG_VARSCOPE_PLC_GLOBAL>
    <TKG_VARSYNCH_IP IsPattern="Yes">ip_synch:\s</TKG_VARSYNCH_IP>
    <TKG_VARSYNCH_PATH IsPattern="Yes">path_synch:\s</TKG_VARSYNCH_PATH>
    <TKG_PAREVAL_DO FileXLInvalid="Yes" IsPattern="Yes">do:\s</TKG_PAREVAL_DO>
    <TKG_GOTOF FileXLInvalid="Yes" IsPattern="Yes" OptFollowedBy="TKG_GOTO_DEST">gotof:\s</TKG_GOTOF>
    <TKG_GOTOB FileXLInvalid="Yes" IsPattern="Yes" OptFollowedBy="TKG_GOTO_DEST">gotob:\s</TKG_GOTOB>
    <TKG_GOTO FileXLInvalid="Yes" IsPattern="Yes" OptFollowedBy="TKG_GOTO_DEST">goto:\s</TKG_GOTO>
    <TKG_GOTO_DEST IsPattern="Yes" Restricted="Yes">\w[\w\d]*</TKG_GOTO_DEST>
      <!-- can only use * quantifier in TKG_GOTO_DEST because of Restricted="Yes" -->
    <TKG_ARITH_BINARY_INT_DIVIDE IsPattern="Yes">DIV:[\s(]</TKG_ARITH_BINARY_INT_DIVIDE>
    <TKG_ARITH_BINARY_MODULO IsPattern="Yes">MOD:[\s(]</TKG_ARITH_BINARY_MODULO>
    <TKG_FOR FileXLInvalid="Yes" IsPattern="Yes">FOR:\s</TKG_FOR>
    <TKG_ENDFOR FileXLInvalid="Yes" IsPattern="Yes">ENDFOR:[\s\n]</TKG_ENDFOR>
    <TKG_FORTO IsPattern="Yes">TO:\W</TKG_FORTO>
    <TKG_DO FileXLInvalid="Yes" IsPattern="Yes">repeat:[\s\n]</TKG_DO>
    <TKG_ENDDO_UNTIL FileXLInvalid="Yes" IsPattern="Yes">until:[\s(]</TKG_ENDDO_UNTIL>
    <TKG_LOGICAL_UNARY_NOT IsPattern="Yes">not:\W</TKG_LOGICAL_UNARY_NOT>
    <TKG_SUPPRESS_SINGLE_STEP>NOHALT</TKG_SUPPRESS_SINGLE_STEP>
    <TKG_NC_BLOCK_PREFIX IsPattern="Yes">N:[\s\d]</TKG_NC_BLOCK_PREFIX>
    <!-- AltLang1 uses special logical operators with higher precedence (_HP_) than comparison operators -->
    <TKG_LOGICAL_HP_BINARY_AND IsPattern="Yes">and:\W</TKG_LOGICAL_HP_BINARY_AND>
    <TKG_LOGICAL_HP_BINARY_OR IsPattern="Yes">or:\W</TKG_LOGICAL_HP_BINARY_OR>
    <TKG_LOGICAL_HP_BINARY_XOR IsPattern="Yes">xor:\W</TKG_LOGICAL_HP_BINARY_XOR>
    <TKG_BITWISE_BINARY_AND IsPattern="Yes">b_and:\W</TKG_BITWISE_BINARY_AND>
    <TKG_BITWISE_BINARY_OR IsPattern="Yes">b_or:\W</TKG_BITWISE_BINARY_OR>
    <TKG_BITWISE_BINARY_XOR IsPattern="Yes">b_xor:\W</TKG_BITWISE_BINARY_XOR>
    <TKG_BITWISE_UNARY_COMPLEMENT IsPattern="Yes">b_not:\W</TKG_BITWISE_UNARY_COMPLEMENT>
    <TKG_PATHSYNCH_REC_IEC FileXLInvalid="Yes" IsPattern="Yes">do_path_synch:\W</TKG_PATHSYNCH_REC_IEC>
    <TKG_PATHSYNCH_END FileXLInvalid="Yes" IsPattern="Yes">end_path_synch:\W</TKG_PATHSYNCH_END>
    <TKG_PATHSYNCH_IPEVAL FileXLInvalid="Yes" IsPattern="Yes">ip_eval:\W</TKG_PATHSYNCH_IPEVAL>
    <TKG_IF FileXLInvalid="Yes" IsPattern="Yes">if:\W</TKG_IF>
    <TKG_THEN FileXLInvalid="Yes" IsPattern="Yes">then:\W</TKG_THEN>
    <TKG_BLOCK_ELSE FileXLInvalid="Yes" IsPattern="Yes">else:\W</TKG_BLOCK_ELSE>
    <TKG_BLOCK_ENDIF FileXLInvalid="Yes" IsPattern="Yes">endif:\W</TKG_BLOCK_ENDIF>
    <TKG_SWITCH FileXLInvalid="Yes" IsPattern="Yes">case:\W</TKG_SWITCH>
    <TKG_SWITCH_OF FileXLInvalid="Yes" IsPattern="Yes">of:\W</TKG_SWITCH_OF>
    <TKG_SWITCH_DEFAULT FileXLInvalid="Yes" IsPattern="Yes">default:\W</TKG_SWITCH_DEFAULT>   
    <TKG_WHILE FileXLInvalid="Yes" IsPattern="Yes">while:\W</TKG_WHILE>
    <TKG_ENDWHILE FileXLInvalid="Yes">endwhile</TKG_ENDWHILE>
    <TKG_FOREVER FileXLInvalid="Yes" IsPattern="Yes">loop:\W</TKG_FOREVER>
    <TKG_ENDFOREVER FileXLInvalid="Yes" IsPattern="Yes">endloop:\W</TKG_ENDFOREVER>
    <TKG_LABEL_DEF IsPattern="Yes" FollowedBy="TKG_LABEL_SUFFIX">\w:\:|\w[\w\d]+:\:</TKG_LABEL_DEF>
    <TKG_LABEL_SUFFIX Restricted="Yes">:</TKG_LABEL_SUFFIX>
    <TKG_MACRO_TEXT Restricted="Yes" IsPattern="Yes">.</TKG_MACRO_TEXT>
    <TKG_MACRO_NAME Restricted="Yes" IsPattern="Yes">[$\w][$\w\d(]+</TKG_MACRO_NAME>
    <TKG_PRIM_TYPE IsPattern="Yes" /> <!-- FollowedBy="TKG_PV_DECL_REF" real:\s|int:\s|bool:\s|char:\s|axis:\s|frame:\s|br_udint:\s|br_dint:\s|br_uint:\s|br_int:\s|br_usint:\s|br_sint:\s|br_real:\s|br_lreal:\s|br_bool:\s|br_time:\s|br_date_and_time:\s</TKG_PRIM_TYPE> -->
    <TKG_OPEN_BRACKET>(</TKG_OPEN_BRACKET>
    <TKG_CLOSE_BRACKET>)</TKG_CLOSE_BRACKET>
    <TKG_OPEN_INDEXBRACKET>[</TKG_OPEN_INDEXBRACKET>
    <TKG_CLOSE_INDEXBRACKET>]</TKG_CLOSE_INDEXBRACKET>
    <TKG_COMMA>,</TKG_COMMA>
    <TKG_DOT IsPattern="Yes" FollowedBy="TKG_STRUCT_MEMBER_REF">\.:\w</TKG_DOT>
    <TKG_STRUCT_MEMBER_REF IsPattern="Yes" Restricted="Yes">\w|\w[\w\d]+</TKG_STRUCT_MEMBER_REF>
    <TKG_PARAM_PREFIX IsPattern="Yes">R:[\[\d]|$[RP]:[\[\d]|M[WLF]:[\[\d]|EX[WLBF]:[\[\d]</TKG_PARAM_PREFIX>
    <TKG_SUBRANGE>..</TKG_SUBRANGE>
    <TKG_NUMBER IsPattern="Yes">\d+\.\d+|\d+\.:[^\.]</TKG_NUMBER>
    <TKG_INTEGER IsPattern="Yes">\d+</TKG_INTEGER>
    <TKG_FRACTION IsPattern="Yes">\.\d+</TKG_FRACTION>
    <TKG_NUMBER_EXP IsPattern="Yes">EX:[\s\d\+\-\.]</TKG_NUMBER_EXP>
    <TKG_STRING_CONCAT>&lt;&lt;</TKG_STRING_CONCAT>
    <TKG_COMP_BINARY_GREATER_THAN_OR_EQ>&gt;=</TKG_COMP_BINARY_GREATER_THAN_OR_EQ>
    <TKG_COMP_BINARY_LESS_THAN_OR_EQ>&lt;=</TKG_COMP_BINARY_LESS_THAN_OR_EQ>
    <TKG_COMP_BINARY_EQUAL_TO>==</TKG_COMP_BINARY_EQUAL_TO>
    <TKG_COMP_BINARY_NOT_EQUAL_TO>&lt;&gt;</TKG_COMP_BINARY_NOT_EQUAL_TO>
    <TKG_COMP_BINARY_GREATER_THAN>&gt;</TKG_COMP_BINARY_GREATER_THAN>
    <TKG_COMP_BINARY_LESS_THAN>&lt;</TKG_COMP_BINARY_LESS_THAN>
    <TKG_ASSIGN_INCR IsPattern="Yes">=ic:(</TKG_ASSIGN_INCR>
    <TKG_ASSIGN_EQ>=</TKG_ASSIGN_EQ>
    <TKG_ARITH_BINARY_PLUS>+</TKG_ARITH_BINARY_PLUS>
    <TKG_ARITH_BINARY_MINUS>-</TKG_ARITH_BINARY_MINUS>
    <TKG_ARITH_BINARY_MULTIPLY>*</TKG_ARITH_BINARY_MULTIPLY>
    <TKG_ARITH_BINARY_DIVIDE>/</TKG_ARITH_BINARY_DIVIDE>
    <TKG_SUBCALL_REPEAT_PREFIX IsPattern="Yes" FollowedBy="TKG_INTEGER">P:[\s\d]</TKG_SUBCALL_REPEAT_PREFIX>
    <TKG_PV_DECL_REF IsPattern="Yes" Restricted="Yes">\w[\w\d\.\:\*]*</TKG_PV_DECL_REF>
    <TKG_G_CODE_PREFIX IsPattern="Yes">G:[\s\d]</TKG_G_CODE_PREFIX>
    <TKG_M_CODE_PREFIX IsPattern="Yes">M:[\s\d(]</TKG_M_CODE_PREFIX>
    <TKG_FUB_DECL IsPattern="Yes">fub\s</TKG_FUB_DECL>
    <TKG_FUB_ERR_LEV_1 IsPattern="Yes">error_level_1:\s</TKG_FUB_ERR_LEV_1>
    <TKG_FUB_ERR_LEV_2 IsPattern="Yes">error_level_2:\s</TKG_FUB_ERR_LEV_2>
    <TKG_FUB_ERR_LEV_3 IsPattern="Yes">error_level_3:\s</TKG_FUB_ERR_LEV_3>
    <TKG_FUB_ERR_LEV_4 IsPattern="Yes">error_level_4:\s</TKG_FUB_ERR_LEV_4>
    <TKG_FUB_BLOCKING IsPattern="Yes">blocking:[\s\n]</TKG_FUB_BLOCKING>
    <TKG_FUB_NON_BLOCKING IsPattern="Yes">non_blocking:\s</TKG_FUB_NON_BLOCKING>
    <!-- For local IEC style type declarations
      <TKG_IEC_OPEN_TYPE IsPattern="Yes">type:[\s\n]</TKG_IEC_OPEN_TYPE> 
      <TKG_IEC_CLOSE_TYPE IsPattern="Yes">end_type:[\s\n]</TKG_IEC_CLOSE_TYPE> 
      <TKG_CNC_TYPEDEF IsPattern="Yes">typedef:[\s\n]</TKG_CNC_TYPEDEF>
      <TKG_IEC_OPEN_STRUCT IsPattern="Yes">struct:[\s\n]</TKG_IEC_OPEN_STRUCT> 
      <TKG_IEC_CLOSE_STRUCT IsPattern="Yes">end_struct:[\s\n]</TKG_IEC_CLOSE_STRUCT> 
      <TKG_IEC_ARRAY IsPattern="Yes">array:[\[\s\n]</TKG_IEC_ARRAY> 
      <TKG_IEC_OF IsPattern="Yes" Disabled="Yes">of:[\s\n]</TKG_IEC_OF> 
      <TKG_IEC_DATATYPE_SPEC IsPattern="Yes">is:[\s\n]</TKG_IEC_DATATYPE_SPEC>
      <TKG_CNC_END IsPattern="Yes">end_enum:[\s\n]|end:[\s\n]</TKG_CNC_END>
    -->
    <TKG_IEC_TYPED_VALUE IsPattern="Yes">#[\w\d]+:[^\w\d\:]</TKG_IEC_TYPED_VALUE>
    <!-- Support for manually dereferenced pointer (REFERENCE TO) vars -->
    <TKG_REFERENCE IsPattern="Yes"  FollowedBy="TKG_IEC_TO">ref:[\s\n]|reference:[\s\n]</TKG_REFERENCE>
    <TKG_IEC_TO IsPattern="Yes" Restricted="Yes">to:[\s\n]</TKG_IEC_TO>
    <TKG_ACCESS IsPattern="Yes">ACCESS:[\s\n]</TKG_ACCESS>
    <!-- <TKG_DEREF_OP IsPattern="Yes">\^:[^\w\d]</TKG_DEREF_OP> only if using manual dereferencing -->
    <TKG_BINARY_LITERAL_START FollowedBy="TKG_BINARY_LITERAL_BODY" IsPattern="Yes">&apos;B:[01_]</TKG_BINARY_LITERAL_START>
    <TKG_BINARY_LITERAL_BODY Restricted="Yes" IsPattern="Yes">[01_]+&apos;</TKG_BINARY_LITERAL_BODY>
    <TKG_HEX_LITERAL_START FollowedBy="TKG_HEX_LITERAL_BODY" IsPattern="Yes">&apos;H:[\dA-F_]</TKG_HEX_LITERAL_START>
    <TKG_HEX_LITERAL_BODY Restricted="Yes" IsPattern="Yes">[\dA-F_]+&apos;</TKG_HEX_LITERAL_BODY>
    <!-- TKG_WORD Must be the final token in the list -->
    <TKG_WORD IsPattern="Yes">\w|\w[\w\d\./]+|\./\w|\./\w[\w\d\./]+|[\^#][\w\d]+\:[\w\d\./]+</TKG_WORD>
  </ParserData>
  <StringChars
  	  AsciiStringStart="&quot;" AsciiStringEnd="&quot;"
  	  UTF16StringStart="W&quot;" UTF16StringEnd="&quot;" >
    <!-- default is case insensitive -->
    <EscapeSeq Search="$N" ReplaceValue="10" />
    <EscapeSeq Search="$L" ReplaceValue="10" />
    <EscapeSeq Search="$P" ReplaceValue="12" />
    <EscapeSeq Search="$R" ReplaceValue="13" />
    <EscapeSeq Search="$T" ReplaceValue="9" />
    <EscapeSeq Search="$Q" ReplaceStr="&quot;" /> <!-- keep $Q for backwards compatibility -->
    <EscapeSeq Search="$&apos;" ReplaceStr="&apos;" />
    <EscapeSeq Search="$&quot;" ReplaceStr="&quot;" />    
    <EscapeSeq Search="$[\dA-Fa-f]+" IsPattern="Yes" ReplaceEncodingBase="16"/>
    <EscapeSeq Search="$$" ReplaceStr="$"/>
    <EscapeSeq Search="$" ReplaceStr=""/>
  </StringChars>
</Root>
