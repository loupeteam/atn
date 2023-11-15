<?xml version="1.0" encoding="utf-8"?>
<?ARNC0 Version="5.12.2"?>
<Root LangModule="ailgcode" Version="1.0">
  <Constants>
    <NumAxes Type="INT">15</NumAxes>
  </Constants>
  <Preprocess>
    <!-- Support for AltLang1 system-global (NCK), and interpreter-global (CHAN) variable scope specifiers -->
    <PP_RULE_STOPRE Search="STOPRE" Replace="G172" />
    <PP_RULE_CIP    Search="CIP:\W" Replace="G102" IsPattern="Yes"/>
  </Preprocess>
  <Types>
    <RotationAngleSpecifier type="ENUM" EnumType="REGEXP" Value6="H" />
    <RadiusSpecifier type="ENUM" EnumType="REGEXP" Value1="R\s*=" Value2="CR\s*=" />
    <InterpolParam type="ENUM" EnumType="REGEXP"
      Value0="I" Value1="J" Value2="K"
      Value100="G161\s*I" Value101="G161\s*J" Value102="G161\s*K"
      Value200="G162\s*I" Value201="G162\s*J" Value202="G162\s*K"
      Value0300="I\s*=\s*AC" Value0301="J\s*=\s*AC" Value0302="K\s*=\s*AC"
      Value0400="I\s*=\s*IC" Value0401="J\s*=\s*IC" Value0402="K\s*=\s*IC"
      />
    <CirclePointParam type="ENUM" EnumType="REGEXP"
      Value0="I1\s*=" Value1="J1\s*=" Value2="K1\s*="
      Value100="G161\s*I1\s*=" Value101="G161\s*J1\s*=" Value102="G161\s*K1\s*="
      Value200="G162\s*I1\s*=" Value201="G162\s*J1\s*=" Value202="G162\s*K1\s*="
      Value0300="I1\s*=\s*AC" Value0301="J1\s*=\s*AC" Value0302="K1\s*=\s*AC"
      Value0400="I1\s*=\s*IC" Value0401="J1\s*=\s*IC" Value0402="K1\s*=\s*IC"
      />
    <RPYAngleName type="ENUM" EnumType="REGEXP"
      Value1="ROLL" Value0="PITCH" Value2="YAW"
      />
    <EulerAngleName type="ENUM" EnumType="REGEXP"
      Value3="PHI" Value4="THETA" Value5="PSI"
      />
    <RotaryVectorName type="ENUM" EnumType="REGEXP"
      Value0="P\s*=" Value1="Q\s*=" Value2="R\s*="
      />
    <DwellTime type="FLOAT" />
    <RParamIndex type="INT" MinValue="0" MaxValue="999" />
    <EXParamIndex type="INT" MinValue="0" MaxValue="99" />
    <MParamIndex type="INT" MinValue="0" MaxValue="99" />
    <Byte type="INT" MinValue="0" MaxValue="255" />
    <Word type="INT" MinValue="-32768" MaxValue="32767" />
    <Long type="INT" />
  </Types>
  <PVMacros>
    <!-- Syntax that looks like PV refs, but is actually mapped to a defined bit of AIL -->
    <SAVE ArrayDims="0" Group="500" >
      <!-- issue MP to save state of modal GCodes, restore state on return from subprog -->
      <!-- implementation requires motion packet support -->
      <CALL>
        Info(:id:52101, msg:"Save Modal GCode State NOT SUPPORTED YET":);
      </CALL>
    </SAVE>
  </PVMacros>
  <SysVars>
    <!-- Note 1: Path synchronous system variables - prefix AIL variable with "@" -->
    <!-- Note 2: variable type is as declared in ARNC0 -->
    <!-- Note 3: CanRead and CanWrite permissions default to "Yes" if not specified -->
    <!-- Note 4: If using <SET> and <GET> instead of <REF>, then do not specify CanRead/Write -->

  </SysVars>
  <Parameters>
    <!--Parameters are assumed to be asynchronous unless specified as Synchronous-->
    <R IndexType="RParamIndex" ValueType="FLOAT">
      <ARG ref="EXPR" DataType="RParamIndex" />
      #sys_vars.R[${EXPR}]
    </R>
    <QUOTED QuotedName="$R" Synchronous="Yes" IndexType="RParamIndex" ValueType="FLOAT">
      <ARG ref="EXPR" DataType="RParamIndex" />
      @#sys_vars.R[${EXPR}]
    </QUOTED>
    <!-- P## is the subroutine call repetition specifier -->
    <QUOTED QuotedName="$P" Synchronous="Yes" IndexType="RParamIndex" ValueType="FLOAT">
      <ARG ref="EXPR" DataType="RParamIndex" />
      @#sys_vars.R[@#sys_vars.R[${EXPR}]]
    </QUOTED>
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
  <MCodes>
    <!-- Scope-End M-Codes use "exit;" to return from sub/main program -->
    <M17 Value="17" Group="41" Alias="RET:[^\d\w\(]" Eval="Early" Inline="Yes" AliasIsPattern="Yes">
      <ARG ref="VALUE" DataType="FLOAT" RequireLiteral="Yes" />
      #next_motion.Command = MPCMD_SET_M_FCT;
      #next_motion.Data.I4_value = ${VALUE};
      PushPacket(::);
      exit;  
    </M17>
    <M17_1 Value="17.1" Group="41" Alias="CONDRET" Eval="Early" Inline="Yes">
      <ARG ref="VALUE" DataType="FLOAT" RequireLiteral="Yes" />
      exit;  
    </M17_1>
  </MCodes>
</Root>
