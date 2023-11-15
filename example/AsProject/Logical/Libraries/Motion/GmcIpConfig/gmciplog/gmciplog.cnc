<?xml version="1.0" encoding="utf-8"?>
<?ARNC0 Version="5.12.2"?>
<Root LangModule="ailgcode" Version="1.0">
  <AxesSpec>
    <!-- specify empty axes section to avoid warning -->
  </AxesSpec>
  <PVMacros>
    <!-- MP Data fields mapped as PVMacros -->
    <DR8><REF>#next_motion.Data.R8_value</REF></DR8>
    <DI4><REF>#next_motion.Data.I4_value</REF></DI4>
    <DU4><REF>#next_motion.Data.UI4_value</REF></DU4>
    <DR8_G211>
      <SET>
       %_CNC.TA = ${EXPR};
       if (%_CNC.TA &lt; 0)
         %_CNC.TA = 0;
       endif
        #next_motion.Data.R8_value = ${EXPR};
      </SET>
    </DR8_G211>

    <!-- LINEAR POSITION DATA -->
    <Dlp><REF>#next_motion.Data.LinMovement.Position</REF></Dlp>
    <Dli>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.LinMovement.Idx[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.LinMovement.Idx = ${EXPR};
      </SET>
    </Dli>
    <Dlm>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.LinMovement.Mode[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.LinMovement.Mode = ${EXPR};
      </SET>
    </Dlm>
    <!-- TRANS/ROT OFFSET DATA, note: (A)ROT_RPL just uses R8_value -->
    <Dto><REF>#next_motion.Data.Trans.Offset</REF></Dto>
    <Dti>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.Trans.AxIdx[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.Trans.AxIdx = ${EXPR};
      </SET>
    </Dti>
    <Dtm>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.Trans.Mode[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.Trans.Mode = ${EXPR};
      </SET>
    </Dtm>
    <!-- Spline interpolation -->
    <DSPp><REF>#next_motion.Data.SplinePoint.Position</REF></DSPp>
    <DSPi>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.SplinePoint.AxIdx[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.SplinePoint.AxIdx = ${EXPR};
      </SET>
    </DSPi>
    <DSPm>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.SplinePoint.Mode[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.SplinePoint.Mode = ${EXPR};
      </SET>
    </DSPm>
    <!-- CIRCULAR MOVEMENT DATA -->
    <Dcp><REF>#next_motion.Data.CircMovement.Parameter</REF></Dcp>
    <Dci>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.CircMovement.Idx[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.CircMovement.Idx = ${EXPR};
      </SET>
    </Dci>
    <Dcm>
      <SET>
        <!-- data members need to be initialized to -1 or do they? -->
        #next_motion.Data.CircMovement.Mode[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.CircMovement.Mode = ${EXPR};
      </SET>
    </Dcm>

    <Dtp><REF>#next_motion.Data.ToolAxOrient.Parameter</REF></Dtp>
    <Dts><REF>#next_motion.Data.ToolAxOrient.Sign</REF></Dts>

    <!-- ZERO POINT OFFSET DATA -->
    <Daz><REF>#next_motion.Data.AbsZeroPtShift.ZpRecIdx</REF></Daz>
    <Das><REF>#next_motion.Data.AbsZeroPtShift.SetCS</REF></Das>

    <!-- PROGRAMMED ZERO POINT OFFSET DATA -->
    <Dpt>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.ProgZeroPtShift.Type[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.ProgZeroPtShift.Type = ${EXPR};
      </SET>
    </Dpt>
    <Dpm>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.ProgZeroPtShift.Mode[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.ProgZeroPtShift.Mode = ${EXPR};
      </SET>
    </Dpm>
    <Dpa>   <REF>#next_motion.Data.ProgZeroPtShift.AxShift</REF></Dpa>

    <!-- OPTMOTPAR DATA -->
    <Dovpathdef> <REF>#next_motion.Data.OptMotPar.path_definition</REF></Dovpathdef>
    <Dovpathdefd><REF>#next_motion.Data.OptMotPar.path_definition_def</REF></Dovpathdefd>
    <Dorpar>     <REF>#next_motion.Data.OptMotPar.robot_par</REF></Dorpar>
    <Dorpard>    <REF>#next_motion.Data.OptMotPar.robot_par_def</REF></Dorpard>
    <Dolim>      <REF>#next_motion.Data.OptMotPar.limits_idx</REF></Dolim>
    <Dolimd>     <REF>#next_motion.Data.OptMotPar.limits_idx_def</REF></Dolimd>
    <Dolimfac>   <REF>#next_motion.Data.OptMotPar.limits_factor</REF></Dolimfac>
    <Dolimfacd>  <REF>#next_motion.Data.OptMotPar.limits_factor_def</REF></Dolimfacd>

    <!-- FULL TOOL TRANSFORMATION DATA -->
    <Dfdx>  <REF>#next_motion.Data.FullTrfTool.Dx</REF></Dfdx>
    <Dfdy>  <REF>#next_motion.Data.FullTrfTool.Dy</REF></Dfdy>
    <Dfdz>  <REF>#next_motion.Data.FullTrfTool.Dz</REF></Dfdz>
    <Dfph>  <REF>#next_motion.Data.FullTrfTool.Phi</REF></Dfph>
    <Dft>   <REF>#next_motion.Data.FullTrfTool.Theta</REF></Dft>
    <Dfps>  <REF>#next_motion.Data.FullTrfTool.Psi</REF></Dfps>

    <!-- latch configuration data -->
    <DPLDli><REF>#next_motion.Data.PosLatchDistance.LatchIdx</REF></DPLDli>
    <DPLDts><REF>#next_motion.Data.PosLatchDistance.TriggSource</REF></DPLDts>
    <DPLDe> <REF>#next_motion.Data.PosLatchDistance.Edge</REF></DPLDe>
    <DPLDti><REF>#next_motion.Data.PosLatchDistance.HwTrigIdx</REF></DPLDti>
    <DPLDd> <REF>#next_motion.Data.PosLatchDistance.Distance</REF></DPLDd>

    <DPLli> <REF>#next_motion.Data.PosLatch.LatchIdx</REF></DPLli>
    <DPLts> <REF>#next_motion.Data.PosLatch.TriggSource</REF></DPLts>
    <DPLe>  <REF>#next_motion.Data.PosLatch.Edge</REF></DPLe>
    <DPLti> <REF>#next_motion.Data.PosLatch.HwTrigIdx</REF></DPLti>
    
    <!-- latch configuration data for GMC -->
    <DPLtr> <REF>#next_motion.Data.PosLatchGmc.Trigger</REF></DPLtr>
    <DPLlp> <REF>#next_motion.Data.PosLatchGmc.pLatchPos</REF></DPLlp>
    <DPLcs> <REF>#next_motion.Data.PosLatchGmc.CoordSystem</REF></DPLcs>
    <DPLrp> <REF>#next_motion.Data.PosLatchGmc.ResidualPath</REF></DPLrp>    

    <!-- RADIUS FEED ADJUSTMENT DATA  -->
    <Drma>  <REF>#next_motion.Data.R_DependFeed.MaxRadius</REF></Drma>
    <Drmi>  <REF>#next_motion.Data.R_DependFeed.MinRadius</REF></Drmi>
    <Drr>   <REF>#next_motion.Data.R_DependFeed.Rate</REF></Drr>

    <!-- V JUMP DATA -->
    <Dsvp>
      <SET>
        <!-- data membeRs need to be initialized to ncOff -->
        #next_motion.Data.Set_v_jump.programmed[0] = ArrayRep(:(:ncOFF:):);
        #next_motion.Data.Set_v_jump.programmed = ${EXPR};
      </SET>
    </Dsvp>
    <Dsvv>  <REF>#next_motion.Data.Set_v_jump.value</REF></Dsvv>

    <!-- A JUMP DATA -->
    <Dsap>
      <SET>
        <!-- data membeRs need to be initialized to ncOff -->
        #next_motion.Data.Set_a_jump.programmed[0] = ArrayRep(:(:ncOFF:):);
        #next_motion.Data.Set_a_jump.programmed = ${EXPR};
      </SET>
    </Dsap>
    <Dsav>  <REF>#next_motion.Data.Set_a_jump.value</REF></Dsav>

    <!-- AXIS LIMIT DATA -->
    <Dsep>
      <SET>
        <!-- data membeRs need to be initialized to ncOff -->
        #next_motion.Data.SetAxLimit.programmed[0] = ArrayRep(:(:ncOFF:):);
        #next_motion.Data.SetAxLimit.programmed = ${EXPR};
      </SET>
    </Dsep>
    <Dser>  <REF>#next_motion.Data.SetAxLimit.RecordIdx</REF></Dser>

    <!-- CAMWRAPPING DATA -->
    <Dcad>  <REF>#next_motion.Data.CamWrapping.Diameter</REF></Dcad>
    <Dcap>  <REF>#next_motion.Data.CamWrapping.ParameterP1</REF></Dcap>

    <Dsu><REF>#next_motion.Data.SetPathAccDec.UnitType</REF></Dsu>

    <!-- ACC DEC DATA -->
    <Dsv108>
      <SET>
        #next_motion.Data.SetPathAccDec.value = ${EXPR};
        if (#next_motion.Data.SetPathAccDec.UnitType == 1)
          %_CNC.lim_path_acc_p = ${EXPR} / 100.0 * %_CNC.lim_path_acc_p_ini;
        else
          %_CNC.lim_path_acc_p = ${EXPR};
        endif
      </SET>
    </Dsv108>

    <Dsv109>
      <SET>
        #next_motion.Data.SetPathAccDec.value = ${EXPR};
        if (#next_motion.Data.SetPathAccDec.UnitType == 1)
          %_CNC.lim_path_acc_n = ${EXPR} / 100.0 * %_CNC.lim_path_acc_n_ini;
        else
          %_CNC.lim_path_acc_n = ${EXPR};
        endif
      </SET>
    </Dsv109>

    <Dsv110>
      <SET>
        #next_motion.Data.SetPathAccDec.value = ${EXPR};
        if (#next_motion.Data.SetPathAccDec.UnitType == 1)
          %_CNC.lim_path_acc_p = ${EXPR} / 100.0 * %_CNC.lim_path_acc_p_ini;
          %_CNC.lim_path_acc_n = ${EXPR} / 100.0 * %_CNC.lim_path_acc_n_ini;
        else
          %_CNC.lim_path_acc_p = ${EXPR};
          %_CNC.lim_path_acc_n = ${EXPR};
        endif
      </SET>
    </Dsv110>

    <!-- MPCMD_SET_AXIS_ACC_DEC -->
    <Daxlv>  <REF>#next_motion.Data.AxisLimit.Value</REF></Daxlv>
    <Daxla>  <REF>#next_motion.Data.AxisLimit.Axis</REF></Daxla>
    <Daxlu>  <REF>#next_motion.Data.AxisLimit.UnitType</REF></Daxlu>
    
    <!-- MPCMD_TANG_TRANS_SPEED_RED -->
    <Dsma>  <REF>#next_motion.Data.SetTransSpeed.MaxAngle</REF></Dsma>
    <Dsmi>  <REF>#next_motion.Data.SetTransSpeed.MinAngle</REF></Dsmi>
    <Dsr>   <REF>#next_motion.Data.SetTransSpeed.RedFactor</REF></Dsr>

    <!-- BEZIER SPLINE DATA -->
    <Dbrp>  <REF>#next_motion.Data.BezierSpline.RadiusProgrammed</REF></Dbrp>
    <Dbr>   <REF>#next_motion.Data.BezierSpline.Radius</REF></Dbr>
    <Dbvp>  <REF>#next_motion.Data.BezierSpline.VeProgrammed</REF></Dbvp>
    <Dbv>   <REF>#next_motion.Data.BezierSpline.Ve</REF></Dbv>
    <Dbl>   <REF>#next_motion.Data.BezierSpline.LinProgrammed</REF></Dbl>
    <Dbsf>  <REF>#next_motion.Data.BezierSpline.scalingFactor</REF></Dbsf>
    <Dbsfd> <REF>#next_motion.Data.BezierSpline.scalingFactor_def</REF></Dbsfd>

    <Dao>   <REF>#next_motion.Data.AutomTangentialAx.Offset</REF></Dao>
    <Daa>   <REF>#next_motion.Data.AutomTangentialAx.AxIdx</REF></Daa>

    <!-- AXIS MAPPING DATA -->
    <DAMa>  <REF>#next_motion.Data.AxisMapping.AxIdx</REF></DAMa>
    <DAMf>  <REF>#next_motion.Data.AxisMapping.factor</REF></DAMf>
    <DAMp>  <REF>#next_motion.Data.AxisMapping.ParameterP1</REF></DAMp>

    <!-- SIGNAL PATH END DATA -->
    <DSPEid> <REF>#next_motion.Data.SignalPathEnd.SignalId</REF></DSPEid>
    <DSPEt>  <REF>#next_motion.Data.SignalPathEnd.Time</REF></DSPEt>
    <DSPEst> <REF>#next_motion.Data.SignalPathEnd.SignalType</REF></DSPEst>
    <DSPEsi> <REF>#next_motion.Data.SignalPathEnd.SignalIdx</REF></DSPEsi>
    <DSPEsd> <REF>#next_motion.Data.SignalPathEnd.SourceData</REF></DSPEsd>
    <DSPEd>  <REF>#next_motion.Data.SignalPathEnd.DataLength </REF></DSPEd>
    <DSPEp>
      <SET>
        #next_motion.Data.SignalPathEnd.pDestination = \#sys_vars.EXF[0];
      </SET>
    </DSPEp>

    <!-- SIGNAL PATH END DISTDATA -->
    <DSPEDid> <REF>#next_motion.Data.SignalPathEndDist.SignalId</REF></DSPEDid>
    <DSPEDd>  <REF>#next_motion.Data.SignalPathEndDist.Distance</REF></DSPEDd>
    <DSPEDst> <REF>#next_motion.Data.SignalPathEndDist.SignalType</REF></DSPEDst>
    <DSPEDsi> <REF>#next_motion.Data.SignalPathEndDist.SignalIdx</REF></DSPEDsi>
    <DSPEDsd> <REF>#next_motion.Data.SignalPathEndDist.SourceData</REF></DSPEDsd>
    <DSPEDdl> <REF>#next_motion.Data.SignalPathEndDist.DataLength </REF></DSPEDdl>
    <DSPEDp>
      <SET>
        #next_motion.Data.SignalPathEndDist.pDestination = \#sys_vars.EXF[0];
      </SET>
    </DSPEDp>

    <!-- SIGNAL PREDICT DATA -->
    <DSPo><REF>#next_motion.Data.SignalPredict.Override</REF></DSPo>
    <DSPop><REF>#next_motion.Data.SignalPredict.OvrProgrammed</REF></DSPop>
    <DSPsi><REF>#next_motion.Data.SignalPredict.SignalIdx</REF></DSPsi>
    <DSPsp><REF>#next_motion.Data.SignalPredict.StopProgrammed</REF></DSPsp>

    <!-- WS_CTRL DATA -->
    <DWCx1>  <REF>#next_motion.Data.WS_Ctrl.x1</REF></DWCx1>
    <DWCz1>  <REF>#next_motion.Data.WS_Ctrl.z1</REF></DWCz1>
    <DWCy1>  <REF>#next_motion.Data.WS_Ctrl.y1</REF></DWCy1>
    <DWCx2>  <REF>#next_motion.Data.WS_Ctrl.x2</REF></DWCx2>
    <DWCz2>  <REF>#next_motion.Data.WS_Ctrl.y2</REF></DWCz2>
    <DWCy2>  <REF>#next_motion.Data.WS_Ctrl.z2</REF></DWCy2>
    <DWCi>   <REF>#next_motion.Data.WS_Ctrl.index</REF></DWCi>
    <DWCc>   <REF>#next_motion.Data.WS_Ctrl.coord</REF></DWCc>
    <DWCpl>   <REF>#next_motion.Data.WS_Ctrl.pplane</REF></DWCpl>
    <DWCo>   <REF>#next_motion.Data.WS_Ctrl.orient</REF></DWCo>
    <DWCs>   <REF>#next_motion.Data.WS_Ctrl.shape</REF></DWCs>
    <DWCca>   <REF>#next_motion.Data.WS_Ctrl.clear_all</REF></DWCca>
    <DWCp1>   <REF>#next_motion.Data.WS_Ctrl.point1</REF></DWCp1>
    <DWCp2>   <REF>#next_motion.Data.WS_Ctrl.point2</REF></DWCp2>
    <DWCen>   <REF>#next_motion.Data.WS_Ctrl.enable</REF></DWCen>

    <DWCa>
      <SET>
        #next_motion.Data.WS_Ctrl.arm_diameter[0] = ArrayRep(:(:ncOFF:):);
        #next_motion.Data.WS_Ctrl.arm_diameter = ${EXPR};
      </SET>
    </DWCa>

    <!-- TOOL DATA RECORD DATA -->
    <DTDRt>  <REF>#next_motion.Data.ToolDataRecord.ToolIdx</REF></DTDRt>

    <!-- SYS VARS -->
    <Sz>     <REF>#sys_vars.ZP</REF></Sz>

    <!-- SPINDLE SPEED DATA -->
    <DSSi>   <REF>#next_motion.Data.SpindleSpeed.Idx</REF></DSSi>
    <DSSs>   <REF>#next_motion.Data.SpindleSpeed.speed</REF></DSSs>

    <!-- C2_SPLINE_START DATA -->
    <DCSSt>  <REF>#next_motion.Data.C2_SplineStart.BCType</REF></DCSSt>
    <DCSSv>  <REF>#next_motion.Data.C2_SplineStart.BCValue</REF></DCSSv>
    <DCSSp>
      <SET>
        #next_motion.Data.C2_SplineStart.BCProgrammed[0] = ArrayRep(:(:ncOFF:):);
        #next_motion.Data.C2_SplineStart.BCProgrammed = ${EXPR};
      </SET>
    </DCSSp>
    <DCSSsp>  <REF>#next_motion.Data.C2_SplineStart.SegmentParameter</REF></DCSSsp>
    <DCSSst>  <REF>#next_motion.Data.C2_SplineStart.SegmentType</REF></DCSSst>

    <!-- C2_SPLINE_END DATA -->
    <DCSEt>  <REF>#next_motion.Data.C2_SplineEnd.BCType</REF></DCSEt>
    <DCSEv>  <REF>#next_motion.Data.C2_SplineEnd.BCValue</REF></DCSEv>
    <DCSEp>
      <SET>
        #next_motion.Data.C2_SplineEnd.BCProgrammed[0] = ArrayRep(:(:ncOFF:):);
        #next_motion.Data.C2_SplineEnd.BCProgrammed = ${EXPR};
      </SET>
    </DCSEp>
    
    <!-- FRAME Data -->
    <DFd>    <REF>#next_motion.Data.Frame.Data</REF></DFd>
    <DFcs>   <REF>#next_motion.Data.Frame.SetCS</REF></DFcs>

    <!-- SYSTEM VARIABLE DATA -->
    <DSVs>   <REF>#next_motion.Data.SystemVariable.SysVarIdx</REF></DSVs>
    <DSVa>   <REF>#next_motion.Data.SystemVariable.AxIdx</REF></DSVa>
    <DSVd>   <REF>#next_motion.Data.SystemVariable.Data.R8_value</REF></DSVd>

    <!-- AUTOMATIC NC BLOCK NUMBERING -->
    <DABNf> <REF>#next_motion.Data.AutoBlockNumber.offset</REF> </DABNf>
    <DABNo> <REF>#next_motion.Data.AutoBlockNumber.factor</REF> </DABNo>

    <!-- CONSTANT SURFACE SPEED (GMC Only) -->
    <DCSSPs> <REF>#next_motion.Data.ConstantSurfaceSpeed.Speed</REF> </DCSSPs>
    <DCSSPp> <REF>#next_motion.Data.ConstantSurfaceSpeed.Programmed</REF> </DCSSPp>

    <!-- MPCMD_MX_FRAME, MPCMD_MX_BASE -->
    <MXFPx> <REF>#next_motion.Data.MXFrame.Pos.x</REF> </MXFPx>
    <MXFPy> <REF>#next_motion.Data.MXFrame.Pos.y</REF> </MXFPy>
    <MXFPz> <REF>#next_motion.Data.MXFrame.Pos.z</REF> </MXFPz>
    <MXFOt> <REF>#next_motion.Data.MXFrame.Orient.Type</REF> </MXFOt>
    <MXFOa> <REF>#next_motion.Data.MXFrame.Orient.Angle</REF> </MXFOa>
    
    <!-- MPCMD_MX_FRAME_EX -->
    <MXFEPx> <REF>#next_motion.Data.MXFrameEx.Frame.Pos.x</REF> </MXFEPx>
    <MXFEPy> <REF>#next_motion.Data.MXFrameEx.Frame.Pos.y</REF> </MXFEPy>
    <MXFEPz> <REF>#next_motion.Data.MXFrameEx.Frame.Pos.z</REF> </MXFEPz>
    <MXFEOt> <REF>#next_motion.Data.MXFrameEx.Frame.Orient.Type</REF> </MXFEOt>
    <MXFEOa> <REF>#next_motion.Data.MXFrameEx.Frame.Orient.Angle</REF> </MXFEOa>    
    <MXFECs> <REF>#next_motion.Data.MXFrameEx.SetCS</REF> </MXFECs>
    <MXFEAd> <REF>#next_motion.Data.MXFrameEx.Additive</REF> </MXFEAd>

    <!-- MPCMD_MX_TOOL -->
    <MXTFPx> <REF>#next_motion.Data.MXTool.Frame.Pos.x</REF> </MXTFPx>
    <MXTFPy> <REF>#next_motion.Data.MXTool.Frame.Pos.y</REF> </MXTFPy>
    <MXTFPz> <REF>#next_motion.Data.MXTool.Frame.Pos.z</REF> </MXTFPz>
    <MXTFOt> <REF>#next_motion.Data.MXTool.Frame.Orient.Type</REF> </MXTFOt>
    <MXTFOa> <REF>#next_motion.Data.MXTool.Frame.Orient.Angle</REF> </MXTFOa>
    <MXTr> <REF>#next_motion.Data.MXTool.Radius</REF> </MXTr>
    <MXTi> <REF>#next_motion.Data.MXTool.Index</REF> </MXTi>

    <!-- MPCMD_MX_POINT, MPCMD_MX_CIRCLE_POINT -->
    <MXPPx> <REF>#next_motion.Data.MXPoint.Pos.x</REF> </MXPPx>
    <MXPPy> <REF>#next_motion.Data.MXPoint.Pos.y</REF> </MXPPy>
    <MXPPz> <REF>#next_motion.Data.MXPoint.Pos.z</REF> </MXPPz>
    <MXPOt> <REF>#next_motion.Data.MXPoint.Orient.Type</REF> </MXPOt>
    <MXPOa> <REF>#next_motion.Data.MXPoint.Orient.Angle</REF> </MXPOa>
    <MXPCm> <REF>#next_motion.Data.MXPoint.Cfg.Mode</REF> </MXPCm>
    <MXPr> <REF>#next_motion.Data.MXPoint.RotAxis</REF> </MXPr>
    <MXPa> <REF>#next_motion.Data.MXPoint.AuxAxis</REF> </MXPa>

    <!-- MPCMD_MX_PATH_DESC -->
    <MXPhTr> <REF>#next_motion.Data.MXPathDesc.Trans.Radius</REF> </MXPhTr>
    <MXPhTt> <REF>#next_motion.Data.MXPathDesc.Trans.Type</REF> </MXPhTt>

    <!-- MPCMD_MX_DYNAMIC_DESC -->
    <MXDa> <REF>#next_motion.Data.MXDynamicDesc.Accel</REF> </MXDa>
    <MXDd> <REF>#next_motion.Data.MXDynamicDesc.Decel</REF> </MXDd>
    <MXDOe> <REF>#next_motion.Data.MXDynamicDesc.Optmot.Enable</REF> </MXDOe>
    <MXDOv> <REF>#next_motion.Data.MXDynamicDesc.Optmot.VelPathDef</REF> </MXDOv>
    <MXDOr> <REF>#next_motion.Data.MXDynamicDesc.Optmot.RobotPar</REF> </MXDOr>
    <MXDOl> <REF>#next_motion.Data.MXDynamicDesc.Optmot.Limits</REF> </MXDOl>

    <!-- MPCMD_MX_VELOCITY -->
    <MXVv> <REF>#next_motion.Data.MXVelocity.v</REF> </MXVv>
    <MXVm> <REF>#next_motion.Data.MXVelocity.Mode</REF> </MXVm>

    <!-- MPCMD_MX_AXIS_TARGET -->
    <MXAj> <REF>#next_motion.Data.MXAxisTarget.JointAxis</REF> </MXAj>
    <MXAa> <REF>#next_motion.Data.MXAxisTarget.AuxAxis</REF> </MXAa>
    <MXAb> <REF>#next_motion.Data.MXAxisTarget.BaseAxis</REF> </MXAb>

    <!-- MPCMD_MX_WANTED_JOINT -->
    <MXJ> <REF>#next_motion.Data.MXJointAxis</REF> </MXJ>

    <!-- MPCMD_MX_TANG_AX_ON -->
    <MXAto> <REF>#next_motion.Data.MXAutoTang.Offset</REF> </MXAto>

    <!-- MPCMD_MX_CDC -->
    <MXCDCas> <REF>#next_motion.Data.MXCDC.ArcTransSpd</REF> </MXCDCas>
    <MXCDCsm> <REF>#next_motion.Data.MXCDC.SpdMode</REF> </MXCDCsm>
    <MXCDCcv> <REF>#next_motion.Data.MXCDC.ContourViolation</REF> </MXCDCcv>
    <MXCDCtm> <REF>#next_motion.Data.MXCDC.TransMode</REF> </MXCDCtm>
    <MXCDCem> <REF>#next_motion.Data.MXCDC.EntryMode</REF> </MXCDCem>
    <MXCDCal> <REF>#next_motion.Data.MXCDC.AcrToLine</REF> </MXCDCal>

    <!-- MPCMD_THREAD_CUT -->
    <THCp><REF>#next_motion.Data.ThreadCut.Position</REF></THCp>
    <THCi>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.ThreadCut.Idx[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.ThreadCut.Idx = ${EXPR};
      </SET>
    </THCi>
    <THCm>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.ThreadCut.Mode[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.ThreadCut.Mode = ${EXPR};
      </SET>
    </THCm>
    <THCld> <REF>#next_motion.Data.ThreadCut.LeadDirection</REF> </THCld>
    <THCl>  <REF>#next_motion.Data.ThreadCut.Lead</REF> </THCl>
    <THCo>  <REF>#next_motion.Data.ThreadCut.Offset</REF> </THCo>

    <ACVc><REF>#next_motion.Data.AxisCtrlVelocity.Command</REF></ACVc>
    <ACVi><REF>#next_motion.Data.AxisCtrlVelocity.Idx</REF></ACVi>

    <ACSs><REF>#next_motion.Data.AxisCtrlSpeed.Speed</REF></ACSs>
    <ACSi><REF>#next_motion.Data.AxisCtrlSpeed.Idx</REF></ACSi>

    <ACPp><REF>#next_motion.Data.AxisCtrlPosition.Position</REF></ACPp>
    <ACPd><REF>#next_motion.Data.AxisCtrlPosition.PositionDefined</REF></ACPd>
    <ACPi><REF>#next_motion.Data.AxisCtrlPosition.Idx</REF></ACPi>
    <ACPm><REF>#next_motion.Data.AxisCtrlPosition.Mode</REF></ACPm>

    <!-- MPCMD_CHAMFER -->
    <CHFm><REF>#next_motion.Data.Chamfer.Mode</REF></CHFm>
    <CHFv><REF>#next_motion.Data.Chamfer.Value</REF></CHFv>

    <!-- MPCMD_PATH_FEED -->
    <PAFv><REF>#next_motion.Data.PathFeed.Value</REF></PAFv>
    <PAFi><REF>#next_motion.Data.PathFeed.Id</REF></PAFi>

    <!-- MPCMD_SERVICE_DATA,  MPCMD_PLOT_BUFFER_DATA -->
    <GENd> <REF>#next_motion.Data.GenericData.Data</REF> </GENd>

    <!-- MPCMD_SET_GMC_AX_LIMIT -->
    <SGALda><REF>#next_motion.Data.SetGmcAxisLimit.DestinationAxis</REF></SGALda>
    <SGALdp><REF>#next_motion.Data.SetGmcAxisLimit.DestinationPath</REF></SGALdp>
    <SGALsa><REF>#next_motion.Data.SetGmcAxisLimit.SourceAxis</REF></SGALsa>
    <SGALsp><REF>#next_motion.Data.SetGmcAxisLimit.SourcePath</REF></SGALsp>
    <SGALn>
      <SET>
        BlockCpy(:\#next_motion.Data.SetGmcAxisLimit.SourceLimitSetName, ${EXPR}:);
      </SET>
    </SGALn>

    <!-- MPCMD_COMPRESSOR_ON -->
    <CMPmd><REF>#next_motion.Data.Compressor.MaxCartesianDeviation</REF></CMPmd>
    <CMPmnd><REF>#next_motion.Data.Compressor.MaxNonCartesianDeviation</REF></CMPmnd>
    <CMPmt><REF>#next_motion.Data.Compressor.MaxCartesianTransitionAngle</REF></CMPmt>
    <CMPml><REF>#next_motion.Data.Compressor.MaxCartesianLength</REF></CMPml>
    <CMPmnt><REF>#next_motion.Data.Compressor.MaxNonCartesianTransitionAngle</REF></CMPmnt>

    <!-- MPCMD_MX_PARAMETER_R8 -->
    <PR8v><REF>#next_motion.Data.R8_param.Value</REF></PR8v>
    <PR8i><REF>#next_motion.Data.R8_param.Id</REF></PR8i>
    
    <!-- MPCMD_SET_TOOL_PAR -->
    <STPi><REF>#next_motion.Data.ToolPar.Id</REF></STPi>
    <STPR8><REF>#next_motion.Data.ToolPar.R8_value</REF></STPR8>
    <STPI4><REF>#next_motion.Data.ToolPar.I4_value</REF></STPI4>

    <!-- MPCMD_SET_FRAME_PROPERTY -->
    <SFPi><REF>#next_motion.Data.SetFrameProperty.FrameId</REF></SFPi>
    <SFPp><REF>#next_motion.Data.SetFrameProperty.FrameProperty</REF></SFPp>

    <!-- MPCMD_SET_FRAME_INDEX -->
    <SFIi><REF>#next_motion.Data.SetFrameIndex.FrameId</REF></SFIi>
    <SFIx><REF>#next_motion.Data.SetFrameIndex.FrameIndex</REF></SFIx>

    <!-- MPCMD_GMC_FRAME -->
    <GFof><REF>#next_motion.Data.GmcFrame.Offset</REF></GFof>
    <GFmo>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.GmcFrame.Mode[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.GmcFrame.Mode = ${EXPR};
      </SET>
    </GFmo>
    <GFai>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.GmcFrame.AxIdx[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.GmcFrame.AxIdx = ${EXPR};
      </SET>
    </GFai>
    <GFor><REF>#next_motion.Data.GmcFrame.Orientation</REF></GFor>
    <GFori>
      <SET>
        <!-- data members need to be initialized to -1 -->
        #next_motion.Data.GmcFrame.OrientationIdx[0] = ArrayRep(:(:-1:):);
        #next_motion.Data.GmcFrame.OrientationIdx = ${EXPR};
      </SET>
    </GFori>
    <GFort><REF>#next_motion.Data.GmcFrame.OrientationType</REF></GFort>
    <GFsc><REF>#next_motion.Data.GmcFrame.SetCS</REF></GFsc>
    <GFtfc><REF>#next_motion.Data.GmcFrame.TCPFromCS</REF></GFtfc>
    <GFttc><REF>#next_motion.Data.GmcFrame.TCPToCS</REF></GFttc>
    <GFcc><REF>#next_motion.Data.GmcFrame.ClearCS</REF></GFcc>
    <GFne><REF>#next_motion.Data.GmcFrame.Negative</REF></GFne>
    <GFut><REF>#next_motion.Data.GmcFrame.UseTCP</REF></GFut>
  </PVMacros>
  <Constants>
    <PathBusy     type="STRING">BUSY</PathBusy>
    <PathStatus   type="STRING">STATUS</PathStatus>
    <PathErrLevel type="STRING">ERRLEV</PathErrLevel>
  </Constants>
  <BuiltInProcs>
    <!-- SendCommand only used prior to ARNC0 V1.25.0 -->
    <SendCommand MinArgs="1" MaxArgs="1" Inline="Yes">
      SendCommand(:$[1]:);
    </SendCommand>
    <DispatchAndWait MinArgs="1" MaxArgs="1" Inline="Yes">
      DispatchAndWait(:$[1]:);
    </DispatchAndWait>
    <WaitForCommand MinArgs="1" MaxArgs="1" Inline="Yes">
      WaitForCommand(:$[1]:);
    </WaitForCommand>
  </BuiltInProcs>
  <Preprocess>
    <MP_PJN Search="MP22000 " Replace="PJN " />
    <MP_PJB Search="MP22100 " Replace="PJB " />
  </Preprocess>
  <GCodes>
    <!-- For MPLogging GCodes only used for commands that take args -->
    <G_DELAY GNum="0" Alias="@" AliasIsPattern="Yes" Inline="Yes">
       <Arg DataType="FLOAT" ref="tickdelay"/>
       #cycle_counter = 0;
      WaitUntil(:#cycle_counter &gt;= ${tickdelay}:);
    </G_DELAY>

    <!-- Path synchronous exec job : Non-Blocking -->
    <G_PJN GNum="22000" Alias="PJN" Group="220">
      <Arg Name="PathBusy" DataType="FLOAT" ref="busy_count"/>
      <Arg Name="PathStatus" DataType="FLOAT" ref="final_status"/>
      <Arg Name="PathErrLevel" DataType="FLOAT" ref="error_level"/>
      #job->group_id = 0;
      #job->enable = 1;
      #job->is_fub = 1;
      #job->error_level = ${error_level};
      if (${busy_count} == 0)
        recordpathsynch
          @#job->terminate = 1;
          @#job->eval_status = ${final_status};
        endpathsynch
      else
        recordpathsynch
          begincyclic
          if (${busy_count} == @#job->eval_count)
            @#job->terminate = 1;
            @#job->eval_status = ${final_status};
          else
            @#job->eval_status = 65535;
          endif
          endcyclic
        endpathsynch
      endif
    </G_PJN>

    <!-- Path synchronous exec job : Blocking -->
    <G_PJB GNum="22100" Alias="PJB" Group="220">
      <Arg Name="PathBusy" DataType="FLOAT" ref="busy_count"/>
      <Arg Name="PathStatus" DataType="FLOAT" ref="final_status"/>
      <Arg Name="PathErrLevel" DataType="FLOAT" ref="error_level"/>
      #job->group_id = 0;
      #job->enable = 1;
      #job->is_fub = 1;
      #job->error_level = ${error_level};
      #job->mp_command = MPCMD_PATH_SYNC_EXEC_WAIT;
      #job->is_blocking = 1;
      if (${busy_count} == 0)
        recordpathsynch
          @#job->terminate = 1;
          @#job->eval_status = ${final_status};
        endpathsynch
      else
        recordpathsynch
          begincyclic
            if (${busy_count} == @#job->eval_count)
              @#job->terminate = 1;
              @#job->eval_status = ${final_status};
            else
              @#job->eval_status = 65535;
            endif
          endcyclic
          WaitForCyclicJob(:@#last_job_id:);
        endpathsynch
      endif
    </G_PJB>
  </GCodes>
  <MCodes>
  	<!-- MPLogging M-Codes are used for processing MPxxxx consts and the ; pushpacket call -->
    <M_DEFAULT IsDefault="Yes" MinValue="0" MaxValue="999999">
      <!-- MP Command number: MP<num> -->
      <ARG ref="VALUE" DataType="FLOAT" RequireLiteral="Yes" />
      #next_motion.Command = ${VALUE};
    </M_DEFAULT>
    <M10003 Value="10003" Inline="Yes">
      <!-- Abort MP must trigger a runtime error from the MPLog run -->
      <ARG ref="VALUE" DataType="FLOAT" RequireLiteral="Yes" />
      Error(:id:10003,msg:"LogAbort":);
    </M10003>
    <M1000000 Value="1000000" Alias=";" AliasIsPattern="Yes" Inline="Yes" IgnoreIfGroups="220">
      <!-- PushPacket call -->
      <ARG ref="VALUE" DataType="FLOAT" RequireLiteral="Yes" />
      PushPacket(::);
    </M1000000>
  </MCodes>
  <ParserData NestedComments="No" DefaultCaseSensitive="Yes" CommentsSpanLines="No"
     ReadWholeFileBeforeParsing="No" ExpectMainProgStmts="Yes" UseFubTemplates="No" >
    <TKG_END_OF_LINE IsPattern="No">\n</TKG_END_OF_LINE>
    <TKG_OPEN_COMMENT>#</TKG_OPEN_COMMENT>
    <TKG_NC_BLOCK_PREFIX IsPattern="Yes">N:[\s\d]</TKG_NC_BLOCK_PREFIX>
    <TKG_OPEN_LISTBRACKET>(</TKG_OPEN_LISTBRACKET>
    <TKG_CLOSE_LISTBRACKET>)</TKG_CLOSE_LISTBRACKET>
    <TKG_COMMA>,</TKG_COMMA>
    <TKG_NUMBER IsPattern="Yes">\d+\.\d+|\d+\.|\.\d+</TKG_NUMBER>
    <TKG_INTEGER IsPattern="Yes">\d+</TKG_INTEGER>
    <TKG_NUMBER_EXP IsPattern="Yes">e:[\s\d\+\-\.]</TKG_NUMBER_EXP>
    <TKG_ASSIGN_EQ>=</TKG_ASSIGN_EQ>
    <TKG_ARITH_BINARY_MINUS>-</TKG_ARITH_BINARY_MINUS>
    <TKG_M_CODE_PREFIX IsPattern="Yes">MP:\d</TKG_M_CODE_PREFIX>
  </ParserData>
  <StringChars AsciiStringStart="&quot;">
    <!-- default is case sensitive -->
    <EscapeSeq Search="$N" CaseSensitive="No" ReplaceValue="10" />
    <EscapeSeq Search="$L" CaseSensitive="Yes" ReplaceValue="10" />
    <EscapeSeq Search="$Q" CaseSensitive="No" ReplaceStr="&quot;" />
    <EscapeSeq Search="$[\dA-F]+" IsPattern="Yes" CaseSensitive="No" ReplaceEncodingBase="16"/>
    <EscapeSeq Search="$$" ReplaceStr="$"/>
    <EscapeSeq Search="$" ReplaceStr=""/>
  </StringChars>
</Root>
