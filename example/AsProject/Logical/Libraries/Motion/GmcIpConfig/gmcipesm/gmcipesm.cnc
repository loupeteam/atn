<?xml version="1.0" encoding="UTF-8"?>
<Root LangModule="ailgcode" Version="1.0">
  <AILHeader Append="Yes">
    def ip_global BOOL  __CANCEL_RND <!-- Request for cancel RND -->
    def ip_global BOOL  __C2_SPLINE_ACTIVE <!-- C2 spline section is active -->
    def ip_global LREAL __RNDM_RADIUS <!-- Current value of modal radius -->
    def ip_global LREAL __CSPLINE_CHORD_ERROR <!-- Chord error used for CSPLINE command -->
    def ip_global DINT __SET_GXX_ACTIVE <!-- SET_Gxx is active -->
    def ip_global DINT __SET_GXX_REACTIVATE <!-- reactivate SET_Gxx is active -->
    def ip_global DINT __SET_GXX_CALL_CNT <!-- cnt move blocks -->
    def ip_global REAL __VAR1 <!-- internal variable -->
    def ip_global DINT __ACTIVE_MIRROR <!-- type of active morror -->

    sub OnProgStartPrivate
      %__CANCEL_RND = 0;
      %__RNDM_RADIUS = 0.0;
      %__C2_SPLINE_ACTIVE = 0;
      %__CSPLINE_CHORD_ERROR = 0.001;
      %__SET_GXX_ACTIVE = 0;
      %__SET_GXX_REACTIVATE = 0;
      %__SET_GXX_CALL_CNT = 0;
      %__ACTIVE_MIRROR = 20;
    endsub

    sub EndSplineSection
      <!-- switch-off spline section if necessary -->
      if (%__C2_SPLINE_ACTIVE)
        `T:GCodes,G802`(:"bc_par":1 :);
        %__C2_SPLINE_ACTIVE = 0;
        <!-- end of spline should be on separate line -->
        DispatchMPList(::);
      endif
    endsub
    sub WriteZpTable
      <!-- set values in zero point table -->
      #next_motion.Command = MPCMD_SET_ZP_TABLE;
      #next_motion.Data.SetZeroPtTable.ZpRecIdx = $[1];
      #next_motion.Data.SetZeroPtTable.ZpOffset[0] = $[2];
      #next_motion.Data.SetZeroPtTable.ZpOffset[1] = $[3];
      #next_motion.Data.SetZeroPtTable.ZpOffset[2] = $[4];
      PushPacket(::);
      DispatchMPList(::);
    endsub

    sub ReactivateGxx
      <!-- check if SET_Gxx was temporary deactivated and -->
      <!-- reactivate SET_Gxx after the next move block -->
      if (%__SET_GXX_CALL_CNT != 0)
          if (%__SET_GXX_REACTIVATE == 1)
            `T:GCodes,G54`(::);
             DispatchMPList(::);
             #sys_vars.ZP = %__SET_GXX_REACTIVATE;
          elif (%__SET_GXX_REACTIVATE == 2)
            `T:GCodes,G55`(::);
             DispatchMPList(::);
             #sys_vars.ZP = %__SET_GXX_REACTIVATE;
          elif (%__SET_GXX_REACTIVATE == 3)
            `T:GCodes,G56`(::);
             DispatchMPList(::);
             #sys_vars.ZP = %__SET_GXX_REACTIVATE;
          elif (%__SET_GXX_REACTIVATE == 4)
            `T:GCodes,G57`(::);
             DispatchMPList(::);
             #sys_vars.ZP = %__SET_GXX_REACTIVATE;
          elif (%__SET_GXX_REACTIVATE == 5)
            `T:GCodes,G58`(::);
             DispatchMPList(::);
             #sys_vars.ZP = %__SET_GXX_REACTIVATE;
          elif (%__SET_GXX_REACTIVATE == 6)
            `T:GCodes,G59`(::);
             DispatchMPList(::);
             #sys_vars.ZP = %__SET_GXX_REACTIVATE;
          endif
          %__SET_GXX_REACTIVATE = 0;
          %__SET_GXX_CALL_CNT = 0;
      endif
    endsub
  </AILHeader>

  <BuiltInProcs>
     <RESET_G54 MinArgs="0" MaxArgs="0">
      WriteZpTable(:1, 0.0, 0.0, 0.0:);
     </RESET_G54> 
     <RESET_G55 MinArgs="0" MaxArgs="0">
      WriteZpTable(:2, 0.0, 0.0, 0.0:);
     </RESET_G55> 
     <RESET_G56 MinArgs="0" MaxArgs="0">
      WriteZpTable(:3, 0.0, 0.0, 0.0:);
     </RESET_G56> 
     <RESET_G57 MinArgs="0" MaxArgs="0">
      WriteZpTable(:4, 0.0, 0.0, 0.0:);
     </RESET_G57> 
     <RESET_G58 MinArgs="0" MaxArgs="0">
      WriteZpTable(:5, 0.0, 0.0, 0.0:);
     </RESET_G58> 
     <RESET_G59 MinArgs="0" MaxArgs="0">
      WriteZpTable(:6, 0.0, 0.0, 0.0:);
     </RESET_G59> 

     <SET_G54 MinArgs="3" MaxArgs="3">
      <!--SET_G54: set values -->
      WriteZpTable(:1, $[1], $[2], $[3]:);
      %_CNC.move_cmd_mode = MPCMD_LIN_INTPOL;
      %__SET_GXX_ACTIVE = 1;
      %__SET_GXX_REACTIVATE = 0;
      %__SET_GXX_CALL_CNT = 0;		
      <!--G54: Zero point offset 1-->
      `T:GCodes,G54`(::);
      #sys_vars.ZP = 1;
     </SET_G54>

     <SET_G55 MinArgs="3" MaxArgs="3">
      WriteZpTable(:2, $[1], $[2], $[3]:);
      %_CNC.move_cmd_mode = MPCMD_LIN_INTPOL;
      %__SET_GXX_ACTIVE = 2;
      %__SET_GXX_REACTIVATE = 0;
      %__SET_GXX_CALL_CNT = 0;		
      `T:GCodes,G55`(::);
      #sys_vars.ZP = 2;
     </SET_G55>

     <SET_G56 MinArgs="3" MaxArgs="3">
      WriteZpTable(:3, $[1], $[2], $[3]:);
      %_CNC.move_cmd_mode = MPCMD_LIN_INTPOL;
      %__SET_GXX_ACTIVE = 3;
      %__SET_GXX_REACTIVATE = 0;
      %__SET_GXX_CALL_CNT = 0;		
      `T:GCodes,G56`(::);
      #sys_vars.ZP = 3;
     </SET_G56>

     <SET_G57 MinArgs="3" MaxArgs="3">
      WriteZpTable(:4, $[1], $[2], $[3]:);
      %_CNC.move_cmd_mode = MPCMD_LIN_INTPOL;
      %__SET_GXX_ACTIVE = 4;
      %__SET_GXX_REACTIVATE = 0;
      %__SET_GXX_CALL_CNT = 0;		
      `T:GCodes,G57`(::);
      #sys_vars.ZP = 4;
     </SET_G57>

     <SET_G58 MinArgs="3" MaxArgs="3">
      WriteZpTable(:5, $[1], $[2], $[3]:);
      %_CNC.move_cmd_mode = MPCMD_LIN_INTPOL;
      %__SET_GXX_ACTIVE = 5;
      %__SET_GXX_REACTIVATE = 0;
      %__SET_GXX_CALL_CNT = 0;		
      `T:GCodes,G58`(::);
      #sys_vars.ZP = 5;
     </SET_G58>

     <SET_G59 MinArgs="3" MaxArgs="3">
      WriteZpTable(:6, $[1], $[2], $[3]:);
      %_CNC.move_cmd_mode = MPCMD_LIN_INTPOL;
      %__SET_GXX_ACTIVE = 6;
      %__SET_GXX_REACTIVATE = 0;
      %__SET_GXX_CALL_CNT = 0;		
      `T:GCodes,G59`(::);
      #sys_vars.ZP = 6;
     </SET_G59>
     <RESET_MIRROR MinArgs="0" MaxArgs="0">
       `T:GCodes,G20`(::);
     </RESET_MIRROR>
  </BuiltInProcs>

  <PVMacros>
    <!--SysVars are prefixed by token SYSVAR_PREFIX-->
    <WORKFRAME Name="$WFRAME" ArrayDims="0">
      <SET Inline="Yes">
        `T:BuiltInProcs,RESET_SCALING`(::);
        #next_motion.Data.Frame.Data = ${EXPR};
        #next_motion.Command = MPCMD_W_FRAME;
        PushPacket(::);
      </SET>
    </WORKFRAME>
    <WORKFRAME_ADD Name="$WFRAME_ADD" ArrayDims="0">
      <SET Inline="Yes">
        `T:BuiltInProcs,RESET_SCALING`(::);
        #next_motion.Data.Frame.Data = ${EXPR};
        #next_motion.Command = MPCMD_W_FRAME_ADD;
        PushPacket(::);
      </SET>
    </WORKFRAME_ADD>
  </PVMacros>

   <GCodes>
    <G_INIT_ESM GNum="-5" AutoPush="Yes" Eval="First" Inline="No" GenerateIfGroups="1,1000" >
      ReactivateGxx(::);
    </G_INIT_ESM>

    <G_MODAL GNum="-1" AutoPush="Yes" Group="1000" Eval="Normal" IgnoreIfNoArgs="Yes">
      <!-- Extended G_MODAL (modal movement commands) with
        1. cancel edge rounding (RND=0) if __CANCEL_RND was set
        2. reset __CANCEL_RND
      -->
      <Arg ref="dest"     MinCount="0" MaxCount="NumAxes" NameType="AXISREF"                DataType="PositionValue" WriteOpts="#:u?" />
      <Arg ref="center"   MinCount="0" MaxCount="3"       NameType="InterpolParam"          DataType="PositionValue" WriteOpts="#:u?" />
      <Arg ref="circlept" MinCount="0" MaxCount="3"       NameType="CirclePointParam"       DataType="PositionValue" WriteOpts="#:u?" />
      <Arg ref="angle"    MinCount="0" MaxCount="1"       NameType="RotationAngleSpecifier" DataType="RotationAngle" WriteOpts="#:u?" />
      <Arg ref="radius"   MinCount="0" MaxCount="1"       NameType="RadiusSpecifier"        DataType="RadiusValue"   WriteOpts="#:u?" />
      PackMPData(:"cmd":%_CNC.move_cmd_mode,"comref":\%_CNC.co_ords_mode,"cemref":\%_CNC.center_mode,${dest},${center},${circlept},${angle},${radius}:);
      #next_motion.Flags.IsMoveCmd = 1;
      PushPacket(::);
      #sys_vars.modal_grp1_set = 0; <!-- must clear the is-set flag before calling the MCALL fn, we`ll send another motion packet -->
      <!-- check if non-modal edge rounding was activated -->
      if (%__CANCEL_RND)
        %__CANCEL_RND = 0;
        `T:GCodes,G25`(:"radius": %__RNDM_RADIUS:);
      endif
      %__SET_GXX_CALL_CNT = %__SET_GXX_CALL_CNT + 1;
      try_mcall;
    </G_MODAL>    
    <G00 GNum="0" Group="1,50" Inline="Yes" Eval="Early">
      <!--G00: Rapid Interpolation-->
      %_CNC.move_cmd_mode = MPCMD_RAPID_MOVE_INTPOL;
      #sys_vars.modal_grp1_set = 1;
      EndSplineSection(::);
      </G00>
    <G01 GNum="1" Group="1,50" Inline="Yes" Eval="Early">
      <!--G01: Linear Interpolation-->
      %_CNC.move_cmd_mode = MPCMD_LIN_INTPOL;
      #sys_vars.modal_grp1_set = 1;
      EndSplineSection(::);
    </G01>
    <G02 GNum="2" Group="1,51" Inline="Yes" Eval="Early">
      <!--G02: Clockwise circular interpolation-->
      %_CNC.move_cmd_mode = MPCMD_CIRC_INTPOL_CW;
      #sys_vars.modal_grp1_set = 1;
      EndSplineSection(::);
    </G02>
    <G03 GNum="3" Group="1,51" Inline="Yes" Eval="Early">
      <!--G03: Counter-Clockwise circular interpolation-->
      %_CNC.move_cmd_mode = MPCMD_CIRC_INTPOL_CCW;
      #sys_vars.modal_grp1_set = 1;
      EndSplineSection(::);
    </G03>

    <G20 GNum="20" Group="3">
      <!--G20: Deactivate Mirroring-->
      #next_motion.Command = MPCMD_MIRRORING;
      #next_motion.Data.I4_value = 20;
      %__ACTIVE_MIRROR = #next_motion.Data.I4_value;
      PushPacket(::);
      </G20>

    <G20.1 GNum="20.1" Alias="MIRROR" Group="3">
      <Arg DataType="AXISREF" ref="axis1" MinCount="0" MaxCount="1" />
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="FLOAT" ref="dummy_pos1" MinCount="0" MaxCount="1" />
      <Arg DataType="AXISREF" ref="axis2" MinCount="0" MaxCount="1" />
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="FLOAT" ref="dummy_pos2" MinCount="0" MaxCount="1" />

      local $m_mode;
      local $idx_1;	
      local $idx_2;	

      $idx_1 = -1;
      $idx_2 = -1;
      $m_mode = 0;	
      if Defined(:${axis1}:)
        $idx_1 = AxisIndex(:${axis1}:);  
        if ($idx_1 == 0)
          <!-- X programmed -->
          $m_mode = 1;
        elif ($idx_1 == 1)
          <!-- Y programmed -->
          $m_mode = 2;
        else
          <!-- other axes than X or Y programmed -->
          Error(:id:1000,msg:"MIRROR":);
          $m_mode = -1000;
        endif
	  endif	

      if Defined(:${axis2}:)
        $idx_2 = AxisIndex(:${axis2}:);
        if ($idx_1 == $idx_2)
          <!-- same axis twice programmed -->
          Error(:id:1001,msg:"MIRROR":);
          $m_mode = -1001;
        elif (($idx_2 == 0) || ($idx_2 == 1)) 
          <!-- X and Y programmed -->
          $m_mode = 3;
        else
          <!-- other axes than X or Y programmed -->
          Error(:id:1002,msg:"MIRROR":);
          $m_mode = -1002;
        endif
      endif	

      `T:BuiltInProcs,RESET_SCALING`(::);

      if ($m_mode >= 0)
        if ($m_mode == 0)        
         `T:GCodes,G20`(::);
        elif ($m_mode == 1)
          `T:GCodes,G21`(::);
        elif ($m_mode == 2)
          `T:GCodes,G22`(::);
        elif ($m_mode == 3)
          `T:GCodes,G23`(::);
        endif
      endif
    </G20.1>

    <G20.2 GNum="20.2" Alias="AMIRROR" Group="3">
      <Arg DataType="AXISREF" ref="axis1" MinCount="1" MaxCount="1" />
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="FLOAT" ref="dummy_pos1" MinCount="0" MaxCount="1" />
      <Arg DataType="AXISREF" ref="axis2" MinCount="0" MaxCount="1" />
      <Arg DataType="EqString" ref="eq" MinCount="0" MaxCount="1" />
      <Arg DataType="FLOAT" ref="dummy_pos2" MinCount="0" MaxCount="1" />

      local $m_mode;
      local $idx_1;	
      local $idx_2;	

      $idx_1 = -1;
      $idx_2 = -1;
      $m_mode = 0;	

      $idx_1 = AxisIndex(:${axis1}:);  
      if ($idx_1 == 0)
        <!-- X programmed -->
        $m_mode = 1;
      elif ($idx_1 == 1)
        <!-- Y programmed -->
        $m_mode = 2;
      else
        <!-- other axes than X or Y programmed -->
        Error(:id:1000,msg:"AMIRROR":);
        $m_mode = -1000;
      endif

      if Defined(:${axis2}:)
        $idx_2 = AxisIndex(:${axis2}:);
        if ($idx_1 == $idx_2)
          <!-- same axis twice programmed -->
          Error(:id:1001,msg:"AMIRROR":);
          $m_mode = -1001;
        elif (($idx_2 == 0) || ($idx_2 == 1)) 
          <!-- X and Y programmed -->
          $m_mode = 3;
        else
          <!-- other axes than X or Y programmed -->
          Error(:id:1002,msg:"AMIRROR":);
          $m_mode = -1002;
        endif
      endif	

      if ($m_mode == 1)
        if(%__ACTIVE_MIRROR == 20)
          `T:GCodes,G21`(::);
        elif(%__ACTIVE_MIRROR == 21)
          `T:GCodes,G20`(::);
        elif(%__ACTIVE_MIRROR == 22)
          `T:GCodes,G23`(::);
        elif(%__ACTIVE_MIRROR == 23)
          `T:GCodes,G22`(::);
        endif
      elif ($m_mode == 2)
        if(%__ACTIVE_MIRROR == 20)
          `T:GCodes,G22`(::);
        elif(%__ACTIVE_MIRROR == 21)
          `T:GCodes,G23`(::);
        elif(%__ACTIVE_MIRROR == 22)
          `T:GCodes,G20`(::);
        elif(%__ACTIVE_MIRROR == 23)
          `T:GCodes,G21`(::);
        endif
      elif ($m_mode == 3)
        if(%__ACTIVE_MIRROR == 20)
          `T:GCodes,G23`(::);
        elif(%__ACTIVE_MIRROR == 21)
          `T:GCodes,G22`(::);
        elif(%__ACTIVE_MIRROR == 22)
          `T:GCodes,G21`(::);
        elif(%__ACTIVE_MIRROR == 23)
          `T:GCodes,G20`(::);
        endif
      endif
    </G20.2>

    <G21 GNum="21" Group="3">
      <!--G21: Y axis mirroring-->
      #next_motion.Command = MPCMD_MIRRORING;
      #next_motion.Data.I4_value = 21;
      %__ACTIVE_MIRROR = #next_motion.Data.I4_value;
      PushPacket(::);
      </G21>
    <G22 GNum="22" Group="3">
      <!--G22: X axis mirroring-->
      #next_motion.Command = MPCMD_MIRRORING;
      #next_motion.Data.I4_value = 22;
      %__ACTIVE_MIRROR = #next_motion.Data.I4_value;
      PushPacket(::);
      </G22>
    <G23 GNum="23" Group="3">
      <!--G23: X and Y axis mirroring-->
      #next_motion.Command = MPCMD_MIRRORING;
      #next_motion.Data.I4_value = 23;
      %__ACTIVE_MIRROR = #next_motion.Data.I4_value;
      PushPacket(::);
    </G23>

    <G25.1 GNum="25.1" Group="11" Alias="RNDM">
      <!-- Extended G25 (Tangential transition arcs) template
       1. Defines alias name RNDM
       2. Requires "=" (RND=2.0)
       -->
      <Arg NameType="EqString" DataType="TangArcRadius" ref="radius" />
      %__RNDM_RADIUS = ${radius};
      #next_motion.Command = MPCMD_TANG_TRANS_ARC;
      #next_motion.Data.R8_value = ${radius};
      PushPacket(::);       
    </G25.1>
    <G25.2 GNum="25.2" Group="11" Alias="RND">
      <!-- Extended G25 (Tangential transition arcs) template
       1. Defines alias name RND
       2. Requires "=" (RND=2.0)
       3. Sets the __CANCEL_RND variable
       -->
      <!-- NameType="EqString" defined in gmcipcbr -->
      <Arg NameType="EqString" DataType="TangArcRadius" ref="radius" />
      #next_motion.Command = MPCMD_TANG_TRANS_ARC;
      #next_motion.Data.R8_value = ${radius};
      %__CANCEL_RND = 1;
      PushPacket(::);
    </G25.2>

    <G53 GNum="53" Group="6" AllowGroups="8,19,21,100,101,102,103">
      <!--G53: Deactivate the zero point offset-->
      <!-- Note: Only temporary for the next move block if SET_Gxx is active -->
      #next_motion.Command = MPCMD_ABS_ZP_SHIFT;
      #next_motion.Data.AbsZeroPtShift.ZpRecIdx = 0;
      PushPacket(::);
      #sys_vars.ZP = 0;
      <!-- Preparation to reactivate ZP shift after the next move block -->
      %__SET_GXX_REACTIVATE = %__SET_GXX_ACTIVE;
      %__SET_GXX_CALL_CNT = 0;
    </G53>

    <G92 GNum="92" Group="21" ResetArgs="Yes" AllowGroups="6,8,19,32,100,101,102,103">
      <!-- Cancel the modal G-Code (args clash) - if args already given to G(-1) then these could be error -->
      <!--G92: Programmed zero point offset with coordinate system rotation + reset of scaling -->
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offset" MinCount="0" MaxCount="NumAxes" WriteOpts="#:u?" />
      <Arg NameType="RotationAngleSpecifier" DataType="RotationAngle" ref="h_rot" MinCount="0" MaxCount="1" WriteOpts="#:u?" DenyArgs="3,4,5" />
      <Arg NameType="EulerAngleName" DataType="RotationAngle" ref="e_rot" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,4,5" />
      <Arg NameType="RPYAngleName" DataType="RotationAngle" ref="rpy_rot" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,3,5" />
      <Arg NameType="RotaryVectorName" DataType="RotaryVector" ref="matrix" MinCount="0" MaxCount="3" WriteOpts="#:u?" DenyArgs="2,3,4" />
      `T:BuiltInProcs,RESET_SCALING`(::);
      PackMPData(:"cmd":MPCMD_PROG_ZP_SHIFT,"comref":\%_CNC.co_ords_mode,"cemref":\%_CNC.center_mode,${offset},${matrix},${e_rot},${rpy_rot},${h_rot}:);
      PushPacket(::);
    </G92>
    <G92.1 GNum="92.1" Group="21" ALIAS="SCALE" AliasIsPattern="Yes">
      <!--G92.1: SCALE command -->
      <Arg DataType="FLOAT" ref="factor" MinCount="0" MaxCount="1"/>
       `T:BuiltInProcs,RESET_MIRROR`(::);
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_NORM_MP_AXIS, 1.0:);
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_LINEAR_AXES, 1.0:);
       if (Defined(:${factor}:))
         `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_MPLANE_AXES, ${factor}:);
         `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_GEOM_PARAM, ${factor}:);
       else
         `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_MPLANE_AXES, 1.0:);
         `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_GEOM_PARAM, 1.0:);
         `T:GCodes,G20`(::);
         `T:GCodes,G492`(::);
       endif
    </G92.1>
    <G92.2 GNum="92.2" Group="21" ALIAS="ASCALE" AliasIsPattern="Yes">
      <!--G92.2: ASCALE command -->
      <Arg DataType="FLOAT" ref="factor" MinCount="1" MaxCount="1"/>
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_NORM_MP_AXIS, 1.0:);
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_LINEAR_AXES, 1.0:);
       %__VAR1 = ${factor} * %_CNC.scale_main_plane_axes;
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_MPLANE_AXES, %__VAR1:);
       `T:BuiltInProcs,SET_SCALE_FACTOR`(:CNC_SYS_VAR_SCALE_GEOM_PARAM, %__VAR1:);
    </G92.2>

    <G492 GNum="492" Group="490" Alias="TRANS" AllowGroups="9999">
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offsets" MinCount="0" MaxCount="NumAxes" WriteOpts="#:" />
        `T:BuiltInProcs,RESET_SCALING`(::);
        `T:BuiltInProcs,RESET_MIRROR`(::);
         #next_motion.Command = MPCMD_TRANS;
         PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${offsets}, \#next_motion.Data.Trans.Offset, \#next_motion.Data.Trans.AxIdx, \#next_motion.Data.Trans.Mode:);
         PushPacket(::);
      </G492>
    <G494 GNum="494" Group="490" Alias="ROT" AllowGroups="9999" MinArgs="0" MaxArgs="1" >
      <Arg Name="RPLArgPrefix" DataType="FLOAT" ref="rpl_value" MinCount="0" MaxCount="1" DenyArgs="offsets" />
      <Arg NameType="AXISREF" DataType="PositionValue" ref="offsets" MinCount="0" MaxCount="NumAxes" DenyArgs="rpl_value" WriteOpts="#:" />
        `T:BuiltInProcs,RESET_SCALING`(::);
        `T:BuiltInProcs,RESET_MIRROR`(::);
         if (Defined(:${rpl_value}:))
            #next_motion.Command = MPCMD_ROT_RPL;
            #next_motion.Data.R8_value = ${rpl_value};
         else
           #next_motion.Command = MPCMD_ROT;
           PackNamedListToArrays(:ORDERING_PACKED, MP_AX_NUMBER, ${offsets}, \#next_motion.Data.Trans.Offset, \#next_motion.Data.Trans.AxIdx, \#next_motion.Data.Trans.Mode:);
         endif
         PushPacket(::);
    </G494>

    <G500 GNum="500" Group="6" AllowGroups="8,19,21,100,101,102,103">
      <!--G500: Deactivate SET_Gxx -->
       %__SET_GXX_REACTIVATE = 0;
       %__SET_GXX_ACTIVE = 0;
       %__SET_GXX_CALL_CNT = 0;
      `T:GCodes,G53`(::);
    </G500>

    <G804 GNum="804" Alias="CSPLINE">
      <!-- CSPLINE behaves like standard modal interpolation commands G00-G03 -->
      if (!%__C2_SPLINE_ACTIVE)
        <!-- zero boundary conditions, segmentation type hardcoded --> 
        `T:GCodes,G801`(:"seg_type":"CE", "seg_par":%__CSPLINE_CHORD_ERROR, "bc_par":1 :);
        %__C2_SPLINE_ACTIVE = 1;
        <!-- start of spline should be always on separate line -->
        DispatchMPList(::);
        <!-- feedrate is considered in spline section -->
        %_CNC.move_cmd_mode = MPCMD_LIN_INTPOL;
      endif
    </G804>
  </GCodes>
</Root>