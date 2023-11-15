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

