(********************************************************************
 * COPYRIGHT (C) B&R Industrial Automation GmbH
 ********************************************************************
 * Library: Motion Command Extension
 * File: arnc0mx.typ
 * Author: B&R
 ********************************************************************
 * Data types of Motion Command Library
 ********************************************************************)

TYPE
	MXOrientationType : STRUCT 
		Type : UDINT;
		Angle : ARRAY[0..3]OF LREAL;
	END_STRUCT;
	MXPositionType : STRUCT 
		x : LREAL;
		y : LREAL;
		z : LREAL;
	END_STRUCT;
	MXFrameType : 	STRUCT 
		Pos : MXPositionType;
		Orient : MXOrientationType;
	END_STRUCT;
	MXToolType : STRUCT 
		Index : UDINT;
		Frame : MXFrameType;
		Radius : LREAL;
	END_STRUCT;
	MXJointAxisType :ARRAY[0..5]OF LREAL;
	MXAuxAxisType :ARRAY[0..14]OF LREAL;
	MXBaseAxisType :ARRAY[0..5]OF LREAL;
	MXRotAxisType :ARRAY[0..5]OF LREAL;
	MXConfigType : 	STRUCT 
		Mode : UDINT;
	END_STRUCT;
	MXPointType : 	STRUCT 
		Pos : MXPositionType;
		Orient : MXOrientationType;
		Cfg : MXConfigType;
		RotAxis : MXRotAxisType;
		AuxAxis : MXAuxAxisType;
	END_STRUCT;
	MXPathTransType : STRUCT
		Radius	:	LREAL;
		Type	:	UDINT;
	END_STRUCT;
	MXPathDescType : STRUCT 
		Trans	:	MXPathTransType;
	END_STRUCT;
	MXOptMotType : STRUCT 
		Enable : BOOL;
		VelPathDef : USINT;
		RobotPar : USINT;
		Limits : USINT;
	END_STRUCT;
	MXDynamicDescType :	STRUCT 
		Accel : LREAL := 100;
		Decel : LREAL := 100;
		Optmot : MXOptMotType;
	END_STRUCT;
	MXHWTrigType : 	STRUCT 
		Source : USINT;
		Index : USINT;
	END_STRUCT;
	MXSWTrigType : STRUCT 
		Expression : STRING[64];
	END_STRUCT;
	MXTriggConfigType :	STRUCT 
		Type : UINT;
		HWTrig : MXHWTrigType;
		SWTrig : MXSWTrigType;
		Edge : USINT;
		ResidPath : USINT;
	END_STRUCT;
	MXVelocityType : STRUCT 
		v : LREAL;
		Mode : UDINT := 1;
	END_STRUCT;
	MXAxisTargetType : 	STRUCT 
		JointAxis : MXJointAxisType;
		AuxAxis : MXAuxAxisType;
		BaseAxis : MXBaseAxisType;
	END_STRUCT;
	MXCDCType : STRUCT
		ArcTransSpd : LREAL := 100;
		SpdMode : UDINT;
		ContourViolation : UDINT;
		TransMode : UDINT;
		EntryMode : USINT;
		AcrToLine : BOOL;
	END_STRUCT;
	MXAutoTangType : STRUCT
		Offset : LREAL;
	END_STRUCT;
	MXHWTriggerType :	STRUCT 
		Source : UINT;
		Index : UINT;
	END_STRUCT;
	MXTriggerConfigType : 	STRUCT 
		Type : UINT;
		Edge : UINT;
		HWTrigger : MXHWTriggerType;
	END_STRUCT;
END_TYPE

(********************************************************************
 * COPYRIGHT (C) B&R Industrial Automation GmbH
 ********************************************************************
 * Library: ARNC0MX
 * File: arnc0mx.fun
 * Created: 13.06.2012
 ********************************************************************
 * Functions and function blocks of library ARNC0MX
 ********************************************************************)
FUNCTION MXPointToJointEx1 : UDINT
	VAR_INPUT
		AddrTrfData : UDINT;
		Point : MXPointType;
		Joint : MXJointAxisType;
		TrfType : UDINT;
		Tool : MXToolType;
		BaseFrame : MXFrameType;
		RefJoint : ARRAY[0..5] OF LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXPointToJointEx : UDINT
	VAR_INPUT
		AddrTrfData : UDINT;
		Point : MXPointType;
		Joint : MXJointAxisType;
		TrfType : UDINT;
		Tool : MXToolType;
		BaseFrame : MXFrameType;
		RefJoint : MXJointAxisType;
	END_VAR
END_FUNCTION

FUNCTION MXJointToPointEx1 : UDINT
	VAR_INPUT
		AddrTrfData : UDINT;
		Joint : MXJointAxisType;
		Point : MXPointType;
		AnglesType : UDINT;
		TrfType : UDINT;
		Tool : MXToolType;
		BaseFrame : MXFrameType;
		RefPath : ARRAY[0..5] OF LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXJointToPointEx : UDINT
	VAR_INPUT
		AddrTrfData : UDINT;
		Joint : MXJointAxisType;
		Point : MXPointType;
		AnglesType : UDINT;
		TrfType : UDINT;
		Tool : MXToolType;
		BaseFrame : MXFrameType;
		RefPoint : MXPointType;
	END_VAR
END_FUNCTION

FUNCTION MXCncAxesToPoint : UDINT
	VAR_INPUT
		AddrTrfData : UDINT;
		Axis : ARRAY[0..14] OF LREAL;
		Point : MXPointType;
		TrfType : UDINT;
		AnglesType : UDINT;
		AxisMapCode : ARRAY[0..14] OF UINT;
		AxisMapIdx : ARRAY[0..14] OF UINT;
		ActiveAxesCount : UDINT;
	END_VAR
END_FUNCTION

FUNCTION MXFromOrient : UDINT
	VAR_INPUT
		Orient : MXOrientationType;
		Matrix : ARRAY[0..8] OF LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXToOrient : UDINT
	VAR_INPUT
		Matrix : ARRAY[0..8] OF LREAL;
		Type : UDINT;
		Orient : MXOrientationType;
		RefAngle : ARRAY[0..2] OF LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXConvertOrient : UDINT
	VAR_INPUT
		OrientIn : MXOrientationType;
		Type : UDINT;
		OrientOut : MXOrientationType;
		RefAngle : ARRAY[0..2] OF LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXFrameRotX : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		Angle : LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXFrameRotY : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		Angle : LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXFrameRotZ : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		Angle : LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXFrameEuler : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		Phi : LREAL;
		Theta : LREAL;
		Psi : LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXFrameRPY : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		Roll : LREAL;
		Pitch : LREAL;
		Yaw : LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXFrameTrans : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		DistanceX : LREAL;
		DistanceY : LREAL;
		DistanceZ : LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXFrameTransX : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		Distance : LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXFrameTransY : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		Distance : LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXFrameTransZ : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		Distance : LREAL;
	END_VAR
END_FUNCTION

FUNCTION MXFrameApply : UDINT
	VAR_INPUT
		Frame1 : MXFrameType;
		Frame2 : MXFrameType;
	END_VAR
END_FUNCTION

FUNCTION MXFromFrame : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		PointIn : MXPointType;
		PointOut : MXPointType;
	END_VAR
END_FUNCTION

FUNCTION MXToFrame : UDINT
	VAR_INPUT
		Frame : MXFrameType;
		PointIn : MXPointType;
		PointOut : MXPointType;
	END_VAR
END_FUNCTION

(********************************************************************
 * COPYRIGHT (C) B&R Industrial Automation GmbH
 ********************************************************************
 * Library: Motion Command Extension
 * File: arnc0mx.var
 * Author: B&R
 ********************************************************************
 * Constants of Motion Command Library
 ********************************************************************)

(* Velocity mode constants (<MXVelocityType>.Mode) *)
VAR CONSTANT  
  MX_VEL_MODE_RAPID : UDINT := 0; (* rapid mode *)
  MX_VEL_MODE_FEED  : UDINT := 1; (* feedrate mode *)
  MX_VEL_MODE_TIME  : UDINT := 2; (* inverse time mode *)  
END_VAR

(* MXVelocityType constants *)
VAR CONSTANT  
  MX_VEL_RAPID  : MXVelocityType := (Mode:=0);           (* rapid movement         *)
  MX_VEL_F50000 : MXVelocityType := (v:=50000, Mode:=1); (* 50000 units per minute *)
  MX_VEL_F10000 : MXVelocityType := (v:=10000, Mode:=1); (* 10000 units per minute *)
  MX_VEL_F5000  : MXVelocityType := (v:=5000,  Mode:=1); (* 5000 units per minute  *)
  MX_VEL_F1000  : MXVelocityType := (v:=1000,  Mode:=1); (* 1000 units per minute  *)
  MX_VEL_F500   : MXVelocityType := (v:=500,   Mode:=1); (* 500 units per minute   *)
  MX_VEL_F100   : MXVelocityType := (v:=100,   Mode:=1); (* 100 units per minute   *)
END_VAR

(* Trigger configuration constants *)
VAR CONSTANT  
  MX_TRIGGER_HW	            : UINT := 0;           (* Hardware trigger - MXHWTriggerType *)
  MX_TRIGGER_POSITIVE_EDGE  : UINT := 0;           (* Positive edge						 *)
  MX_TRIGGER_NEGATIVE_EDGE  : UINT := 1;           (* Negative edge						 *)
  MX_TRIGGER_HW_INPUT1		: UINT := 1;           (* Hardware trigger input 1			 *)
  MX_TRIGGER_HW_INPUT2		: UINT := 2;           (* Hardware trigger input 1			 *)
END_VAR

(* MXFrameMXFrameType constants *)
VAR CONSTANT
  MX_FRM_ZERO : MXFrameType := (0); (* zero (identity) frame *)
END_VAR
 
(* Transition type constants (<MXPathTransType>.Type) *)
VAR CONSTANT  
  MX_TRANS_OFF      : UDINT := 0; (* Transition deactivated *)
  MX_TRANS_ACCURATE : UDINT := 1; (* Accuracy hold *)
  MX_TRANS_ARC      : UDINT := 2; (* Tangential transition arcs *)
  MX_TRANS_ROUND    : UDINT := 3; (* Rounding edges *)
END_VAR
 
(* Orientation type constants (<MXOrientationType>.Type) matches constants from TRF_LIB *)
VAR CONSTANT  
  MX_CARDAN_XYZ_ANGLES    : UDINT := 1;      (* Cardan XYZ angles *)
  MX_EULER_XYZ_ANGLES     : UDINT := 1;      (* Cardan XYZ angles *)
  MX_CARDAN_XZY_ANGLES    : UDINT := 2;      (* Cardan XZY angles *)
  MX_EULER_XZY_ANGLES     : UDINT := 2;      (* Cardan XZY angles *)
  MX_CARDAN_YXZ_ANGLES    : UDINT := 4;      (* Cardan YXZ angles *)
  MX_EULER_YXZ_ANGLES     : UDINT := 4;      (* Cardan YXZ angles *)
  MX_CARDAN_YZX_ANGLES    : UDINT := 8;      (* Cardan YZX angles *)
  MX_EULER_YZX_ANGLES     : UDINT := 8;      (* Cardan YZX angles *)
  MX_CARDAN_ZXY_ANGLES    : UDINT := 16;     (* Cardan ZXY angles *)
  MX_EULER_ZXY_ANGLES     : UDINT := 16;     (* Cardan ZXY angles *)
  MX_CARDAN_ZYX_ANGLES    : UDINT := 32;     (* Cardan ZYX angles *)
  MX_EULER_ZYX_ANGLES     : UDINT := 32;     (* Cardan ZYX angles *)
  MX_EULER_XYX_ANGLES     : UDINT := 64;     (* Euler XYX angles  *)
  MX_EULER_XZX_ANGLES     : UDINT := 128;    (* Euler XZX angles  *)
  MX_EULER_YXY_ANGLES     : UDINT := 256;    (* Euler YXY angles  *)
  MX_EULER_YZY_ANGLES     : UDINT := 512;    (* Euler YZY angles  *)
  MX_EULER_ZXZ_ANGLES     : UDINT := 1024;   (* Euler ZXZ angles  *)
  MX_EULER_ZYZ_ANGLES     : UDINT := 2048;   (* Euler ZYZ angles  *)
  MX_POSITIVE_ANGLES      : UDINT := 4096;   (* mathematically positive angles *)
  MX_NEGATIVE_ANGLES      : UDINT := 8192;   (* mathematically negative angles *)
  MX_DIRECT_ANGLES        : UDINT := 16384;  (* direct "R" rotation matrix     *)
  MX_INDIRECT_ANGLES      : UDINT := 32768;  (* indirect "R^T" rotation matrix *)
  MX_EULER_ANGLES         : UDINT := 1024;   (* Euler ZXZ is commonly in view  *)
  MX_CARDAN_ANGLES        : UDINT := 1;      (* Cardan XYZ is commonly in view *)
  MX_NAUTICAL_ANGLES      : UDINT := 1;      (* Cardan XYZ is commonly in view *)
  MX_TAIT_BRYAN_ANGLES    : UDINT := 1;      (* Cardan XYZ is commonly in view *)
  MX_QUATERNION           : UDINT := 8000;   (* quaternion *)
END_VAR

(* Kinematics configuration mode constants (<MXConfigType>.Mode) matches constants from TRF_LIB *)
VAR CONSTANT  
  MX_MODE_FRONT           : UDINT := 1;          (* front *)
  MX_MODE_BACK            : UDINT := 2;          (* back *)
  MX_MODE_CONVEX          : UDINT := 4;          (* convex *)
  MX_MODE_CONCAVE         : UDINT := 8;          (* concave *)
  MX_MODE_POSITIVE        : UDINT := 16;         (* positive *)
  MX_MODE_NEGATIVE        : UDINT := 32;         (* negative *)
  MX_MODE_LEFT            : UDINT := 64;         (* left *)
  MX_MODE_RIGHT           : UDINT := 128;        (* right *)
  MX_MODE_DIRECT          : UDINT := 256;        (* direct *)
  MX_MODE_INDIRECT        : UDINT := 512;        (* indirect *)
  MX_MODE_CONVEX2         : UDINT := 1024;       (* convex2 *)
  MX_MODE_CONCAVE2        : UDINT := 2048;       (* concave2 *)
  MX_MODE_CONVEX3         : UDINT := 4096;       (* convex3 *)
  MX_MODE_CONCAVE3        : UDINT := 8192;       (* concave3 *)
  MX_MODE_HETEROGENEOUS   : UDINT := 16384;      (* heterogeneous *)
  MX_MODE_HOMOGENEOUS     : UDINT := 32768;      (* homogeneous *)
  MX_MODE_LEFT2           : UDINT := 65536;      (* left2 *)
  MX_MODE_RIGHT2          : UDINT := 131072;     (* right2 *)
  MX_MODE_NEG_DIR         : UDINT := 268435456;  (* negative direction forced *)
  MX_MODE_POS_DIR         : UDINT := 536870912;  (* positive direction forced *)
  MX_MODE_IN_SW_ENDS      : UDINT := 1073741824; (* in SW ends *)
END_VAR

(* Cutter diameter compensation constants *)
VAR CONSTANT  
  MX_CDC_LEFT                    : UDINT := 0;      (* CDC left *)
  MX_CDC_RIGHT                   : UDINT := 1;      (* CDC right *)
  MX_CDC_SPD_ON_CONTOUR          : UDINT := 0;      (* Path speed moves to the contour *)
  MX_CDC_SPD_ON_TCP              : UDINT := 1;      (* Path speed moves to the center of the tool *)
  MX_CDC_NO_COUNTER_VIOLATION    : UDINT := 0;      (* Do NOT allow contour violations due to very short path *)
  MX_CDC_VIOLATION_SHORT_PATH    : UDINT := 1;      (* Allow contour violations due to very short path sections *)
  MX_CDC_VIOLATION_INNER_EDGE    : UDINT := 2;      (* Allow contour violations due to an inner edge without intersection *)
  MX_CDC_LINEAR_TRANSITION       : UDINT := 0;      (* CDC with linear transitions *)
  MX_CDC_ARC_TRANSITION          : UDINT := 1;      (* CDC with arc transitions *)
  MX_CDC_ENTRY_BLOCK             : UDINT := 0;      (* Activate/deactivate CDC indirectly with transi-tion block *)
  MX_CDC_ENTRY_DIRECT            : UDINT := 1;      (* Activate/deactivate CDC directly *)
  MX_CDC_ENTRY_INDIRECT          : UDINT := 2;      (* Activate/deactivate CDC indirectly *)
  MX_CDC_NO_ARC_TO_LINE          : UDINT := 0;      (* Deactivate replacement of arc with straight line *)
  MX_CDC_ARC_TO_LINE             : UDINT := 1;      (* Activate replacement of arc with straight line *)
END_VAR

(* Transformation function types *)
VAR CONSTANT
  MX_TRF_TYPE_INVERSE            : UDINT := 0;      (* TRF_inverse  function *)
  MX_TRF_TYPE_INVERSE2           : UDINT := 1;      (* TRF_inverse2 function *)
  MX_TRF_TYPE_INVERSE3           : UDINT := 2;      (* TRF_inverse3 function *)
  MX_TRF_TYPE_DIRECT             : UDINT := 0;      (* TRF_direct   function *)
  MX_TRF_TYPE_DIRECT2            : UDINT := 1;      (* TRF_direct2  function *)
  MX_TRF_TYPE_DIRECT3            : UDINT := 2;      (* TRF_direct3  function *)
END_VAR  

(* Statuses, warnings, errors *)
VAR CONSTANT  
  MX_OK                          : UDINT := 0;     (* Status OK *)
  MX_WARNING_AXES                : UDINT := 2001;  (* Transformation returns valid values with warnings on axes *)
  MX_WARNING_REF_POINT_ANGLES    : UDINT := 2002;  (* Values in reference point or reference joint axes may be ignored due to conversion to another angles type *)
  MX_ERROR_WRONG_ANGLE_TYPE      : UDINT := 6001;  (* Angles type is not supported *)
  MX_ERROR_TRF_DATA_NOT_DEFINED  : UDINT := 6002;  (* Address of the transformation data variable is zero *)
  MX_ERROR_WRONG_ROBOT           : UDINT := 6003;  (* Robot is not supported *)
  MX_ERROR_WRONG_TRF_TYPE        : UDINT := 6004;  (* Transformation type not supported *)
  MX_ERROR_TRF_LIB_NOT_SUPPORTED : UDINT := 6005;  (* Transformation library of not supported version *)
  MX_ERROR_TRF_CMD_CODE			 : UDINT := 8001;  (* Unknown command code *)
  MX_ERROR_TRF_MEASURE           : UDINT := 8002;  (* Unknown measure *)
  MX_ERROR_TRF_ANGLES_TYPE       : UDINT := 8003;  (* Unknown angles type *)
  MX_ERROR_TRF_GEN29_CMD_CODE    : UDINT := 9001;  (* Unknown command code *)
  MX_ERROR_UNKNOWN_ROBOT         : UDINT := 9002;  (* Unknown robot *)
  MX_ERROR_INVALID_TRF_TYPE      : UDINT := 9003;  (* Invalid type of transformation *)
  MX_ERROR_TRF_ERROR_AXES        : UDINT := 10003; (* Transformation function returns error of axis *)
  MX_ERROR_TRF_NOT_LICENSED      : UDINT := 10008; (* Transformation function not licenced *)
  MX_ERROR_TRF_NOT_SUPPORTED     : UDINT := 10009; (* Transformation function not supported *)
  MX_ERROR_FCT_NOT_DEFINED       : UDINT := 10010; (* Transformation function address is zero *) 
  MX_ERROR_TRF_INVALID_INPUTS    : UDINT := 10015; (* Invalid inputs for transformation error *)
END_VAR

(* Error offsets *)
VAR CONSTANT  
  MX_OFFSET_WARNING              : UDINT := 2000;  (* ARNC0MX warnings *)
  MX_OFFSET_WARNING_TRF_FUN      : UDINT := 4000;  (* TRF_LIB warnings *)
  MX_OFFSET_ERROR                : UDINT := 6000;  (* ARNC0MX errros *)
  MX_OFFSET_ERROR_TRF_FUN        : UDINT := 12000; (* TRF_LIB errors *)
END_VAR

(********************************************************************
 * COPYRIGHT (C) B&R Industrial Automation GmbH
 ********************************************************************
 * Library: Motion Command Library
 * File: arnc0mxsv.var
 * Author: B&R
 ********************************************************************
 * System Variables of Motion Command Library
 ********************************************************************)
VAR {SHARED_IP_GLOBAL}
   _Frm  : MXFrameType; 
   _Tool : MXToolType; 
   _Vel  : MXVelocityType;
   _Base : MXFrameType; 
   _Ref  : MXJointAxisType;
   _Pth  : MXPathDescType;
   _Dyn  : MXDynamicDescType;
END_VAR

VAR CONSTANT
   FRM_0   : MXFrameType := (0);
   POINT_0 : MXPointType := (0);
   BASE_0  : MXFrameType := (0);
   TOOL_0  : MXToolType  := (0); 
   VEL_0   : MXVelocityType := (Mode:=1);
   REF_0   : MXJointAxisType := (0);
   VEC6_0  : ARRAY[0..5] OF LREAL := 6(0.0);
   PTH_0   : MXPathDescType := (0); 
   DYN_0   : MXDynamicDescType := (Accel:=100, Decel:=100); 
   AXIS_TARGET_0 : MXAxisTargetType := (0); 
END_VAR

VAR {SHARED_IP_GLOBAL}
  __tmp_point : MXPointType;
  __tmp_frame : MXFrameType;
  __tmp_tool : MXToolType;
  __tmp_vel : MXVelocityType;
  __tmp_joint_axis : MXJointAxisType;
  __tmp_axis_target : MXAxisTargetType;
  __tmp_pth : MXPathDescType;
  __tmp_dynamic : MXDynamicDescType;
  __tmp_cdc : MXCDCType;
  __tmp_auto_tang : MXAutoTangType;
  __tmp_trigger : MXTriggerConfigType;
  __mx_status : UDINT;
  __tmp_vec6 : ARRAY[0..5] OF LREAL;
  __tmp_set_pos : ARRAY[0..14] OF LREAL;
  __tmp_axis_code : ARRAY[0..14] OF UINT;
  __tmp_axis_idx : ARRAY[0..14] OF UINT;
END_VAR