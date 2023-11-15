/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _ARNC0MX_
#define _ARNC0MX_
#ifdef __cplusplus
extern "C" 
{
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
/* Constants */
#ifdef _REPLACE_CONST
 #define MX_OFFSET_ERROR_TRF_FUN 12000U
 #define MX_OFFSET_ERROR 6000U
 #define MX_OFFSET_WARNING_TRF_FUN 4000U
 #define MX_OFFSET_WARNING 2000U
 #define MX_ERROR_TRF_INVALID_INPUTS 10015U
 #define MX_ERROR_FCT_NOT_DEFINED 10010U
 #define MX_ERROR_TRF_NOT_SUPPORTED 10009U
 #define MX_ERROR_TRF_NOT_LICENSED 10008U
 #define MX_ERROR_TRF_ERROR_AXES 10003U
 #define MX_ERROR_INVALID_TRF_TYPE 9003U
 #define MX_ERROR_UNKNOWN_ROBOT 9002U
 #define MX_ERROR_TRF_GEN29_CMD_CODE 9001U
 #define MX_ERROR_TRF_ANGLES_TYPE 8003U
 #define MX_ERROR_TRF_MEASURE 8002U
 #define MX_ERROR_TRF_CMD_CODE 8001U
 #define MX_ERROR_TRF_LIB_NOT_SUPPORTED 6005U
 #define MX_ERROR_WRONG_TRF_TYPE 6004U
 #define MX_ERROR_WRONG_ROBOT 6003U
 #define MX_ERROR_TRF_DATA_NOT_DEFINED 6002U
 #define MX_ERROR_WRONG_ANGLE_TYPE 6001U
 #define MX_WARNING_REF_POINT_ANGLES 2002U
 #define MX_WARNING_AXES 2001U
 #define MX_OK 0U
 #define MX_TRF_TYPE_DIRECT3 2U
 #define MX_TRF_TYPE_DIRECT2 1U
 #define MX_TRF_TYPE_DIRECT 0U
 #define MX_TRF_TYPE_INVERSE3 2U
 #define MX_TRF_TYPE_INVERSE2 1U
 #define MX_TRF_TYPE_INVERSE 0U
 #define MX_CDC_ARC_TO_LINE 1U
 #define MX_CDC_NO_ARC_TO_LINE 0U
 #define MX_CDC_ENTRY_INDIRECT 2U
 #define MX_CDC_ENTRY_DIRECT 1U
 #define MX_CDC_ENTRY_BLOCK 0U
 #define MX_CDC_ARC_TRANSITION 1U
 #define MX_CDC_LINEAR_TRANSITION 0U
 #define MX_CDC_VIOLATION_INNER_EDGE 2U
 #define MX_CDC_VIOLATION_SHORT_PATH 1U
 #define MX_CDC_NO_COUNTER_VIOLATION 0U
 #define MX_CDC_SPD_ON_TCP 1U
 #define MX_CDC_SPD_ON_CONTOUR 0U
 #define MX_CDC_RIGHT 1U
 #define MX_CDC_LEFT 0U
 #define MX_MODE_IN_SW_ENDS 1073741824U
 #define MX_MODE_POS_DIR 536870912U
 #define MX_MODE_NEG_DIR 268435456U
 #define MX_MODE_RIGHT2 131072U
 #define MX_MODE_LEFT2 65536U
 #define MX_MODE_HOMOGENEOUS 32768U
 #define MX_MODE_HETEROGENEOUS 16384U
 #define MX_MODE_CONCAVE3 8192U
 #define MX_MODE_CONVEX3 4096U
 #define MX_MODE_CONCAVE2 2048U
 #define MX_MODE_CONVEX2 1024U
 #define MX_MODE_INDIRECT 512U
 #define MX_MODE_DIRECT 256U
 #define MX_MODE_RIGHT 128U
 #define MX_MODE_LEFT 64U
 #define MX_MODE_NEGATIVE 32U
 #define MX_MODE_POSITIVE 16U
 #define MX_MODE_CONCAVE 8U
 #define MX_MODE_CONVEX 4U
 #define MX_MODE_BACK 2U
 #define MX_MODE_FRONT 1U
 #define MX_QUATERNION 8000U
 #define MX_TAIT_BRYAN_ANGLES 1U
 #define MX_NAUTICAL_ANGLES 1U
 #define MX_CARDAN_ANGLES 1U
 #define MX_EULER_ANGLES 1024U
 #define MX_INDIRECT_ANGLES 32768U
 #define MX_DIRECT_ANGLES 16384U
 #define MX_NEGATIVE_ANGLES 8192U
 #define MX_POSITIVE_ANGLES 4096U
 #define MX_EULER_ZYZ_ANGLES 2048U
 #define MX_EULER_ZXZ_ANGLES 1024U
 #define MX_EULER_YZY_ANGLES 512U
 #define MX_EULER_YXY_ANGLES 256U
 #define MX_EULER_XZX_ANGLES 128U
 #define MX_EULER_XYX_ANGLES 64U
 #define MX_EULER_ZYX_ANGLES 32U
 #define MX_CARDAN_ZYX_ANGLES 32U
 #define MX_EULER_ZXY_ANGLES 16U
 #define MX_CARDAN_ZXY_ANGLES 16U
 #define MX_EULER_YZX_ANGLES 8U
 #define MX_CARDAN_YZX_ANGLES 8U
 #define MX_EULER_YXZ_ANGLES 4U
 #define MX_CARDAN_YXZ_ANGLES 4U
 #define MX_EULER_XZY_ANGLES 2U
 #define MX_CARDAN_XZY_ANGLES 2U
 #define MX_EULER_XYZ_ANGLES 1U
 #define MX_CARDAN_XYZ_ANGLES 1U
 #define MX_TRANS_ROUND 3U
 #define MX_TRANS_ARC 2U
 #define MX_TRANS_ACCURATE 1U
 #define MX_TRANS_OFF 0U
/*Constant MX_FRM_ZERO not declared. Initialized constants from structured datatypes cannot be used in ANSI C programs / libraries. See Automation Help for details.*/

 #define MX_TRIGGER_HW_INPUT2 2U
 #define MX_TRIGGER_HW_INPUT1 1U
 #define MX_TRIGGER_NEGATIVE_EDGE 1U
 #define MX_TRIGGER_POSITIVE_EDGE 0U
 #define MX_TRIGGER_HW 0U
/*Constant MX_VEL_F100 not declared. Initialized constants from structured datatypes cannot be used in ANSI C programs / libraries. See Automation Help for details.*/

/*Constant MX_VEL_F500 not declared. Initialized constants from structured datatypes cannot be used in ANSI C programs / libraries. See Automation Help for details.*/

/*Constant MX_VEL_F1000 not declared. Initialized constants from structured datatypes cannot be used in ANSI C programs / libraries. See Automation Help for details.*/

/*Constant MX_VEL_F5000 not declared. Initialized constants from structured datatypes cannot be used in ANSI C programs / libraries. See Automation Help for details.*/

/*Constant MX_VEL_F10000 not declared. Initialized constants from structured datatypes cannot be used in ANSI C programs / libraries. See Automation Help for details.*/

/*Constant MX_VEL_F50000 not declared. Initialized constants from structured datatypes cannot be used in ANSI C programs / libraries. See Automation Help for details.*/

/*Constant MX_VEL_RAPID not declared. Initialized constants from structured datatypes cannot be used in ANSI C programs / libraries. See Automation Help for details.*/

 #define MX_VEL_MODE_TIME 2U
 #define MX_VEL_MODE_FEED 1U
 #define MX_VEL_MODE_RAPID 0U
#else
 #ifndef _GLOBAL_CONST
   #define _GLOBAL_CONST _WEAK const
 #endif
 _GLOBAL_CONST unsigned long MX_OFFSET_ERROR_TRF_FUN;
 _GLOBAL_CONST unsigned long MX_OFFSET_ERROR;
 _GLOBAL_CONST unsigned long MX_OFFSET_WARNING_TRF_FUN;
 _GLOBAL_CONST unsigned long MX_OFFSET_WARNING;
 _GLOBAL_CONST unsigned long MX_ERROR_TRF_INVALID_INPUTS;
 _GLOBAL_CONST unsigned long MX_ERROR_FCT_NOT_DEFINED;
 _GLOBAL_CONST unsigned long MX_ERROR_TRF_NOT_SUPPORTED;
 _GLOBAL_CONST unsigned long MX_ERROR_TRF_NOT_LICENSED;
 _GLOBAL_CONST unsigned long MX_ERROR_TRF_ERROR_AXES;
 _GLOBAL_CONST unsigned long MX_ERROR_INVALID_TRF_TYPE;
 _GLOBAL_CONST unsigned long MX_ERROR_UNKNOWN_ROBOT;
 _GLOBAL_CONST unsigned long MX_ERROR_TRF_GEN29_CMD_CODE;
 _GLOBAL_CONST unsigned long MX_ERROR_TRF_ANGLES_TYPE;
 _GLOBAL_CONST unsigned long MX_ERROR_TRF_MEASURE;
 _GLOBAL_CONST unsigned long MX_ERROR_TRF_CMD_CODE;
 _GLOBAL_CONST unsigned long MX_ERROR_TRF_LIB_NOT_SUPPORTED;
 _GLOBAL_CONST unsigned long MX_ERROR_WRONG_TRF_TYPE;
 _GLOBAL_CONST unsigned long MX_ERROR_WRONG_ROBOT;
 _GLOBAL_CONST unsigned long MX_ERROR_TRF_DATA_NOT_DEFINED;
 _GLOBAL_CONST unsigned long MX_ERROR_WRONG_ANGLE_TYPE;
 _GLOBAL_CONST unsigned long MX_WARNING_REF_POINT_ANGLES;
 _GLOBAL_CONST unsigned long MX_WARNING_AXES;
 _GLOBAL_CONST unsigned long MX_OK;
 _GLOBAL_CONST unsigned long MX_TRF_TYPE_DIRECT3;
 _GLOBAL_CONST unsigned long MX_TRF_TYPE_DIRECT2;
 _GLOBAL_CONST unsigned long MX_TRF_TYPE_DIRECT;
 _GLOBAL_CONST unsigned long MX_TRF_TYPE_INVERSE3;
 _GLOBAL_CONST unsigned long MX_TRF_TYPE_INVERSE2;
 _GLOBAL_CONST unsigned long MX_TRF_TYPE_INVERSE;
 _GLOBAL_CONST unsigned long MX_CDC_ARC_TO_LINE;
 _GLOBAL_CONST unsigned long MX_CDC_NO_ARC_TO_LINE;
 _GLOBAL_CONST unsigned long MX_CDC_ENTRY_INDIRECT;
 _GLOBAL_CONST unsigned long MX_CDC_ENTRY_DIRECT;
 _GLOBAL_CONST unsigned long MX_CDC_ENTRY_BLOCK;
 _GLOBAL_CONST unsigned long MX_CDC_ARC_TRANSITION;
 _GLOBAL_CONST unsigned long MX_CDC_LINEAR_TRANSITION;
 _GLOBAL_CONST unsigned long MX_CDC_VIOLATION_INNER_EDGE;
 _GLOBAL_CONST unsigned long MX_CDC_VIOLATION_SHORT_PATH;
 _GLOBAL_CONST unsigned long MX_CDC_NO_COUNTER_VIOLATION;
 _GLOBAL_CONST unsigned long MX_CDC_SPD_ON_TCP;
 _GLOBAL_CONST unsigned long MX_CDC_SPD_ON_CONTOUR;
 _GLOBAL_CONST unsigned long MX_CDC_RIGHT;
 _GLOBAL_CONST unsigned long MX_CDC_LEFT;
 _GLOBAL_CONST unsigned long MX_MODE_IN_SW_ENDS;
 _GLOBAL_CONST unsigned long MX_MODE_POS_DIR;
 _GLOBAL_CONST unsigned long MX_MODE_NEG_DIR;
 _GLOBAL_CONST unsigned long MX_MODE_RIGHT2;
 _GLOBAL_CONST unsigned long MX_MODE_LEFT2;
 _GLOBAL_CONST unsigned long MX_MODE_HOMOGENEOUS;
 _GLOBAL_CONST unsigned long MX_MODE_HETEROGENEOUS;
 _GLOBAL_CONST unsigned long MX_MODE_CONCAVE3;
 _GLOBAL_CONST unsigned long MX_MODE_CONVEX3;
 _GLOBAL_CONST unsigned long MX_MODE_CONCAVE2;
 _GLOBAL_CONST unsigned long MX_MODE_CONVEX2;
 _GLOBAL_CONST unsigned long MX_MODE_INDIRECT;
 _GLOBAL_CONST unsigned long MX_MODE_DIRECT;
 _GLOBAL_CONST unsigned long MX_MODE_RIGHT;
 _GLOBAL_CONST unsigned long MX_MODE_LEFT;
 _GLOBAL_CONST unsigned long MX_MODE_NEGATIVE;
 _GLOBAL_CONST unsigned long MX_MODE_POSITIVE;
 _GLOBAL_CONST unsigned long MX_MODE_CONCAVE;
 _GLOBAL_CONST unsigned long MX_MODE_CONVEX;
 _GLOBAL_CONST unsigned long MX_MODE_BACK;
 _GLOBAL_CONST unsigned long MX_MODE_FRONT;
 _GLOBAL_CONST unsigned long MX_QUATERNION;
 _GLOBAL_CONST unsigned long MX_TAIT_BRYAN_ANGLES;
 _GLOBAL_CONST unsigned long MX_NAUTICAL_ANGLES;
 _GLOBAL_CONST unsigned long MX_CARDAN_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_ANGLES;
 _GLOBAL_CONST unsigned long MX_INDIRECT_ANGLES;
 _GLOBAL_CONST unsigned long MX_DIRECT_ANGLES;
 _GLOBAL_CONST unsigned long MX_NEGATIVE_ANGLES;
 _GLOBAL_CONST unsigned long MX_POSITIVE_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_ZYZ_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_ZXZ_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_YZY_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_YXY_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_XZX_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_XYX_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_ZYX_ANGLES;
 _GLOBAL_CONST unsigned long MX_CARDAN_ZYX_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_ZXY_ANGLES;
 _GLOBAL_CONST unsigned long MX_CARDAN_ZXY_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_YZX_ANGLES;
 _GLOBAL_CONST unsigned long MX_CARDAN_YZX_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_YXZ_ANGLES;
 _GLOBAL_CONST unsigned long MX_CARDAN_YXZ_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_XZY_ANGLES;
 _GLOBAL_CONST unsigned long MX_CARDAN_XZY_ANGLES;
 _GLOBAL_CONST unsigned long MX_EULER_XYZ_ANGLES;
 _GLOBAL_CONST unsigned long MX_CARDAN_XYZ_ANGLES;
 _GLOBAL_CONST unsigned long MX_TRANS_ROUND;
 _GLOBAL_CONST unsigned long MX_TRANS_ARC;
 _GLOBAL_CONST unsigned long MX_TRANS_ACCURATE;
 _GLOBAL_CONST unsigned long MX_TRANS_OFF;

 _GLOBAL_CONST unsigned short MX_TRIGGER_HW_INPUT2;
 _GLOBAL_CONST unsigned short MX_TRIGGER_HW_INPUT1;
 _GLOBAL_CONST unsigned short MX_TRIGGER_NEGATIVE_EDGE;
 _GLOBAL_CONST unsigned short MX_TRIGGER_POSITIVE_EDGE;
 _GLOBAL_CONST unsigned short MX_TRIGGER_HW;







 _GLOBAL_CONST unsigned long MX_VEL_MODE_TIME;
 _GLOBAL_CONST unsigned long MX_VEL_MODE_FEED;
 _GLOBAL_CONST unsigned long MX_VEL_MODE_RAPID;
#endif




/* Datatypes and datatypes of function blocks */
typedef struct MXOrientationType
{	unsigned long Type;
	double Angle[4];
} MXOrientationType;

typedef struct MXPositionType
{	double x;
	double y;
	double z;
} MXPositionType;

typedef struct MXFrameType
{	struct MXPositionType Pos;
	struct MXOrientationType Orient;
} MXFrameType;

typedef struct MXToolType
{	unsigned long Index;
	struct MXFrameType Frame;
	double Radius;
} MXToolType;

typedef struct MXConfigType
{	unsigned long Mode;
} MXConfigType;

typedef double MXRotAxisType[6];

typedef double MXAuxAxisType[15];

typedef struct MXPointType
{	struct MXPositionType Pos;
	struct MXOrientationType Orient;
	struct MXConfigType Cfg;
	MXRotAxisType RotAxis;
	MXAuxAxisType AuxAxis;
} MXPointType;

typedef struct MXPathTransType
{	double Radius;
	unsigned long Type;
} MXPathTransType;

typedef struct MXPathDescType
{	struct MXPathTransType Trans;
} MXPathDescType;

typedef struct MXOptMotType
{	plcbit Enable;
	unsigned char VelPathDef;
	unsigned char RobotPar;
	unsigned char Limits;
} MXOptMotType;

typedef struct MXDynamicDescType
{	double Accel;
	double Decel;
	struct MXOptMotType Optmot;
} MXDynamicDescType;

typedef struct MXHWTrigType
{	unsigned char Source;
	unsigned char Index;
} MXHWTrigType;

typedef struct MXSWTrigType
{	plcstring Expression[65];
} MXSWTrigType;

typedef struct MXTriggConfigType
{	unsigned short Type;
	struct MXHWTrigType HWTrig;
	struct MXSWTrigType SWTrig;
	unsigned char Edge;
	unsigned char ResidPath;
} MXTriggConfigType;

typedef struct MXVelocityType
{	double v;
	unsigned long Mode;
} MXVelocityType;

typedef double MXJointAxisType[6];

typedef double MXBaseAxisType[6];

typedef struct MXAxisTargetType
{	MXJointAxisType JointAxis;
	MXAuxAxisType AuxAxis;
	MXBaseAxisType BaseAxis;
} MXAxisTargetType;

typedef struct MXCDCType
{	double ArcTransSpd;
	unsigned long SpdMode;
	unsigned long ContourViolation;
	unsigned long TransMode;
	unsigned char EntryMode;
	plcbit AcrToLine;
} MXCDCType;

typedef struct MXAutoTangType
{	double Offset;
} MXAutoTangType;

typedef struct MXHWTriggerType
{	unsigned short Source;
	unsigned short Index;
} MXHWTriggerType;

typedef struct MXTriggerConfigType
{	unsigned short Type;
	unsigned short Edge;
	struct MXHWTriggerType HWTrigger;
} MXTriggerConfigType;



/* Prototyping of functions and function blocks */
_BUR_PUBLIC unsigned long MXPointToJointEx1(unsigned long AddrTrfData, struct MXPointType* Point, MXJointAxisType Joint, unsigned long TrfType, struct MXToolType* Tool, struct MXFrameType* BaseFrame, double RefJoint[6]);
_BUR_PUBLIC unsigned long MXPointToJointEx(unsigned long AddrTrfData, struct MXPointType* Point, MXJointAxisType Joint, unsigned long TrfType, struct MXToolType* Tool, struct MXFrameType* BaseFrame, MXJointAxisType RefJoint);
_BUR_PUBLIC unsigned long MXJointToPointEx1(unsigned long AddrTrfData, MXJointAxisType Joint, struct MXPointType* Point, unsigned long AnglesType, unsigned long TrfType, struct MXToolType* Tool, struct MXFrameType* BaseFrame, double RefPath[6]);
_BUR_PUBLIC unsigned long MXJointToPointEx(unsigned long AddrTrfData, MXJointAxisType Joint, struct MXPointType* Point, unsigned long AnglesType, unsigned long TrfType, struct MXToolType* Tool, struct MXFrameType* BaseFrame, struct MXPointType* RefPoint);
_BUR_PUBLIC unsigned long MXCncAxesToPoint(unsigned long AddrTrfData, double Axis[15], struct MXPointType* Point, unsigned long TrfType, unsigned long AnglesType, unsigned short AxisMapCode[15], unsigned short AxisMapIdx[15], unsigned long ActiveAxesCount);
_BUR_PUBLIC unsigned long MXFromOrient(struct MXOrientationType* Orient, double Matrix[9]);
_BUR_PUBLIC unsigned long MXToOrient(double Matrix[9], unsigned long Type, struct MXOrientationType* Orient, double RefAngle[3]);
_BUR_PUBLIC unsigned long MXConvertOrient(struct MXOrientationType* OrientIn, unsigned long Type, struct MXOrientationType* OrientOut, double RefAngle[3]);
_BUR_PUBLIC unsigned long MXFrameRotX(struct MXFrameType* Frame, double Angle);
_BUR_PUBLIC unsigned long MXFrameRotY(struct MXFrameType* Frame, double Angle);
_BUR_PUBLIC unsigned long MXFrameRotZ(struct MXFrameType* Frame, double Angle);
_BUR_PUBLIC unsigned long MXFrameEuler(struct MXFrameType* Frame, double Phi, double Theta, double Psi);
_BUR_PUBLIC unsigned long MXFrameRPY(struct MXFrameType* Frame, double Roll, double Pitch, double Yaw);
_BUR_PUBLIC unsigned long MXFrameTrans(struct MXFrameType* Frame, double DistanceX, double DistanceY, double DistanceZ);
_BUR_PUBLIC unsigned long MXFrameTransX(struct MXFrameType* Frame, double Distance);
_BUR_PUBLIC unsigned long MXFrameTransY(struct MXFrameType* Frame, double Distance);
_BUR_PUBLIC unsigned long MXFrameTransZ(struct MXFrameType* Frame, double Distance);
_BUR_PUBLIC unsigned long MXFrameApply(struct MXFrameType* Frame1, struct MXFrameType* Frame2);
_BUR_PUBLIC unsigned long MXFromFrame(struct MXFrameType* Frame, struct MXPointType* PointIn, struct MXPointType* PointOut);
_BUR_PUBLIC unsigned long MXToFrame(struct MXFrameType* Frame, struct MXPointType* PointIn, struct MXPointType* PointOut);


#ifdef __cplusplus
};
#endif
#endif /* _ARNC0MX_ */

