<?xml version="1.0" encoding="utf-8"?>
<?ARNC0 Version="5.12.2"?>
<Root LangModule="ailgcode" Version="1.0">
  <AILHeader>
    <!-- Init modal system varaibles on program start -->
    sub OnProgStartPrivate
      %_Frm = %FRM_0;
      %_Base = %BASE_0;
      %_Tool = %TOOL_0;
      %_Vel = %VEL_0;
      %_Pth = %PTH_0;
      %_Dyn = %DYN_0;
      if (%_CNC.optmot_segmentation_on)
        %_Dyn.Optmot.Enable = 1 <!-- Force OptMod on -->
      endif      
      BlockCpy(:\%_Ref, \%REF_0:);
    endsub
  </AILHeader>
  <BuiltInProcs>
    <WAIT_PP_SYNC>
      #next_motion.Command = MPCMD_IP_SYNCH_PP;
      PushPacket(::);
      DispatchAndWait(:IPCMD_SYNC_PP_CONT:);  
    </WAIT_PP_SYNC>
    <ERROR_EX MinArgs="3" MaxArgs="14">
      ErrorEx(:"id":$[1],"fmt":$[2],"data":(:$[3],$[4],$[5],$[6],$[7],$[8],$[9],$[10],$[11],$[12],$[13],$[14]:):);
    </ERROR_EX>
    <SET_POINT>
      <Arg ref="POINT" DataType="ANY_DATA" MinCount="1" MaxCount="1"/>
      %__tmp_point = ${POINT};
      BlockCpy(:\#next_motion.Data.MXPoint.Pos.x, \%__tmp_point:);
      #next_motion.Command = MPCMD_MX_POINT;
      PushPacket(::);
    </SET_POINT>
    <SET_TRIGGER_CONFIG>
      <Arg ref="TRIGGER" DataType="ANY_DATA" MinCount="1" MaxCount="1"/>
      <Arg ref="bHALT" DataType="ANY_DATA" MinCount="1" MaxCount="1"/>
      <Arg ref="ID" DataType="ANY_DATA" MinCount="1" MaxCount="1"/>
      %__tmp_trigger = ${TRIGGER};
      #next_motion.Data.MXTriggerConfig.Type = %__tmp_trigger.Type;
      #next_motion.Data.MXTriggerConfig.Edge = %__tmp_trigger.Edge;
      #next_motion.Data.MXTriggerConfig.HWTrigger.Source = %__tmp_trigger.HWTrigger.Source;
      #next_motion.Data.MXTriggerConfig.HWTrigger.Index  = %__tmp_trigger.HWTrigger.Index;
      #next_motion.Data.MXTriggerConfig.Halt = ${bHALT};
      #next_motion.Data.MXTriggerConfig.LatchIdx = ${ID};
      #next_motion.Command = MPCMD_MX_TRIGGER_CONFIG;
      PushPacket(::);
    </SET_TRIGGER_CONFIG>
    <SET_WANTED_JOINT>
      <Arg ref="Ref" DataType="ANY_DATA" MinCount="1" MaxCount="1"/>
      if (Defined(:${Ref}:))
        BlockCpy(:\%__tmp_joint_axis, \${Ref}:);
      else
        BlockCpy(:\%__tmp_joint_axis, \%_Ref:);
      endif
      BlockCpy(:\#next_motion.Data.MXJointAxis, \%__tmp_joint_axis:);
      #next_motion.Command = MPCMD_MX_WANTED_JOINT;
      PushPacket(::);
    </SET_WANTED_JOINT>
    <SET_CIRCLE>
      <Arg ref="END_POINT" DataType="ANY_DATA" MinCount="1" MaxCount="1"/>
      <Arg ref="CIRCLE_POINT" DataType="ANY_DATA" MinCount="1" MaxCount="1"/>
      <Arg ref="Angle" DataType="IEC_LREAL" MinCount="0" MaxCount="1"/>
      %__tmp_point = ${END_POINT};
      BlockCpy(:\#next_motion.Data.MXPoint.Pos.x, \%__tmp_point:);
      #next_motion.Command = MPCMD_MX_POINT;
      PushPacket(::);
      #next_motion.Data.R8_value = ${Angle};
      #next_motion.Command = MPCMD_MX_ANGLE_OF_ROTATION;
      PushPacket(::);
      %__tmp_point = ${CIRCLE_POINT};
      BlockCpy(:\#next_motion.Data.MXPoint.Pos.x, \%__tmp_point:);
      #next_motion.Command = MPCMD_MX_CIRCLE_POINT;
      PushPacket(::);
      DispatchMPList(::);
    </SET_CIRCLE>
    <SET_AXIS_TARGET>
      <Arg ref="AXIS_TARGET" DataType="ANY_DATA" MinCount="1" MaxCount="1"/>
      %__tmp_axis_target = ${AXIS_TARGET};
      BlockCpy(:\#next_motion.Data.MXAxisTarget.JointAxis, \%__tmp_axis_target:);
      #next_motion.Command = MPCMD_MX_AXIS_TARGET;
      PushPacket(::);
      DispatchMPList(::);
    </SET_AXIS_TARGET>
    <SET_FRAME>
      <Arg ref="Frm" DataType="ANY_DATA" MinCount="0" MaxCount="1"/>
      if (Defined(:${Frm}:))
        %__tmp_frame = ${Frm};
      else
        %__tmp_frame = %_Frm;
      endif
      BlockCpy(:\#next_motion.Data.MXFrame.Pos.x, \%__tmp_frame:);
      #next_motion.Command = MPCMD_MX_FRAME;
      PushPacket(::);
      DispatchMPList(::);
    </SET_FRAME>
    <SET_BASEFRAME>
      <Arg ref="Base" DataType="ANY_DATA" MinCount="0" MaxCount="1"/>
      if (Defined(:${Base}:))
        %__tmp_frame = ${Base};
      else
        %__tmp_frame = %_Base;
      endif
      BlockCpy(:\#next_motion.Data.MXFrame.Pos.x, \%__tmp_frame:);
      #next_motion.Command = MPCMD_MX_BASE;
      PushPacket(::);
    </SET_BASEFRAME>
    <SET_TOOL>
      <Arg ref="Tool" DataType="ANY_DATA" MinCount="0" MaxCount="1"/>
      if (Defined(:${Tool}:))
        %__tmp_tool = ${Tool};
      else
        %__tmp_tool = %_Tool;
      endif
      BlockCpy(:\#next_motion.Data.MXTool.Index, \%__tmp_tool:);
      #next_motion.Command = MPCMD_MX_TOOL;
      #sys_vars.RAD = %__tmp_tool.Radius;
      PushPacket(::);
      DispatchMPList(::);
    </SET_TOOL>
    <SET_PATH_DESC>
      <Arg ref="Pth" DataType="ANY_DATA" MinCount="0" MaxCount="1"/>
      if (Defined(:${Pth}:))
        %__tmp_pth = ${Pth};
      else
        %__tmp_pth = %_Pth;
      endif      
      if (%__tmp_pth.Trans.Type == 3)
        DispatchMPList(::);
      endif
      BlockCpy(:\#next_motion.Data.MXPathDesc.Trans.Radius, \%__tmp_pth:);
      #next_motion.Command = MPCMD_MX_PATH_DESC;
      PushPacket(::);
      DispatchMPList(::);
    </SET_PATH_DESC>
    <SET_DYNAMIC_DESC>
      <Arg ref="Dyn" DataType="ANY_DATA" MinCount="0" MaxCount="1"/>
      if (Defined(:${Dyn}:))
        %__tmp_dynamic = ${Dyn};
      else
        %__tmp_dynamic = %_Dyn;
      endif
      BlockCpy(:\#next_motion.Data.MXDynamicDesc.Accel, \%__tmp_dynamic:);
      #next_motion.Command = MPCMD_MX_DYNAMIC_DESC;
      PushPacket(::);
      DispatchMPList(::);
    </SET_DYNAMIC_DESC>
    <SET_VELOCITY>
      <Arg ref="Vel" DataType="ANY_DATA" MinCount="0" MaxCount="1"/>
      if (Defined(:${Vel}:))
        %__tmp_vel = ${Vel};
      else
        %__tmp_vel = %_Vel;
      endif
      <!-- Set feedrate -->
      BlockCpy(:\#next_motion.Data.MXVelocity.v, \%__tmp_vel:);
      #next_motion.Command = MPCMD_MX_VELOCITY;
      PushPacket(::);
      DispatchMPList(::);
    </SET_VELOCITY>
    <JointToPoint>
      <Arg ref="Joint" UserType="MXJointAxisType" MinCount="1" MaxCount="1"/>
      <Arg ref="Point" UserType="MXPointType" MinCount="1" MaxCount="1"/>
      BlockCpy(:\%__tmp_joint_axis, \${Joint}:);
      BlockCpy(:\%__tmp_vec6, \%VEC6_0:);
      <!-- Synchronize with PP to get curent tool and base frame -->
      `T:BuiltInProcs,WAIT_PP_SYNC`(::);        
      <!-- Get tool: set __tmp_tool -->
      `T:BuiltInProcs,TmpTool`(::);
      <!-- Get robot base frame: set __tmp_frame -->
      `T:BuiltInProcs,TmpBaseFrame`(::);
      %__mx_status = MXJointToPointEx1(:%_CNC.adr_trf_data_mx, \%__tmp_joint_axis, \%__tmp_point,  %_CNC.angles_type,  %_CNC.trf_type, \%__tmp_tool, \%__tmp_frame, \%__tmp_vec6:);
      if (%__mx_status &gt; 0)
        <!-- 10905: ERR_MX_FUN_ERROR, 2: MXJointToPointEx -->
        ErrorEx(:"id":10905,"fmt":"4d4d4d","data":(:GetCurLine(::),2,%__mx_status:):);
      endif
      ${Point} = %__tmp_point;
    </JointToPoint>
    <PointToJoint>
      <Arg ref="Point" UserType="MXPointType" MinCount="1" MaxCount="1"/>
      <Arg ref="Joint" UserType="MXJointAxisType" MinCount="1" MaxCount="1"/>
      local $i;
      %__tmp_point = ${Point};     
      <!-- Synchronize with PP to get curent tool, base frame and reference joints -->
      `T:BuiltInProcs,WAIT_PP_SYNC`(::);        
      BlockCpy(:\%__tmp_joint_axis, \%REF_0:);
      $i=0;
      lbegin(1)
        if (%_AX.axis_map[$i] &amp; 2) <!-- 2: joint axis-->
          %__tmp_joint_axis[%_AX.axis_map_idx[$i]] = %_AX.end_pos_mcs[$i];
        endif
        $i = $i + 1;
      lend($i &lt; GetIpInt(:300:))   <!-- GetIpInt(:300:): number of active axes -->  
      <!-- Get tool: set __tmp_tool -->
      `T:BuiltInProcs,TmpTool`(::);
      <!-- Get robot base frame -> set __tmp_frame -->
      `T:BuiltInProcs,TmpBaseFrame`(::);
      %__mx_status = MXPointToJointEx1(:%_CNC.adr_trf_data_mx, \%__tmp_point, \%__tmp_joint_axis,  %_CNC.trf_type, \%__tmp_tool, \%__tmp_frame, \%__tmp_joint_axis:);
      if (%__mx_status &gt; 0)
        <!-- 10905: ERR_MX_FUN_ERROR, 3: MXPointToJointEx -->
        ErrorEx(:"id":10905,"fmt":"4d4d4d","data":(:GetCurLine(::),3,%__mx_status:):);
      endif
      BlockCpy(:\${Joint}, \%__tmp_joint_axis:);
    </PointToJoint>
    <MoveL>
      <Arg ref="POINT" UserType="MXPointType" MinCount="1" MaxCount="1"/>
      <Arg ref="Frm" UserType="MXFrameType" MinCount="0" MaxCount="1"/>
      <Arg ref="Base" UserType="MXFrameType" MinCount="0" MaxCount="1"/>
      <Arg ref="Tool" UserType="MXToolType" MinCount="0" MaxCount="1"/>
      <Arg ref="Vel" UserType="MXVelocityType" MinCount="0" MaxCount="1"/>
      <Arg ref="Pth" UserType="MXPathDescType" MinCount="0" MaxCount="1"/>
      <Arg ref="Dyn" UserType="MXDynamicDescType" MinCount="0" MaxCount="1"/>
      `T:BuiltInProcs,SET_DYNAMIC_DESC`(:${Dyn}:);
      `T:BuiltInProcs,SET_TOOL`(:${Tool}:);
      `T:BuiltInProcs,SET_FRAME`(:${Frm}:);
      `T:BuiltInProcs,SET_VELOCITY`(:${Vel}:);
      `T:BuiltInProcs,SET_BASEFRAME`(:${Base}:);
      `T:BuiltInProcs,SET_POINT`(:${POINT}:);
      `T:BuiltInProcs,SET_PATH_DESC`(:${Pth}:);
    </MoveL>
    <MoveJ>
      <Arg ref="POINT" UserType="MXPointType" MinCount="1" MaxCount="1"/>
      <Arg ref="Frm" UserType="MXFrameType" MinCount="0" MaxCount="1"/>
      <Arg ref="Base" UserType="MXFrameType" MinCount="0" MaxCount="1"/>
      <Arg ref="Tool" UserType="MXToolType" MinCount="0" MaxCount="1"/>
      <Arg ref="Vel" UserType="MXVelocityType" MinCount="0" MaxCount="1"/>
      <Arg ref="Ref" UserType="MXJointAxisType" MinCount="0" MaxCount="1"/>
      <Arg ref="Pth" UserType="MXPathDescType" MinCount="0" MaxCount="1"/>
      <Arg ref="Dyn" UserType="MXDynamicDescType" MinCount="0" MaxCount="1"/>
      `T:BuiltInProcs,SET_DYNAMIC_DESC`(:${Dyn}:);
      `T:BuiltInProcs,SET_TOOL`(:${Tool}:);
      `T:BuiltInProcs,SET_FRAME`(:${Frm}:);
      `T:BuiltInProcs,SET_VELOCITY`(:${Vel}:);
      `T:BuiltInProcs,SET_WANTED_JOINT`(:${Ref}:);
      `T:BuiltInProcs,SET_BASEFRAME`(:${Base}:);
      #next_motion.Command = MPCMD_MX_PTP_MOVE;
      PushPacket(::);
      `T:BuiltInProcs,SET_POINT`(:${POINT}:);
      `T:BuiltInProcs,SET_PATH_DESC`(:${Pth}:);
    </MoveJ>
    <MoveC>
      <Arg ref="END_POINT" UserType="MXPointType" MinCount="1" MaxCount="1"/>
      <Arg ref="CIRCLE_POINT" UserType="MXPointType" MinCount="1" MaxCount="1"/>
      <Arg ref="Angle" DataType="IEC_LREAL" MinCount="0" MaxCount="1"/>
      <Arg ref="Frm" UserType="MXFrameType" MinCount="0" MaxCount="1"/>
      <Arg ref="Base" UserType="MXFrameType" MinCount="0" MaxCount="1"/>
      <Arg ref="Tool" UserType="MXToolType" MinCount="0" MaxCount="1"/>
      <Arg ref="Vel" UserType="MXVelocityType" MinCount="0" MaxCount="1"/>
      <Arg ref="Pth" UserType="MXPathDescType" MinCount="0" MaxCount="1"/>
      <Arg ref="Dyn" UserType="MXDynamicDescType" MinCount="0" MaxCount="1"/>
      `T:BuiltInProcs,SET_DYNAMIC_DESC`(:${Dyn}:);
      `T:BuiltInProcs,SET_TOOL`(:${Tool}:);
      `T:BuiltInProcs,SET_FRAME`(:${Frm}:);
      `T:BuiltInProcs,SET_VELOCITY`(:${Vel}:);
      `T:BuiltInProcs,SET_BASEFRAME`(:${Base}:);
      `T:BuiltInProcs,SET_CIRCLE`(:${END_POINT},${CIRCLE_POINT},${Angle}:);
      `T:BuiltInProcs,SET_PATH_DESC`(:${Pth}:);
    </MoveC>
    <MoveA>
      <Arg ref="AXIS_TARGET" UserType="MXAxisTargetType" MinCount="1" MaxCount="1"/>
      <Arg ref="Vel" UserType="MXVelocityType" MinCount="0" MaxCount="1"/>
      <Arg ref="Dyn" UserType="MXDynamicDescType" MinCount="0" MaxCount="1"/>
      <Arg ref="Pth" UserType="MXPathDescType" MinCount="0" MaxCount="1"/>
      `T:BuiltInProcs,SET_DYNAMIC_DESC`(:${Dyn}:); 
      `T:BuiltInProcs,SET_VELOCITY`(:${Vel}:);
      #next_motion.Command = MPCMD_MX_PTP_MOVE;
      PushPacket(::);
      `T:BuiltInProcs,SET_AXIS_TARGET`(:${AXIS_TARGET}:);
      `T:BuiltInProcs,SET_PATH_DESC`(:${Pth}:);
    </MoveA>
    <MoveLSearch>
      <Arg ref="POINT" UserType="MXPointType" MinCount="1" MaxCount="1"/>
      <Arg ref="TRIGGER" UserType="MXTriggerConfigType" MinCount="1" MaxCount="1"/>
      <Arg ref="bHALT" DataType="IEC_BOOL" MinCount="1" MaxCount="1"/>
      <Arg ref="ID" DataType="IEC_UINT" MinCount="1" MaxCount="1"/>
      <Arg ref="Frm" UserType="MXFrameType" MinCount="0" MaxCount="1"/>
      <Arg ref="Base" UserType="MXFrameType" MinCount="0" MaxCount="1"/>
      <Arg ref="Tool" UserType="MXToolType" MinCount="0" MaxCount="1"/>
      <Arg ref="Vel" UserType="MXVelocityType" MinCount="0" MaxCount="1"/>
      <Arg ref="Pth" UserType="MXPathDescType" MinCount="0" MaxCount="1"/>
      <Arg ref="Dyn" UserType="MXDynamicDescType" MinCount="0" MaxCount="1"/>
      `T:BuiltInProcs,SET_DYNAMIC_DESC`(:${Dyn}:);
      `T:BuiltInProcs,SET_TOOL`(:${Tool}:);
      `T:BuiltInProcs,SET_FRAME`(:${Frm}:);
      `T:BuiltInProcs,SET_VELOCITY`(:${Vel}:);
      `T:BuiltInProcs,SET_BASEFRAME`(:${Base}:);
      `T:BuiltInProcs,SET_POINT`(:${POINT}:);
      `T:BuiltInProcs,SET_TRIGGER_CONFIG`(:${TRIGGER},${bHALT},${ID}:);
      `T:BuiltInProcs,SET_PATH_DESC`(:${Pth}:);
    </MoveLSearch>
    <WaitTime>
      <!-- G04 Dwell time -->
      <Arg ref="set_time" DataType="IEC_LREAL" MinCount="1" MaxCount="1"/>
      #next_motion.Command = MPCMD_DWELL_TIME;
      #next_motion.Data.R8_value = ${set_time};
      PushPacket(::);
    </WaitTime>
    <!-- Synchronization commands -->
    <WaitIp>
      <!-- G170 IP Synchronization -->
      #next_motion.Command = MPCMD_IP_SYNCH;
      if (#thread.restart.playback)
        #next_motion.Data.I4_value = ncSIMULATION;
      else
        #next_motion.Data.I4_value = ncSTANDARD;
      endif
      PushPacket(::);
      DispatchAndWait(:IPCMD_SYNC_PLC_CONT:);
    </WaitIp>
    <WaitEndMove>
      <!-- Synchronization between interpreter and set position generator (G172)  -->
      #next_motion.Command = MPCMD_IP_SYNCH_PATH;
      PushPacket(::);
      DispatchAndWait(:IPCMD_SYNC_PATH_CONT:);
    </WaitEndMove>
    <TmpTool>
      <!-- Get tool -->
      %__tmp_tool.Frame.Pos.x = %_CNC.tool_dx;
      %__tmp_tool.Frame.Pos.y = %_CNC.tool_dy;
      %__tmp_tool.Frame.Pos.z = %_CNC.tool_dz;
      %__tmp_tool.Frame.Orient.Type = %_CNC.tool_angles_type;
      %__tmp_tool.Frame.Orient.Angle[0] = %_CNC.tool_phi;
      %__tmp_tool.Frame.Orient.Angle[1] = %_CNC.tool_theta;
      %__tmp_tool.Frame.Orient.Angle[2] = %_CNC.tool_psi;
      %__tmp_tool.Frame.Orient.Angle[3] = 0;
      %__tmp_tool.Radius = #sys_vars.RAD;
    </TmpTool>
    <GetTool>
      <Arg ref="Tool" UserType="MXToolType" MinCount="1" MaxCount="1"/>
      <!-- Synchronization IP and path -->
      `T:BuiltInProcs,WaitEndMove`(::);
      <!-- Get tool -->
      `T:BuiltInProcs,TmpTool`(::);
      ${Tool} = %__tmp_tool;
    </GetTool>
    <TmpBaseFrame>
      <!-- Get robot base frame -->
      %__tmp_frame.Pos.x = %_CNC.base_frame_dx;
      %__tmp_frame.Pos.y = %_CNC.base_frame_dy;
      %__tmp_frame.Pos.z = %_CNC.base_frame_dz;
      %__tmp_frame.Orient.Type = %_CNC.base_frame_angles_type;
      %__tmp_frame.Orient.Angle[0] = %_CNC.base_frame_phi;
      %__tmp_frame.Orient.Angle[1] = %_CNC.base_frame_theta;
      %__tmp_frame.Orient.Angle[2] = %_CNC.base_frame_psi;
      %__tmp_frame.Orient.Angle[3] = 0;
    </TmpBaseFrame>
    <GetBaseFrame>
      <Arg ref="Frame" UserType="MXFrameType" MinCount="1" MaxCount="1"/>
      <!-- Synchronization IP and path -->
      `T:BuiltInProcs,WaitEndMove`(::);
      <!-- Get robot base frame -->
      `T:BuiltInProcs,TmpBaseFrame`(::);
      ${Frame} = %__tmp_frame;
    </GetBaseFrame>
    <GetJoint>
      <Arg ref="Joint" UserType="MXJointAxisType" MinCount="1" MaxCount="1"/>
      <!-- Synchronization IP and path -->
      `T:BuiltInProcs,WaitEndMove`(::);
      <!-- get joint axes -->
      BlockCpy(:\%__tmp_joint_axis, \%REF_0:);
      local $i;
      $i=0;
      lbegin(1)
        if (%_AX.axis_map[$i] &amp; 2) <!--2: PTP (joint) axis-->
          %__tmp_joint_axis[%_AX.axis_map_idx[$i]] = %_AX.set_pos[$i];
        endif
        $i = $i + 1;
      lend($i &lt; GetIpInt(:300:))   <!-- GetIpInt(:300:): number of active axes -->
      BlockCpy(:\${Joint}, \%__tmp_joint_axis:);
    </GetJoint>
    <GetAxisTarget>
      <Arg ref="AxisTarget" UserType="MXAxisTargetType" MinCount="1" MaxCount="1"/>
      <!-- Synchronization IP and path -->
      `T:BuiltInProcs,WaitEndMove`(::);
      <!-- get joint, base and aux axes -->
      %__tmp_axis_target = %AXIS_TARGET_0;
      local $i;
      local $j;
      local $k;
      $i=0;
      $j=0;
      $k=0;
      if (%_CNC.adr_trf_data_mx &gt; 0)  <!-- robot is used -->
        lbegin(1)
          if (%_AX.axis_map[$i] &amp; 2)     <!-- 2: PTP (joint) axis -->
           %__tmp_axis_target.JointAxis[%_AX.axis_map_idx[$i]] = %_AX.set_pos[$i];
          elif (%_AX.axis_map[$i] &amp; 4)  <!-- 4: base frame axis -->
            %__tmp_axis_target.BaseAxis[$k] = %_AX.set_pos[$i];
            $k = $k + 1;
          elif !(%_AX.axis_map[$i] &amp; 1)   <!-- not TCP (path) axis-->
            %__tmp_axis_target.AuxAxis[$j] = %_AX.set_pos[$i];
            $j = $j + 1;
          endif
          $i = $i + 1;
        lend($i &lt; GetIpInt(:300:))   <!-- GetIpInt(:300:): number of active axes -->
      else    <!-- Robot is not used -->
       lbegin(1)
        if !(%_AX.axis_map[$i] &amp; 8)   <!-- 8: Cart.axis -->
          %__tmp_axis_target.AuxAxis[$j] = %_AX.set_pos[$i];
          $j = $j + 1;
        endif
        $i = $i + 1;
        lend($i &lt; GetIpInt(:300:))  <!-- GetIpInt(:300:): number of active axes -->
      endif
      BlockCpy(:\${AxisTarget}, \%__tmp_axis_target:);
    </GetAxisTarget>
    <GetLatchPoint>
      <Arg ref="ID" DataType="IEC_UINT" MinCount="1" MaxCount="1"/>
      <Arg ref="Point" UserType="MXPointType" MinCount="1" MaxCount="1"/>
      <Arg ref="Event" DataType="IEC_BOOL" MinCount="1" MaxCount="1"/>
      if (${ID} > 9 )
        <!-- 10910: ERR_MX_TRIGGER_LATCH_INDEX -->
        ErrorEx(:"id":10910,"fmt":"4d","data":(:GetCurLine(::):):);
      else
        ${Event} = CopyLatchPos(:${ID}, \%__tmp_set_pos, \%_CNC.latch0.pos0:);
        <!-- GetPointIntern - input: %__tmp_set_pos, output: %__tmp_point -->
       `T:BuiltInProcs,GetPointIntern`(::);
        ${Point} = %__tmp_point;
      endif
    </GetLatchPoint>
    <GetPoint>
      <Arg ref="Point" UserType="MXPointType" MinCount="1" MaxCount="1"/>
      <!-- Synchronization IP and path -->
     `T:BuiltInProcs,WaitEndMove`(::);
      local $i;
      $i=0;
      lbegin(1)
        %__tmp_set_pos[$i] = %_AX.set_pos_mcs[$i];
        $i = $i + 1;
      lend($i &lt; GetIpInt(:300:))   <!-- GetIpInt(:300:) -> number of active axes -->
      <!-- GetPointIntern - input: %__tmp_set_pos, output: %__tmp_point -->
      `T:BuiltInProcs,GetPointIntern`(::);
      ${Point} = %__tmp_point;
    </GetPoint>
    <GetPointIntern>
      %__tmp_point = %POINT_0;
      <!-- get joint (PTP) axes  and aux_axes -->
      local $i;
      $i=0;
      lbegin(1)
        %__tmp_axis_code[$i] = %_AX.axis_map[$i];
        %__tmp_axis_idx[$i] = %_AX.axis_map_idx[$i];
        $i = $i + 1;
      lend($i &lt; GetIpInt(:300:))   <!-- GetIpInt(:300:) -> number of active axes -->  
      %__mx_status =  MXCncAxesToPoint(:%_CNC.adr_trf_data_mx,  \%__tmp_set_pos, \%__tmp_point,   %_CNC.trf_type, %_CNC.angles_type, \%__tmp_axis_code, \%__tmp_axis_idx, GetIpInt(:300:) :);
      if (%__mx_status > 0)
        <!-- 10905: ERR_MX_FUN_ERROR, 4: MXCncAxesToPoint -->
        ErrorEx(:"id":10905,"fmt":"4d4d4d","data":(:GetCurLine(::),4,%__mx_status:):);
      endif
    </GetPointIntern>
    <CDCOn>
      <Arg ref="Direction" DataType="INT" MinCount="1" MaxCount="1"/>
      <Arg ref="CDC" UserType="MXCDCType" MinCount="0" MaxCount="1"/>
      if (Defined(:${CDC}:))
        %__tmp_cdc = ${CDC};
        <!-- Cutter Diameter Compensation with Linear and Arc Transitions (G132/G133)
             0: CDC with linear transitions
             1: CDC with arc transitions -->
        if (%__tmp_cdc.TransMode == 0)
          #next_motion.Command = MPCMD_CDC_TRANS_LINES;
        else
          #next_motion.Command = MPCMD_CDC_TRANS_ARCS;
        endif
        PushPacket(::);
        DispatchMPList(::);
        BlockCpy(:\#next_motion.Data.MXCDC.ArcTransSpd, \%__tmp_cdc:);
        #next_motion.Command = MPCMD_MX_CDC;
        PushPacket(::);
        DispatchMPList(::);
        <!-- Types of CDC Activation/Deactivation (G137/G138/G139)
             0: Self-controlled activation record block
             1: Direct CDC activation
             2: Indirect CDC activation -->
        if (%__tmp_cdc.EntryMode == 0)
          #next_motion.Command = MPCMD_CDC_G137_MODE;
        elif (%__tmp_cdc.EntryMode == 1)
          #next_motion.Command = MPCMD_CDC_G138_MODE;
        elif (%__tmp_cdc.EntryMode == 2)
          #next_motion.Command = MPCMD_CDC_G139_MODE;
        endif
        PushPacket(::);
        DispatchMPList(::);
      endif <!-- Defined(:${cdc}:) -->
      if (${Direction}==0)
        <!-- G41: CDC left -->
        #next_motion.Command = MPCMD_CDC_ON_LEFT;
      else
        <!-- G42: CDC right -->
        #next_motion.Command = MPCMD_CDC_ON_RIGHT;
      endif
      PushPacket(::);
    </CDCOn>
    <CDCOff>
      <Arg ref="CDC" UserType="MXCDCType" MinCount="0" MaxCount="1"/>
      if (Defined(:${CDC}:))
        %__tmp_cdc = ${CDC};
        BlockCpy(:\#next_motion.Data.MXCDC.ArcTransSpd, \%__tmp_cdc:);
        #next_motion.Command = MPCMD_MX_CDC;
        PushPacket(::);
        DispatchMPList(::);
      endif
      <!-- Types of CDC Activation/Deactivation
           0: Self-controlled activation record block 
           1: Direct CDC activation 
           2: Indirect CDC activation -->
      if (%__tmp_cdc.EntryMode == 0)
        #next_motion.Command = MPCMD_CDC_G137_MODE;
      elif (%__tmp_cdc.EntryMode == 1)
        #next_motion.Command = MPCMD_CDC_G138_MODE;
      elif (%__tmp_cdc.EntryMode == 2)
        #next_motion.Command = MPCMD_CDC_G139_MODE;
      endif
      PushPacket(::);
      DispatchMPList(::);
      #next_motion.Command = MPCMD_CDC_OFF;
      PushPacket(::);
    </CDCOff>
    <AutoTangOn>
      <Arg ref="Param" UserType="MXAutoTangType" MinCount="0" MaxCount="1"/>
      #next_motion.Command = MPCMD_MX_TANG_AX_ON;
      if Defined(:${Param}:) 
        %__tmp_auto_tang = ${Param};
        BlockCpy(:\#next_motion.Data.MXAutoTang.Offset, \%__tmp_auto_tang:);
      endif
      PushPacket(::);
    </AutoTangOn>
    <AutoTangOff>
      #next_motion.Command = MPCMD_MX_TANG_AX_OFF;
      PushPacket(::);
    </AutoTangOff>
    <SetM MinArgs="1" MaxArgs="10">
      local $i, $num_item;
      $i = 1;
      $num_item = ListLength(:${*}:);
      lbegin (1)
        #next_motion.Command = MPCMD_SET_M_FCT;
        #next_motion.Data.I4_value = ListItemValue(:${*}, $i:);  
        PushPacket(::);
        $i = $i + 1;
      lend($i &lt;= $num_item)
      DispatchMPList(::);
    </SetM>
  </BuiltInProcs>
  <SysVars>
    <TRF_DATA_MX Name="$TRF_DATA_MX">
      <GET ReturnType="IEC_UDINT">
        return %_CNC.adr_trf_data_mx;
      </GET>
    </TRF_DATA_MX>
  </SysVars>
</Root>