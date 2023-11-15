<?xml version="1.0" encoding="utf-8"?>
<?ARNC0 Version="5.12.2"?>
<Root LangModule="ailgcode" Version="1.0">
  <BuiltInProcs>
    <cancel MinArgs="1" MaxArgs="*">
      <!-- cancel modal Synch Action groups -->
      beginpathsynch
        StopCyclicGroups(:${*}:);
      endpathsynch
      <!-- Note: alternative, blocking version:
          #job->mp_command = MPCMD_PATH_SYNC_EXEC_WAIT;
          beginpathsynch
            WaitStopCyclicGroups(:${*}:);
          endpathsynch
      -->
    </cancel>
  </BuiltInProcs>
  <BuiltInFns PatternSuffix=":\[" >
    <!-- The PatternSuffix can be defined to set lookahead requirements -->
    <ABS    NumArgs="1" Inline="Yes">Abs(:$[1]:)</ABS>
    <SQR    NumArgs="1">($[1] * $[1])</SQR>
    <ACOS   NumArgs="1" Inline="Yes">ACos(:$[1]:)</ACOS>
    <ASIN   NumArgs="1" Inline="Yes">ASin(:$[1]:)</ASIN>
    <ATAN   NumArgs="1" Inline="Yes">ATan(:$[1]:)</ATAN>
    <COS    NumArgs="1" Inline="Yes">Cos(:$[1]:)</COS>
    <DEXP   NumArgs="1" Inline="Yes">DExp(:$[1]:)</DEXP>
    <EXP    NumArgs="1" Inline="Yes">Exp(:$[1]:)</EXP>
    <FIX    NumArgs="1" Inline="Yes">Fix(:$[1]:)</FIX>
    <FRACT  NumArgs="1" Inline="Yes">Fract(:$[1]:)</FRACT>
    <FUP    NumArgs="1" Inline="Yes">Fup(:$[1]:)</FUP>
    <INV    NumArgs="1" Inline="Yes">~($[1])</INV>
    <LN     NumArgs="1" Inline="Yes">Ln(:$[1]:)</LN>
    <LOG    NumArgs="1" Inline="Yes">Log(:$[1]:)</LOG>
    <ROUND  NumArgs="1" Inline="Yes">ToInt(:$[1]:)</ROUND>
    <SIN    NumArgs="1" Inline="Yes">Sin(:$[1]:)</SIN>
    <SQRT   NumArgs="1" Inline="Yes">Sqrt(:$[1]:)</SQRT>
    <TAN    NumArgs="1" Inline="Yes">Tan(:$[1]:)</TAN>
    <!-- type conversion functions need explicit pattern specifying to distinguish them from the PrimType keyword -->
    <BOOL   NumArgs="1" Inline="Yes">ToBool(:$[1]:)</BOOL>
    <INT    NumArgs="1" Inline="Yes">Fix(:$[1]:)</INT>
    <ADR    NumArgs="1" Inline="Yes">Adr(:\$[1]:)</ADR>
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
    <RDISABLE ArrayDims="0" Group="500" >
      <CALL Inline="Yes">
        @#job->sa.keep_alive = 1;
        @#thread.sa_keep_alive = 1;
      </CALL>
    </RDISABLE>
  </PVMacros>
  <Parameters>
    <!--Parameters are assumed to be asynchronous unless specified as Synchronous-->
    <R IndexType="RParamIndex" ValueType="FLOAT">
      <ARG ref="EXPR" DataType="RParamIndex" />
      #sys_vars.R[${EXPR}]
    </R>
    <P IndexType="RParamIndex" ValueType="FLOAT">
      <ARG ref="EXPR" DataType="RParamIndex" />
      #sys_vars.R[#sys_vars.R[${EXPR}]]
    </P>
    <EXB IndexType="EXParamIndex" ValueType="Byte">
      <ARG ref="EXPR" DataType="EXParamIndex" />
      #sys_vars.EXB[${EXPR}]
    </EXB>
    <EXW IndexType="EXParamIndex" ValueType="Word">
      <ARG ref="EXPR" DataType="EXParamIndex" />
      #sys_vars.EXW[${EXPR}]
    </EXW>
    <EXL IndexType="EXParamIndex" ValueType="Long">
      <ARG ref="EXPR" DataType="EXParamIndex" />
      #sys_vars.EXL[${EXPR}]
    </EXL>
    <EXF IndexType="EXFParamIndex" ValueType="FLOAT">
      <ARG ref="EXPR" DataType="EXFParamIndex" />
      #sys_vars.EXF[${EXPR}]
    </EXF>
    <!-- TODO: synchronous M-parameter support -->
    <MW Synchronous="Yes" IndexType="MParamIndex" ValueType="Word">
      <ARG ref="EXPR" DataType="MParamIndex" />
      @#sys_vars.MW[${EXPR}]
    </MW>
    <ML Synchronous="Yes" IndexType="MParamIndex" ValueType="Long">
      <ARG ref="EXPR" DataType="MParamIndex" />
      @#sys_vars.ML[${EXPR}]
    </ML>
    <MF Synchronous="Yes" IndexType="MParamIndex" ValueType="FLOAT">
      <ARG ref="EXPR" DataType="MParamIndex" />
      @#sys_vars.MF[${EXPR}]
    </MF>
  </Parameters>
  <PrimTypes PatternSuffix=":[^\[]" MapIECTypes="Yes" />
  <Preprocess>
    <PP_RULE_FRAME_I Search="$FRAME_I" Replace="[1,0,0,0,1,0,0,0,1,0,0,0]"/>
    <PP_RULE_FRAME_DEF IsPattern="Yes" Search="FRAME:[^\w\d]" Replace="LREAL{12}"/>
  </Preprocess>
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
     SubDeclsLocalToFile="Yes" ProgDeclsLocalToFile="Yes" AllowUnprefixedFileCalls="No"
     LocalVarScopeForMainProg="No" FileScopeVarsVisibleInSub="Yes" MainPrgReturnAtNextMainPrgHdr="Yes"
     MaxSizePassByValue="1024"
     AllowVarReadBeforeAssign="No" AllowArrayRefWithoutIndex="Yes"
     AllowStructMemberAutoDereference="Yes" AllowVariableAutoDereference="Yes"  AllowIgnoredExtraSubArgs="Yes"
     EnableStringCharacterIndexing="Yes" OnMacroRedefinition="Warn" CheckFileTimestampBeforeCalls="Yes">
     <!-- For type decl support: ReadWholeFileBeforeParsing="Yes" FinalizeDeclaredTypes="Yes" DefaultTypeDeclScope="IP_LOCAL" -->
    <!--Patterns are specified as Perl regular expressions-->
    <!--Token Names should not be changed-->
    <!--Restricted means this token can only match on a FollowedBy request-->
    <TKG_END_OF_LINE IsPattern="No">\n</TKG_END_OF_LINE>
    <TKG_LINE_CONTINUE IsPattern="No" FileXLInvalid="Yes">\</TKG_LINE_CONTINUE>
    <TKG_LINE_BREAK>@@</TKG_LINE_BREAK>
    <TKG_ARITH_BINARY_MODULO>MOD</TKG_ARITH_BINARY_MODULO>
    <TKG_TRUE IsPattern="Yes">TRUE:\W</TKG_TRUE>
    <TKG_FALSE IsPattern="Yes">FALSE:\W</TKG_FALSE>
    <TKG_PAREVAL_MODAL_ID FileXLInvalid="Yes" IsPattern="Yes">ID:[\s=]</TKG_PAREVAL_MODAL_ID>
    <TKG_OPEN_COMMENT>(</TKG_OPEN_COMMENT>
    <TKG_CLOSE_COMMENT>)</TKG_CLOSE_COMMENT>
    <TKG_OPEN_BRACKET>[</TKG_OPEN_BRACKET>
    <TKG_COMMA>,</TKG_COMMA>
    <TKG_CLOSE_BRACKET>]</TKG_CLOSE_BRACKET>
    <TKG_OPEN_INDEXBRACKET>{</TKG_OPEN_INDEXBRACKET>
    <TKG_CLOSE_INDEXBRACKET>}</TKG_CLOSE_INDEXBRACKET>
    <TKG_NUMBER IsPattern="Yes">\d+\.\d+|\d+\.:[^\.]</TKG_NUMBER>
    <TKG_INTEGER IsPattern="Yes">\d+</TKG_INTEGER>
    <TKG_FRACTION IsPattern="Yes">\.\d+</TKG_FRACTION>
    <TKG_DOT IsPattern="Yes" FollowedBy="TKG_STRUCT_MEMBER_REF">\.:\w</TKG_DOT>
    <TKG_STRUCT_MEMBER_REF IsPattern="Yes" Restricted="Yes">\w|\w[\w\d]+</TKG_STRUCT_MEMBER_REF>
    <TKG_NUMBER_EXP IsPattern="Yes">EX:[\s\d\+\-\.]</TKG_NUMBER_EXP>
    <TKG_MACRO_DEFINE_GLOBAL IsPattern="Yes" FollowedBy="TKG_MACRO_NAME">define\s+ip_global:\s</TKG_MACRO_DEFINE_GLOBAL>
    <TKG_MACRO_DEFINE IsPattern="Yes" FollowedBy="TKG_MACRO_NAME">define\s+local:\s|define:\s</TKG_MACRO_DEFINE>
    <TKG_MACRO_UNDEFINE IsPattern="Yes" FollowedBy="TKG_MACRO_NAME">undefine:\s</TKG_MACRO_UNDEFINE>
    <TKG_MACRO_AS IsPattern="Yes" FollowedBy="TKG_MACRO_TEXT">as:[\s\n]</TKG_MACRO_AS>
    <TKG_MACRO_NAME Restricted="Yes" IsPattern="Yes">[$\w][$\w\d]+</TKG_MACRO_NAME>
    <TKG_MACRO_TEXT Restricted="Yes" IsPattern="Yes">.</TKG_MACRO_TEXT>
    <TKG_BUILTIN_NUM_FN_NAME/> <!-- each BuiltInFn added adds itself to the parse token string-cache, this just defines priority of that token -->
    <_TKG_LABEL_DEF1><TKG_LABEL_DEF IsPattern="Yes" FollowedBy="TKG_LABEL_SUFFIX">L[\w\d]+:\:[^\w\d]</TKG_LABEL_DEF></_TKG_LABEL_DEF1>
    <TKG_SUBPROG_START FileXLInvalid="Yes" IsPattern="Yes" FollowedBy="TKG_SUBPROG_NAME">%:L</TKG_SUBPROG_START>
    <TKG_SUBPROG_NAME IsPattern="Yes" Restricted="Yes">L\d+</TKG_SUBPROG_NAME>
    <TKG_SUBPROG_CALL IsPattern="Yes" FollowedBy="TKG_SUBPROG_NAME">L:L\d</TKG_SUBPROG_CALL>
    <TKG_SUBPROG_PROTO IsPattern="Yes" FollowedBy="TKG_SUBPROG_NAME">%D:L</TKG_SUBPROG_PROTO>
    <TKG_SUBCALL_REPEAT_PREFIX IsPattern="Yes" FollowedBy="TKG_INTEGER">O:[\s\d]</TKG_SUBCALL_REPEAT_PREFIX>
    <TKG_EXTERN IsPattern="Yes" FollowedBy="TKG_PROG_FILE_NAME">EXTERN:\s</TKG_EXTERN>
    <TKG_ARG_PASSBYREF IsPattern="Yes">VAR\s</TKG_ARG_PASSBYREF>
    <TKG_SET_MODAL_SUB FileXLInvalid="Yes" IsPattern="Yes">MCALL:\W</TKG_SET_MODAL_SUB>
    <TKG_PROG_START IsPattern="Yes" FollowedBy="TKG_PROG_NAME">%:\d</TKG_PROG_START>
    <TKG_PROG_NAME IsPattern="Yes" Restricted="Yes">\d+</TKG_PROG_NAME>
    <TKG_PROG_CALL IsPattern="Yes" FollowedBy="TKG_PROG_FILE_NAME">L:[^L]</TKG_PROG_CALL>
    <TKG_PROG_FILE_NAME IsPattern="Yes" Restricted="Yes">[\^#&amp;@']?[\w\d\.\\]+:[^\w\d\.\\\:]|[\^#][\w\d]+\:[\w\d\.\\]+</TKG_PROG_FILE_NAME>
    <TKG_SUPPRESS_SINGLE_STEP>NOHALT</TKG_SUPPRESS_SINGLE_STEP>
    <TKG_NC_BLOCK_PREFIX IsPattern="Yes">N:[\d\s]</TKG_NC_BLOCK_PREFIX>
    <TKG_PARAM_PREFIX IsPattern="Yes">R:\d|P:\d|M[WLF]:\d|EX[WLBF]:\d</TKG_PARAM_PREFIX>
    <TKG_SUBRANGE>..</TKG_SUBRANGE >
    <TKG_G_CODE_PREFIX IsPattern="Yes">G:[\s\d]</TKG_G_CODE_PREFIX>
    <TKG_M_CODE_PREFIX IsPattern="Yes">M:[\s\d\[]</TKG_M_CODE_PREFIX>
    <TKG_PAREVAL_DO FileXLInvalid="Yes" IsPattern="Yes">do:\s</TKG_PAREVAL_DO>
    <TKG_GOTO FileXLInvalid="Yes" IsPattern="Yes" OptFollowedBy="TKG_GOTO_DEST">$GOTO:\s</TKG_GOTO>
    <TKG_GOTO_DEST IsPattern="Yes" Restricted="Yes">\w[\w\d]*</TKG_GOTO_DEST>
    <TKG_LOGICAL_BINARY_AND>&amp;&amp;</TKG_LOGICAL_BINARY_AND>
    <TKG_LOGICAL_BINARY_OR>||</TKG_LOGICAL_BINARY_OR>
    <TKG_LOGICAL_BINARY_XOR>XOR</TKG_LOGICAL_BINARY_XOR>
    <TKG_STRING_CONCAT>&lt;&lt;</TKG_STRING_CONCAT>
    <TKG_COMP_BINARY_GREATER_THAN_OR_EQ>&gt;=</TKG_COMP_BINARY_GREATER_THAN_OR_EQ>
    <TKG_COMP_BINARY_LESS_THAN_OR_EQ>&lt;=</TKG_COMP_BINARY_LESS_THAN_OR_EQ>
    <TKG_COMP_BINARY_EQUAL_TO>==</TKG_COMP_BINARY_EQUAL_TO>
    <TKG_COMP_BINARY_NOT_EQUAL_TO>!=</TKG_COMP_BINARY_NOT_EQUAL_TO>
    <TKG_COMP_BINARY_GREATER_THAN>&gt;</TKG_COMP_BINARY_GREATER_THAN>
    <TKG_COMP_BINARY_LESS_THAN>&lt;</TKG_COMP_BINARY_LESS_THAN>
    <TKG_ASSIGN_EQ>=</TKG_ASSIGN_EQ>
    <TKG_LOGICAL_UNARY_NOT>!</TKG_LOGICAL_UNARY_NOT>
    <TKG_BITWISE_BINARY_AND>&amp;</TKG_BITWISE_BINARY_AND>
    <TKG_BITWISE_BINARY_OR>|</TKG_BITWISE_BINARY_OR>
    <TKG_BITWISE_BINARY_XOR>^</TKG_BITWISE_BINARY_XOR>
    <TKG_BITWISE_UNARY_COMPLEMENT>~</TKG_BITWISE_UNARY_COMPLEMENT>
    <TKG_ARITH_BINARY_PLUS>+</TKG_ARITH_BINARY_PLUS>
    <TKG_ARITH_BINARY_MINUS>-</TKG_ARITH_BINARY_MINUS>
    <TKG_ARITH_BINARY_POWER>**</TKG_ARITH_BINARY_POWER>
    <TKG_ARITH_BINARY_MULTIPLY>*</TKG_ARITH_BINARY_MULTIPLY>
    <TKG_ARITH_BINARY_DIVIDE>/</TKG_ARITH_BINARY_DIVIDE>
    <TKG_PATHSYNCH_REC_IEC FileXLInvalid="Yes">$DO_PATH_SYNCH</TKG_PATHSYNCH_REC_IEC>
    <TKG_PATHSYNCH_END FileXLInvalid="Yes">$END_PATH_SYNCH</TKG_PATHSYNCH_END>
    <TKG_PATHSYNCH_IPEVAL FileXLInvalid="Yes">$IP_EVAL</TKG_PATHSYNCH_IPEVAL>
    <TKG_IF FileXLInvalid="Yes">$IF</TKG_IF>
    <TKG_THEN FileXLInvalid="Yes">$THEN</TKG_THEN>
    <TKG_BLOCK_ELSEIF FileXLInvalid="Yes">$ELSEIF</TKG_BLOCK_ELSEIF>
    <TKG_BLOCK_ELSE FileXLInvalid="Yes">$ELSE</TKG_BLOCK_ELSE>
    <TKG_BLOCK_ENDIF FileXLInvalid="Yes">$ENDIF</TKG_BLOCK_ENDIF>
    <TKG_SWITCH FileXLInvalid="Yes">$SWITCH</TKG_SWITCH>
    <TKG_SWITCH_CASE FileXLInvalid="Yes">$CASE</TKG_SWITCH_CASE>
    <TKG_SWITCH_DEFAULT FileXLInvalid="Yes">$DEFAULT</TKG_SWITCH_DEFAULT>
    <TKG_ENDSWITCH FileXLInvalid="Yes">$ENDSWITCH</TKG_ENDSWITCH>
    <TKG_FOR FileXLInvalid="Yes">$FOR</TKG_FOR>
    <TKG_ENDFOR FileXLInvalid="Yes">$ENDFOR</TKG_ENDFOR>
    <TKG_WHILE FileXLInvalid="Yes">$WHILE</TKG_WHILE>
    <TKG_ENDWHILE FileXLInvalid="Yes">$ENDWHILE</TKG_ENDWHILE>
    <TKG_DO FileXLInvalid="Yes">$DO</TKG_DO>
    <TKG_ENDDO FileXLInvalid="Yes">$ENDDO</TKG_ENDDO>
    <TKG_BREAK FileXLInvalid="Yes">$BREAK</TKG_BREAK>
    <TKG_CONTINUE FileXLInvalid="Yes">$CONTINUE</TKG_CONTINUE>
    <!-- GCode specific parse tokens -->
    <TKG_PRIM_TYPE IsPattern="Yes" />
    <TKG_PV_DECL IsPattern="Yes">def:\s</TKG_PV_DECL>
    <TKG_PV_UNDECL IsPattern="Yes">~def:\s</TKG_PV_UNDECL>
    <TKG_PV_DECL_REF IsPattern="Yes" Restricted="Yes">\w[\w\d\.\:\*]+|\w</TKG_PV_DECL_REF>
    <TKG_VARSCOPE_IP_LOCAL IsPattern="Yes">local:[\s\n]</TKG_VARSCOPE_IP_LOCAL>
    <TKG_VARSCOPE_IP_GLOBAL IsPattern="Yes">ip_global:[\s\n]</TKG_VARSCOPE_IP_GLOBAL>
    <TKG_VARSCOPE_NC_GLOBAL IsPattern="Yes">nc_global:[\s\n]</TKG_VARSCOPE_NC_GLOBAL>
    <TKG_VARSCOPE_PLC_GLOBAL IsPattern="Yes">plc_global:[\s\n]</TKG_VARSCOPE_PLC_GLOBAL>
    <TKG_VAR_RETAIN IsPattern="Yes">retain:\s</TKG_VAR_RETAIN>
    <TKG_VARSYNCH_IP IsPattern="Yes">ip_synch:\s</TKG_VARSYNCH_IP>
    <TKG_VARSYNCH_PATH IsPattern="Yes">path_synch:\s</TKG_VARSYNCH_PATH>
    <TKG_LABEL_DEF IsPattern="Yes" FollowedBy="TKG_LABEL_SUFFIX">\w:\:|\w[\w\d]+:\:</TKG_LABEL_DEF>
    <TKG_LABEL_SUFFIX Restricted="Yes">:</TKG_LABEL_SUFFIX>
    <TKG_FUB_DECL IsPattern="Yes">fub:\s</TKG_FUB_DECL>
    <TKG_FUB_ERR_LEV_1 IsPattern="Yes">error_level_1:\s</TKG_FUB_ERR_LEV_1>
    <TKG_FUB_ERR_LEV_2 IsPattern="Yes">error_level_2:\s</TKG_FUB_ERR_LEV_2>
    <TKG_FUB_ERR_LEV_3 IsPattern="Yes">error_level_3:\s</TKG_FUB_ERR_LEV_3>
    <TKG_FUB_ERR_LEV_4 IsPattern="Yes">error_level_4:\s</TKG_FUB_ERR_LEV_4>
    <TKG_FUB_BLOCKING IsPattern="Yes">blocking:\s</TKG_FUB_BLOCKING>
    <TKG_FUB_NON_BLOCKING IsPattern="Yes">non_blocking:\s</TKG_FUB_NON_BLOCKING>
    <!-- Definitions to enable IEC-style type declarations and WSTRING literals
      <TKG_IEC_OPEN_TYPE IsPattern="Yes">$TYPE:[\s\n]</TKG_IEC_OPEN_TYPE> 
      <TKG_IEC_CLOSE_TYPE IsPattern="Yes">$END_TYPE:[\s\n]</TKG_IEC_CLOSE_TYPE> 
      <TKG_CNC_TYPEDEF IsPattern="Yes">$TYPEDEF:[\s\n]</TKG_CNC_TYPEDEF>
      <TKG_IEC_OPEN_STRUCT IsPattern="Yes">struct:[\s\n]</TKG_IEC_OPEN_STRUCT> 
      <TKG_IEC_CLOSE_STRUCT IsPattern="Yes">end_struct:[\s\n]</TKG_IEC_CLOSE_STRUCT> 
      <TKG_IEC_ARRAY IsPattern="Yes">array:[{\s\n]</TKG_IEC_ARRAY> 
      <TKG_IEC_OF IsPattern="Yes">of:[\s\n]</TKG_IEC_OF> 
      <TKG_IEC_DATATYPE_SPEC IsPattern="Yes">is:[\s\n]</TKG_IEC_DATATYPE_SPEC>
      <TKG_CNC_END IsPattern="Yes">end_enum:[\s\n]|end:[\s\n]</TKG_CNC_END>
    -->
    <TKG_IEC_TYPED_VALUE IsPattern="Yes">#[\w\d]+</TKG_IEC_TYPED_VALUE>
    <!-- Support for automatic dereferenced pointer (REFERENCE TO) vars -->
    <TKG_REFERENCE IsPattern="Yes" FollowedBy="TKG_IEC_TO">ref:[\s\n]|reference:[\s\n]</TKG_REFERENCE>
    <TKG_IEC_TO IsPattern="Yes" Restricted="Yes">to:[\s\n]</TKG_IEC_TO>
    <TKG_ACCESS IsPattern="Yes">ACCESS:[\s\n]</TKG_ACCESS>
    <!-- TKG_WORD Must be the final token in the list -->
    <TKG_WORD IsPattern="Yes">\w|\w[\w\d\.]+</TKG_WORD>
  </ParserData>
  <StringChars AsciiStringStart="&quot;" UTF16StringStart="W&quot;" UTF16StringEnd="&quot;" >
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