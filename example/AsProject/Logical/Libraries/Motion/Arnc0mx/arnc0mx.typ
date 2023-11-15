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

