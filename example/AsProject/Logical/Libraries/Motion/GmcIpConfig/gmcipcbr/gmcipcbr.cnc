<?xml version="1.0" encoding="utf-8"?>
<?ARNC0 Version="5.12.2"?>
<Root LangModule="ailgcode" Version="1.0">
  <AxesSpec>
    <!-- recommend configuring long names first -->
    <!-- long names require a seperator char after -->
    <AxisRef Mode="INC"    >G91\s*$[\s=]</AxisRef>
    <AxisRef Mode="ABS"    >G90\s*$[\s=]</AxisRef>
    <AxisRef Mode="default">$[\s=]</AxisRef>
    <!-- short name (single character) spec -->
    <AxisRef Mode="default" MaxAxisNameLen="1">$</AxisRef>
    <AxisRef Mode="INC"     MaxAxisNameLen="1">G91\s*$</AxisRef>
    <AxisRef Mode="ABS"     MaxAxisNameLen="1">G90\s*$</AxisRef>
  </AxesSpec>
  <Constants>
    <BCTypeArg type="STRING">BC</BCTypeArg>
    <NumAxes Type="INT">15</NumAxes>
    <AccelArgPrefix type="STRING">ACC</AccelArgPrefix>
    <RPLArgPrefix type="STRING">RPL</RPLArgPrefix>
    <ve_par type="STRING">$VE</ve_par>
    <LatchArgPrefix type="STRING">L</LatchArgPrefix>
    <CamWrappingParameter type="STRING">Q</CamWrappingParameter>
    <FirstAxisIndicator1 type="STRING">P</FirstAxisIndicator1>
    <EPSILON type="FLOAT">0.0000001</EPSILON>
    <MFunSignalArgPrefix type="STRING">M</MFunSignalArgPrefix>
    <SpindleSignalArgPrefix type="STRING">S</SpindleSignalArgPrefix>
    <FullTrfToolDx type="STRING">DX</FullTrfToolDx>
    <FullTrfToolDy type="STRING">DY</FullTrfToolDy>
    <FullTrfToolDz type="STRING">DZ</FullTrfToolDz>
    <FullTrfToolPhi type="STRING">PHI</FullTrfToolPhi>
    <FullTrfToolTheta type="STRING">THETA</FullTrfToolTheta>
    <FullTrfToolPsi type="STRING">PSI</FullTrfToolPsi>
    <FullTrfToolDmp type="STRING">DMP</FullTrfToolDmp>
    <EXFSigParamPrefix type="REGEXP">EXF:\d+\s*=</EXFSigParamPrefix>
    <EXLSigParamPrefix type="REGEXP">EXL:\d+\s*=</EXLSigParamPrefix>
    <EXWSigParamPrefix type="REGEXP">EXW:\d+\s*=</EXWSigParamPrefix>
    <EXBSigParamPrefix type="REGEXP">EXB:\d+\s*=</EXBSigParamPrefix>
    <WSCoordX1 type="STRING">X1</WSCoordX1>
    <WSCoordY1 type="STRING">Y1</WSCoordY1>
    <WSCoordZ1 type="STRING">Z1</WSCoordZ1>
    <WSCoordX2 type="STRING">X2</WSCoordX2>
    <WSCoordY2 type="STRING">Y2</WSCoordY2>
    <WSCoordZ2 type="STRING">Z2</WSCoordZ2>
    <WSCoordC type="STRING">COORD</WSCoordC>
    <WSIndex type="STRING">INDEX</WSIndex>
    <WSChannel type="STRING">CHANNEL</WSChannel>
    <WSStopDifference type="STRING">STOP_DIFFERENCE</WSStopDifference>
    <OptMotPathDefinition type="STRING">PATH_DEFINITION</OptMotPathDefinition>
    <OptMotRobotParameter type="STRING">ROBOT_PARAMETER</OptMotRobotParameter>
    <OptMotLimits type="STRING">LIMITS</OptMotLimits>
    <OptMotLimitsFactor type="STRING">LIMITS_FACTOR</OptMotLimitsFactor>
    <AutoBlockNumberFactor type="STRING">FACTOR</AutoBlockNumberFactor>
    <AutoBlockNumberOffset type="STRING">OFFSET</AutoBlockNumberOffset>
    <BezierScalingFactor type="STRING">SCALING_FACTOR</BezierScalingFactor>
    <ChamferLength type="STRING">CHF</ChamferLength>
    <ChamferWidth type="STRING">CHR</ChamferWidth>
  </Constants>
  <Preprocess>
    <PP_RULE_MODE_00000001 Search="TRF_MODE_FRONT" Replace="1"/>
    <PP_RULE_MODE_00000002 Search="TRF_MODE_BACK" Replace="2"/>
    <PP_RULE_MODE_00000004 Search="TRF_MODE_CONVEX" Replace="4"/>
    <PP_RULE_MODE_00000008 Search="TRF_MODE_CONCAVE" Replace="8"/>
    <PP_RULE_MODE_00000010 Search="TRF_MODE_POSITIVE" Replace="16"/>
    <PP_RULE_MODE_00000020 Search="TRF_MODE_NEGATIVE" Replace="32"/>
    <PP_RULE_MODE_00000040 Search="TRF_MODE_LEFT" Replace="64"/>
    <PP_RULE_MODE_00000080 Search="TRF_MODE_RIGHT" Replace="128"/>
    <PP_RULE_MODE_00000100 Search="TRF_MODE_DIRECT" Replace="256"/>
    <PP_RULE_MODE_00000200 Search="TRF_MODE_INDIRECT" Replace="512"/>
    <PP_RULE_MODE_00000400 Search="TRF_MODE_CONVEX2" Replace="1024"/>
    <PP_RULE_MODE_00000800 Search="TRF_MODE_CONCAVE2" Replace="2048"/>
    <PP_RULE_MODE_00001000 Search="TRF_MODE_CONVEX3" Replace="4096"/>
    <PP_RULE_MODE_00002000 Search="TRF_MODE_CONCAVE3" Replace="8192"/>
    <PP_RULE_MODE_10000000 Search="TRF_MODE_NEG_DIR" Replace="268435456"/>
    <PP_RULE_MODE_20000000 Search="TRF_MODE_POS_DIR" Replace="536870912"/>
    <PP_RULE_MODE_40000000 Search="TRF_MODE_IN_SW_ENDS" Replace="1073741824"/>
    <PP_RULE_FRAME_ANGLE_00000001 Search="FRAME_ANGLE_ZYZ" Replace="1"/>
    <PP_RULE_FRAME_ANGLE_00000002 Search="FRAME_ANGLE_ZYX" Replace="2"/>
  </Preprocess>
  <Types>
    <LinName type="ENUM" EnumType="STRING" Value1="$LIN" />
    <!-- G-Arg string enums for PackMPData() - the Value__ number is critical...
        - the tens and units dgits identify this axis/rotation-setting
        - the hundreds digit and beyond are for modifiers:
           (0xx = Value without modifiers - behaves in the default manner)
            1xx = Explicitly absolute value
            2xx = Explicitly incremental value

      Whitespace in enum strings:
        - Only used for G-Arg name string-enums
        - Add a space in the enum-string where spaces are *allowed* to occur in the program
        - ...in those places, there can be zero-or-more spaces in the program
     -->
    <WS_SelfCollisionOff type="ENUM" EnumType="STRING" Value1="SELF_COLLISION_OFF" />
    <WS_ExclOff type="ENUM" EnumType="STRING" Value1="EXCL_OFF" />
    <WS_CyclicOn type="ENUM" EnumType="STRING" Value1="CYCLIC_ON" />
    <WS_InterChannelOn type="ENUM" EnumType="STRING" Value1="INTERCHANNEL_ON" />
    <WS_ExternalInterChannelOn type="ENUM" EnumType="STRING" Value1="EXTERNAL_INTERCHANNEL_ON" />
    <WS_Shape type="ENUM" EnumType="STRING" Value1="CUBOID" Value2="CYLINDER_IN_Z" Value3="CYLINDER2_IN_Z" />
    <D_FULL_TcpShift type="ENUM" EnumType="STRING" Value1="TCP_SHIFT" />
    <D_FULL_JointsShift type="ENUM" EnumType="STRING" Value1="JOINTS_SHIFT" />
    <FreeExtData type="ENUM" EnumType="STRING" Value1="FREE_EXT_DATA" />
    <FuncBeforeRounding type="ENUM" EnumType="STRING" Value1="FUNC_BEFORE_ROUNDING" />
    <RotationAngleSpecifier type="ENUM" EnumType="STRING" IsPattern="Yes" Value6="H" />
    <RadiusSpecifier type="ENUM" EnumType="STRING" IsPattern="Yes" Value1="R=" />
    <CirclePointParam type="ENUM" EnumType="STRING" IsPattern="Yes"
      Value0="I1\s*=" Value1="J1\s*=" Value2="K1\s*="
      Value100="G161\s*I1\s*=" Value101="G161\s*J1\s*=" Value102="G161\s*K1\s*="
      Value200="G162\s*I1\s*=" Value201="G162\s*J1\s*=" Value202="G162\s*K1\s*="
      Value0300="I1\s*=\s*AC" Value0301="J1\s*=\s*AC" Value0302="K1\s*=\s*AC"
      Value0400="I1\s*=\s*IC" Value0401="J1\s*=\s*IC" Value0402="K1\s*=\s*IC"
      />
    <InterpolParam type="ENUM" EnumType="STRING" IsPattern="Yes"
      Value0="I" Value1="J" Value2="K"
      Value100="G161\s*I" Value101="G161\s*J" Value102="G161\s*K"
      Value200="G162\s*I" Value201="G162\s*J" Value202="G162\s*K"
      Value0300="I\s*=\s*AC" Value0301="J\s*=\s*AC" Value0302="K\s*=\s*AC"
      Value0400="I\s*=\s*IC" Value0401="J\s*=\s*IC" Value0402="K\s*=\s*IC"
      />
    <RPYAngleName type="ENUM" EnumType="STRING" IsPattern="Yes"
      Value1="ROLL" Value0="PITCH" Value2="YAW"
      />
    <EulerAngleName type="ENUM" EnumType="STRING" IsPattern="Yes"
      Value3="PHI" Value4="THETA" Value5="PSI"
      />
    <RotaryVectorName type="ENUM" EnumType="STRING" IsPattern="Yes"
      Value0="P\s*=" Value1="Q\s*=" Value2="R\s*="
      />
    <OrientParam type="ENUM" EnumType="STRING" Value1="P" Value2="Q" Value3="R" />
    <CirclePointOrient type="ENUM" EnumType="STRING" IsPattern="Yes"
      Value0="A1\s*=" Value1="B1\s*=" Value2="C1\s*="/>
    <PositionValue Type="FLOAT" />
    <ChordErrorValue Type="FLOAT" />
    <SpindleID Type="INT" IsLiteral="Yes" MinValue="0" MaxValue="3" />
    <SpindleRPM Type="INT" MinValue="0" />
    <Distance Type="FLOAT" />
    <ToolID Type="INT" MinValue="0" MaxValue="499">
      <!--(ToolID applies to both Tool Location and Tool Data selections)-->
    </ToolID>
    <Feedrate Type="FLOAT" MinValue="0" />
    <FeedFactor Type="INT" MinValue="0" MaxValue="10000" />
    <FeedChangeRate type="FLOAT" MinValue="-10000" MaxValue="10000" />
    <ContourTransitionIndex Type="INT" MinValue="0" MaxValue="0" IsLiteral="Yes">
      <!--Currently only valid value is 0 (G180=000 : Tangential Line-Circle-Programming)-->
    </ContourTransitionIndex>
    <RotationAngle type="FLOAT" />
    <DwellTime type="FLOAT" />
    <TA_Time type="FLOAT" />
    <SignArg type="ENUM" EnumType="STRING" Value1="+" Value2="-" />
    <TangArcRadius type="FLOAT" MinValue="0.0" MaxValue="" />
    <AxisLimitRecordIndex type="INT" IsLiteral="Yes" MinValue="-1" MaxValue="NumAxes">
      <!--Value of -1 indicates: return to axis defaults-->
    </AxisLimitRecordIndex>
    <VJumpValue type="FLOAT" />
    <AJumpValue type="FLOAT" />
    <AngleDegrees type="FLOAT" MinValue="-36000" MaxValue="36000" />
    <PathSpeedReductionFactor type="FLOAT" MinValue="-1" MaxValue="36000" />
    <RadiusValue type="FLOAT" />
    <RotVectorValue type="FLOAT" MinValue="-1" MaxValue="1" />
    <RotaryVector type="LIST" ListOf="RotVectorValue" MinCount="3" MaxCount="3" />
    <RotaryMatrix type="LIST" ListOf="RotaryVector" MinCount="3" MaxCount="3" />
    <AccelPercentage type="FLOAT" MinValue="0.0000001" /> <!-- not just percentage but CNC unit accel too -->
    <ZeroPointTableIndex type="INT" MinValue="0" MaxValue="499" />
    <TriggerEdge type="ENUM" EnumType="STRING" Value1="P" Value2="N" />
    <TriggerInputIndex type="INT" MinValue="1" MaxValue="2" />
    <FOverridePercent type="FLOAT" MinValue="0" MaxValue="10000" />
    <CutterDiameter type="FLOAT" MinValue="0" MaxValue="999999" />
    <RParamIndex type="INT" IsLiteral="No" MinValue="0" MaxValue="999" />
    <EXParamIndex type="INT" IsLiteral="Yes" MinValue="0" MaxValue="99" />
    <EXFParamIndex type="INT" IsLiteral="Yes" MinValue="0" MaxValue="3999" />
    <MParamIndex type="INT" IsLiteral="Yes" MinValue="0" MaxValue="99" />
    <RoundingEntranceSpeedFactor type="FLOAT" MinValue="1.0" MaxValue="100.0" />
    <ZeroPointOffsetIndex type="INT" MinValue="1" MaxValue="6" />
    <Byte type="INT" MinValue="-128" MaxValue="127" />
    <UByte type="INT" MinValue="0" MaxValue="255" />
    <Word type="INT" MinValue="-32768" MaxValue="32767" />
    <UWord type="INT" MinValue="0" MaxValue="65535" />
    <Long type="INT" />
    <EqString type="ENUM" EnumType="STRING" Value1="=" />
    <AxisMappingFactor Type="FLOAT" MinValue="EPSILON" />
    <CamWrappingDiameter Type="FLOAT" MinValue="EPSILON" />
    <FirstAxisIndicator2 Type="INT" MinValue="1" MaxValue="1" />
    <C2SplineSeg type="ENUM" EnumType="STRING" Value1="CE" Value2="SL" />
    <BLIntersection type="ENUM" EnumType="STRING" Value1="C0" Value2="C2" Value3="$C0" Value4="$C2" />
    <BLAngle type="FLOAT" />
    <BLAngleSpecifier type="ENUM" EnumType="STRING" IsPattern="Yes" Value1="W" Value2="$W"/>
    <ProgramNumber type="INT" MinValue="0" />
    <FullTrfToolItem type="FLOAT" />
    <WS_Boundaries type="FLOAT" />
    <WS_Coord type="FLOAT" />
    <WS_Index type="INT" />
    <RobotArmDiameter type="FLOAT" />
    <WSParallelPlane type="ENUM" EnumType="STRING" Value0="PPLANE=" />
     <PlaneEnum type="ENUM" EnumType="STRING"
      Value1="XY" Value2="YX"
      Value3="XZ" Value4="ZX"
      Value5="YZ" Value6="ZY"/>
    <WSOrientation type="ENUM" EnumType="STRING" Value0="ORIENT=" />
     <OrientEnum type="ENUM" EnumType="STRING"
     Value1="POS" Value2="NEG" />
    <WantedQ type="FLOAT" />
    <BlockSkipFlush type="ENUM" EnumType="STRING" Value0="FORCE_FLUSH" />
    <AxisAccelPercentage type="FLOAT" MinValue="0.0000001" MaxValue="100"/>
  </Types>
   <BuiltInProcs>
    <WFRAME MinArgs="1" MaxArgs="1" Inline="Yes">
      #next_motion.Data.Frame.Data = $[1];
      #next_motion.Command = MPCMD_W_FRAME;
      PushPacket(::);
    </WFRAME>
    <FROTX MinArgs="2" MaxArgs="2">
      Matrix12MultModify(:\$[1],(:1,0,0,0,Cos(:$[2]:),-Sin(:$[2]:),0,Sin(:$[2]:),Cos(:$[2]:),0,0,0:):);
    </FROTX>
    <FROTY MinArgs="2" MaxArgs="2">
      Matrix12MultModify(:\$[1],(:Cos(:$[2]:),0,Sin(:$[2]:),0,1,0,-Sin(:$[2]:),0,Cos(:$[2]:),0,0,0:):);
    </FROTY>
    <FROTZ MinArgs="2" MaxArgs="2">
      Matrix12MultModify(:\$[1],(:Cos(:$[2]:),-Sin(:$[2]:),0,Sin(:$[2]:),Cos(:$[2]:),0,0,0,1,0,0,0:):);
    </FROTZ>
    <FEULER MinArgs="4" MaxArgs="4">
      Matrix12MultModify(:\$[1],(:Cos(:$[2]:),-Sin(:$[2]:),0,Sin(:$[2]:),Cos(:$[2]:),0,0,0,1,0,0,0:):);
      Matrix12MultModify(:\$[1],(:Cos(:$[3]:),0,Sin(:$[3]:),0,1,0,-Sin(:$[3]:),0,Cos(:$[3]:),0,0,0:):);
      Matrix12MultModify(:\$[1],(:Cos(:$[4]:),-Sin(:$[4]:),0,Sin(:$[4]:),Cos(:$[4]:),0,0,0,1,0,0,0:):);
    </FEULER>
    <FRPY MinArgs="4" MaxArgs="4">
      Matrix12MultModify(:\$[1],(:Cos(:$[2]:),-Sin(:$[2]:),0,Sin(:$[2]:),Cos(:$[2]:),0,0,0,1,0,0,0:):);
      Matrix12MultModify(:\$[1],(:Cos(:$[3]:),0,Sin(:$[3]:),0,1,0,-Sin(:$[3]:),0,Cos(:$[3]:),0,0,0:):);
      Matrix12MultModify(:\$[1],(:1,0,0,0,Cos(:$[4]:),-Sin(:$[4]:),0,Sin(:$[4]:),Cos(:$[4]:),0,0,0:):);
    </FRPY>
    <FTRANS MinArgs="4" MaxArgs="4">
      Matrix12MultModify(:\$[1],(:1,0,0,0,1,0,0,0,1,$[2],$[3],$[4]:):);
    </FTRANS>
    <FTRANSX MinArgs="2" MaxArgs="2">
      Matrix12MultModify(:\$[1],(:1,0,0,0,1,0,0,0,1,$[2],0,0:):);
    </FTRANSX>
    <FTRANSY MinArgs="2" MaxArgs="2">
      Matrix12MultModify(:\$[1],(:1,0,0,0,1,0,0,0,1,0,$[2],0:):);
    </FTRANSY>
    <FTRANSZ MinArgs="2" MaxArgs="2">
      Matrix12MultModify(:\$[1],(:1,0,0,0,1,0,0,0,1,0,0,$[2]:):);
    </FTRANSZ>
    <FAPPLY MinArgs="2" MaxArgs="2">
      Matrix12MultModifyRef(:\$[1],\$[2]:);
    </FAPPLY>
    <FRESET MinArgs="1" MaxArgs="1" Inline="Yes">
      #next_motion.Data.Frame.Data[0] = 1.0;
      #next_motion.Data.Frame.Data[1] = 0.0;
      #next_motion.Data.Frame.Data[2] = 0.0;
      #next_motion.Data.Frame.Data[3] = 0.0;
      #next_motion.Data.Frame.Data[4] = 1.0;
      #next_motion.Data.Frame.Data[5] = 0.0;
      #next_motion.Data.Frame.Data[6] = 0.0;
      #next_motion.Data.Frame.Data[7] = 0.0;
      #next_motion.Data.Frame.Data[8] = 1.0;
      #next_motion.Data.Frame.Data[9] = 0.0;
      #next_motion.Data.Frame.Data[10] = 0.0;
      #next_motion.Data.Frame.Data[11] = 0.0;
      MemCpy(:\$[1],#next_motion.Data.Frame.Data:);
    </FRESET>
    <!-- ALLOW_REFRESH(filename) enable the next timecheck and reload for a ncSTATIC protected file -->
    <ALLOW_REFRESH MinArgs="1" MaxArgs="1">
      AllowRTFileRefresh(:$[1]:);
    </ALLOW_REFRESH>
    <SET_SCALE_FACTOR MinArgs="2" MaxArgs="2">
      if ($[1] == CNC_SYS_VAR_SCALE_MPLANE_AXES)
          %_CNC.scale_main_plane_axes = $[2];
          #next_motion.Data.SystemVariable.SysVarIdx = $[1];
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = $[2];
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
          DispatchMPList(::);
      elif ($[1] == CNC_SYS_VAR_SCALE_NORM_MP_AXIS)
          %_CNC.scale_normal_main_plane_axis = $[2];
          #next_motion.Data.SystemVariable.SysVarIdx = $[1];
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = $[2];
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
          DispatchMPList(::);
      elif ($[1] == CNC_SYS_VAR_SCALE_LINEAR_AXES)
          %_CNC.scale_linear_axes = $[2];
          #next_motion.Data.SystemVariable.SysVarIdx = $[1];
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = $[2];
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
          DispatchMPList(::);
      elif ($[1] == CNC_SYS_VAR_SCALE_GEOM_PARAM)
          %_CNC.scale_geometry_parameter = $[2];
          #next_motion.Data.SystemVariable.SysVarIdx = $[1];
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = $[2];
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
          DispatchMPList(::);
      elif ($[1] == CNC_SYS_VAR_SCALE_1ST_CARTESIAN_AXIS)
          %_CNC.scale_1st_cartesian_axis = $[2];
          #next_motion.Data.SystemVariable.SysVarIdx = $[1];
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = $[2];
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
          DispatchMPList(::);
      elif ($[1] == CNC_SYS_VAR_SCALE_2ND_CARTESIAN_AXIS)
          %_CNC.scale_2nd_cartesian_axis = $[2];
          #next_motion.Data.SystemVariable.SysVarIdx = $[1];
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = $[2];
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
          DispatchMPList(::);
      elif ($[1] == CNC_SYS_VAR_SCALE_3RD_CARTESIAN_AXIS)
          %_CNC.scale_3rd_cartesian_axis = $[2];
          #next_motion.Data.SystemVariable.SysVarIdx = $[1];
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = $[2];
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
          DispatchMPList(::);
      endif
    </SET_SCALE_FACTOR>
    <RESET_SCALING MinArgs="0" MaxArgs="0">
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_NORM_MP_AXIS, 1.0:);
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_LINEAR_AXES, 1.0:);
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_MPLANE_AXES, 1.0:);
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_GEOM_PARAM, 1.0:);
      `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_1ST_CARTESIAN_AXIS, 1.0:);
      `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_2ND_CARTESIAN_AXIS, 1.0:);
      `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_3RD_CARTESIAN_AXIS, 1.0:);
    </RESET_SCALING>
    <WAIT_UNTIL MinArgs="1" MaxArgs="1" Inline="Yes">
      WaitUntil(:$[1]:)
    </WAIT_UNTIL>
    <WAIT_UNTIL_SYNC MinArgs="1" MaxArgs="1" Inline="Yes">
      #next_motion.Command = MPCMD_IP_SYNCH_PATH;
      PushPacket(::);
      DispatchAndWait(:IPCMD_SYNC_PATH_CONT:);
      WaitUntil(:$[1]:)
    </WAIT_UNTIL_SYNC>
    <WAIT_UNTIL_FLUSH MinArgs="1" MaxArgs="1" Inline="Yes">
      #next_motion.Command = MPCMD_IP_SYNCH_PATH;
      PushPacket(::);
      DispatchAndWait(:IPCMD_SYNC_PATH_CONT:);
      WaitUntil(:$[1]:)
      #next_motion.Command = MPCMD_IMMED_PROC_DATA;
      PushPacket(::);
    </WAIT_UNTIL_FLUSH>
    <WRITE_TO_PLOT_BUFFER MinArgs="1" MaxArgs="1">
      MemCpy(:\#next_motion.Data.GenericData.Data, \$[1]:);
      #next_motion.Command = MPCMD_PLOT_BUFFER_DATA;
      PushPacket(::);
    </WRITE_TO_PLOT_BUFFER>
  </BuiltInProcs>
  <BuiltInFns>
    <F_TO_ANGLES MinArgs="1" MaxArgs="4" Inline="Yes">FToAngles(:${*}:)</F_TO_ANGLES>
    <F_TO_EULER  MinArgs="1" MaxArgs="3" Inline="Yes">FToEuler(:${*}:)</F_TO_EULER>
    <F_TO_RPY    MinArgs="1" MaxArgs="3" Inline="Yes">FToRPY(:${*}:)</F_TO_RPY>
    <F_TO_TRANS  MinArgs="1" MaxArgs="1" Inline="Yes">FToTrans(:\$[1]:)</F_TO_TRANS>
  </BuiltInFns>
  <PVMacros>
    <!--SysVars are prefixed by token SYSVAR_PREFIX-->
    <WORKFRAME Name="$WFRAME" ArrayDims="0">
      <SET Inline="Yes">
        #next_motion.Data.Frame.Data = ${EXPR};
        #next_motion.Command = MPCMD_W_FRAME;
        PushPacket(::);
      </SET>
    </WORKFRAME>
    <WORKFRAME_ADD Name="$WFRAME_ADD" ArrayDims="0">
      <SET Inline="Yes">
        #next_motion.Data.Frame.Data = ${EXPR};
        #next_motion.Command = MPCMD_W_FRAME_ADD;
        PushPacket(::);
      </SET>
    </WORKFRAME_ADD>
    <!--NOTE: $TIME is not included because it is declared as an alias of G04-->
    <LATCH0_EV Name="$L0.EV" CanWrite="No"> <REF> @%_CNC.latch0.ev </REF> </LATCH0_EV>
    <LATCH1_EV Name="$L1.EV" CanWrite="No"> <REF> @%_CNC.latch1.ev </REF> </LATCH1_EV>
    <LATCH2_EV Name="$L2.EV" CanWrite="No"> <REF> @%_CNC.latch2.ev </REF> </LATCH2_EV>
    <LATCH3_EV Name="$L3.EV" CanWrite="No"> <REF> @%_CNC.latch3.ev </REF> </LATCH3_EV>
    <LATCH4_EV Name="$L4.EV" CanWrite="No"> <REF> @%_CNC.latch4.ev </REF> </LATCH4_EV>
    <LATCH5_EV Name="$L5.EV" CanWrite="No"> <REF> @%_CNC.latch5.ev </REF> </LATCH5_EV>
    <LATCH6_EV Name="$L6.EV" CanWrite="No"> <REF> @%_CNC.latch6.ev </REF> </LATCH6_EV>
    <LATCH7_EV Name="$L7.EV" CanWrite="No"> <REF> @%_CNC.latch7.ev </REF> </LATCH7_EV>
    <LATCH8_EV Name="$L8.EV" CanWrite="No"> <REF> @%_CNC.latch8.ev </REF> </LATCH8_EV>
    <LATCH9_EV Name="$L9.EV" CanWrite="No"> <REF> @%_CNC.latch9.ev </REF> </LATCH9_EV>

    <LATCH0_POS10 Name="$L0.S10" CanWrite="No"> <REF> @%_CNC.latch0.pos10 </REF> </LATCH0_POS10>
    <LATCH0_POS11 Name="$L0.S11" CanWrite="No"> <REF> @%_CNC.latch0.pos11 </REF> </LATCH0_POS11>
    <LATCH0_POS12 Name="$L0.S12" CanWrite="No"> <REF> @%_CNC.latch0.pos12 </REF> </LATCH0_POS12>
    <LATCH0_POS13 Name="$L0.S13" CanWrite="No"> <REF> @%_CNC.latch0.pos13 </REF> </LATCH0_POS13>
    <LATCH0_POS14 Name="$L0.S14" CanWrite="No"> <REF> @%_CNC.latch0.pos14 </REF> </LATCH0_POS14>
    <LATCH0_POS0 Name="$L0.S0" CanWrite="No"> <REF> @%_CNC.latch0.pos0 </REF> </LATCH0_POS0>
    <LATCH0_POS1 Name="$L0.S1" CanWrite="No"> <REF> @%_CNC.latch0.pos1 </REF> </LATCH0_POS1>
    <LATCH0_POS2 Name="$L0.S2" CanWrite="No"> <REF> @%_CNC.latch0.pos2 </REF> </LATCH0_POS2>
    <LATCH0_POS3 Name="$L0.S3" CanWrite="No"> <REF> @%_CNC.latch0.pos3 </REF> </LATCH0_POS3>
    <LATCH0_POS4 Name="$L0.S4" CanWrite="No"> <REF> @%_CNC.latch0.pos4 </REF> </LATCH0_POS4>
    <LATCH0_POS5 Name="$L0.S5" CanWrite="No"> <REF> @%_CNC.latch0.pos5 </REF> </LATCH0_POS5>
    <LATCH0_POS6 Name="$L0.S6" CanWrite="No"> <REF> @%_CNC.latch0.pos6 </REF> </LATCH0_POS6>
    <LATCH0_POS7 Name="$L0.S7" CanWrite="No"> <REF> @%_CNC.latch0.pos7 </REF> </LATCH0_POS7>
    <LATCH0_POS8 Name="$L0.S8" CanWrite="No"> <REF> @%_CNC.latch0.pos8 </REF> </LATCH0_POS8>
    <LATCH0_POS9 Name="$L0.S9" CanWrite="No"> <REF> @%_CNC.latch0.pos9 </REF> </LATCH0_POS9>

    <LATCH1_POS10 Name="$L1.S10" CanWrite="No"> <REF> @%_CNC.latch1.pos10 </REF> </LATCH1_POS10>
    <LATCH1_POS11 Name="$L1.S11" CanWrite="No"> <REF> @%_CNC.latch1.pos11 </REF> </LATCH1_POS11>
    <LATCH1_POS12 Name="$L1.S12" CanWrite="No"> <REF> @%_CNC.latch1.pos12 </REF> </LATCH1_POS12>
    <LATCH1_POS13 Name="$L1.S13" CanWrite="No"> <REF> @%_CNC.latch1.pos13 </REF> </LATCH1_POS13>
    <LATCH1_POS14 Name="$L1.S14" CanWrite="No"> <REF> @%_CNC.latch1.pos14 </REF> </LATCH1_POS14>
    <LATCH1_POS0 Name="$L1.S0" CanWrite="No"> <REF> @%_CNC.latch1.pos0 </REF> </LATCH1_POS0>
    <LATCH1_POS1 Name="$L1.S1" CanWrite="No"> <REF> @%_CNC.latch1.pos1 </REF> </LATCH1_POS1>
    <LATCH1_POS2 Name="$L1.S2" CanWrite="No"> <REF> @%_CNC.latch1.pos2 </REF> </LATCH1_POS2>
    <LATCH1_POS3 Name="$L1.S3" CanWrite="No"> <REF> @%_CNC.latch1.pos3 </REF> </LATCH1_POS3>
    <LATCH1_POS4 Name="$L1.S4" CanWrite="No"> <REF> @%_CNC.latch1.pos4 </REF> </LATCH1_POS4>
    <LATCH1_POS5 Name="$L1.S5" CanWrite="No"> <REF> @%_CNC.latch1.pos5 </REF> </LATCH1_POS5>
    <LATCH1_POS6 Name="$L1.S6" CanWrite="No"> <REF> @%_CNC.latch1.pos6 </REF> </LATCH1_POS6>
    <LATCH1_POS7 Name="$L1.S7" CanWrite="No"> <REF> @%_CNC.latch1.pos7 </REF> </LATCH1_POS7>
    <LATCH1_POS8 Name="$L1.S8" CanWrite="No"> <REF> @%_CNC.latch1.pos8 </REF> </LATCH1_POS8>
    <LATCH1_POS9 Name="$L1.S9" CanWrite="No"> <REF> @%_CNC.latch1.pos9 </REF> </LATCH1_POS9>

    <LATCH2_POS10 Name="$L2.S10" CanWrite="No"> <REF> @%_CNC.latch2.pos10 </REF> </LATCH2_POS10>
    <LATCH2_POS11 Name="$L2.S11" CanWrite="No"> <REF> @%_CNC.latch2.pos11 </REF> </LATCH2_POS11>
    <LATCH2_POS12 Name="$L2.S12" CanWrite="No"> <REF> @%_CNC.latch2.pos12 </REF> </LATCH2_POS12>
    <LATCH2_POS13 Name="$L2.S13" CanWrite="No"> <REF> @%_CNC.latch2.pos13 </REF> </LATCH2_POS13>
    <LATCH2_POS14 Name="$L2.S14" CanWrite="No"> <REF> @%_CNC.latch2.pos14 </REF> </LATCH2_POS14>
    <LATCH2_POS0 Name="$L2.S0" CanWrite="No"> <REF> @%_CNC.latch2.pos0 </REF> </LATCH2_POS0>
    <LATCH2_POS1 Name="$L2.S1" CanWrite="No"> <REF> @%_CNC.latch2.pos1 </REF> </LATCH2_POS1>
    <LATCH2_POS2 Name="$L2.S2" CanWrite="No"> <REF> @%_CNC.latch2.pos2 </REF> </LATCH2_POS2>
    <LATCH2_POS3 Name="$L2.S3" CanWrite="No"> <REF> @%_CNC.latch2.pos3 </REF> </LATCH2_POS3>
    <LATCH2_POS4 Name="$L2.S4" CanWrite="No"> <REF> @%_CNC.latch2.pos4 </REF> </LATCH2_POS4>
    <LATCH2_POS5 Name="$L2.S5" CanWrite="No"> <REF> @%_CNC.latch2.pos5 </REF> </LATCH2_POS5>
    <LATCH2_POS6 Name="$L2.S6" CanWrite="No"> <REF> @%_CNC.latch2.pos6 </REF> </LATCH2_POS6>
    <LATCH2_POS7 Name="$L2.S7" CanWrite="No"> <REF> @%_CNC.latch2.pos7 </REF> </LATCH2_POS7>
    <LATCH2_POS8 Name="$L2.S8" CanWrite="No"> <REF> @%_CNC.latch2.pos8 </REF> </LATCH2_POS8>
    <LATCH2_POS9 Name="$L2.S9" CanWrite="No"> <REF> @%_CNC.latch2.pos9 </REF> </LATCH2_POS9>

    <LATCH3_POS10 Name="$L3.S10" CanWrite="No"> <REF> @%_CNC.latch3.pos10 </REF> </LATCH3_POS10>
    <LATCH3_POS11 Name="$L3.S11" CanWrite="No"> <REF> @%_CNC.latch3.pos11 </REF> </LATCH3_POS11>
    <LATCH3_POS12 Name="$L3.S12" CanWrite="No"> <REF> @%_CNC.latch3.pos12 </REF> </LATCH3_POS12>
    <LATCH3_POS13 Name="$L3.S13" CanWrite="No"> <REF> @%_CNC.latch3.pos13 </REF> </LATCH3_POS13>
    <LATCH3_POS14 Name="$L3.S14" CanWrite="No"> <REF> @%_CNC.latch3.pos14 </REF> </LATCH3_POS14>
    <LATCH3_POS0 Name="$L3.S0" CanWrite="No"> <REF> @%_CNC.latch3.pos0 </REF> </LATCH3_POS0>
    <LATCH3_POS1 Name="$L3.S1" CanWrite="No"> <REF> @%_CNC.latch3.pos1 </REF> </LATCH3_POS1>
    <LATCH3_POS2 Name="$L3.S2" CanWrite="No"> <REF> @%_CNC.latch3.pos2 </REF> </LATCH3_POS2>
    <LATCH3_POS3 Name="$L3.S3" CanWrite="No"> <REF> @%_CNC.latch3.pos3 </REF> </LATCH3_POS3>
    <LATCH3_POS4 Name="$L3.S4" CanWrite="No"> <REF> @%_CNC.latch3.pos4 </REF> </LATCH3_POS4>
    <LATCH3_POS5 Name="$L3.S5" CanWrite="No"> <REF> @%_CNC.latch3.pos5 </REF> </LATCH3_POS5>
    <LATCH3_POS6 Name="$L3.S6" CanWrite="No"> <REF> @%_CNC.latch3.pos6 </REF> </LATCH3_POS6>
    <LATCH3_POS7 Name="$L3.S7" CanWrite="No"> <REF> @%_CNC.latch3.pos7 </REF> </LATCH3_POS7>
    <LATCH3_POS8 Name="$L3.S8" CanWrite="No"> <REF> @%_CNC.latch3.pos8 </REF> </LATCH3_POS8>
    <LATCH3_POS9 Name="$L3.S9" CanWrite="No"> <REF> @%_CNC.latch3.pos9 </REF> </LATCH3_POS9>

    <LATCH4_POS10 Name="$L4.S10" CanWrite="No"> <REF> @%_CNC.latch4.pos10 </REF> </LATCH4_POS10>
    <LATCH4_POS11 Name="$L4.S11" CanWrite="No"> <REF> @%_CNC.latch4.pos11 </REF> </LATCH4_POS11>
    <LATCH4_POS12 Name="$L4.S12" CanWrite="No"> <REF> @%_CNC.latch4.pos12 </REF> </LATCH4_POS12>
    <LATCH4_POS13 Name="$L4.S13" CanWrite="No"> <REF> @%_CNC.latch4.pos13 </REF> </LATCH4_POS13>
    <LATCH4_POS14 Name="$L4.S14" CanWrite="No"> <REF> @%_CNC.latch4.pos14 </REF> </LATCH4_POS14>
    <LATCH4_POS0 Name="$L4.S0" CanWrite="No"> <REF> @%_CNC.latch4.pos0 </REF> </LATCH4_POS0>
    <LATCH4_POS1 Name="$L4.S1" CanWrite="No"> <REF> @%_CNC.latch4.pos1 </REF> </LATCH4_POS1>
    <LATCH4_POS2 Name="$L4.S2" CanWrite="No"> <REF> @%_CNC.latch4.pos2 </REF> </LATCH4_POS2>
    <LATCH4_POS3 Name="$L4.S3" CanWrite="No"> <REF> @%_CNC.latch4.pos3 </REF> </LATCH4_POS3>
    <LATCH4_POS4 Name="$L4.S4" CanWrite="No"> <REF> @%_CNC.latch4.pos4 </REF> </LATCH4_POS4>
    <LATCH4_POS5 Name="$L4.S5" CanWrite="No"> <REF> @%_CNC.latch4.pos5 </REF> </LATCH4_POS5>
    <LATCH4_POS6 Name="$L4.S6" CanWrite="No"> <REF> @%_CNC.latch4.pos6 </REF> </LATCH4_POS6>
    <LATCH4_POS7 Name="$L4.S7" CanWrite="No"> <REF> @%_CNC.latch4.pos7 </REF> </LATCH4_POS7>
    <LATCH4_POS8 Name="$L4.S8" CanWrite="No"> <REF> @%_CNC.latch4.pos8 </REF> </LATCH4_POS8>
    <LATCH4_POS9 Name="$L4.S9" CanWrite="No"> <REF> @%_CNC.latch4.pos9 </REF> </LATCH4_POS9>

    <LATCH5_POS10 Name="$L5.S10" CanWrite="No"> <REF> @%_CNC.latch5.pos10 </REF> </LATCH5_POS10>
    <LATCH5_POS11 Name="$L5.S11" CanWrite="No"> <REF> @%_CNC.latch5.pos11 </REF> </LATCH5_POS11>
    <LATCH5_POS12 Name="$L5.S12" CanWrite="No"> <REF> @%_CNC.latch5.pos12 </REF> </LATCH5_POS12>
    <LATCH5_POS13 Name="$L5.S13" CanWrite="No"> <REF> @%_CNC.latch5.pos13 </REF> </LATCH5_POS13>
    <LATCH5_POS14 Name="$L5.S14" CanWrite="No"> <REF> @%_CNC.latch5.pos14 </REF> </LATCH5_POS14>
    <LATCH5_POS0 Name="$L5.S0" CanWrite="No"> <REF> @%_CNC.latch5.pos0 </REF> </LATCH5_POS0>
    <LATCH5_POS1 Name="$L5.S1" CanWrite="No"> <REF> @%_CNC.latch5.pos1 </REF> </LATCH5_POS1>
    <LATCH5_POS2 Name="$L5.S2" CanWrite="No"> <REF> @%_CNC.latch5.pos2 </REF> </LATCH5_POS2>
    <LATCH5_POS3 Name="$L5.S3" CanWrite="No"> <REF> @%_CNC.latch5.pos3 </REF> </LATCH5_POS3>
    <LATCH5_POS4 Name="$L5.S4" CanWrite="No"> <REF> @%_CNC.latch5.pos4 </REF> </LATCH5_POS4>
    <LATCH5_POS5 Name="$L5.S5" CanWrite="No"> <REF> @%_CNC.latch5.pos5 </REF> </LATCH5_POS5>
    <LATCH5_POS6 Name="$L5.S6" CanWrite="No"> <REF> @%_CNC.latch5.pos6 </REF> </LATCH5_POS6>
    <LATCH5_POS7 Name="$L5.S7" CanWrite="No"> <REF> @%_CNC.latch5.pos7 </REF> </LATCH5_POS7>
    <LATCH5_POS8 Name="$L5.S8" CanWrite="No"> <REF> @%_CNC.latch5.pos8 </REF> </LATCH5_POS8>
    <LATCH5_POS9 Name="$L5.S9" CanWrite="No"> <REF> @%_CNC.latch5.pos9 </REF> </LATCH5_POS9>

    <LATCH6_POS10 Name="$L6.S10" CanWrite="No"> <REF> @%_CNC.latch6.pos10 </REF> </LATCH6_POS10>
    <LATCH6_POS11 Name="$L6.S11" CanWrite="No"> <REF> @%_CNC.latch6.pos11 </REF> </LATCH6_POS11>
    <LATCH6_POS12 Name="$L6.S12" CanWrite="No"> <REF> @%_CNC.latch6.pos12 </REF> </LATCH6_POS12>
    <LATCH6_POS13 Name="$L6.S13" CanWrite="No"> <REF> @%_CNC.latch6.pos13 </REF> </LATCH6_POS13>
    <LATCH6_POS14 Name="$L6.S14" CanWrite="No"> <REF> @%_CNC.latch6.pos14 </REF> </LATCH6_POS14>
    <LATCH6_POS0 Name="$L6.S0" CanWrite="No"> <REF> @%_CNC.latch6.pos0 </REF> </LATCH6_POS0>
    <LATCH6_POS1 Name="$L6.S1" CanWrite="No"> <REF> @%_CNC.latch6.pos1 </REF> </LATCH6_POS1>
    <LATCH6_POS2 Name="$L6.S2" CanWrite="No"> <REF> @%_CNC.latch6.pos2 </REF> </LATCH6_POS2>
    <LATCH6_POS3 Name="$L6.S3" CanWrite="No"> <REF> @%_CNC.latch6.pos3 </REF> </LATCH6_POS3>
    <LATCH6_POS4 Name="$L6.S4" CanWrite="No"> <REF> @%_CNC.latch6.pos4 </REF> </LATCH6_POS4>
    <LATCH6_POS5 Name="$L6.S5" CanWrite="No"> <REF> @%_CNC.latch6.pos5 </REF> </LATCH6_POS5>
    <LATCH6_POS6 Name="$L6.S6" CanWrite="No"> <REF> @%_CNC.latch6.pos6 </REF> </LATCH6_POS6>
    <LATCH6_POS7 Name="$L6.S7" CanWrite="No"> <REF> @%_CNC.latch6.pos7 </REF> </LATCH6_POS7>
    <LATCH6_POS8 Name="$L6.S8" CanWrite="No"> <REF> @%_CNC.latch6.pos8 </REF> </LATCH6_POS8>
    <LATCH6_POS9 Name="$L6.S9" CanWrite="No"> <REF> @%_CNC.latch6.pos9 </REF> </LATCH6_POS9>

    <LATCH7_POS10 Name="$L7.S10" CanWrite="No"> <REF> @%_CNC.latch7.pos10 </REF> </LATCH7_POS10>
    <LATCH7_POS11 Name="$L7.S11" CanWrite="No"> <REF> @%_CNC.latch7.pos11 </REF> </LATCH7_POS11>
    <LATCH7_POS12 Name="$L7.S12" CanWrite="No"> <REF> @%_CNC.latch7.pos12 </REF> </LATCH7_POS12>
    <LATCH7_POS13 Name="$L7.S13" CanWrite="No"> <REF> @%_CNC.latch7.pos13 </REF> </LATCH7_POS13>
    <LATCH7_POS14 Name="$L7.S14" CanWrite="No"> <REF> @%_CNC.latch7.pos14 </REF> </LATCH7_POS14>
    <LATCH7_POS0 Name="$L7.S0" CanWrite="No"> <REF> @%_CNC.latch7.pos0 </REF> </LATCH7_POS0>
    <LATCH7_POS1 Name="$L7.S1" CanWrite="No"> <REF> @%_CNC.latch7.pos1 </REF> </LATCH7_POS1>
    <LATCH7_POS2 Name="$L7.S2" CanWrite="No"> <REF> @%_CNC.latch7.pos2 </REF> </LATCH7_POS2>
    <LATCH7_POS3 Name="$L7.S3" CanWrite="No"> <REF> @%_CNC.latch7.pos3 </REF> </LATCH7_POS3>
    <LATCH7_POS4 Name="$L7.S4" CanWrite="No"> <REF> @%_CNC.latch7.pos4 </REF> </LATCH7_POS4>
    <LATCH7_POS5 Name="$L7.S5" CanWrite="No"> <REF> @%_CNC.latch7.pos5 </REF> </LATCH7_POS5>
    <LATCH7_POS6 Name="$L7.S6" CanWrite="No"> <REF> @%_CNC.latch7.pos6 </REF> </LATCH7_POS6>
    <LATCH7_POS7 Name="$L7.S7" CanWrite="No"> <REF> @%_CNC.latch7.pos7 </REF> </LATCH7_POS7>
    <LATCH7_POS8 Name="$L7.S8" CanWrite="No"> <REF> @%_CNC.latch7.pos8 </REF> </LATCH7_POS8>
    <LATCH7_POS9 Name="$L7.S9" CanWrite="No"> <REF> @%_CNC.latch7.pos9 </REF> </LATCH7_POS9>

    <LATCH8_POS10 Name="$L8.S10" CanWrite="No"> <REF> @%_CNC.latch8.pos10 </REF> </LATCH8_POS10>
    <LATCH8_POS11 Name="$L8.S11" CanWrite="No"> <REF> @%_CNC.latch8.pos11 </REF> </LATCH8_POS11>
    <LATCH8_POS12 Name="$L8.S12" CanWrite="No"> <REF> @%_CNC.latch8.pos12 </REF> </LATCH8_POS12>
    <LATCH8_POS13 Name="$L8.S13" CanWrite="No"> <REF> @%_CNC.latch8.pos13 </REF> </LATCH8_POS13>
    <LATCH8_POS14 Name="$L8.S14" CanWrite="No"> <REF> @%_CNC.latch8.pos14 </REF> </LATCH8_POS14>
    <LATCH8_POS0 Name="$L8.S0" CanWrite="No"> <REF> @%_CNC.latch8.pos0 </REF> </LATCH8_POS0>
    <LATCH8_POS1 Name="$L8.S1" CanWrite="No"> <REF> @%_CNC.latch8.pos1 </REF> </LATCH8_POS1>
    <LATCH8_POS2 Name="$L8.S2" CanWrite="No"> <REF> @%_CNC.latch8.pos2 </REF> </LATCH8_POS2>
    <LATCH8_POS3 Name="$L8.S3" CanWrite="No"> <REF> @%_CNC.latch8.pos3 </REF> </LATCH8_POS3>
    <LATCH8_POS4 Name="$L8.S4" CanWrite="No"> <REF> @%_CNC.latch8.pos4 </REF> </LATCH8_POS4>
    <LATCH8_POS5 Name="$L8.S5" CanWrite="No"> <REF> @%_CNC.latch8.pos5 </REF> </LATCH8_POS5>
    <LATCH8_POS6 Name="$L8.S6" CanWrite="No"> <REF> @%_CNC.latch8.pos6 </REF> </LATCH8_POS6>
    <LATCH8_POS7 Name="$L8.S7" CanWrite="No"> <REF> @%_CNC.latch8.pos7 </REF> </LATCH8_POS7>
    <LATCH8_POS8 Name="$L8.S8" CanWrite="No"> <REF> @%_CNC.latch8.pos8 </REF> </LATCH8_POS8>
    <LATCH8_POS9 Name="$L8.S9" CanWrite="No"> <REF> @%_CNC.latch8.pos9 </REF> </LATCH8_POS9>

    <LATCH9_POS10 Name="$L9.S10" CanWrite="No"> <REF> @%_CNC.latch9.pos10 </REF> </LATCH9_POS10>
    <LATCH9_POS11 Name="$L9.S11" CanWrite="No"> <REF> @%_CNC.latch9.pos11 </REF> </LATCH9_POS11>
    <LATCH9_POS12 Name="$L9.S12" CanWrite="No"> <REF> @%_CNC.latch9.pos12 </REF> </LATCH9_POS12>
    <LATCH9_POS13 Name="$L9.S13" CanWrite="No"> <REF> @%_CNC.latch9.pos13 </REF> </LATCH9_POS13>
    <LATCH9_POS14 Name="$L9.S14" CanWrite="No"> <REF> @%_CNC.latch9.pos14 </REF> </LATCH9_POS14>
    <LATCH9_POS0 Name="$L9.S0" CanWrite="No"> <REF> @%_CNC.latch9.pos0 </REF> </LATCH9_POS0>
    <LATCH9_POS1 Name="$L9.S1" CanWrite="No"> <REF> @%_CNC.latch9.pos1 </REF> </LATCH9_POS1>
    <LATCH9_POS2 Name="$L9.S2" CanWrite="No"> <REF> @%_CNC.latch9.pos2 </REF> </LATCH9_POS2>
    <LATCH9_POS3 Name="$L9.S3" CanWrite="No"> <REF> @%_CNC.latch9.pos3 </REF> </LATCH9_POS3>
    <LATCH9_POS4 Name="$L9.S4" CanWrite="No"> <REF> @%_CNC.latch9.pos4 </REF> </LATCH9_POS4>
    <LATCH9_POS5 Name="$L9.S5" CanWrite="No"> <REF> @%_CNC.latch9.pos5 </REF> </LATCH9_POS5>
    <LATCH9_POS6 Name="$L9.S6" CanWrite="No"> <REF> @%_CNC.latch9.pos6 </REF> </LATCH9_POS6>
    <LATCH9_POS7 Name="$L9.S7" CanWrite="No"> <REF> @%_CNC.latch9.pos7 </REF> </LATCH9_POS7>
    <LATCH9_POS8 Name="$L9.S8" CanWrite="No"> <REF> @%_CNC.latch9.pos8 </REF> </LATCH9_POS8>
    <LATCH9_POS9 Name="$L9.S9" CanWrite="No"> <REF> @%_CNC.latch9.pos9 </REF> </LATCH9_POS9>
  </PVMacros>

  <SysVars>
    <!-- Note 1: Path synchronous system variables - prefix AIL variable with "@" -->
    <!-- Note 2: variable type is as declared in ARNC0 -->
    <!-- Note 3: CanRead and CanWrite permissions default to "Yes" if not specified -->
    <!-- Note 4: If using <SET> and <GET> instead of <REF>, then do not specify CanRead/Write -->
    <D Name="$D" ArrayDims="0" Group="104">
      <!--Tool Data Number-->
      <GET>
        return #sys_vars.D;
      </GET>
      </D>
    <RAD Name="$RAD" ArrayDims="0" Group="104">
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        #next_motion.Command = MPCMD_TOOL_RADIUS;
        #next_motion.Data.R8_value = ${EXPR};
        PushPacket(::);
        #sys_vars.RAD = ${EXPR};
      </SET>
      <GET>
        return #sys_vars.RAD;
      </GET>
      </RAD>
    <RAD_IDX Name="$RAD_IDX" ArrayDims="0" Group="104">
      <!-- Write only -->
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        #next_motion.Command = MPCMD_TOOL_RADIUS_IDX;
        #next_motion.Data.I4_value = ${EXPR};
        PushPacket(::);
        #sys_vars.RAD_IDX = ${EXPR};
      </SET>
    </RAD_IDX>
    <T Name="$T" ArrayDims="0" Group="104">
      <!--Tool Location Number-->
      <GET>
        return #sys_vars.T;
      </GET>
      </T>
    <ZP Name="$ZP" ArrayDims="0" Group="104">
      <GET>
        return #sys_vars.ZP;
      </GET>
    </ZP>
    <FILTER_ERR Name="$FILTER_ERR">
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_CNC.filter_err = ${EXPR};
        %_CNC.filter_err_cir = ${EXPR};
        %_CNC.filter_err_trans = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_FILTER_ERR;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.filter_err;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </FILTER_ERR>
    <FILTER_ERR_CIR Name="$FILTER_ERR_CIR">
      <GET>
        return %_CNC.filter_err_cir;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_CNC.filter_err_cir = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_FILTER_ERR_CIR;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.filter_err_cir;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </FILTER_ERR_CIR>
    <FILTER_ERR_TRANS Name="$FILTER_ERR_TRANS">
      <GET>
        return %_CNC.filter_err_trans;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_CNC.filter_err_trans = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_FILTER_ERR_TRANS;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.filter_err_trans;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </FILTER_ERR_TRANS>
    <BLENDED_MOVE_MODE_TA Name="$TA">
      <GET>
        return %_CNC.TA;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
         %_CNC.TA = ${EXPR};
         if (%_CNC.TA &lt; 0)
           %_CNC.TA = 0;
         endif
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_BLENDMOVEMODE_TA;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.TA;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </BLENDED_MOVE_MODE_TA>
    <FRAME_ANGLE_INPUT_MODE Name = "$FRAME_ANGLE_INPUT_MODE">
      <GET>
        return %_CNC.frame_angle_input_mode;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT"/>
        %_CNC.frame_angle_input_mode = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_FRAME_ANGLE_MODE;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.frame_angle_input_mode;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </FRAME_ANGLE_INPUT_MODE>
    <MOVE_CMD_MODE Name="$MOVE_CMD_MODE">
      <GET>
        return (%_CNC.move_cmd_mode - MPCMD_RAPID_MOVE_INTPOL);
      </GET>
    </MOVE_CMD_MODE>
    <CO_ORDS_MODE Name="$CO_ORDS_MODE" CanWrite="No">
      <REF>
        @%_CNC.co_ords_mode
      </REF>
    </CO_ORDS_MODE>
    <CENTER_MODE Name="$CENTER_MODE" CanWrite="No">
      <REF>
        @%_CNC.center_mode
      </REF>
    </CENTER_MODE>
    <P_EP Name="$P_EP" ArrayDims="1" IpEval="Yes">
      <GET>
        #next_motion.Command = MPCMD_IP_SYNCH_PP;
        PushPacket(::);
        DispatchAndWait(:IPCMD_SYNC_PP_CONT:);
        return @%_AX.end_pos[$[1]];
      </GET>
    </P_EP>
    <P_EM Name="$P_EM" ArrayDims="1" IpEval="Yes">
      <GET>
        #next_motion.Command = MPCMD_IP_SYNCH_PP;
        PushPacket(::);
        DispatchAndWait(:IPCMD_SYNC_PP_CONT:);
        return @%_AX.end_pos_mcs[$[1]];
      </GET>
    </P_EM>

    <PSM_PHASE Name="$PSM_PHASE">
      <GET>
          return @%_CNC.psm_phase;
      </GET>
    </PSM_PHASE>
    <PSM1_ANGLE Name = "$PSM1_ANGLE">
      <GET>
          return %_CNC.psm1_angle;
      </GET>
      <SET>
          <ARG ref="EXPR" DataType="FLOAT"/>
          %_CNC.psm1_angle = ${EXPR};
          #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_PSM1_ANGLE;
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.psm1_angle;
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
      </SET>
    </PSM1_ANGLE>
    <PSM1_V_APCH Name = "$PSM1_V_APCH">
      <GET>
          return %_CNC.psm1_v_apch;
      </GET>
      <SET>
          <ARG ref="EXPR" DataType="FLOAT"/>
          %_CNC.psm1_v_apch = ${EXPR};
          #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_PSM1_V_APCH;
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.psm1_v_apch;
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
      </SET>
    </PSM1_V_APCH>
    <PSM1_S_APCH Name = "$PSM1_S_APCH">
      <GET>
          return %_CNC.psm1_s_apch;
      </GET>
      <SET>
          <ARG ref="EXPR" DataType="FLOAT"/>
          %_CNC.psm1_s_apch = ${EXPR};
          #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_PSM1_S_APCH;
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.psm1_s_apch;
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
      </SET>
    </PSM1_S_APCH>
    <PSM1_V_EDGE Name = "$PSM1_V_EDGE">
      <GET>
          return %_CNC.psm1_v_edge;
      </GET>
      <SET>
          <ARG ref="EXPR" DataType="FLOAT"/>
          %_CNC.psm1_v_edge = ${EXPR};
          #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_PSM1_V_EDGE;
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.psm1_v_edge;
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
      </SET>
    </PSM1_V_EDGE>
    <PSM1_S_EDGE Name = "$PSM1_S_EDGE">
      <GET>
          return %_CNC.psm1_s_edge;
      </GET>
      <SET>
          <ARG ref="EXPR" DataType="FLOAT"/>
          %_CNC.psm1_s_edge = ${EXPR};
          #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_PSM1_S_EDGE;
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.psm1_s_edge;
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
      </SET>
    </PSM1_S_EDGE>
    <PSM1_T_PIERCE Name = "$PSM1_T_PIERCE">
      <GET>
          return %_CNC.psm1_t_pierce;
      </GET>
      <SET>
          <ARG ref="EXPR" DataType="FLOAT"/>
          %_CNC.psm1_t_pierce = ${EXPR};
          #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_PSM1_T_PIERCE;
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.psm1_t_pierce;
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
      </SET>
    </PSM1_T_PIERCE>
    <ACC_HOLD_ADD_T_WAIT Name = "$ACC_HOLD_ADD_T_WAIT">
      <GET>
        return %_CNC.acc_hold_add_t_wait;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
        %_CNC.acc_hold_add_t_wait = ${EXPR};

        <!--G172: Wait for motion completion-->
        #next_motion.Command = MPCMD_IP_SYNCH_PATH;
        PushPacket(::);
        DispatchAndWait(:IPCMD_SYNC_PATH_CONT:);

        <!--send $ACC_HOLD_ADD_T_WAIT motion packet-->
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_ACC_HOLD_ADD_T_WAIT;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.acc_hold_add_t_wait;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </ACC_HOLD_ADD_T_WAIT>
    <CDC_OVS_DISTANCE Name = "$CDC_OVS_DISTANCE">
      <GET>
          return %_CNC.cdc_ovs_distance;
      </GET>
      <SET>
          <ARG ref="EXPR" DataType="FLOAT"/>
          %_CNC.cdc_ovs_distance = ${EXPR};
          #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_CDC_OVS_DISTANCE;
          #next_motion.Data.SystemVariable.AxIdx = -1;
          #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.cdc_ovs_distance;
          #next_motion.Command = MPCMD_CNC_SYS_VAR;
          PushPacket(::);
      </SET>
    </CDC_OVS_DISTANCE>
    <CDC_OVS_ANGLE Name = "$CDC_OVS_ANGLE">
          <GET>
              return %_CNC.cdc_ovs_angle;
          </GET>
          <SET>
              <ARG ref="EXPR" DataType="FLOAT"/>
              %_CNC.cdc_ovs_angle = ${EXPR};
              #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_CDC_OVS_ANGLE;
              #next_motion.Data.SystemVariable.AxIdx = -1;
              #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.cdc_ovs_angle;
              #next_motion.Command = MPCMD_CNC_SYS_VAR;
              PushPacket(::);
          </SET>
    </CDC_OVS_ANGLE>
    <CDC_PROG_END_LEAD_OUT Name = "$CDC_PROG_END_LEAD_OUT">
      <GET>
        return %_CNC.cdc_prog_end_lead_out;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT"/>
        %_CNC.cdc_prog_end_lead_out = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_CDC_PROG_END_LEAD_OUT;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.cdc_prog_end_lead_out;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </CDC_PROG_END_LEAD_OUT>
    <CDC_LEAD_OUT Name = "$CDC_LEAD_OUT">
      <GET>
        return %_CNC.cdc_lead_out;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT"/>
        %_CNC.cdc_lead_out = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_CDC_LEAD_OUT;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.cdc_lead_out;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </CDC_LEAD_OUT>
    <CDC_DUPLICATE_POS_PROG Name = "$CDC_DUPLICATE_POS_PROG">
      <GET>
        return %_CNC.cdc_duplicate_pos_prog;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT"/>
        %_CNC.cdc_duplicate_pos_prog = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_CDC_DUPLICATE_POS_PROG;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.cdc_duplicate_pos_prog;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </CDC_DUPLICATE_POS_PROG>
    <SCALE_MAIN_PLANE_AXES Name = "$SCALE_MAIN_PLANE_AXES">
      <GET>
        return %_CNC.scale_main_plane_axes;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_MPLANE_AXES, ${EXPR}:);
      </SET>
    </SCALE_MAIN_PLANE_AXES>
    <SCALE_1ST_CARTESIAN_AXIS Name = "$SCALE_1ST_CARTESIAN_AXIS">
      <GET>
        return %_CNC.scale_1st_cartesian_axis;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
        `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_1ST_CARTESIAN_AXIS, ${EXPR}:);
      </SET>
    </SCALE_1ST_CARTESIAN_AXIS>
    <SCALE_2ND_CARTESIAN_AXIS Name = "$SCALE_2ND_CARTESIAN_AXIS">
      <GET>
        return %_CNC.scale_2nd_cartesian_axis;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
        `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_2ND_CARTESIAN_AXIS, ${EXPR}:);
      </SET>
    </SCALE_2ND_CARTESIAN_AXIS>
    <SCALE_3RD_CARTESIAN_AXIS Name = "$SCALE_3RD_CARTESIAN_AXIS">
      <GET>
        return %_CNC.scale_3rd_cartesian_axis;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
        `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_3RD_CARTESIAN_AXIS, ${EXPR}:);
      </SET>
    </SCALE_3RD_CARTESIAN_AXIS>
    <SCALE_NORM_MP_AXES Name = "$SCALE_NORMAL_MAIN_PLANE_AXIS">
      <GET>
        return %_CNC.scale_normal_main_plane_axis;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
        `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_NORM_MP_AXIS, ${EXPR}:);
      </SET>
    </SCALE_NORM_MP_AXES>
    <SCALE_LINEAR_AXES Name = "$SCALE_LINEAR_AXES">
      <GET>
        return %_CNC.scale_linear_axes;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
        `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_LINEAR_AXES, ${EXPR}:);
      </SET>
    </SCALE_LINEAR_AXES>
    <SCALE_GEOM_PARAM Name = "$SCALE_GEOMETRY_PARAMETER">
      <GET>
        return %_CNC.scale_geometry_parameter;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
        `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_GEOM_PARAM, ${EXPR}:);
      </SET>
    </SCALE_GEOM_PARAM>
    <V_PATH_MODE Name = "$V_PATH_MODE">
      <GET>
        return %_CNC.v_path_mode;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT"/>
        %_CNC.v_path_mode = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_V_PATH_MODE;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.v_path_mode;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </V_PATH_MODE>
    <BACK_LINE Name = "$BACK">
      <GET>
        return %_CNC.back;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT"/>
        %_CNC.back = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_BACK;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.back;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </BACK_LINE>
    <SIM_S_NCPROG Name ="$SIM_S_NCPROG">
      <REF>
         @%_CNC.sim_s_ncprog
      </REF>
    </SIM_S_NCPROG>
    <TRIG_HELP Name = "$TRIG_HELP">
      <GET>
        return %_CNC.trig_help;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT"/>
        %_CNC.trig_help = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_TRIG_HELP;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.trig_help;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </TRIG_HELP>
    <LINEAR_FEED_MODE Name = "$LINEAR_FEED_MODE">
      <GET>
        return %_CNC.linear_feed_mode;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT"/>
        %_CNC.linear_feed_mode = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_LINEAR_FEED_MODE;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.linear_feed_mode;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </LINEAR_FEED_MODE>

    <!-- CNC sourced system variables -->
    <P_F Name="$P_F">
      <GET>
        return @%_CNC.v_ncprog;
      </GET>
    </P_F>
    <P_GG Name="$P_GG">
      <GET>
        return @%_CNC.typ_ncblock;
      </GET>
    </P_GG>

    <LIM_PATH_V Name="$LIM_PATH_V">
      <GET>
        return %_CNC.lim_path_v;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_CNC.lim_path_v = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_LIM_PATH_V;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.lim_path_v;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </LIM_PATH_V>

    <LIM_PATH_ACC_P Name="$LIM_PATH_ACC_P">
      <GET>
        return %_CNC.lim_path_acc_p;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_CNC.lim_path_acc_p = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_LIM_PATH_ACC_P;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.lim_path_acc_p;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </LIM_PATH_ACC_P>

    <LIM_PATH_ACC_N Name="$LIM_PATH_ACC_N">
      <GET>
        return %_CNC.lim_path_acc_n;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_CNC.lim_path_acc_n = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_LIM_PATH_ACC_N;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.lim_path_acc_n;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </LIM_PATH_ACC_N>

    <S_JUMP_T Name="$S_JUMP_T">
      <GET>
        return %_CNC.s_jump_t;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_CNC.s_jump_t = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_S_JUMP_T;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.s_jump_t;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </S_JUMP_T>

    <RADIUS_ERR Name="$RADIUS_ERR">
      <GET>
        return %_CNC.radius_err;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_CNC.radius_err = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_RADIUS_ERR;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.radius_err;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </RADIUS_ERR>

    <RADIUS_ERR_MODE Name = "$RADIUS_ERR_MODE">
      <GET>
        return %_CNC.radius_err_mode;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT"/>
        %_CNC.radius_err_mode = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_RADIUS_ERR_MODE;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.radius_err_mode;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </RADIUS_ERR_MODE>

    <G102_MODE Name="$G102_MODE">
      <GET>
        return %_CNC.G102_mode;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT"/>
        %_CNC.G102_mode = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_G102_MODE;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.G102_mode;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </G102_MODE>

    <V_JUMP_T Name="$V_JUMP_T">
      <GET>
        return %_CNC.v_jump_t;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_CNC.v_jump_t = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_V_JUMP_T;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.v_jump_t;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </V_JUMP_T>

    <LIM_AX_ACC Name="$LIM_AX_ACC" ArrayDims="1">
      <GET>
        return %_AX.a_max_ncdy[$[1]];
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_AX.a_max_ncdy[$[1]] = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = AX_SYS_VAR_MAX_ACCEL_NCDY;
        #next_motion.Data.SystemVariable.AxIdx = $[1];
        #next_motion.Data.SystemVariable.Data.R8_value = %_AX.a_max_ncdy[$[1]];
        #next_motion.Command = MPCMD_AX_SYS_VAR;
        PushPacket(::);
      </SET>
    </LIM_AX_ACC>

    <LIM_ACC Name="ACC" ArrayDims="1">
      <GET>
        return %_AX.a_max_ncdy[$[1]] / %_AX.a_max[$[1]] * 100.0;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="AxisAccelPercentage" />
        %_AX.a_max_ncdy[$[1]] = ${EXPR} / 100.0 * %_AX.a_max[$[1]];
        #next_motion.Data.SystemVariable.SysVarIdx = AX_SYS_VAR_MAX_ACCEL_NCDY;
        #next_motion.Data.SystemVariable.AxIdx = $[1];
        #next_motion.Data.SystemVariable.Data.R8_value = %_AX.a_max_ncdy[$[1]];
        #next_motion.Command = MPCMD_AX_SYS_VAR;
        PushPacket(::);
      </SET>
    </LIM_ACC>

    <LIM_AX_V Name="$LIM_AX_V" ArrayDims="1">
      <GET>
        return %_AX.v_max_ncdy[$[1]];
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_AX.v_max_ncdy[$[1]] = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = AX_SYS_VAR_MAX_VELO_NCDY;
        #next_motion.Data.SystemVariable.AxIdx = $[1];
        #next_motion.Data.SystemVariable.Data.R8_value = %_AX.v_max_ncdy[$[1]];
        #next_motion.Command = MPCMD_AX_SYS_VAR;
        PushPacket(::);
      </SET>
    </LIM_AX_V>

    <USE_SYSTEM_UNIT Name="$USE_SYSTEM_UNIT" ArrayDims="1">
      <GET>
        return %_AX.use_system_unit[$[1]];
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="INT" />
        %_AX.use_system_unit[$[1]] = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = AX_SYS_VAR_USES_SYSTEM_UNIT;
        #next_motion.Data.SystemVariable.AxIdx = $[1];
        #next_motion.Data.SystemVariable.Data.I4_value = %_AX.use_system_unit[$[1]];
        #next_motion.Command = MPCMD_AX_SYS_VAR;
        PushPacket(::);
      </SET>
    </USE_SYSTEM_UNIT>    
    <AX_A_JUMP Name="$AX_A_JUMP" ArrayDims="1">
      <GET>
        return %_AX.a_jump_ncdy[$[1]];
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_AX.a_jump_ncdy[$[1]] = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = AX_SYS_VAR_A_JUMP_NCDY;
        #next_motion.Data.SystemVariable.AxIdx = $[1];
        #next_motion.Data.SystemVariable.Data.R8_value = %_AX.a_jump_ncdy[$[1]];
        #next_motion.Command = MPCMD_AX_SYS_VAR;
        PushPacket(::);
      </SET>
    </AX_A_JUMP>
    <AX_V_JUMP Name="$AX_V_JUMP" ArrayDims="1">
      <GET>
        return %_AX.v_jump_ncdy[$[1]];
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT" />
        %_AX.v_jump_ncdy[$[1]] = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = AX_SYS_VAR_V_JUMP_NCDY;
        #next_motion.Data.SystemVariable.AxIdx = $[1];
        #next_motion.Data.SystemVariable.Data.R8_value = %_AX.v_jump_ncdy[$[1]];
        #next_motion.Command = MPCMD_AX_SYS_VAR;
        PushPacket(::);
      </SET>
    </AX_V_JUMP>

    <AX_T_INPOS Name="$AX_T_INPOS" ArrayDims="1">
      <GET>
        return %_AX.t_inpos[$[1]];
      </GET>
    </AX_T_INPOS>

    <AX_T_IN_POS Name="$AX_T_IN_POS" ArrayDims="1">
      <GET>
        return %_AX.t_inpos[$[1]];
      </GET>
    </AX_T_IN_POS>

    <AX_T_JOLT Name="$AX_T_JOLT" ArrayDims="1">
      <GET>
        return %_AX.t_jolt_ax[$[1]];
      </GET>
    </AX_T_JOLT>

    <PATH_T_JOLT Name="$PATH_T_JOLT">
      <GET>
        return %_CNC.path_t_jolt;
      </GET>
    </PATH_T_JOLT>

    <!-- to calculate the absoulute value for G108/G110+percent value -->
    <LIM_PATH_ACC_P_INI Name="$LIM_PATH_ACC_P_INI">
      <GET>
        return %_CNC.lim_path_acc_p_ini;
      </GET>
    </LIM_PATH_ACC_P_INI>

    <!-- to calculate the absoulute value for G109/G110+percent value -->
    <LIM_PATH_ACC_N_INI Name="$LIM_PATH_ACC_N_INI">
      <GET>
        return %_CNC.lim_path_acc_n_ini;
      </GET>
    </LIM_PATH_ACC_N_INI>

    <!-- AXIS sourced system variables, CNC axis index number is the argument $AA_IM[0] -->
    <AA_IM Name="$AA_IM" ArrayDims="1">
      <GET>
        return @%_AX.set_pos_mcs[$[1]];
      </GET>
    </AA_IM>
    <AA_IW Name="$AA_IW" ArrayDims="1">
      <GET>
        return @%_AX.set_pos[$[1]];
      </GET>
    </AA_IW>
    <P_SIM Name="$P_SIM" ArrayDims="1">
      <GET>
        return %_AX.sim_status[$[1]];
      </GET>
    </P_SIM>
    <MA_MAX_AX_ACCEL Name="$MA_MAX_AX_ACCEL" ArrayDims="1">
      <GET>
        return %_AX.a_max[$[1]];
      </GET>
    </MA_MAX_AX_ACCEL>
    <MA_MAX_AX_VELO Name="$MA_MAX_AX_VELO" ArrayDims="1">
      <GET>
        return %_AX.v_max[$[1]];
      </GET>
    </MA_MAX_AX_VELO>
    <MA_MAX_AX_JERK Name="$MA_MAX_AX_JERK" ArrayDims="1">
      <GET>
        return %_AX.jerk_max[$[1]];
      </GET>
    </MA_MAX_AX_JERK>
    <MA_POSCTRL_GAIN Name="$MA_POSCTRL_GAIN" ArrayDims="1">
      <GET>
        return %_AX.servo_gain[$[1]];
      </GET>
    </MA_POSCTRL_GAIN>
    <MA_REFP_SET_POS Name="$MA_REFP_SET_POS" ArrayDims="1">
      <GET>
        return %_AX.home_pos[$[1]];
      </GET>
    </MA_REFP_SET_POS>
    <MA_POS_LIMIT_PLUS Name="$MA_POS_LIMIT_PLUS" ArrayDims="1">
      <GET>
        return %_AX.pos_sw_end[$[1]];
      </GET>
    </MA_POS_LIMIT_PLUS>
    <MA_POS_LIMIT_MINUS Name="$MA_POS_LIMIT_MINUS" ArrayDims="1">
      <GET>
        return %_AX.neg_sw_end[$[1]];
      </GET>
    </MA_POS_LIMIT_MINUS>

    <G116_ACC_CP_V_PATH Name = "$G116_ACC_CP_V_PATH">
      <GET>
        return %_CNC.G116_acp_vpath;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
        %_CNC.G116_acp_vpath = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_G116_ACC_CP_V_PATH;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.G116_acp_vpath;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </G116_ACC_CP_V_PATH>
    <G116_RADIUS Name = "$G116_RADIUS">
      <GET>
        return %_CNC.G116_radius;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
        %_CNC.G116_radius = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_G116_RADIUS;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.G116_radius;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </G116_RADIUS>
    <G116_ACC_CP_V_TRANS Name = "$G116_ACC_CP_V_TRANS">
      <GET>
        return %_CNC.G116_acp_vtrans;
      </GET>
      <SET>
        <ARG ref="EXPR" DataType="FLOAT"/>
        %_CNC.G116_acp_vtrans = ${EXPR};
        #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_G116_ACC_CP_V_TRANS;
        #next_motion.Data.SystemVariable.AxIdx = -1;
        #next_motion.Data.SystemVariable.Data.R8_value = %_CNC.G116_acp_vtrans;
        #next_motion.Command = MPCMD_CNC_SYS_VAR;
        PushPacket(::);
      </SET>
    </G116_ACC_CP_V_TRANS>
  </SysVars>

  <GCodes>
    <!-- Modal GCode is automatically pushed at the start of each line (AutoPush="Yes")
          - any G00-G03,G05-06 instructions are evaluated in the *Early* phase and so tell the modal GCode what GCode to issue
     -->
    <G_INIT GNum="-2" AutoPush="Yes" Eval="First" Inline="No" GenerateIfGroups="1,1000" >
      <!-- $RAD_IDX: Check if function is active, check if value in according external parameter has changed. -->
      if (#sys_vars.RAD_IDX &gt;= 0)
        #rel_cmp_precision = 0.00001; <!-- reduce relative comparison precision level -->
        #next_motion.Data.R8_value = #sys_vars.EXF[#sys_vars.RAD_IDX]; <!-- restart: log EXF param now -->
        if ((#next_motion.Data.R8_value &gt;= 0) &amp;&amp; (#next_motion.Data.R8_value != #sys_vars.RAD))
          #next_motion.Command = MPCMD_TOOL_RADIUS_AUTO;
          #sys_vars.RAD = #next_motion.Data.R8_value;
          PushPacket(::);
        else
          #next_motion.Data.R8_value = 0; <!-- ensure #next_motion is clear -->
        endif
        #rel_cmp_precision = 10e-12; <!-- restore default precision -->
      endif
    </G_INIT>
    <G_FINAL GNum="-3" AutoPush="Yes" Eval="Late" Inline="No" GenerateIfGroups="1" IgnoreIfGroups="1000" >
      <!-- if there was a modal-group-1 gcode programmed with no args, then it must be pushed at the end -->
      if (#sys_vars.modal_grp1_set &amp;&amp; !#mplist.have_move_cmd)
        PackMPData(:"cmd":%_CNC.move_cmd_mode,"comref":\%_CNC.co_ords_mode,"cemref":\%_CNC.center_mode:);
        #next_motion.Flags.IsMoveCmd = 1;
        PushPacket(::);
        #sys_vars.modal_grp1_set = 0; <!-- must clear the is-set flag before calling the MCALL fn, we'll send another motion packet -->
        try_mcall;
      else
        #sys_vars.modal_grp1_set = 0;
      endif
    </G_FINAL>
    <G_MODAL GNum="-1" AutoPush="Yes" Group="1000" Eval="Normal" IgnoreIfNoArgs="Yes">
      <!-- MODAL G-CODE (G -1): MPCMD comes from variable assigned by most recent explicit group-1 GCode -->
      <!-- Args: all possible group-1 args must be considered -->
      <!-- Sequencing of evaluation in relation to other content on line: because IgnoreIfNoArgs="Yes", statement "occurs" at position of first arg -->
      <Arg ref="dest"     MinCount="0" MaxCount="NumAxes" NameType="AXISREF"                DataType="PositionValue" WriteOpts="#:u?" />
      <Arg ref="center"   MinCount="0" MaxCount="3"       NameType="InterpolParam"          DataType="PositionValue" WriteOpts="#:u?" />
      <Arg ref="circlept" MinCount="0" MaxCount="3"       NameType="CirclePointParam"       DataType="PositionValue" WriteOpts="#:u?" />
      <Arg ref="angle"    MinCount="0" MaxCount="1"       NameType="RotationAngleSpecifier" DataType="RotationAngle" WriteOpts="#:u?" />
      <Arg ref="radius"   MinCount="0" MaxCount="1"       NameType="RadiusSpecifier"        DataType="RadiusValue"   WriteOpts="#:u?" />
      PackMPData(:"cmd":%_CNC.move_cmd_mode,"comref":\%_CNC.co_ords_mode,"cemref":\%_CNC.center_mode,${dest},${center},${circlept},${angle},${radius}:);
      #next_motion.Flags.IsMoveCmd = 1;
      PushPacket(::);
      #sys_vars.modal_grp1_set = 0; <!-- must clear the is-set flag before calling the MCALL fn, we'll send another motion packet -->
      try_mcall;
      </G_MODAL>
    <!-- Modal group 1 gcodes are evaluated early and set the command that the modal gcode will issue -->
    <G00 GNum="0" Group="1,50" Inline="Yes" Eval="Early">
      <!--G00: Rapid Interpolation-->
      %_CNC.move_cmd_mode = MPCMD_RAPID_MOVE_INTPOL;
      #sys_vars.modal_grp1_set = 1;
      </G00>
    <G01 GNum="1" Group="1,50" Inline="Yes" Eval="Early">
      <!--G01: Linear Interpolation-->
      %_CNC.move_cmd_mode = MPCMD_LIN_INTPOL;
      #sys_vars.modal_grp1_set = 1;
      </G01>
    <G02 GNum="2" Group="1,51" Inline="Yes" Eval="Early">
      <!--G02: Clockwise circular interpolation-->
      %_CNC.move_cmd_mode = MPCMD_CIRC_INTPOL_CW;
      #sys_vars.modal_grp1_set = 1;
      </G02>
    <G03 GNum="3" Group="1,51" Inline="Yes" Eval="Early">
      <!--G03: Counter-Clockwise circular interpolation-->
      %_CNC.move_cmd_mode = MPCMD_CIRC_INTPOL_CCW;
      #sys_vars.modal_grp1_set = 1;
      </G03>
    <G04 GNum="4" Alias="$TIME" Group="38">
      <!--AllowGroups is empty meaning that no other commands are allowed on this line-->
      <!--G04: Dwell (for a number of seconds)-->
      <Arg ref="time" DataType="DwellTime"/>
       #next_motion.Command = MPCMD_DWELL_TIME;
       #next_motion.Data.R8_value = ${time};
       PushPacket(::);
      </G04>
    <G05 GNum="5" Group="1,52" Inline="Yes" Eval="Early">
      <!--G05: Direct Programming of Polar Axes (Clockwise)-->
      %_CNC.move_cmd_mode = MPCMD_POL_AX_DIRECT_CW;
      #sys_vars.modal_grp1_set = 1;
      </G05>
    <G06 GNum="6" Group="1,52" Inline="Yes" Eval="Early">
      <!--G06: Direct Programming of Polar Axes (Counter Clockwise)-->
      %_CNC.move_cmd_mode = MPCMD_POL_AX_DIRECT_CCW;
      #sys_vars.modal_grp1_set = 1;
      </G06>
    <G10 GNum="10" Group="14">
      <!--G10: Programmed path speed on the Workpiece Contour-->
        #next_motion.Command = MPCMD_CDC_F_ON_CONTOUR;
        PushPacket(::);
      </G10>
    <G11 GNum="11" Group="14">
      <!--G11: Programmed path speed on the TCP-->
        #next_motion.Command = MPCMD_CDC_F_ON_TCP;
        PushPacket(::);
      </G11>
    <G12 GNum="12" Group="14">
      <!--G12: Path speed at transition arcs-->
      <Arg DataType="FeedFactor" ref="feed">
        <!--No Name or NameType means no name!-->
        <!--No Min or Max count means: Min=1, Max=1-->
      </Arg>
        #next_motion.Command = MPCMD_CDC_V_TRANS_ARC;
        #next_motion.Data.R8_value = ${feed};
        PushPacket(::);
      </G12>
    <G16 GNum="16" Group="19" AllowGroups="6,8,19,21,100,101,102,103">
      <!--G16: Orientation of Tool Axis-->
      <Arg DataType="OrientParam" ref="orient" MinCount="0" MaxCount="1" />
      <Arg DataType="SignArg" ref="sign" />
      #next_motion.Command = MPCMD_CDC_TOOL_AX_ORIENT;

      if(${orient} == "P")
        #next_motion.Data.ToolAxOrient.Parameter = 0;
      else
        if (${orient} == "Q")
          #next_motion.Data.ToolAxOrient.Parameter = 1;
        else
          if(${orient} == "R")
            #next_motion.Data.ToolAxOrient.Parameter = 2;
          else
            #next_motion.Data.ToolAxOrient.Parameter = -1;
          endif
        endif
      endif

      if(${sign} == "+")
        #next_motion.Data.ToolAxOrient.Sign = ncPOSITIVE;
      else
        if(${sign} == "-")
          #next_motion.Data.ToolAxOrient.Sign = ncNEGATIVE;
        else
          #next_motion.Data.ToolAxOrient.Sign = -1;
        endif
      endif
      PushPacket(::);
      </G16>
    <G17 GNum="17" Group="2">
      <!--G17: XY Plane Selection-->
      <Arg Name="CamWrappingParameter" DataType="CamWrappingDiameter" ref="camWrapDiameter" MinCount="0" MaxCount="1" />
      <Arg Name="FirstAxisIndicator1" DataType="FirstAxisIndicator2" ref="p1" MinCount="0" MaxCount="1" RequireArg="camWrapDiameter" />

      <!-- G17Q vs. standard G17 -->
      if (Defined(:${camWrapDiameter}:))
        #next_motion.Command = MPCMD_CAM_WRAP_17;
        #next_motion.Data.CamWrapping.Diameter = ${camWrapDiameter};
        if (Defined(:${p1}:))
            #next_motion.Data.CamWrapping.ParameterP1 = ncON;
        else
            #next_motion.Data.CamWrapping.ParameterP1 = ncOFF;
        endif
      else
        #next_motion.Command = MPCMD_MAIN_PLANE;
        #next_motion.Data.I4_value = ncXY;
      endif
      PushPacket(::);
    </G17>
    <!--G17_1 GNum="17.1" Alias="MAPPING_MODE"-->
    <G17_1 GNum="17.1" Alias="MAPPING_MODE|$MAPPING_MODE" AliasIsPattern="Yes">
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="2" />
      <Arg DataType="Long" ref="mapping_mode" />
      #next_motion.Command = MPCMD_MAPPING_MODE;
      #next_motion.Data.I4_value = ${mapping_mode};
      PushPacket(::);
    </G17_1>
    <G18 GNum="18" Group="2">
      <!--G18: ZX Plane Selection-->
      <Arg Name="CamWrappingParameter" DataType="CamWrappingDiameter" MinCount="0" MaxCount="1" ref="camWrapDiameter" />
      <Arg Name="FirstAxisIndicator1" DataType="FirstAxisIndicator2" MinCount="0" MaxCount="1" ref="p1" RequireArg="CamWrappingParameter" />

      <!-- G18Q vs. standard G18 -->
      if (Defined(:${camWrapDiameter}:))
        #next_motion.Command = MPCMD_CAM_WRAP_18;
        #next_motion.Data.CamWrapping.Diameter = ${camWrapDiameter};
        if (Defined(:${p1}:))
            #next_motion.Data.CamWrapping.ParameterP1 = ncON;
        else
            #next_motion.Data.CamWrapping.ParameterP1 = ncOFF;
        endif
      else
        #next_motion.Command = MPCMD_MAIN_PLANE;
        #next_motion.Data.I4_value = ncZX;
      endif
      PushPacket(::);
    </G18>
    <G19 GNum="19" Group="2">
      <!--G19: YZ Plane Selection-->
      <Arg Name="CamWrappingParameter" DataType="CamWrappingDiameter" MinCount="0" MaxCount="1" ref="camWrapDiameter" />
      <Arg Name="FirstAxisIndicator1" DataType="FirstAxisIndicator2" MinCount="0" MaxCount="1" ref="p1" RequireArg="CamWrappingParameter" />

      <!-- G19Q vs. standard G19 -->
      if (Defined(:${camWrapDiameter}:))
        #next_motion.Command = MPCMD_CAM_WRAP_19;
        #next_motion.Data.CamWrapping.Diameter = ${camWrapDiameter};
        if (Defined(:${p1}:))
            #next_motion.Data.CamWrapping.ParameterP1 = ncON;
        else
            #next_motion.Data.CamWrapping.ParameterP1 = ncOFF;
        endif
      else
        #next_motion.Command = MPCMD_MAIN_PLANE;
        #next_motion.Data.I4_value = ncYZ;
      endif
      PushPacket(::);
    </G19>
    <G20 GNum="20" Group="3">
      <!--G20: Deactivate Mirroring-->
      #next_motion.Command = MPCMD_MIRRORING;
      #next_motion.Data.I4_value = 20;
      PushPacket(::);
      </G20>
    <G21 GNum="21" Group="3">
      <!--G21: Y axis mirroring-->
      #next_motion.Command = MPCMD_MIRRORING;
      #next_motion.Data.I4_value = 21;
      PushPacket(::);
      </G21>
    <G22 GNum="22" Group="3">
      <!--G22: X axis mirroring-->
      #next_motion.Command = MPCMD_MIRRORING;
      #next_motion.Data.I4_value = 22;
      PushPacket(::);
      </G22>
    <G23 GNum="23" Group="3">
      <!--G23: X and Y axis mirroring-->
      #next_motion.Command = MPCMD_MIRRORING;
      #next_motion.Data.I4_value = 23;
      PushPacket(::);
      </G23>
    <G25 GNum="25" Group="11">
      <!--G25: Tangential transition arcs-->
      <Arg DataType="TangArcRadius" ref="radius" />
      #next_motion.Command = MPCMD_TANG_TRANS_ARC;
      #next_motion.Data.R8_value = ${radius};
      PushPacket(::);
      </G25>
    <G26 GNum="26" MinArgs="0" MaxArgs="1">
      <!--G26: Chamfer-->
      <Arg Name="ChamferLength" ref="length" DataType="FLOAT" MinCount="0" MaxCount="1"/>
      <Arg Name="ChamferWidth" ref="width" DataType="FLOAT" MinCount="0" MaxCount="1"/>
      if Defined(:${length}:)
        #next_motion.Data.Chamfer.Value = ${length};
        #next_motion.Data.Chamfer.Mode = 1;
      elif Defined(:${width}:)
        #next_motion.Data.Chamfer.Value = ${width};
        #next_motion.Data.Chamfer.Mode = 2;
      else
        #next_motion.Data.Chamfer.Mode = 0;
      endif
      #next_motion.Command = MPCMD_CHAMFER;
      PushPacket(::);
    </G26>
    <G36 GNum="36" Group="17">
      <!--G36: CDC: Replace arc with straight line - DEACTIVATE-->
      #next_motion.Command = MPCMD_CDC_ARC_2_LINE_OFF;
      PushPacket(::);
      </G36>
    <G37 GNum="37" Group="17">
      <!--G37: CDC: Replace arc with straight line - ACTIVATE-->
      #next_motion.Command = MPCMD_CDC_ARC_LINE_OFF;
      PushPacket(::);
      </G37>
    <G38 GNum="38" Group="18">
      <!--G38: CDC: Allow contour violations at small path sections - DEACTIVATE-->
      #next_motion.Command = MPCMD_CDC_NO_CONT_VIOLATION;
      PushPacket(::);
      </G38>
    <G39 GNum="39" Group="18">
      #next_motion.Command = MPCMD_CDC_CONT_VIOLATION;
      PushPacket(::);
      <!--G39: CDC: Allow contour violations at small path sections - ACTIVATE--></G39>
    <G239 GNum="239" Group="18">
      #next_motion.Command = MPCMD_CDC_CONT_VIOLATION_NO_ABORT;
      PushPacket(::);
      <!--G239: CDC: Allow contour violations at small path sections - ACTIVATE-->
    </G239>
    <G40 GNum="40" Group="5">
      <!--G40: Deactivate the CDC-->
      #next_motion.Command = MPCMD_CDC_OFF;
      PushPacket(::);
      </G40>
    <G41 GNum="41" Group="5">
      <!--G41: CDC left-->
      #next_motion.Command = MPCMD_CDC_ON_LEFT;
      PushPacket(::);
      </G41>
    <G42 GNum="42" Group="5">
      <!--G42: CDC right-->
      #next_motion.Command = MPCMD_CDC_ON_RIGHT;
      PushPacket(::);
      </G42>
    <G53 GNum="53" Group="6" AllowGroups="8,19,21,100,101,102,103">
      <!--G53: Deactivate the zero point offset-->
      #next_motion.Command = MPCMD_ABS_ZP_SHIFT;
      #next_motion.Data.AbsZeroPtShift.ZpRecIdx = 0;
      PushPacket(::);
      #sys_vars.ZP = 0;
      </G53>
    <G54 GNum="54" Group="6" AllowGroups="8,19,21,100,101,102,103">
      <!--G54: Zero point offset 1-->
      #next_motion.Command = MPCMD_ABS_ZP_SHIFT;
      #next_motion.Data.AbsZeroPtShift.ZpRecIdx = 1;
      PushPacket(::);
      #sys_vars.ZP = 1;
      </G54>
    <G55 GNum="55" Group="6" AllowGroups="8,19,21,100,101,102,103">
      <!--G55: Zero point offset 2-->
      #next_motion.Command = MPCMD_ABS_ZP_SHIFT;
      #next_motion.Data.AbsZeroPtShift.ZpRecIdx = 2;
      PushPacket(::);
      #sys_vars.ZP = 2;
      </G55>
    <G56 GNum="56" Group="6" AllowGroups="8,19,21,100,101,102,103">
      <!--G55: Zero point offset 3-->
      #next_motion.Command = MPCMD_ABS_ZP_SHIFT;
      #next_motion.Data.AbsZeroPtShift.ZpRecIdx = 3;
      PushPacket(::);
      #sys_vars.ZP = 3;
      </G56>
    <G57 GNum="57" Group="6" AllowGroups="8,19,21,100,101,102,103">
      <!--G55: Zero point offset 4-->
      #next_motion.Command = MPCMD_ABS_ZP_SHIFT;
      #next_motion.Data.AbsZeroPtShift.ZpRecIdx = 4;
      PushPacket(::);
      #sys_vars.ZP = 4;
      </G57>
    <G58 GNum="58" Group="6" AllowGroups="8,19,21,100,101,102,103">
      <!--G55: Zero point offset 5-->
      #next_motion.Command = MPCMD_ABS_ZP_SHIFT;
      #next_motion.Data.AbsZeroPtShift.ZpRecIdx = 5;
      PushPacket(::);
      #sys_vars.ZP = 5;
      </G58>
    <G59 GNum="59" Group="6" AllowGroups="8,19,21,100,101,102,103">
      <!--G55: Zero point offset 6-->
      #next_motion.Command = MPCMD_ABS_ZP_SHIFT;
      #next_motion.Data.AbsZeroPtShift.ZpRecIdx = 6;
      PushPacket(::);
      #sys_vars.ZP = 6;
      </G59>
    <G60 GNum="60" Group="39">
      <!--G60: Accuracy hold-->
      #next_motion.Command = MPCMD_ACC_HOLD;
      PushPacket(::);
      </G60>
    <G65 GNum="65" Group="65">
      <!--G65: auxiliary point-->
      #next_motion.Command = MPCMD_AUXILIARY_POINT;
      PushPacket(::);
    </G65>
    <G70 GNum="70" Group="7">
      <!--G70: Set measurement unit - Inch-->
      #next_motion.Command = MPCMD_IMPERIAL_UNIT;
      PushPacket(::);
      </G70>
    <G71 GNum="71" Group="7">
      <!--G71: Set measurement unit - mm-->
      #next_motion.Command = MPCMD_METRIC_UNIT;
      PushPacket(::);
      </G71>
    <G90 GNum="90" Group="8">
      <!--G90: Absolute position coordinates-->
      %_CNC.co_ords_mode = ncABSOLUTE;
      #next_motion.Command = MPCMD_ABS_POS_COORD;
      PushPacket(::);
      </G90>
    <G91 GNum="91" Group="8">
      <!--G91: Relative position coordinates-->
      %_CNC.co_ords_mode = ncRELATIVE;
      #next_motion.Command = MPCMD_REL_POS_COORD;
      PushPacket(::);
      </G91>
    <G92 GNum="92" Group="21" ResetArgs="Yes" AllowGroups="6,8,19,32,100,101,102,103">
      <!-- Cancel the modal G-Code (args clash) - if args already given to G(-1) then these could be error -->
      <!--G92: Programmed zero point offset with coordinate system rotation-->
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offset" MinCount="0" MaxCount="NumAxes" WriteOpts="#:u?" />
      <Arg NameType="RotationAngleSpecifier" DataType="RotationAngle" ref="h_rot" MinCount="0" MaxCount="1" WriteOpts="#:u?" DenyArgs="3,4,5" />
      <Arg NameType="EulerAngleName" DataType="RotationAngle" ref="e_rot" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,4,5" />
      <Arg NameType="RPYAngleName" DataType="RotationAngle" ref="rpy_rot" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,3,5" />
      <Arg NameType="RotaryVectorName" DataType="RotaryVector" ref="matrix" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,3,4" />
         PackMPData(:"cmd":MPCMD_PROG_ZP_SHIFT,"comref":\%_CNC.co_ords_mode,"cemref":\%_CNC.center_mode,${offset},${matrix},${e_rot},${rpy_rot},${h_rot}:);
         PushPacket(::);
      </G92>
    <G492 GNum="492" Group="490" Alias="TRANS" AllowGroups="9999">
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offsets" MinCount="0" MaxCount="NumAxes" WriteOpts="#:" />
         #next_motion.Command = MPCMD_TRANS;
         PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${offsets}, \#next_motion.Data.Trans.Offset, \#next_motion.Data.Trans.AxIdx, \#next_motion.Data.Trans.Mode:);
         PushPacket(::);
      </G492>
    <G493 GNum="493" Group="490" Alias="ATRANS" AllowGroups="9999">
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offsets" MinCount="0" MaxCount="NumAxes" WriteOpts="#:" />
         #next_motion.Command = MPCMD_ATRANS;
         PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${offsets}, \#next_motion.Data.Trans.Offset, \#next_motion.Data.Trans.AxIdx, \#next_motion.Data.Trans.Mode:);
         PushPacket(::);
      </G493>
    <G494 GNum="494" Group="490" Alias="ROT" AllowGroups="9999" MinArgs="0" MaxArgs="1" >
      <Arg Name="RPLArgPrefix" DataType="FLOAT" ref="rpl_value" MinCount="0" MaxCount="1" DenyArgs="offsets" />
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offsets" MinCount="0" MaxCount="NumAxes" DenyArgs="rpl_value" WriteOpts="#:" />
         if (Defined(:${rpl_value}:))
            #next_motion.Command = MPCMD_ROT_RPL;
            #next_motion.Data.R8_value = ${rpl_value};
         else
           #next_motion.Command = MPCMD_ROT;
           PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${offsets}, \#next_motion.Data.Trans.Offset, \#next_motion.Data.Trans.AxIdx, \#next_motion.Data.Trans.Mode:);
         endif
         PushPacket(::);
      </G494>
    <G495 GNum="495" Group="490" Alias="AROT" AllowGroups="9999" MinArgs="0" MaxArgs="1" >
      <Arg Name="RPLArgPrefix" DataType="FLOAT" ref="rpl_value" MinCount="0" MaxCount="1" DenyArgs="offsets" />
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offsets" MinCount="0" MaxCount="NumAxes" DenyArgs="rpl_value" WriteOpts="#:" />
         if (Defined(:${rpl_value}:))
            #next_motion.Command = MPCMD_AROT_RPL;
            #next_motion.Data.R8_value = ${rpl_value};
         else
           #next_motion.Command = MPCMD_AROT;
           PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${offsets}, \#next_motion.Data.Trans.Offset, \#next_motion.Data.Trans.AxIdx, \#next_motion.Data.Trans.Mode:);
         endif
         PushPacket(::);
      </G495>
    <G93 GNum="93" Group="22">
      <!--G93: Feed rate - inverse time-->
      #next_motion.Command = MPCMD_F_INV_TIME_DEF;
      PushPacket(::);
      </G93>
    <G94 GNum="94" Group="22">
      <!--G94: Feed rate - feed per minute-->
      #next_motion.Command = MPCMD_F_UNIT_MIN_DEF;
      PushPacket(::);
      </G94>
    <G100 GNum="100" Group="1,50" Eval="Early">
      <!--G100: Rapid Move Not-Interpolated -->
      %_CNC.move_cmd_mode = MPCMD_PTP_RAPID_MOVE;
      #sys_vars.modal_grp1_set = 1;
      </G100>
    <G100_1 GNum="100.1" Alias="MODE">
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="Long" ref="required_mode" />
      #next_motion.Command = MPCMD_TRF_MODE;
      #next_motion.Data.UI4_value = ${required_mode};
      PushPacket(::);
      </G100_1>
    <G100_2 GNum="100.2" Alias="D_FULL" Group="211" MinArgs="1" MaxArgs="7" >
      <!--D_FULL: General tool definition for full transformations-->
      <Arg Name="FullTrfToolDx" DataType="FullTrfToolItem" ref="dx" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolDy" DataType="FullTrfToolItem" ref="dy" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolDz" DataType="FullTrfToolItem" ref="dz" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolPhi" DataType="FullTrfToolItem" ref="phi" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolTheta" DataType="FullTrfToolItem" ref="theta" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolPsi" DataType="FullTrfToolItem" ref="psi" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolDmp" DataType="FullTrfToolItem" ref="dmp" MinCount="0" MaxCount="1" />
       #next_motion.Command = MPCMD_TRF_TOOL;
       if (Defined(:${dx}:))
         #next_motion.Data.FullTrfTool.Dx = ${dx};
       else
         #next_motion.Data.FullTrfTool.Dx = 0;
       endif
       if (Defined(:${dy}:))
         #next_motion.Data.FullTrfTool.Dy = ${dy};
       else
         #next_motion.Data.FullTrfTool.Dy = 0;
       endif
       if (Defined(:${dz}:))
         #next_motion.Data.FullTrfTool.Dz = ${dz};
       else
         #next_motion.Data.FullTrfTool.Dz = 0;
       endif
       if (Defined(:${phi}:))
         #next_motion.Data.FullTrfTool.Phi = ${phi};
       else
         #next_motion.Data.FullTrfTool.Phi = 0;
       endif
       if (Defined(:${theta}:))
         #next_motion.Data.FullTrfTool.Theta = ${theta};
       else
         #next_motion.Data.FullTrfTool.Theta = 0;
       endif
       if (Defined(:${psi}:))
         #next_motion.Data.FullTrfTool.Psi = ${psi};
       else
         #next_motion.Data.FullTrfTool.Psi = 0;
       endif
       if (Defined(:${dmp}:))
         #next_motion.Data.FullTrfTool.Dmp = ${dmp};
       else
         #next_motion.Data.FullTrfTool.Dmp = 0;
       endif
      PushPacket(::);
      </G100_2>
    <G100_3 GNum="100.3" Alias="SEG">
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="Long" ref="nr_of_segments" />
      #next_motion.Command = MPCMD_TRF_SEGMENTS;
      #next_motion.Data.UI4_value = ${nr_of_segments};
      PushPacket(::);
      </G100_3>
    <G100_4 GNum="100.4" Alias="Q1REF">
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="WantedQ" ref="wanted" />
      #next_motion.Command = MPCMD_WANTED1;
      #next_motion.Data.R8_value = ${wanted};
      PushPacket(::);
      </G100_4>
    <G100_5 GNum="100.5" Alias="Q2REF">
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="WantedQ" ref="wanted" />
      #next_motion.Command = MPCMD_WANTED2;
      #next_motion.Data.R8_value = ${wanted};
      PushPacket(::);
      </G100_5>
    <G100_6 GNum="100.6" Alias="Q3REF">
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="WantedQ" ref="wanted" />
      #next_motion.Command = MPCMD_WANTED3;
      #next_motion.Data.R8_value = ${wanted};
      PushPacket(::);
      </G100_6>
    <G100_7 GNum="100.7" Alias="Q4REF">
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="WantedQ" ref="wanted" />
      #next_motion.Command = MPCMD_WANTED4;
      #next_motion.Data.R8_value = ${wanted};
      PushPacket(::);
      </G100_7>
    <G100_8 GNum="100.8" Alias="Q5REF">
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="WantedQ" ref="wanted" />
      #next_motion.Command = MPCMD_WANTED5;
      #next_motion.Data.R8_value = ${wanted};
      PushPacket(::);
      </G100_8>
    <G100_9 GNum="100.9" Alias="Q6REF">
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="WantedQ" ref="wanted" />
      #next_motion.Command = MPCMD_WANTED6;
      #next_motion.Data.R8_value = ${wanted};
      PushPacket(::);
      </G100_9>
    <G100_11 GNum="100.11" Alias="WS_D_FULL" Group="211" MinArgs="1" MaxArgs="7" >
      <!--WS_D_FULL: Tool definition for work space monitoring-->
      <Arg Name="FullTrfToolDx" DataType="FullTrfToolItem" ref="dx" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolDy" DataType="FullTrfToolItem" ref="dy" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolDz" DataType="FullTrfToolItem" ref="dz" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolPhi" DataType="FullTrfToolItem" ref="phi" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolTheta" DataType="FullTrfToolItem" ref="theta" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolPsi" DataType="FullTrfToolItem" ref="psi" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolDmp" DataType="FullTrfToolItem" ref="dmp" MinCount="0" MaxCount="1" />
        #next_motion.Command = MPCMD_WS_D_FULL;
        if (Defined(:${dx}:))
        #next_motion.Data.FullTrfTool.Dx = ${dx};
        else
        #next_motion.Data.FullTrfTool.Dx = 0;
        endif
        if (Defined(:${dy}:))
        #next_motion.Data.FullTrfTool.Dy = ${dy};
        else
        #next_motion.Data.FullTrfTool.Dy = 0;
        endif
        if (Defined(:${dz}:))
        #next_motion.Data.FullTrfTool.Dz = ${dz};
        else
        #next_motion.Data.FullTrfTool.Dz = 0;
        endif
        if (Defined(:${phi}:))
        #next_motion.Data.FullTrfTool.Phi = ${phi};
        else
        #next_motion.Data.FullTrfTool.Phi = 0;
        endif
        if (Defined(:${theta}:))
        #next_motion.Data.FullTrfTool.Theta = ${theta};
        else
        #next_motion.Data.FullTrfTool.Theta = 0;
        endif
        if (Defined(:${psi}:))
        #next_motion.Data.FullTrfTool.Psi = ${psi};
        else
        #next_motion.Data.FullTrfTool.Psi = 0;
        endif
        if (Defined(:${dmp}:))
        #next_motion.Data.FullTrfTool.Dmp = ${dmp};
        else
        #next_motion.Data.FullTrfTool.Dmp = 0;
        endif
        PushPacket(::);
    </G100_11>
    <G100_12 GNum="100.12" Alias="WS_D_FULL_ON">
      <!--activation of WS_D_FULL -->
      #next_motion.Command = MPCMD_WS_D_FULL_ON;
      PushPacket(::);
      </G100_12>
    <G100_13 GNum="100.13" Alias="WS_D_FULL_OFF">
      <!--deactivation of WS_D_FULL -->
      #next_motion.Command = MPCMD_WS_D_FULL_OFF;
      PushPacket(::);
      </G100_13>
    <G100_14 GNum="100.14" Alias="EXTERNAL_D_FULL" Group="211" MinArgs="1" MaxArgs="6" >
      <!--EXTERNAL_D_FULL: External tool definition -->
      <Arg Name="FullTrfToolDx" DataType="FullTrfToolItem" ref="dx" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolDy" DataType="FullTrfToolItem" ref="dy" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolDz" DataType="FullTrfToolItem" ref="dz" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolPhi" DataType="FullTrfToolItem" ref="phi" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolTheta" DataType="FullTrfToolItem" ref="theta" MinCount="0" MaxCount="1" />
      <Arg Name="FullTrfToolPsi" DataType="FullTrfToolItem" ref="psi" MinCount="0" MaxCount="1" />
        #next_motion.Command = MPCMD_EXTERNAL_D_FULL;
        if (Defined(:${dx}:))
        #next_motion.Data.FullTrfTool.Dx = ${dx};
        else
        #next_motion.Data.FullTrfTool.Dx = 0;
        endif
        if (Defined(:${dy}:))
        #next_motion.Data.FullTrfTool.Dy = ${dy};
        else
        #next_motion.Data.FullTrfTool.Dy = 0;
        endif
        if (Defined(:${dz}:))
        #next_motion.Data.FullTrfTool.Dz = ${dz};
        else
        #next_motion.Data.FullTrfTool.Dz = 0;
        endif
        if (Defined(:${phi}:))
        #next_motion.Data.FullTrfTool.Phi = ${phi};
        else
        #next_motion.Data.FullTrfTool.Phi = 0;
        endif
        if (Defined(:${theta}:))
        #next_motion.Data.FullTrfTool.Theta = ${theta};
        else
        #next_motion.Data.FullTrfTool.Theta = 0;
        endif
        if (Defined(:${psi}:))
        #next_motion.Data.FullTrfTool.Psi = ${psi};
        else
        #next_motion.Data.FullTrfTool.Psi = 0;
        endif
        PushPacket(::);
    </G100_14>
    <G100_15 GNum="100.15" Alias="EXTERNAL_D_FULL_ON">
      <!--activation of EXTERNAL_D_FULL -->
      #next_motion.Command = MPCMD_EXTERNAL_D_FULL_ON;
      PushPacket(::);
      </G100_15>
    <G100_16 GNum="100.16" Alias="EXTERNAL_D_FULL_OFF">
      <!--deactivation of EXTERNAL_D_FULL -->
      #next_motion.Command = MPCMD_EXTERNAL_D_FULL_OFF;
      PushPacket(::);
      </G100_16>
    <G100_17 GNum="100.17" Alias="D_FULL_ADD_EL" MinArgs="1" MaxArgs="1" >
      <!--TCP behavior on D_FULL additive elements-->
      <Arg DataType="D_FULL_TcpShift" ref="tcp" MinCount="0" MaxCount="1" />
      <Arg DataType="D_FULL_JointsShift" ref="joints" MinCount="0" MaxCount="1" />
      #next_motion.Command = MPCMD_D_FULL_ADD_EL;
      if(Defined(:${tcp}:))
        #next_motion.Data.UI4_value = 0;
      endif
      if(Defined(:${joints}:))
        #next_motion.Data.UI4_value = 1;
      endif
      PushPacket(::);
      </G100_17>
    <G101 GNum="101" Group="1,50" Eval="Early">
      <!--G101: Feedrate Move Not-Interpolated -->
      %_CNC.move_cmd_mode = MPCMD_PTP_LIN_MOVE;
      #sys_vars.modal_grp1_set = 1;
      </G101>
    <G102 GNum="102" Group="1,51" Eval="Early">
      <!--G102: Circle Interpolation in General Orientation-->
      %_CNC.move_cmd_mode = MPCMD_CIRC_INTPOL_CIRC_PT;
      #sys_vars.modal_grp1_set = 1;
      </G102>
    <G102_1 GNum="102.1">
      <Arg ref="orient" MinCount="3" MaxCount="3" NameType="CirclePointOrient" DataType="PositionValue" WriteOpts="#:u?" />
      <!--G102.1 orientation of circle point -->
      #next_motion.Command=MPCMD_CIRC_INTPOL_PT_ORI;
      PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${orient}, \#next_motion.Data.CircMovement.Parameter, \#next_motion.Data.CircMovement.Idx, \#next_motion.Data.CircMovement.Mode:);
      PushPacket(::);
      </G102_1>
    <G103 GNum="103" Group="23">
      <!--G103: CDC: Radius-dependent feed adjustment at CONVEX path sections-->
      <Arg DataType="FeedChangeRate" ref="rate_or_maxrad" />
      <Arg DataType="RadiusValue" MinCount="0" MaxCount="1" ref="min_radius" RequireArgs="rate" />
      <Arg DataType="FeedChangeRate" MinCount="0" MaxCount="1" ref="rate" />
       #next_motion.Command = MPCMD_CDC_RAD_FEED_CONVEX;
       if (Defined(:${rate}:))
         #next_motion.Data.R_DependFeed.MaxRadius = ${rate_or_maxrad};
         #next_motion.Data.R_DependFeed.MinRadius = ${min_radius};
         #next_motion.Data.R_DependFeed.Rate = ${rate};
       else
         #next_motion.Data.R_DependFeed.MaxRadius = -1;
         #next_motion.Data.R_DependFeed.MinRadius = -1;
         #next_motion.Data.R_DependFeed.Rate = ${rate_or_maxrad};
       endif
       PushPacket(::);
      </G103>
    <G104 GNum="104" Group="23">
      <!--G104: CDC: Radius-dependent feed adjustment at CONCAVE path sections-->
      <Arg DataType="FeedChangeRate" ref="rate_or_maxrad" />
      <Arg DataType="RadiusValue" MinCount="0" MaxCount="1" ref="min_radius" RequireArgs="rate" />
      <Arg DataType="FeedChangeRate" MinCount="0" MaxCount="1" ref="rate" />
       #next_motion.Command = MPCMD_CDC_RAD_FEED_CONCAVE;
       if (Defined(:${rate}:))
         #next_motion.Data.R_DependFeed.MaxRadius = ${rate_or_maxrad};
         #next_motion.Data.R_DependFeed.MinRadius = ${min_radius};
         #next_motion.Data.R_DependFeed.Rate = ${rate};
       else
         #next_motion.Data.R_DependFeed.MaxRadius = -1;
         #next_motion.Data.R_DependFeed.MinRadius = -1;
         #next_motion.Data.R_DependFeed.Rate = ${rate_or_maxrad};
       endif
       PushPacket(::);
      </G104>
    <G105 GNum="105" Group="24">
      <!--G105: Setting the v_jump parameter-->
      <Arg NameType="AXISREF" DataType="VJumpValue" ref="v_jump" WriteOpts="#:" />
      #next_motion.Command = MPCMD_SET_V_JUMP;
      PackNamedListToArrays(:ORDERING_REAL, MP_AX_NUMBER, ${v_jump}, \#next_motion.Data.Set_v_jump.value, \#next_motion.Data.Set_v_jump.programmed:);
      PushPacket(::);
      %_AX.v_jump_ncdy[ToInt(:ListItemName(:${v_jump},1:):)] = ListItemValue(:${v_jump},1:);
    </G105>
    <G106 GNum="106" Group="25">
      <!--G106: Setting the a_jump parameter-->
      <Arg NameType="AXISREF" DataType="AJumpValue" ref="a_jump" WriteOpts="#:" />
      #next_motion.Command = MPCMD_SET_A_JUMP;
      PackNamedListToArrays(:ORDERING_REAL, MP_AX_NUMBER, ${a_jump}, \#next_motion.Data.Set_a_jump.value, \#next_motion.Data.Set_a_jump.programmed:);
      PushPacket(::);
      %_AX.a_jump_ncdy[ToInt(:ListItemName(:${a_jump},1:):)] = ListItemValue(:${a_jump},1:);
      </G106>
    <G107 GNum="107" Group="26">
      <!--G107: Axis limit switch-->
      <Arg NameType="AXISREF" DataType="AxisLimitRecordIndex" ref="limit" WriteOpts="#:" />
      #next_motion.Command = MPCMD_SET_AX_LIMIT;
      AxisAssign(:MP_METADATA | ORDERING_REAL |DATATYPE_AXES, MP_AX_NUMBER, ${limit}, \#next_motion.Data.SetAxLimit.RecordIdx, \#next_motion.Data.SetAxLimit.programmed:);
      PushPacket(::);
      </G107>
    <G108 GNum="108" Group="12" MinArgs="1" MaxArgs="1" >
      <!--G108: Set path acceleration-->
      <Arg Name="AccelArgPrefix" DataType="AccelPercentage" ref="acc_value" MinCount="0" MaxCount="1" DenyArgs="value" />
      <Arg DataType="AccelPercentage" ref="value" MinCount="0" MaxCount="1" DenyArgs="acc_value" />
       #next_motion.Command = MPCMD_PATH_ACC;
       if (Defined(:${acc_value}:))
         #next_motion.Data.SetPathAccDec.UnitType = 0;
         #next_motion.Data.SetPathAccDec.value = ${acc_value};
           %_CNC.lim_path_acc_p = ${acc_value};
         PushPacket(::);
       else
         if (Defined(:${value}:))
           #next_motion.Data.SetPathAccDec.UnitType = 1;
           #next_motion.Data.SetPathAccDec.value = ${value};
           %_CNC.lim_path_acc_p = ${value} / 100.0 * %_CNC.lim_path_acc_p_ini;
           PushPacket(::);
         endif
       endif
      </G108>
    <G109 GNum="109" Group="13" MinArgs="1" MaxArgs="1" >
      <!--G109: Set path deceleration-->
      <Arg Name="AccelArgPrefix" DataType="AccelPercentage" ref="acc_value" MinCount="0" MaxCount="1" DenyArgs="value" />
      <Arg DataType="AccelPercentage" ref="value" MinCount="0" MaxCount="1" DenyArgs="acc_value" />
       #next_motion.Command = MPCMD_PATH_DEC;
       if (Defined(:${acc_value}:))
         #next_motion.Data.SetPathAccDec.UnitType = 0;
         #next_motion.Data.SetPathAccDec.value = ${acc_value};
           %_CNC.lim_path_acc_n = ${acc_value};
         PushPacket(::);
       else
         if (Defined(:${value}:))
           #next_motion.Data.SetPathAccDec.UnitType = 1;
           #next_motion.Data.SetPathAccDec.value = ${value};
           %_CNC.lim_path_acc_n = ${value} / 100.0 * %_CNC.lim_path_acc_n_ini;
           PushPacket(::);
         endif
       endif
      </G109>
    <G110 GNum="110" Group="12,13" MinArgs="1" MaxArgs="1" >
      <!--G110: Set path acceleration and deceleration-->
      <Arg Name="AccelArgPrefix" DataType="AccelPercentage" ref="acc_value" MinCount="0" MaxCount="1" DenyArgs="value" />
      <Arg DataType="AccelPercentage" ref="value" MinCount="0" MaxCount="1" DenyArgs="acc_value" />
       #next_motion.Command = MPCMD_PATH_ACC_DEC;
       if (Defined(:${acc_value}:))
         #next_motion.Data.SetPathAccDec.UnitType = 0;
         #next_motion.Data.SetPathAccDec.value = ${acc_value};
           %_CNC.lim_path_acc_p = ${acc_value};
           %_CNC.lim_path_acc_n = ${acc_value};
         PushPacket(::);
       else
         if (Defined(:${value}:))
           #next_motion.Data.SetPathAccDec.UnitType = 1;
           #next_motion.Data.SetPathAccDec.value = ${value};
           %_CNC.lim_path_acc_p = ${value} /100.0 * %_CNC.lim_path_acc_p_ini;
           %_CNC.lim_path_acc_n = ${value} /100.0 * %_CNC.lim_path_acc_n_ini;
           PushPacket(::);
         endif
       endif
      </G110>
    <G111 GNum="111" Group="27">
      <!--G111: Block transition with speed dip-->
      #next_motion.Command = MPCMD_SPEED_DIP_ON;
      PushPacket(::);
      </G111>
    <G112 GNum="112" Group="27">
      <!--G112: Block transition without speed dip-->
      #next_motion.Command = MPCMD_SPEED_DIP_OFF;
      PushPacket(::);
      </G112>
    <G113 GNum="113" Group="28">
      <!--G113: Reduction of path speed at tangential path section transitions-->
      <Arg DataType="AngleDegrees" ref="max_angle" LastIfValue="-1">
        <!--if (max_angle == -1) then function is deactivate, and no further arguments-->
      </Arg>
      <Arg DataType="AngleDegrees" ref="min_angle" MinCount="0" MaxCount="1" RequireArgs="path_speed_reduction" />
      <Arg DataType="PathSpeedReductionFactor" ref="path_speed_reduction" MinCount="0" MaxCount="1" />
      #next_motion.Command = MPCMD_TANG_TRANS_SPEED_RED;
      if (${max_angle} == -1)
        #next_motion.Data.SetTransSpeed.MaxAngle = -1;
        #next_motion.Data.SetTransSpeed.MinAngle = -1;
        #next_motion.Data.SetTransSpeed.RedFactor = -1;
      else
        #next_motion.Data.SetTransSpeed.MaxAngle = ${max_angle};
        #next_motion.Data.SetTransSpeed.MinAngle = ${min_angle};
        #next_motion.Data.SetTransSpeed.RedFactor = ${path_speed_reduction};
      endif
      PushPacket(::);
      </G113>
    <G114 GNum="114" Group="54" DenyGroups="54">
      <!--G114: Optimized circular acceleration ratio-->
      #next_motion.Command = MPCMD_CIRC_DYN_CALC_OPT;
      PushPacket(::);
      </G114>
    <G115 GNum="115" Group="54" DenyGroups="54">
      <!--G115: Standard acceleration ratio-->
      #next_motion.Command = MPCMD_CIRC_DYN_CALC_STD;
      PushPacket(::);
      </G115>
    <G116 GNum="116" Group="54" DenyGroups="54">
      <!--G116: Optimized circular acceleration ratio 0.5:1.0-->
      #next_motion.Command = MPCMD_CIRC_DYN_CALC_OPT_116;
      PushPacket(::);
      </G116>
    <G126 GNum="126" Group="11" DenyGroups="11" >
      <!--G126: Rounding edges-->
      <Arg DataType="RadiusValue" ref="radius"/>
        <!--if (radius == 0) then function is deactivated-->
      <Arg Name="ve_par" DataType="RoundingEntranceSpeedFactor" MinCount="0" MaxCount="1" ref="v_ein"/>
      <Arg DataType="LinName" MinCount="0" MaxCount="1" ref="lin"/>
      <Arg Name="BezierScalingFactor" DataType="UByte" ref="bezierFactor" MinCount="0" MaxCount="1" />
      #next_motion.Command = MPCMD_BEZ_SPLINE;
      if (Defined(:${radius}:))
          #next_motion.Data.BezierSpline.RadiusProgrammed = ncON;
          #next_motion.Data.BezierSpline.Radius = ${radius};
      else
          #next_motion.Data.BezierSpline.RadiusProgrammed = ncOFF;
          #next_motion.Data.BezierSpline.Radius = -1;
      endif
      if (Defined(:${v_ein}:))
          #next_motion.Data.BezierSpline.VeProgrammed = ncON;
          #next_motion.Data.BezierSpline.Ve = ${v_ein};
      else
          #next_motion.Data.BezierSpline.VeProgrammed = ncOFF;
          #next_motion.Data.BezierSpline.Ve = -1;
      endif
      if (Defined(:${lin}:))
          #next_motion.Data.BezierSpline.LinProgrammed = ncON;
      else
          #next_motion.Data.BezierSpline.LinProgrammed = ncOFF;
      endif
      if (Defined(:${bezierFactor}:))
          #next_motion.Data.BezierSpline.scalingFactor_def = 1;
          #next_motion.Data.BezierSpline.scalingFactor = ${bezierFactor};
      else
          #next_motion.Data.BezierSpline.scalingFactor_def = 0;
      endif
      PushPacket(::);
      </G126>
    <G126_1 GNum="126.1" Alias="$VE" Group="11" DenyGroups="11" >
      <!--G126 $VE <value> [$LIN] : Rounding edges -->
      <Arg DataType="RoundingEntranceSpeedFactor" ref="v_ein"/>
      <Arg DataType="LinName" MinCount="0" MaxCount="1" ref="lin"/>
      #next_motion.Command = MPCMD_BEZ_SPLINE;
      #next_motion.Data.BezierSpline.RadiusProgrammed = ncOFF;
      #next_motion.Data.BezierSpline.Radius = -1;
      #next_motion.Data.BezierSpline.VeProgrammed = ncON;
      #next_motion.Data.BezierSpline.Ve = ${v_ein};
      if (Defined(:${lin}:))
          #next_motion.Data.BezierSpline.LinProgrammed = ncON;
      else
          #next_motion.Data.BezierSpline.LinProgrammed = ncOFF;
      endif
      PushPacket(::);
      </G126_1>
    <G126_2 GNum="126.2" Alias="$LIN" Group="11" DenyGroups="11" >
      <!--G126 $LIN : Rounding edges -->
      #next_motion.Command = MPCMD_BEZ_SPLINE;
      #next_motion.Data.BezierSpline.RadiusProgrammed = ncOFF;
      #next_motion.Data.BezierSpline.Radius = -1;
      #next_motion.Data.BezierSpline.VeProgrammed = ncOFF;
      #next_motion.Data.BezierSpline.Ve = -1;
      #next_motion.Data.BezierSpline.LinProgrammed = ncON;
      PushPacket(::);
      </G126_2>
    <G126_3 GNum="126.3" Alias="PTP_TCP_TRANSITION">
      <!--Related to G126 but a change of a parameter without G126 required -->
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="Long" ref="ptp_tcp_transition" />
      #next_motion.Command = MPCMD_PTP_TCP_TRANSITION;
      #next_motion.Data.UI4_value = ${ptp_tcp_transition};
      PushPacket(::);
    </G126_3>
    <G126_4 GNum="126.4" Alias="STANDARD_ROUNDING">
      <!--Related to G126 but a change of a parameter without G126 possible -->
      #next_motion.Command = MPCMD_G126_STANDARD;
      PushPacket(::);
    </G126_4>
    <G126_5 GNum="126.5" Alias="EXTENDED_ROUNDING">
      <!--Related to G126 but a change of a parameter without G126 possible -->
      #next_motion.Command = MPCMD_G126_EXTENDED;
      PushPacket(::);
    </G126_5>
    <G130 GNum="130" Group="20">
      <!--G130: Tool compensation in direction of machine coordinate system-->
      #next_motion.Command = MPCMD_CDC_DIR_MACHINE_CS;
      PushPacket(::);
      </G130>
    <G131 GNum="131" Group="20">
      <!--G131: Tool compensation in direction of programmed coordinate system-->
      #next_motion.Command = MPCMD_CDC_DIR_PROG_CS;
      PushPacket(::);
      </G131>
    <G132 GNum="132" Group="4">
      <!--G132: CDC with linear transitions-->
      #next_motion.Command = MPCMD_CDC_TRANS_LINES;
      PushPacket(::);
      </G132>
    <G133 GNum="133" Group="4" Alias="$WRK_R_ON">
      <!--G133: CDC with arc transitions-->
      #next_motion.Command = MPCMD_CDC_TRANS_ARCS;
      PushPacket(::);
      </G133>
    <G134 GNum="134" Group="4">
      <!--G134: Intersection with path calculation - DEACTIVATE-->
      #next_motion.Command = MPCMD_CDC_INTERS_PATH_OFF;
      PushPacket(::);
      </G134>
    <G135 GNum="135" Group="4">
      <!--G135: Intersection with path calculation - ACTIVATE-->
      #next_motion.Command = MPCMD_CDC_INTERS_PATH_ON;
      PushPacket(::);
      </G135>
    <G137 GNum="137" Group="9">
      <!--G137: Activate/deactivate CDC indirectly with transition block-->
      #next_motion.Command = MPCMD_CDC_G137_MODE;
      PushPacket(::);
      </G137>
    <G138 GNum="138" Group="9">
      <!--G138: Activate/deactivate CDC directly-->
      #next_motion.Command = MPCMD_CDC_G138_MODE;
      PushPacket(::);
      </G138>
    <G139 GNum="139" Group="9">
      <!--G139: Activate/deactivate CDC indirectly-->
      #next_motion.Command = MPCMD_CDC_G139_MODE;
      PushPacket(::);
      </G139>
    <G140 GNum="140" Group="15">
      <!--G140: Deactivate tangential axis automatically-->
      #next_motion.Command = MPCMD_TANG_AX_OFF;
      PushPacket(::);
      </G140>
    <G141 GNum="141" Group="15">
      <!--G141: Activate automatic tangential axis-->
      <Arg DataType="AXISREF" ref="axis" />
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="FLOAT" ref="offset" />
      #next_motion.Command = MPCMD_TANG_AX_ON;
      #next_motion.Data.AutomTangentialAx.Offset = ${offset};
      #next_motion.Data.AutomTangentialAx.AxIdx = AxisIndex(:${axis}:);
      PushPacket(::);
      </G141>
    <G144 GNum="144" Group="15">
      <!--G144: Activate continuous alignment of tang. axis-->
      #next_motion.Command = MPCMD_TANG_CONT_ON;
      PushPacket(::);
      </G144>
    <G145 GNum="145" Group="15">
      <!--G145: Deactivate continuous alignment of tang. axis-->
      #next_motion.Command = MPCMD_TANG_CONT_OFF;
      PushPacket(::);
    </G145>
    <G153 GNum="153" Group="29" Eval="Early">
      <!--G153: Position coordinates in the machine system-->
      <!--Note: Must be combined with G00 or G01-->
      #next_motion.Command = MPCMD_MACHINE_POS_COORD;
      PushPacket(::);
      </G153>
    <G159 GNum="159" Group="6" AllowGroups="6,19,21,102">
      <!--G159: Expanded zero-point offset-->
      <Arg NameType="EqString" DataType="ZeroPointTableIndex" ref="index" />
      #next_motion.Command = MPCMD_ABS_ZP_SHIFT;
      #next_motion.Data.AbsZeroPtShift.ZpRecIdx = ${index};
      PushPacket(::);
      #sys_vars.ZP = ${index};
      </G159>
    <G161 GNum="161" Group="10">
      <!--G161: Absolute coordinates for centre of circle-->
      %_CNC.center_mode = ncABSOLUTE;
      #next_motion.Command = MPCMD_ABS_CP_COORD;
      PushPacket(::);
      </G161>
    <G162 GNum="162" Group="10">
      <!--G162: Relative coordinates for centre of circle-->
      %_CNC.center_mode = ncRELATIVE;
      #next_motion.Command = MPCMD_REL_CP_COORD;
      PushPacket(::);
      </G162>
    <G170 GNum="170" Group="30" AllowGroups="40,41,42,43,44,101,102"  MinArgs="0" MaxArgs="1">
      <!--G170: decoder Synchronization-->
      <Arg DataType="FuncBeforeRounding" MinCount="0" MaxCount="1" ref="funcbr"/>
      #next_motion.Command = MPCMD_IP_SYNCH;
      if (#thread.restart.playback)
        #next_motion.Data.I4_value = ncSIMULATION;
      else
        #next_motion.Data.I4_value = ncSTANDARD;
      endif
      if (Defined(:${funcbr}:))
        #next_motion.Data.UI4_value = 1;
      else
        #next_motion.Data.UI4_value = 0;
      endif
      PushPacket(::);
      DispatchAndWait(:IPCMD_SYNC_PLC_CONT:);
      </G170>
    <G171 GNum="171" Group="30" AllowGroups="40,41,42,43,101,102">
      <!--G171: Immediate processing of NC blocks-->
      #next_motion.Command = MPCMD_IMMED_PROC_DATA;
      PushPacket(::);
      </G171>
    <G172 GNum="172" Group="30" AllowGroups="40,41,42,43,44,101,102">
      <!--G172: Wait for motion completion-->
      #next_motion.Command = MPCMD_IP_SYNCH_PATH;
      PushPacket(::);
      DispatchAndWait(:IPCMD_SYNC_PATH_CONT:);
      </G172>
    <G173 GNum="173" Group="30" AllowGroups="40,41,42,43,44,101,102">
      <!--G173: Wait for path planer (decoder) completion-->
      #next_motion.Command = MPCMD_IP_SYNCH_PP;
      PushPacket(::);
      DispatchAndWait(:IPCMD_SYNC_PP_CONT:);
    </G173>
    <G180 GNum="180" Group="31">
      <!--G180=<index>: Connecting contour elements-->
      <Arg NameType="EqString" DataType="ContourTransitionIndex" ref="index" MinCount="0" MaxCount="1"/>
      #next_motion.Command = MPCMD_CONNECT_CONTOUR_EL;
      if (Defined(:${index}:))
        #next_motion.Data.I4_value = ${index};
      else
        #next_motion.Data.I4_value = 0;
      endif
      PushPacket(::);
    </G180>
    <G181 GNum="181" Group="181">
      <!--G181: back line mode on-->
      %_CNC.back = 1;
      #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_BACK;
      #next_motion.Data.SystemVariable.AxIdx = -1;
      #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.back;
      #next_motion.Command = MPCMD_CNC_SYS_VAR;
      PushPacket(::);
    </G181>
    <G181.1 GNum="181.1"  Alias="BACK" Group="181" Eval="First" GenerateIfGroups="1,1000" ResetArgs="Yes">
      <!--G181.1: back line command-->
      <Arg DataType="BLIntersection" ref="intersection"/>
      <Arg NameType="BLAngleSpecifier" DataType="BLAngle" ref="bl_angle" MinCount="1" MaxCount="1" />
      #next_motion.Command = MPCMD_BACK_LINE;
      #next_motion.Data.BackLine.IsPointNr = -1;
      if((${intersection} == "C0") || (${intersection} == "$C0"))
      #next_motion.Data.BackLine.IsPointNr = 0;
      else
      if((${intersection} == "C2") || (${intersection} == "$C2"))
      #next_motion.Data.BackLine.IsPointNr = 2;
      endif
      endif
      #next_motion.Data.BackLine.LineAngle = ${bl_angle};
      PushPacket(::);
    </G181.1>
    <G182 GNum="182" Group="181">
      <!--G182: back line mode off-->
      %_CNC.back = 0;
      #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_BACK;
      #next_motion.Data.SystemVariable.AxIdx = -1;
      #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.back;
      #next_motion.Command = MPCMD_CNC_SYS_VAR;
      PushPacket(::);
    </G182>
    <G183 GNum="183" Group="183">
      <!--G183: Trig Help mode on-->
      %_CNC.trig_help = 1;
      #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_TRIG_HELP;
      #next_motion.Data.SystemVariable.AxIdx = -1;
      #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.trig_help;
      #next_motion.Command = MPCMD_CNC_SYS_VAR;
      PushPacket(::);
    </G183>
    <G184 GNum="184" Group="184">
      <!--G184: Trig Help mode off-->
      %_CNC.trig_help = 0;
      #next_motion.Data.SystemVariable.SysVarIdx = CNC_SYS_VAR_TRIG_HELP;
      #next_motion.Data.SystemVariable.AxIdx = -1;
      #next_motion.Data.SystemVariable.Data.I4_value = %_CNC.trig_help;
      #next_motion.Command = MPCMD_CNC_SYS_VAR;
      PushPacket(::);
    </G184>
    <G192 GNum="192" Group="32" ResetArgs="Yes" AllowGroups="6,8,19,21,100,101,102,103">
      <!--G192: Span/Mounting correction-->
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offset" MinCount="0" MaxCount="NumAxes" WriteOpts="#:u?" />
      <Arg NameType="RotationAngleSpecifier" DataType="RotationAngle" ref="h_rot" MinCount="0" MaxCount="1" WriteOpts="#:u?" DenyArgs="3,4,5"/>
      <Arg NameType="EulerAngleName" DataType="RotationAngle" ref="e_rot" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,4,5"/>
      <Arg NameType="RPYAngleName" DataType="RotationAngle" ref="rpy_rot" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,3,5"/>
      <Arg NameType="RotaryVectorName" DataType="RotaryVector" ref="matrix" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,3,4"/>
         PackMPData(:"cmd":MPCMD_MTPT_ZP_SHIFT,"comref":\%_CNC.co_ords_mode,"cemref":\%_CNC.center_mode,${offset},${matrix},${e_rot},${rpy_rot},${h_rot}:);
         PushPacket(::);
      </G192>
    <G193 GNum="193" Group="60">
      <!--G193: Activate linear feed profile-->
      #next_motion.Command = MPCMP_LINEAR_FEED_ON;
      PushPacket(::);
      </G193>
    <G194 GNum="194" Group="60">
      <!--G194: Deactivate linear feed profile-->
      #next_motion.Command = MPCMP_LINEAR_FEED_OFF;
      PushPacket(::);
      </G194>
    <G195 GNum="195" Group="105">
      <!--G195: Activate RTCP-->
      #next_motion.Command = MPCMD_RTCP_ON;
      PushPacket(::);
      </G195>
    <G196 GNum="196" Group="105">
      <!--G196: Deactivate RTCP-->
      #next_motion.Command = MPCMD_RTCP_OFF;
      PushPacket(::);
      </G196>
    <G200 GNum="200" Group="33" RequireGroup="50">
      <!--G200: Position latch after trigger event (for measuring)-->
      <Arg Name="LatchArgPrefix" DataType="INT" ref="latch_var"/>
      <Arg DataType="AXISREF" ref="trigger_axis"/>
      <Arg DataType="TriggerEdge" ref="trigger_edge"/>
      <Arg DataType="TriggerInputIndex" ref="trigger_input" MinCount="0" MaxCount="1"/>
      #next_motion.Command = MPCMD_POS_LATCH;
      #next_motion.Data.PosLatch.LatchIdx = ${latch_var};
      #next_motion.Data.PosLatch.TriggSource = AxisIndex(:${trigger_axis}:);
      if(${trigger_edge} == "P")
        #next_motion.Data.PosLatch.Edge = ncPOSITIVE;
      else
        if(${trigger_edge} == "N")
          #next_motion.Data.PosLatch.Edge = ncNEGATIVE;
        endif
      endif
      if(Defined(:${trigger_input}:))
        #next_motion.Data.PosLatch.HwTrigIdx = ${trigger_input};
      else
        #next_motion.Data.PosLatch.HwTrigIdx = 1;
      endif
      PushPacket(::);
      </G200>
    <G201 GNum="201" Group="33" RequireGroup="50">
      <!--G201: Position latch and halt after trigger event-->
      <Arg Name="LatchArgPrefix" DataType="INT" ref="latch_var"/>
      <Arg DataType="AXISREF" ref="trigger_axis"/>
      <Arg DataType="TriggerEdge" ref="trigger_edge"/>
      <Arg DataType="TriggerInputIndex" ref="trigger_input" MinCount="0" MaxCount="1"/>
      <Arg NameType="EqString" DataType="PositionValue" ref="remaining_dist" MinCount="0" MaxCount="1" />
      #next_motion.Command = MPCMD_POS_LATCH_DIST;
      #next_motion.Data.PosLatchDistance.LatchIdx = ${latch_var};
      #next_motion.Data.PosLatchDistance.TriggSource = AxisIndex(:${trigger_axis}:);
      if(${trigger_edge} == "P")
        #next_motion.Data.PosLatchDistance.Edge = ncPOSITIVE;
      else
        if(${trigger_edge} == "N")
          #next_motion.Data.PosLatchDistance.Edge = ncNEGATIVE;
        endif
      endif
      if(Defined(:${trigger_input}:))
        #next_motion.Data.PosLatchDistance.HwTrigIdx = ${trigger_input};
      else
        #next_motion.Data.PosLatchDistance.HwTrigIdx = 1;
      endif
      if(Defined(:${remaining_dist}:))
        #next_motion.Data.PosLatchDistance.Distance = ${remaining_dist};
      else
        #next_motion.Data.PosLatchDistance.Distance = 0;
      endif
      PushPacket(::);
      </G201>

    <G211 GNum="211" Group="27">
      <!--AllowGroups is empty meaning that no other commands are allowed on this line-->
      <!--G211: switch on blended move mode, set acceleration time [ms] -->
      <Arg ref="time" DataType="TA_Time"/>
       %_CNC.TA = ${time};
       if (%_CNC.TA &lt; 0)
         %_CNC.TA = 0;
       endif
       #next_motion.Command = MPCMD_BLENDEDMOVEMODE;
       #next_motion.Data.R8_value = %_CNC.TA;
       PushPacket(::);
    </G211>
    <G212 GNum="212" Group="60">
      <!--G212: path speed mode 1-->
        #next_motion.Command = MPCMD_PSM1_G212;
        PushPacket(::);
    </G212>
    <G217 GNum="217" Group="53" DenyGroups="53">
      <!--G217: Mapping -->
      <Arg DataType="AXISREF" ref="mapAxis" MinCount="0" MaxCount="1"/>
      <Arg DataType="AxisMappingFactor" ref="factor" MinCount="0" MaxCount="1" RequireArgs="mapAxis"/>
      <Arg Name="FirstAxisIndicator1" DataType="FirstAxisIndicator2" MinCount="0" MaxCount="1" ref="p1"  RequireArgs="mapAxis"/>
      #next_motion.Command = MPCMD_AX_MAPPING_217;
      if(Defined(:${mapAxis}:))
        #next_motion.Data.AxisMapping.AxIdx = AxisIndex(:${mapAxis}:);
        if (Defined(:${factor}:))
          #next_motion.Data.AxisMapping.factor = ${factor};
        else
          #next_motion.Data.AxisMapping.factor = 1;
        endif
        if (Defined(:${p1}:))
          #next_motion.Data.AxisMapping.ParameterP1 = ncON;
        else
          #next_motion.Data.AxisMapping.ParameterP1 = ncOFF;
        endif
      else
        #next_motion.Data.AxisMapping.AxIdx = -1;
        #next_motion.Data.AxisMapping.factor = -1;
        #next_motion.Data.AxisMapping.ParameterP1 = ncOFF;
      endif
      PushPacket(::);
    </G217>
    <G218 GNum="218" Group="53" DenyGroups="53">
      <!--G218: Mapping -->
      <Arg DataType="AXISREF" ref="mapAxis" MinCount="0" MaxCount="1" />
      <Arg DataType="AxisMappingFactor" ref="factor" MinCount="0" MaxCount="1" RequireArgs="mapAxis"/>
      <Arg Name="FirstAxisIndicator1" DataType="FirstAxisIndicator2" MinCount="0" MaxCount="1" ref="p1"  RequireArgs="mapAxis"/>
      #next_motion.Command = MPCMD_AX_MAPPING_218;
      if(Defined(:${mapAxis}:))
        #next_motion.Data.AxisMapping.AxIdx = AxisIndex(:${mapAxis}:);
        if (Defined(:${factor}:))
          #next_motion.Data.AxisMapping.factor = ${factor};
        else
          #next_motion.Data.AxisMapping.factor = 1;
        endif
        if (Defined(:${p1}:))
          #next_motion.Data.AxisMapping.ParameterP1 = ncON;
        else
          #next_motion.Data.AxisMapping.ParameterP1 = ncOFF;
        endif
      else
        #next_motion.Data.AxisMapping.AxIdx = -1;
        #next_motion.Data.AxisMapping.factor = -1;
        #next_motion.Data.AxisMapping.ParameterP1 = ncOFF;
      endif
      PushPacket(::);
    </G218>
    <G219 GNum="219" Group="53" DenyGroups="53">
      <!--G219: Mapping -->
      <Arg DataType="AXISREF" ref="mapAxis" MinCount="0" MaxCount="1"/>
      <Arg DataType="AxisMappingFactor" ref="factor" MinCount="0" MaxCount="1" RequireArgs="mapAxis"/>
      <Arg Name="FirstAxisIndicator1" DataType="FirstAxisIndicator2" MinCount="0" MaxCount="1" ref="p1"  RequireArgs="mapAxis"/>
      #next_motion.Command = MPCMD_AX_MAPPING_219;
      if(Defined(:${mapAxis}:))
        #next_motion.Data.AxisMapping.AxIdx = AxisIndex(:${mapAxis}:);
        if (Defined(:${factor}:))
          #next_motion.Data.AxisMapping.factor = ${factor};
        else
          #next_motion.Data.AxisMapping.factor = 1;
        endif
        if (Defined(:${p1}:))
          #next_motion.Data.AxisMapping.ParameterP1 = ncON;
        else
          #next_motion.Data.AxisMapping.ParameterP1 = ncOFF;
        endif
      else
        #next_motion.Data.AxisMapping.AxIdx = -1;
        #next_motion.Data.AxisMapping.factor = -1;
        #next_motion.Data.AxisMapping.ParameterP1 = ncOFF;
      endif
      PushPacket(::);
    </G219>
    <G220 GNum="220" Group="34" RequireGroups="1" MinArgs="2" MaxArgs="3">
      <!--G220: Signal output before end of path section-->
      <Arg DataType="DwellTime" ref="rem_time" />
      <Arg Name="MFunSignalArgPrefix" DataType="INT" ref="mfun" MinCount="0" MaxCount="1" AllowArgs="rem_time"/>
      <Arg Name="SpindleSignalArgPrefix" DataType="INT" ref="sfun" MinCount="0" MaxCount="1" AllowArgs="rem_time,setval"/>
      <Arg Name="EXFSigParamPrefix" DataType="INT" ref="exfpar" MinCount="0" MaxCount="1" AllowArgs="rem_time,setval" RequireArgs="rem_time,setval"/>
      <Arg Name="EXLSigParamPrefix" DataType="INT" ref="exlpar" MinCount="0" MaxCount="1" AllowArgs="rem_time,setval" RequireArgs="rem_time,setval"/>
      <Arg Name="EXWSigParamPrefix" DataType="INT" ref="exwpar" MinCount="0" MaxCount="1" AllowArgs="rem_time,setval" RequireArgs="rem_time,setval"/>
      <Arg Name="EXBSigParamPrefix" DataType="INT" ref="exbpar" MinCount="0" MaxCount="1" AllowArgs="rem_time,setval" RequireArgs="rem_time,setval"/>
      <Arg NameType="EqString" DataType="FLOAT" ref="setval" MinCount="0" MaxCount="1" DenyArgs="mfun"/>
      #next_motion.Command = MPCMD_SIGNAL;
      #next_motion.Data.SignalPathEnd.Time = ${rem_time};
      if(Defined(:${mfun}:))
        #next_motion.Data.SignalPathEnd.SignalType = 1;
        #next_motion.Data.SignalPathEnd.SignalIdx = ${mfun};
      elif(Defined(:${sfun}:))
        #next_motion.Data.SignalPathEnd.SignalType = 2;
        if (Defined(:${setval}:))
          #next_motion.Data.SignalPathEnd.SourceData.UDINT = ${sfun};
          #next_motion.Data.SignalPathEnd.SignalIdx = ${setval};
        else
          #next_motion.Data.SignalPathEnd.SourceData.UDINT = 0;
          #next_motion.Data.SignalPathEnd.SignalIdx = ${sfun};
        endif
      elif(Defined(:${exfpar}:))
        #next_motion.Data.SignalPathEnd.SignalType = 4;
        #next_motion.Data.SignalPathEnd.SourceData.REAL = ${setval};
        #next_motion.Data.SignalPathEnd.DataLength = 4;
        #next_motion.Data.SignalPathEnd.pDestination = \#sys_vars.EXF[${exfpar}];
      elif(Defined(:${exlpar}:))
        #next_motion.Data.SignalPathEnd.SignalType = 4;
        #next_motion.Data.SignalPathEnd.SourceData.DINT = ${setval};
        #next_motion.Data.SignalPathEnd.DataLength = 4;
        #next_motion.Data.SignalPathEnd.pDestination = \#sys_vars.EXL[${exlpar}];
      elif(Defined(:${exwpar}:))
        #next_motion.Data.SignalPathEnd.SignalType = 4;
        #next_motion.Data.SignalPathEnd.SourceData.INT = ${setval};
        #next_motion.Data.SignalPathEnd.DataLength = 2;
        #next_motion.Data.SignalPathEnd.pDestination = \#sys_vars.EXW[${exwpar}];
      elif(Defined(:${exbpar}:))
        #next_motion.Data.SignalPathEnd.SignalType = 4;
        #next_motion.Data.SignalPathEnd.SourceData.SINT = ${setval};
        #next_motion.Data.SignalPathEnd.DataLength = 1;
        #next_motion.Data.SignalPathEnd.pDestination = \#sys_vars.EXB[${exbpar}];
      endif
      PushPacket(::);
    </G220>
    <G221 GNum="221" Group="35">
      <!--G221: Activate prediction for G220-->
      <Arg DataType="FOverridePercent" ref="f_override" MinCount="0" MaxCount="1" />
      #next_motion.Command = MPCMD_SIGNAL_PREDICT;
      if(Defined(:${f_override}:))
        #next_motion.Data.SignalPredict.Override = ${f_override};
      else
        #next_motion.Data.SignalPredict.Override = 0;
      endif
      PushPacket(::);
    </G221>
    <G222 GNum="222" Group="36" RequireGroups="1" MinArgs="2" MaxArgs="3">
      <!--G220: Signal output before end of path section-->
      <Arg DataType="PositionValue" ref="rem_path_dist" />
      <Arg Name="MFunSignalArgPrefix" DataType="INT" ref="mfun" MinCount="0" MaxCount="1" AllowArgs="rem_path_dist"/>
      <Arg Name="SpindleSignalArgPrefix" DataType="INT" ref="sfun" MinCount="0" MaxCount="1" AllowArgs="rem_path_dist,setval"/>
      <Arg Name="EXFSigParamPrefix" DataType="INT" ref="exfpar" MinCount="0" MaxCount="1" AllowArgs="rem_path_dist,setval" RequireArgs="rem_path_dist,setval"/>
      <Arg Name="EXLSigParamPrefix" DataType="INT" ref="exlpar" MinCount="0" MaxCount="1" AllowArgs="rem_path_dist,setval" RequireArgs="rem_path_dist,setval"/>
      <Arg Name="EXWSigParamPrefix" DataType="INT" ref="exwpar" MinCount="0" MaxCount="1" AllowArgs="rem_path_dist,setval" RequireArgs="rem_path_dist,setval"/>
      <Arg Name="EXBSigParamPrefix" DataType="INT" ref="exbpar" MinCount="0" MaxCount="1" AllowArgs="rem_path_dist,setval" RequireArgs="rem_path_dist,setval"/>
      <Arg NameType="EqString" DataType="FLOAT" ref="setval" MinCount="0" MaxCount="1" DenyArgs="mfun"/>
      #next_motion.Command = MPCMD_SIGNAL_DISTANCE;
      #next_motion.Data.SignalPathEndDist.Distance = ${rem_path_dist};
      if(Defined(:${mfun}:))
        #next_motion.Data.SignalPathEndDist.SignalType = 1;
        #next_motion.Data.SignalPathEndDist.SignalIdx = ${mfun};
      elif(Defined(:${sfun}:))
        #next_motion.Data.SignalPathEndDist.SignalType = 2;
        if (Defined(:${setval}:))
          #next_motion.Data.SignalPathEndDist.SourceData.UDINT = ${sfun};
          #next_motion.Data.SignalPathEndDist.SignalIdx = ${setval};
        else
          #next_motion.Data.SignalPathEndDist.SourceData.UDINT = 0;
          #next_motion.Data.SignalPathEndDist.SignalIdx = ${sfun};
        endif
      elif(Defined(:${exfpar}:))
        #next_motion.Data.SignalPathEndDist.SignalType = 4;
        #next_motion.Data.SignalPathEndDist.SourceData.REAL = ${setval};
        #next_motion.Data.SignalPathEndDist.DataLength = 4;
        #next_motion.Data.SignalPathEndDist.pDestination = \#sys_vars.EXF[${exfpar}];
      elif(Defined(:${exlpar}:))
        #next_motion.Data.SignalPathEndDist.SignalType = 4;
        #next_motion.Data.SignalPathEndDist.SourceData.DINT = ${setval};
        #next_motion.Data.SignalPathEndDist.DataLength = 4;
        #next_motion.Data.SignalPathEndDist.pDestination = \#sys_vars.EXL[${exlpar}];
      elif(Defined(:${exwpar}:))
        #next_motion.Data.SignalPathEndDist.SignalType = 4;
        #next_motion.Data.SignalPathEndDist.SourceData.INT = ${setval};
        #next_motion.Data.SignalPathEndDist.DataLength = 2;
        #next_motion.Data.SignalPathEndDist.pDestination = \#sys_vars.EXW[${exwpar}];
      elif(Defined(:${exbpar}:))
        #next_motion.Data.SignalPathEndDist.SignalType = 4;
        #next_motion.Data.SignalPathEndDist.SourceData.SINT = ${setval};
        #next_motion.Data.SignalPathEndDist.DataLength = 1;
        #next_motion.Data.SignalPathEndDist.pDestination = \#sys_vars.EXB[${exbpar}];
      endif
      PushPacket(::);
     </G222>
    <G234 GNum="234" Group="45">
      <!--G235: Change of CDC Side without transition Elements-->
      #next_motion.Command = MPCMD_CDC_CHG_NO_TRANS_ELEM;
      PushPacket(::);
      </G234>
    <G235 GNum="235" Group="45">
      <!--G235: Change of CDC Side with transition Elements-->
      #next_motion.Command = MPCMD_CDC_CHG_TRANS_ELEM;
      PushPacket(::);
      </G235>
    <G240 GNum="240" Group="16">
      <!--G240: Activate "non-periodic tangential axis" operating mode-->
      #next_motion.Command = MPCMD_NON_PERIOD_TANG_AX;
      PushPacket(::);
      </G240>
    <G241 GNum="241" Group="16">
      <!--G241: Activate "periodic tangential axis" operating mode-->
      #next_motion.Command = MPCMD_PERIOD_TANG_AX;
      PushPacket(::);
      </G241>
    <G250 GNum="250" Group="250" AllowGroups="250">
      <!--G250: Standard method of computation of axis jolt filter-->
      <Arg DataType="AXISREF" ref="axis"/>
      #next_motion.Data.UI4_value = AxisIndex(:${axis}:);
      #next_motion.Command = MPCMD_AX_FILTER_STANDARD;
      PushPacket(::);
    </G250>
   <G251 GNum="251" Group="250" AllowGroups="250">
      <!--G251: Accurate method of computation of axis jolt filter-->
      <Arg DataType="AXISREF" ref="axis"/>
      #next_motion.Data.UI4_value = AxisIndex(:${axis}:);
      #next_motion.Command = MPCMD_AX_FILTER_ACCURATE;
      PushPacket(::);
    </G251>
    <!-- For rotation matrix args, must use ResetArgs to stop RotaryVectorName "R=" confusion with RadiusSpecifier "R=" -->
    <G292 GNum="292" Group="32" ResetArgs="Yes" AllowGroups="6,8,19,21,100,101,102,103">
      <!--G292: CS shift and rotation-->
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offset" MinCount="0" MaxCount="NumAxes" WriteOpts="#:u?" />
      <Arg NameType="RotationAngleSpecifier" DataType="RotationAngle" ref="h_rot" MinCount="0" MaxCount="1" WriteOpts="#:u?" DenyArgs="3,4,5"/>
      <Arg NameType="EulerAngleName" DataType="RotationAngle" ref="e_rot" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,4,5"/>
      <Arg NameType="RPYAngleName" DataType="RotationAngle" ref="rpy_rot" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,3,5"/>
      <Arg NameType="RotaryVectorName" DataType="RotaryVector" ref="matrix" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,3,4"/>
       PackMPData(:"cmd":MPCMD_PROG_ZP_SHIFT2,"comref":\%_CNC.co_ords_mode,"cemref":\%_CNC.center_mode,${offset},${matrix},${e_rot},${rpy_rot},${h_rot}:);
       PushPacket(::);
      </G292>
    <G300 GNum="300" Group="37">
      <Arg DataType="ChordErrorValue" ref="chord_error" />
      <!--G300: Set maximum chord error-->
      #next_motion.Command = MPCMD_CHORD_ERROR;
      #next_motion.Data.R8_value = ${chord_error};
      PushPacket(::);
      </G300>
      <G320 GNum="320" Alias="WS_MAIN_DEF" Group="212" MinArgs="6" MaxArgs="7" >
      <!--WS_MAIN_DEF: Workspace boundaries definition-->
      <Arg Name="WSCoordX1" DataType="WS_Boundaries" ref="x1" MinCount="1" MaxCount="1" />
      <Arg Name="WSCoordY1" DataType="WS_Boundaries" ref="y1" MinCount="1" MaxCount="1" />
      <Arg Name="WSCoordZ1" DataType="WS_Boundaries" ref="z1" MinCount="1" MaxCount="1" />
      <Arg Name="WSCoordX2" DataType="WS_Boundaries" ref="x2" MinCount="1" MaxCount="1" />
      <Arg Name="WSCoordY2" DataType="WS_Boundaries" ref="y2" MinCount="1" MaxCount="1" />
      <Arg Name="WSCoordZ2" DataType="WS_Boundaries" ref="z2" MinCount="1" MaxCount="1" />
      <Arg DataType="WS_Shape" ref="shape" MinCount="0" MaxCount="1" />
      #next_motion.Command = MPCMD_WS_MAIN_DEF;
      #next_motion.Data.WS_Ctrl.x1 = ${x1};
      #next_motion.Data.WS_Ctrl.y1 = ${y1};
      #next_motion.Data.WS_Ctrl.z1 = ${z1};
      #next_motion.Data.WS_Ctrl.x2 = ${x2};
      #next_motion.Data.WS_Ctrl.y2 = ${y2};
      #next_motion.Data.WS_Ctrl.z2 = ${z2};
      #next_motion.Data.WS_Ctrl.shape = WS_CUBOID;
      if(Defined(:${shape}:))
        if (${shape} == "CYLINDER_IN_Z")
          #next_motion.Data.WS_Ctrl.shape = WS_CYLINDER_IN_Z;
        elif (${shape} == "CYLINDER2_IN_Z")
          #next_motion.Data.WS_Ctrl.shape = WS_CYLINDER2_IN_Z;
        endif
      endif
      PushPacket(::);
      </G320>
    <G320.1 GNum="320.1" Alias="WS_MAIN_ALL" Group="212" MinArgs="0" MaxArgs="0" >
      <!--WS_MAIN_ALL: No workspace boundaries to be controlled-->
      #next_motion.Command = MPCMD_WS_MAIN_ALL;
      PushPacket(::);
      </G320.1>
    <G320.2 GNum="320.2" Alias="WS_CTRL_ON" Group="212" MinArgs="0" MaxArgs="3" >
      <!--WS_CTRL_ON: Workspace control in decoder switch on-->
      <Arg DataType="WS_SelfCollisionOff" ref="sco" MinCount="0" MaxCount="1" />
      <Arg DataType="WS_ExclOff" ref="excl_off" MinCount="0" MaxCount="1" />
      <Arg DataType="WS_CyclicOn" ref="cyclic_on" MinCount="0" MaxCount="1" />
      <Arg DataType="WS_InterChannelOn" ref="inter_channel_on" MinCount="0" MaxCount="1" />
      <Arg DataType="WS_ExternalInterChannelOn" ref="external_inter_channel_on" MinCount="0" MaxCount="1" />
      #next_motion.Command = MPCMD_WS_CTRL_ON;
      if(Defined(:${sco}:))
        <!-- noop -->
      else
        #next_motion.Data.WS_Ctrl.self_collision = 1;
      endif
      if(Defined(:${excl_off}:))
        <!-- noop -->
      else
        #next_motion.Data.WS_Ctrl.exclusive = 1;
      endif
      if(Defined(:${cyclic_on}:))
        #next_motion.Data.WS_Ctrl.cyclic = 1;
      endif
      if(Defined(:${inter_channel_on}:))
        #next_motion.Data.WS_Ctrl.interchannel_collision = 1;
      endif
      if(Defined(:${external_inter_channel_on}:))
        #next_motion.Data.WS_Ctrl.external_interchannel_collision = 1;
      endif
      PushPacket(::);
      </G320.2>
    <G320.3 GNum="320.3" Alias="WS_CTRL_OFF" Group="212" MinArgs="0" MaxArgs="0" >
      <!--WS_CTRL_OFF: Workspace control in decoder switch off-->
      #next_motion.Command = MPCMD_WS_CTRL_OFF;
      PushPacket(::);
      </G320.3>
    <G320.4 GNum="320.4" Alias="ARM_DIAMETER" Group="212" MinArgs="1" MaxArgs="20" >
      <!--ARM_DIAMETER: Diameter of robot arms -->
      <Arg ref="arm_diameter" DataType="RobotArmDiameter" MinCount="1" MaxCount="20" WriteOpts="#:u"/>
      <!-- read the number of arguments into local variable $f ($f is LREAL type) -->
      local $f;
      $f = ListLength(:${arm_diameter}:);
      #next_motion.Command = MPCMD_ARM_DIAMETER;
      #next_motion.Data.WS_Ctrl.arm_diameter[0] = ${arm_diameter};

      if ($f &lt; 20)
      <!-- fill remaining array indexes (starting from index [<num_items>]) with last value: ListItemValue accepts ranges 1..n (not 0..n-1) -->
       #next_motion.Data.WS_Ctrl.arm_diameter[$f] = ArrayRep(:(: ListItemValue(:${arm_diameter}, $f:) :):);
      endif

      PushPacket(::);
      </G320.4>
    <G320.5 GNum="320.5" Alias="PROTBLOCK_DEF" Group="212" MinArgs="1" MaxArgs="7" >
      <!--PROTBLOCK_DEF: Protected block definition for WS Control-->
      <Arg Name="WSIndex" DataType="WS_Index" ref="index" MinCount="1" MaxCount="1" />
      <Arg Name="WSCoordX1" DataType="WS_Boundaries" ref="x1" MinCount="0" MaxCount="1" />
      <Arg Name="WSCoordY1" DataType="WS_Boundaries" ref="y1" MinCount="0" MaxCount="1" />
      <Arg Name="WSCoordZ1" DataType="WS_Boundaries" ref="z1" MinCount="0" MaxCount="1" />
      <Arg Name="WSCoordX2" DataType="WS_Boundaries" ref="x2" MinCount="0" MaxCount="1" />
      <Arg Name="WSCoordY2" DataType="WS_Boundaries" ref="y2" MinCount="0" MaxCount="1" />
      <Arg Name="WSCoordZ2" DataType="WS_Boundaries" ref="z2" MinCount="0" MaxCount="1" />
      #next_motion.Command = MPCMD_PROTBLOCK_DEF;
      #next_motion.Data.WS_Ctrl.index = ${index};
      if (Defined(:${x1}:))
        #next_motion.Data.WS_Ctrl.x1 = ${x1};
      else
        #next_motion.Data.WS_Ctrl.x1 = 0;
      endif
      if (Defined(:${y1}:))
        #next_motion.Data.WS_Ctrl.y1 = ${y1};
      else
        #next_motion.Data.WS_Ctrl.y1 = 0;
      endif
      if (Defined(:${z1}:))
        #next_motion.Data.WS_Ctrl.z1 = ${z1};
      else
        #next_motion.Data.WS_Ctrl.z1 = 0;
      endif
      if (Defined(:${x2}:))
        #next_motion.Data.WS_Ctrl.x2 = ${x2};
      else
        #next_motion.Data.WS_Ctrl.x2 = 0;
      endif
      if (Defined(:${y2}:))
        #next_motion.Data.WS_Ctrl.y2 = ${y2};
      else
        #next_motion.Data.WS_Ctrl.y2 = 0;
      endif
      if (Defined(:${z2}:))
        #next_motion.Data.WS_Ctrl.z2 = ${z2};
      else
        #next_motion.Data.WS_Ctrl.z2 = 0;
      endif
      PushPacket(::);
      </G320.5>
    <G320.6 GNum="320.6" Alias="PROTBLOCK_ADD" Group="212" MinArgs="1" MaxArgs="1" >
      <!--PROTBLOCK_ADD: Protected block is added to the protection area model-->
      <Arg Name="WSIndex" DataType="WS_Index" ref="index" MinCount="1" MaxCount="1" />
      #next_motion.Command = MPCMD_PROTBLOCK_ADD;
      #next_motion.Data.WS_Ctrl.index = ${index};
      PushPacket(::);
      </G320.6>
    <G320.7 GNum="320.7" Alias="PROTBLOCK_REM" Group="212" MinArgs="1" MaxArgs="1" >
      <!--PROTBLOCK_REM: Protected block is removed from the protection area model-->
      <Arg Name="WSIndex" DataType="WS_Index" ref="index" MinCount="1" MaxCount="1" />
      #next_motion.Command = MPCMD_PROTBLOCK_REM;
      #next_motion.Data.WS_Ctrl.index = ${index};
      PushPacket(::);
      </G320.7>
    <G320.8 GNum="320.8" Alias="PROTHSPACE_DEF" Group="212" MinArgs="6" MaxArgs="6" >
      <!-- PROTBLOCK_DEF: Protected half-space definition for WS Control -->
      <Arg Name="WSIndex" DataType="WS_Index" ref="index" MinCount="1" MaxCount="1" />
      <Arg DataType="WSParallelPlane" ref="ignored" MinCount="1" MaxCount="1" />
      <Arg DataType="PlaneEnum" ref="pplane" MinCount="1" MaxCount="1" />
      <Arg Name="WSCoordC" DataType="WS_Coord" ref="coord" MinCount="1" MaxCount="1" />
      <Arg DataType="WSOrientation" ref="ignored1" MinCount="1" MaxCount="1" />
      <Arg DataType="OrientEnum" ref="orient" MinCount="1" MaxCount="1" />
      #next_motion.Command = MPCMD_PROTHSPACE_DEF;
      #next_motion.Data.WS_Ctrl.index = ${index};
      #next_motion.Data.WS_Ctrl.coord = ${coord};
      if ((${pplane} == "XY") || (${pplane} == "YX"))
        #next_motion.Data.WS_Ctrl.pplane = 1;
      elif ((${pplane} == "YZ") || (${pplane} == "ZY"))
        #next_motion.Data.WS_Ctrl.pplane = 2;
      elif ((${pplane} == "XZ") || (${pplane} == "ZX"))
        #next_motion.Data.WS_Ctrl.pplane = 3;
      else
        #next_motion.Data.WS_Ctrl.pplane = 0;
      endif
      if (${orient} == "POS")
        #next_motion.Data.WS_Ctrl.orient = 1;
      elif (${orient} == "NEG")
        #next_motion.Data.WS_Ctrl.orient = 2;
      else
        #next_motion.Data.WS_Ctrl.orient = 0;
      endif
      PushPacket(::);
      </G320.8>
    <G320.9 GNum="320.9" Alias="PROTHSPACE_ADD" Group="212" MinArgs="1" MaxArgs="1" >
      <!--PROTHSPACE_ADD: Protected half-space is added to the protection area model-->
      <Arg Name="WSIndex" DataType="WS_Index" ref="index" MinCount="1" MaxCount="1" />
      #next_motion.Command = MPCMD_PROTHSPACE_ADD;
      #next_motion.Data.WS_Ctrl.index = ${index};
      PushPacket(::);
      </G320.9>
    <G321 GNum="321" Alias="PROTHSPACE_REM" Group="212" MinArgs="1" MaxArgs="1" >
      <!--PROTHSPACE_REM: Protected half-space is removed from the protection area model-->
      <Arg Name="WSIndex" DataType="WS_Index" ref="index" MinCount="1" MaxCount="1" />
      #next_motion.Command = MPCMD_PROTHSPACE_REM;
      #next_motion.Data.WS_Ctrl.index = ${index};
      PushPacket(::);
      </G321>
    <G321.1 GNum="321.1" Alias="EXCLBLOCK_DEF" Group="212" MinArgs="1" MaxArgs="8" >
      <!--EXCLBLOCK_DEF: Exclusive block definition for WS Control-->
      <Arg Name="WSIndex" DataType="WS_Index" ref="index" MinCount="1" MaxCount="1" />
      <Arg Name="WSCoordX1" DataType="WS_Boundaries" ref="x1" MinCount="0" MaxCount="1" />
      <Arg Name="WSCoordY1" DataType="WS_Boundaries" ref="y1" MinCount="0" MaxCount="1" />
      <Arg Name="WSCoordZ1" DataType="WS_Boundaries" ref="z1" MinCount="0" MaxCount="1" />
      <Arg Name="WSCoordX2" DataType="WS_Boundaries" ref="x2" MinCount="0" MaxCount="1" />
      <Arg Name="WSCoordY2" DataType="WS_Boundaries" ref="y2" MinCount="0" MaxCount="1" />
      <Arg Name="WSCoordZ2" DataType="WS_Boundaries" ref="z2" MinCount="0" MaxCount="1" />
      <Arg Name="WSStopDifference" DataType="WS_Coord" ref="stop_difference" MinCount="0" MaxCount="1" />
      #next_motion.Command = MPCMD_EXCLBLOCK_DEF;
      #next_motion.Data.WS_Ctrl.index = ${index};
      if (Defined(:${x1}:))
        #next_motion.Data.WS_Ctrl.x1 = ${x1};
      else
        #next_motion.Data.WS_Ctrl.x1 = 0;
      endif
      if (Defined(:${y1}:))
        #next_motion.Data.WS_Ctrl.y1 = ${y1};
      else
        #next_motion.Data.WS_Ctrl.y1 = 0;
      endif
      if (Defined(:${z1}:))
        #next_motion.Data.WS_Ctrl.z1 = ${z1};
      else
        #next_motion.Data.WS_Ctrl.z1 = 0;
      endif
      if (Defined(:${x2}:))
        #next_motion.Data.WS_Ctrl.x2 = ${x2};
      else
        #next_motion.Data.WS_Ctrl.x2 = 0;
      endif
      if (Defined(:${y2}:))
        #next_motion.Data.WS_Ctrl.y2 = ${y2};
      else
        #next_motion.Data.WS_Ctrl.y2 = 0;
      endif
      if (Defined(:${z2}:))
        #next_motion.Data.WS_Ctrl.z2 = ${z2};
      else
        #next_motion.Data.WS_Ctrl.z2 = 0;
      endif
      if (Defined(:${stop_difference}:))
        #next_motion.Data.WS_Ctrl.coord = ${stop_difference};
      else
        #next_motion.Data.WS_Ctrl.coord = 0;
      endif
      PushPacket(::);
    </G321.1>
    <G321.2 GNum="321.2" Alias="EXCLBLOCK_ADD" Group="212" MinArgs="1" MaxArgs="1" >
      <!--EXCLBLOCK_ADD: Exclusive block is added to the protection area model-->
      <Arg Name="WSIndex" DataType="WS_Index" ref="index" MinCount="1" MaxCount="1" />
      #next_motion.Command = MPCMD_EXCLBLOCK_ADD;
      #next_motion.Data.WS_Ctrl.index = ${index};
      PushPacket(::);
      </G321.2>
    <G321.3 GNum="321.3" Alias="EXCLBLOCK_REM" Group="212" MinArgs="1" MaxArgs="1" >
      <!--EXCLBLOCK_REM: Exclusive block is removed from the protection area model-->
      <Arg Name="WSIndex" DataType="WS_Index" ref="index" MinCount="1" MaxCount="1" />
      #next_motion.Command = MPCMD_EXCLBLOCK_REM;
      #next_motion.Data.WS_Ctrl.index = ${index};
      PushPacket(::);
    </G321.3>
    <G321.4 GNum="321.4" Alias="INTERCHANNEL_EXCLUDE" Group="212" MinArgs="1" MaxArgs="1" >
      <Arg Name="WSChannel" DataType="STRING" ref="channel" MinCount="1" MaxCount="1" />
      MemCpy(:\#next_motion.Data.WS_Ctrl.cncObjName, \${channel}:);
      #next_motion.Command = MPCMD_INTERCHANNEL_EXCLUDE;
     PushPacket(::);
    </G321.4>
    <G321.5 GNum="321.5" Alias="SAFE_DISTANCE" Group="212" MinArgs="1" MaxArgs="1" >
      <Arg DataType="WS_Boundaries" ref="safe_distance" MinCount="1" MaxCount="1" />
      #next_motion.Command = MPCMD_SAFE_DISTANCE;
      #next_motion.Data.WS_Ctrl.coord = ${safe_distance};
      PushPacket(::);
    </G321.5>
    <G395 GNum="395" Alias="$WFRAME_TCP" Group="32">
    <!--G395: TCP frame -->
      #next_motion.Command = MPCMD_TCP_FRAME;
      PushPacket(::);
    </G395>
    <G396 GNum="396" Group="32" Alias="FRAME_ORIENT_ON">
    <!--G396: enable TCP orientaion by frame -->
      #next_motion.Command = MPCMD_FRAME_TCP_AX_ON;
      PushPacket(::);
    </G396>
    <G397 GNum="397" Group="32" Alias="FRAME_ORIENT_OFF">
    <!--G397: disable TCP orientaion by frame -->
      #next_motion.Command = MPCMD_FRAME_TCP_AX_OFF;
      PushPacket(::);
    </G397>
    <G398 GNum="398" Alias="FRAME_ORIENT_SHORT">
    <!--G398: recomputed orientation closest to current pos -->
      #next_motion.Command = MPCMD_FRAME_ORIENT_SHORT;
      PushPacket(::);
    </G398>
    <G399 GNum="399" Alias="FRAME_ORIENT_USER">
    <!--G399: recomputed orientation closest to programmed pos -->
      #next_motion.Command = MPCMD_FRAME_ORIENT_USER;
      PushPacket(::);
    </G399>
    <!-- Tech-Params implemented as Alias'ed GCodes -
      - Need option AliasIsPattern="Yes" to stop the default word-break lookahead pattern being added
      -->
    <G501_FEED GNum="501" Alias="F:[\d\s=]|F:EX[FLWB]\d|F:[PR]\d|F:\.\d" AliasIsPattern="Yes" Group="100">
      <ARG ref="opteq" DataType="EqString" MinCount="0" MaxCount="1" />
      <ARG ref="EXPR" DataType="Feedrate" />
      #next_motion.Command = MPCMD_FEED_RATE;
      #next_motion.Data.R8_value = ${EXPR};
      PushPacket(::);
    </G501_FEED>
    <G502_SPINDLE GNum="502" Alias="S:[\d\s]|S:EX[FLWB]\d|S:[PR]\d" AliasIsPattern="Yes" Group="101" MinArgs="1">
      <ARG ref="arg1" DataType="SpindleRPM" />
      <ARG ref="arg2" NameType="EqString" DataType="SpindleRPM" MinCount="0" MaxCount="1" />
      <!--Spindle setting has an optional argument for Spindle ID (S1000 or S0=1000) - default ID=0-->
      #next_motion.Command = MPCMD_CDC_SPINDLE_SPEED;
      if (Defined(:${arg2}:))
        #next_motion.Data.SpindleSpeed.Idx = ${arg1};
        #next_motion.Data.SpindleSpeed.speed = ${arg2};
      else
        #next_motion.Data.SpindleSpeed.Idx = 0;
        #next_motion.Data.SpindleSpeed.speed = ${arg1};
      endif
      PushPacket(::);
    </G502_SPINDLE>
    <G502_1_SPINDLE GNum="502.1" Alias="S=:[^=]" AliasIsPattern="Yes" Group="101">
      <ARG ref="arg1" DataType="SpindleRPM" />
      <!--Spindle setting S= does not accept spindle-id-->
      #next_motion.Command = MPCMD_CDC_SPINDLE_SPEED;
      #next_motion.Data.SpindleSpeed.Idx = 0;
      #next_motion.Data.SpindleSpeed.speed = ${arg1};
      PushPacket(::);
    </G502_1_SPINDLE>
    <G503_TOOLID GNum="503" Alias="T:[\d\s=]|T:EX[FLWB]\d|T:[PR]\d" AliasIsPattern="Yes" Group="102">
      <ARG ref="opteq" DataType="EqString" MinCount="0" MaxCount="1" />
      <ARG ref="EXPR" DataType="ToolID" />
      #next_motion.Command = MPCMD_CDC_TOOL_LOC_NR;
      #next_motion.Data.UI4_value = ${EXPR};
      PushPacket(::);
      #sys_vars.T = ${EXPR};
    </G503_TOOLID>
    <G504_TOOLDATAID GNum="504" Alias="D:[\d\s=]|D:EX[FLWB]\d|D:[PR]\d" AliasIsPattern="Yes" Group="103">
      <ARG ref="opteq" DataType="EqString" MinCount="0" MaxCount="1" />
      <ARG ref="EXPR" DataType="ToolID" />
      #next_motion.Command = MPCMD_CDC_TOOL_DATA_REC;
      #next_motion.Data.ToolDataRecord.ToolIdx = ${EXPR};
      PushPacket(::);
      #sys_vars.D = ${EXPR};
      #sys_vars.RAD = GetToolRadius(:${EXPR}:);
    </G504_TOOLDATAID>
    <G505_CGC GNum="-4" IsCgcProcedure="No">
      <!-- Custom G-Code -->
      local $file_id;
      UnloadProgIfModified(:$[2]:);
      $file_id = LoadProg(:$[2],-1:);
      AssignProgArgs(:$file_id,\$[3]:);
      ExecProg(:$file_id:);
      #cgc_disable = 0;
    </G505_CGC>
    <G510 GNum="510" Alias="AUTO_BLOCK_NUMBER_ON">
    <!-- Automatic NC block numbering on -->
      <Arg Name="AutoBlockNumberFactor" DataType="int" ref="factor" MinCount="0" MaxCount="1" />
      <Arg Name="AutoBlockNumberOffset" DataType="int" ref="offset" MinCount="0" MaxCount="1" />
      if Defined(:${factor}:)
        #next_motion.Data.AutoBlockNumber.factor = ${factor};
      else
        #next_motion.Data.AutoBlockNumber.factor = 1;
      endif
      if Defined(:${offset}:)
        #next_motion.Data.AutoBlockNumber.offset = ${offset};
      endif
      #next_motion.Command = MPCMD_AUTO_BLOCK_NUMBER_ON;
      PushPacket(::);
    </G510>
    <G511 GNum="511" Alias="AUTO_BLOCK_NUMBER_OFF">
    <!-- Automatic NC block numbering off -->
      #next_motion.Command = MPCMD_AUTO_BLOCK_NUMBER_OFF;
      PushPacket(::);
    </G511>
    <G601 GNum="601">
      <!--G601: Mode for ccuracy hold-->
      #next_motion.Command = MPCMD_ACC_HOLD_MODE;
      #next_motion.Data.I4_value = 0;
      PushPacket(::);
    </G601>
    <G602 GNum="602">
      <!--G602: Mode for ccuracy hold-->
      #next_motion.Command = MPCMD_ACC_HOLD_MODE;
      #next_motion.Data.I4_value = 1;
      PushPacket(::);
    </G602>
    <G603 GNum="603">
      <!--G603: Mode for ccuracy hold-->
      #next_motion.Command = MPCMD_ACC_HOLD_MODE;
      #next_motion.Data.I4_value = 2;
      PushPacket(::);
    </G603>
    <!-- Motion packet logging control GCodes, configuration to be reviewed -->
    <G701 GNum="701" Alias="LOGON" Group="700">
      <!--G701: Enable MPLogging (following an explicit disable, or if logging set to ncMANUAL start) -->
      #enable_mplogging = 1;
      LogWrite(:"#GCode Enable":);
    </G701>
    <G702 GNum="702" Alias="LOGOFF" Group="700">
      <!--G702: Disable MPLogging during a program run -->
      LogWrite(:"#GCode Disable":);
      #enable_mplogging = 0;
    </G702>
    <G705 GNum="705" Group="700">
      <ARG ref="EXPR" DataType="INT"  MinCount="1" MaxCount="1"/>
      #next_motion.Command = MPCMD_CNC_LOG_PARAMETER;
      #next_motion.Data.I4_value = ${EXPR};
      PushPacket(::);
    </G705>
    <G720 GNum="720" Alias="SBLOF_PATH" Group="720" AllowGroups="">
      <!--G720: Inhibit path single step mode -->
      #next_motion.Command = MPCMD_SBL_PATH_INHIBIT;
      PushPacket(::);
    </G720>
    <G721 GNum="721" Alias="SBLON_PATH" Group="721" AllowGroups="">
      <!--G721: Release path single step mode -->
      #next_motion.Command = MPCMD_SBL_PATH_RELEASE;
      PushPacket(::);
    </G721>
    <G801 GNum="801" Group="200">
      <!--G801: Activate C2 spline interpolation-->
      <Arg DataType="C2SplineSeg" ref="seg_type"/>
      <Arg NameType="EqString" DataType="FLOAT" ref="seg_par"/>
      <Arg Name="BCTypeArg" DataType="INT" ref="bc_par"/>
      <Arg NameType="AXISREF" DataType="PositionValue" ref="boundary" MinCount="0" MaxCount="NumAxes" WriteOpts="#:" />
      #next_motion.Command = MPCMD_C2_SPLINE_START;
      if(${seg_type} == "CE")
        #next_motion.Data.C2_SplineStart.SegmentType = 1;
      else
        if(${seg_type} == "SL")
          #next_motion.Data.C2_SplineStart.SegmentType = 2;
        endif
      endif
      if(Defined(:${seg_par}:))
        #next_motion.Data.C2_SplineStart.SegmentParameter = ${seg_par};
      else
        #next_motion.Data.C2_SplineStart.SegmentParameter = -1.0;
      endif
      #next_motion.Data.C2_SplineStart.BCType = ${bc_par};
      PackNamedListToArrays(:ORDERING_REAL, MP_AX_NUMBER, ${boundary}, \#next_motion.Data.C2_SplineStart.BCValue, \#next_motion.Data.C2_SplineStart.BCProgrammed:);
      PushPacket(::);
      </G801>
    <G802 GNum="802" Group="200">
      <!--G801: Deactivate C2 spline interpolation-->
      <Arg Name="BCTypeArg" DataType="INT" ref="bc_par"/>
      <Arg NameType="AXISREF" DataType="PositionValue" ref="boundary" MinCount="0" MaxCount="NumAxes" WriteOpts="#:" />
      #next_motion.Command = MPCMD_C2_SPLINE_END;
      #next_motion.Data.C2_SplineEnd.BCType = ${bc_par};
      PackNamedListToArrays(:ORDERING_REAL, MP_AX_NUMBER, ${boundary}, \#next_motion.Data.C2_SplineEnd.BCValue, \#next_motion.Data.C2_SplineEnd.BCProgrammed:);
      PushPacket(::);
      </G802>
    <G803 GNum="803" Group="200">
      <!--G803: Switch off accurate C2 spline temporarily-->
      #next_motion.Command = MPCMD_C2_SPLINE_ACCUR_OFF;
      PushPacket(::);
    </G803>
    <G804 GNum="804" ResetArgs="Yes">
      <Arg ref="dest"     MinCount="0" MaxCount="NumAxes" NameType="AXISREF"         DataType="PositionValue" WriteOpts="#:u?" />
      <Arg ref="radius"   MinCount="1" MaxCount="1"       NameType="RadiusSpecifier" DataType="RadiusValue"/>
      #next_motion.Data.R8_value = ${radius};
      #next_motion.Command = MPCMD_BEZIER_INTPOL_PARAM;
      PushPacket(::);
      PackMPData(:"cmd":MPCMD_BEZIER_INTPOL_RAPID, "comref":\%_CNC.co_ords_mode, "cemref":\%_CNC.center_mode, ${dest}:);
      PushPacket(::);
    </G804>
    <G805 GNum="805" ResetArgs="Yes">
      <Arg ref="dest"     MinCount="0" MaxCount="NumAxes" NameType="AXISREF"         DataType="PositionValue" WriteOpts="#:u?" />
      <Arg ref="radius"   MinCount="1" MaxCount="1"       NameType="RadiusSpecifier" DataType="RadiusValue"/>
      #next_motion.Data.R8_value = ${radius};
      #next_motion.Command = MPCMD_BEZIER_INTPOL_PARAM;
      PushPacket(::);
      PackMPData(:"cmd":MPCMD_BEZIER_INTPOL, "comref":\%_CNC.co_ords_mode, "cemref":\%_CNC.center_mode, ${dest}:);
      PushPacket(::);
    </G805>
    <G806 GNum="806" ResetArgs="Yes">
      <!-- Bezier spline rapid interpolation -->
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offsets" MinCount="1" MaxCount="NumAxes" WriteOpts="#:?" />
      #next_motion.Command = MPCMD_SPLINE_RAPID_INTPOL;
      PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${offsets}, \#next_motion.Data.SplinePoint.Position, \#next_motion.Data.SplinePoint.AxIdx, \#next_motion.Data.SplinePoint.Mode:);
      PushPacket(::);
    </G806>
    <G806_1 GNum="806.1" Alias="BP_1" ResetArgs="Yes">
      <!-- Bezier spline interpolation: Bezier point 1 -->
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offsets1" MinCount="1" MaxCount="NumAxes" WriteOpts="#:?" />
      #next_motion.Command = MPCMD_SPLINE_INTPOL_BP1;
      PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${offsets1}, \#next_motion.Data.SplinePoint.Position, \#next_motion.Data.SplinePoint.AxIdx, \#next_motion.Data.SplinePoint.Mode:);
      PushPacket(::);
    </G806_1>
    <G806_2 GNum="806.2" Alias="BP_2" ResetArgs="Yes">
      <!-- Bezier spline interpolation: Bezier point 2 -->
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offsets2" MinCount="1" MaxCount="NumAxes" WriteOpts="#:?" />
      #next_motion.Command = MPCMD_SPLINE_INTPOL_BP2;
      PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${offsets2}, \#next_motion.Data.SplinePoint.Position, \#next_motion.Data.SplinePoint.AxIdx, \#next_motion.Data.SplinePoint.Mode:);
      PushPacket(::);
    </G806_2>
    <G807 GNum="807" ResetArgs="Yes">
      <!-- Bezier spline interpolation -->
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offsets" MinCount="1" MaxCount="NumAxes" WriteOpts="#:?" />
      #next_motion.Command = MPCMD_SPLINE_INTPOL;
      PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${offsets}, \#next_motion.Data.SplinePoint.Position, \#next_motion.Data.SplinePoint.AxIdx, \#next_motion.Data.SplinePoint.Mode:);
      PushPacket(::);
    </G807>
    <G810 GNum="810" Alias="OPTI_SPEED_START" Group="200">
      <!--G810: Segmentation in path planner-->
      <Arg DataType="FreeExtData" MinCount="0" MaxCount="1" ref="free"/>
      #next_motion.Command = MPCMD_SEGMENTATION_START;
      if (Defined(:${free}:))
      #next_motion.Data.UI4_value = 1;
      else
      #next_motion.Data.UI4_value = 0;
      endif
      PushPacket(::);
      </G810>
    <G810_1 GNum="810.1" Alias="CONDITIONAL_STOP" Group="200">
      <!--G810.1: Conditional stop-->
      <Arg DataType="Long" ref="ident" MinCount="0" MaxCount="1" />
      if (Defined(:${ident}:))
      #next_motion.Data.UI4_value = ${ident};
      else
      #next_motion.Data.UI4_value = 0;
      endif
      #next_motion.Command = MPCMD_CONDITIONAL_STOP;
      PushPacket(::);
      </G810_1>
    <G810_2 GNum="810.2" Alias="TRACKING_ON" Group="200">
      <!--G810.2: tracking on on the optimized section-->
      <Arg DataType="Long" ref="ident" MinCount="0" MaxCount="1" />
      if (Defined(:${ident}:))
      #next_motion.Data.UI4_value = ${ident};
      else
      #next_motion.Data.UI4_value = 0;
      endif
      #next_motion.Command = MPCMD_TRACKING_ON;
      PushPacket(::);
      </G810_2>
    <G810_3 GNum="810.3" Alias="TRACKING_OFF" Group="200">
      <!--G810.3: tracking off on the optimized section-->
      #next_motion.Command = MPCMD_TRACKING_OFF;
      PushPacket(::);
      </G810_3>
    <G810_4 GNum="810.4" Alias="CONDITIONAL_STOP_OPTMOT" Group="200">
      <Arg DataType="Long" ref="ident" MinCount="0" MaxCount="1" />
      if (Defined(:${ident}:))
      #next_motion.Data.UI4_value = ${ident};
      else
      #next_motion.Data.UI4_value = 1;
      endif
      #next_motion.Command = MPCMD_COND_STOP_OPTMOT;
      PushPacket(::);
    </G810_4>
    <G811 GNum="811" Alias="OPTI_SPEED_END" Group="200">
      <!--G811: Segmentation in path planner-->
      #next_motion.Command = MPCMD_SEGMENTATION_END;
      PushPacket(::);
      </G811>
    <G812 GNum="812" Alias="SHORTEST_ORIENTATION" Group="200">
      <!--G812: As small orientation axes change as possible for 6ax robot-->
      #next_motion.Command = MPCMD_SHORTEST_ORIENTATION_AXES;
      PushPacket(::);
      </G812>
    <G812_1 GNum="812.1" Alias="CONTINUOUS_ORIENTATION_ALIGNMENT" Group="200">
      <!--G812_1: As small orientation axes change as possible for 6ax robot on NC block level-->
      #next_motion.Command = MPCMD_CONTINUOUS_ORIENTATION_ALIGNMENT;
      PushPacket(::);
      </G812_1>
    <G813 GNum="813" Alias="STANDARD_ORIENTATION" Group="200">
      <!--G813: No special orientation axes changes-->
      #next_motion.Command = MPCMD_STANDARD_ORIENTATION_AXES;
      PushPacket(::);
      </G813>
    <G813_1 GNum="813.1" Alias="STANDARD_ORIENTATION_ALIGNMENT" Group="200">
      <!--G813_1: No special orientation axes changes, neither on NC block level-->
      #next_motion.Command = MPCMD_STANDARD_ORIENTATION_ALIGNMENT;
      PushPacket(::);
      </G813_1>
    <G814 GNum="814" Alias="UNIQUE_ORIENTATION_CHECK" Group="200">
      <!--G814: A check for unique orientation axes change-->
      #next_motion.Command = MPCMD_UNIQUE_ORIENTATION_CHECK;
      PushPacket(::);
      </G814>
    <G815 GNum="815" Alias="NO_ORIENTATION_CHECK" Group="200">
      <!--G815: No check for unique orientation axes change-->
      #next_motion.Command = MPCMD_NO_ORIENTATION_CHECK;
      PushPacket(::);
      </G815>
    <G816 GNum="816" Alias="NC_BLOCK_SKIP_ON" Group="200">
      <!--G816: A skip of NC block allowed in path planner-->
      <Arg DataType="BlockSkipFlush" MinCount="0" MaxCount="1" ref="flush"/>
      #next_motion.Command = MPCMD_SKIP_PP_ON;
      if (Defined(:${flush}:))
      #next_motion.Data.UI4_value = ncON;
      else
      #next_motion.Data.UI4_value = ncOFF;
      endif
      PushPacket(::);
      </G816>
    <G817 GNum="817" Alias="NC_BLOCK_SKIP_OFF" Group="200">
      <!--G817: No skip of NC block allowed in path planner-->
      #next_motion.Command = MPCMD_SKIP_PP_OFF;
      PushPacket(::);
      </G817>
    <G818 GNum="818" Alias="SMOOTH_ORIENTATION_CHANGE" Group="200">
      <!--G818: Smooth orientation change: quaternions, SLERP-->
      #next_motion.Command = MPCMD_SMOOTH_ORIENTATION;
      PushPacket(::);
      </G818>
    <G819 GNum="819" Alias="COMPONENTWISE_ORIENTATION_CHANGE" Group="200">
      <!--G819: Componentwise orientation change: Euler, Cardan angles-->
      #next_motion.Command = MPCMD_COMPONENTWISE_ORIENTATION;
      PushPacket(::);
      </G819>
    <G820 GNum="820" Alias="OPTI_PARAMETER" Group="200" MinArgs="1" MaxArgs="4" >
      <!--G820: Optimizer synchronous change of parameters-->
      <Arg Name="OptMotPathDefinition" DataType="UByte" ref="vpath" MinCount="0" MaxCount="1" />
      <Arg Name="OptMotRobotParameter" DataType="UByte" ref="robopar" MinCount="0" MaxCount="1" />
      <Arg Name="OptMotLimits" DataType="UByte" ref="limits" MinCount="0" MaxCount="1" />
      <Arg Name="OptMotLimitsFactor" DataType="FLOAT" ref="factor" MinCount="0" MaxCount="1" />
      #next_motion.Command = MPCMD_OPTMOT_PAR;
      if (Defined(:${vpath}:))
      #next_motion.Data.OptMotPar.path_definition = ${vpath};
      #next_motion.Data.OptMotPar.path_definition_def = 1;
      else
      #next_motion.Data.OptMotPar.path_definition_def = 0;
      endif
      if (Defined(:${robopar}:))
      #next_motion.Data.OptMotPar.robot_par = ${robopar};
      #next_motion.Data.OptMotPar.robot_par_def = 1;
      else
      #next_motion.Data.OptMotPar.robot_par_def = 0;
      endif
      if (Defined(:${limits}:))
      #next_motion.Data.OptMotPar.limits_idx = ${limits};
      #next_motion.Data.OptMotPar.limits_idx_def = 1;
      else
      #next_motion.Data.OptMotPar.limits_idx_def = 0;
      endif
      if (Defined(:${factor}:))
      #next_motion.Data.OptMotPar.limits_factor = ${factor};
      #next_motion.Data.OptMotPar.limits_factor_def = 1;
      else
      #next_motion.Data.OptMotPar.limits_factor_def = 0;
      endif
      PushPacket(::);
    </G820>
    <G840 GNum="840" Alias="SKIP_FILTER_AFTER_CYCLIC_ERROR" Group="200">
      <!--G840: Skip data in axes jolt filters after a cyclic error-->
      #next_motion.Command = MPCMD_SKIP_FILTER_AFTER_CYCLIC_ERROR;
      PushPacket(::);
      </G840>
    <G841 GNum="841" Alias="USE_FILTER_AFTER_CYCLIC_ERROR" Group="200">
      <!--G841: Use data in axes jolt filters after a cyclic error-->
      #next_motion.Command = MPCMD_USE_FILTER_AFTER_CYCLIC_ERROR;
      PushPacket(::);
      </G841>
  </GCodes>
  <MCodes>
    <M_DEFAULT IsDefault="Yes" MinValue="0" MaxValue="1023" Group="44" Eval="Early">
      <ARG ref="VALUE" DataType="FLOAT" RequireLiteral="Yes" />
      <!-- Default AIL template -->
      #next_motion.Command = MPCMD_SET_M_FCT;
      #next_motion.Data.I4_value = ${VALUE};
      PushPacket(::);
    </M_DEFAULT>
    <!-- Scope-End M-Codes use "exit;" to return from sub/main program -->
    <M02 Value="2" Group="41" Alias="$RETURN" Eval="Early" DNCStreamEnd="Yes" Inline="Yes"> <!-- M02/29/30: return from sub/main program -->
      <ARG ref="VALUE" DataType="FLOAT" RequireLiteral="Yes" />
      #next_motion.Command = MPCMD_SET_M_FCT;
      #next_motion.Data.I4_value = ${VALUE};
      PushPacket(::);
      exit;
    </M02>
    <M29-30 MinValue="29" MaxValue="30" Group="41" Eval="Early" DNCStreamEnd="Yes" Inline="Yes">
      <ARG ref="VALUE" DataType="FLOAT" RequireLiteral="Yes" />
      #next_motion.Command = MPCMD_SET_M_FCT;
      #next_motion.Data.I4_value = ${VALUE};
      PushPacket(::);
      exit;
    </M29-30>
  </MCodes>
</Root>
