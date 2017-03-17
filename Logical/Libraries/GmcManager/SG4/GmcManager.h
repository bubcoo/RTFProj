/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _GMCMANAGER_
#define _GMCMANAGER_

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#if defined(_WIN32) || defined(__WINDOWS__) || defined(__MINGW32__) || defined(__CYGWIN__)
#if defined(BUILD_GMCMANAGER) || defined(GMCMANAGER_EXPORTS)
#define GMCMANAGER_DLLAPI __declspec(dllexport)
#else
#define GMCMANAGER_DLLAPI __declspec(dllimport)
#endif
#else /* not Windows */
#define GMCMANAGER_DLLAPI _BUR_PUBLIC
#endif

/** @cond NO */
#ifdef	__cplusplus
#define TYPEDEF_FORWARD_GMC_CLASS(ClassName) \
	namespace Gmc { class ClassName; } \
	typedef ::Gmc::ClassName
#define TYPEDEF_FORWARD_GMC_STRUCT(StructName) \
	namespace Gmc { struct StructName; } \
	typedef ::Gmc::StructName

#ifndef _COMMONIF_MOTIONTYPES_DECLARED_
/**
 * Forward declaration of (internal) C++ - interface types or ...
 */
TYPEDEF_FORWARD_GMC_CLASS(TaskMediator) TaskInteraction;
TYPEDEF_FORWARD_GMC_CLASS(IAxisIf) IGmcAxisIf;
TYPEDEF_FORWARD_GMC_CLASS(IAxesGrpIf) IGmcAxesGrpIf;
TYPEDEF_FORWARD_GMC_CLASS(AssemblyIf) IGmcLLMIf;
TYPEDEF_FORWARD_GMC_CLASS(SegmentIf) IGmcLLMSegIf;
TYPEDEF_FORWARD_GMC_CLASS(SectorIf) IGmcLLMSectorIf;
//TYPEDEF_FORWARD_GMC_CLASS(ShuttleIf) IGmcLLMShuttleIf;
#endif
/**
 *  ... declaration of a comparatively equivalent C structure type.
 */
#else	/*< not C++ >:O */
#if !defined(__STDC__) || defined(__STRICT_ANSI__)
#define TYPEDEF_PSEUDO_GMC_CSTRUCT(StructName, Content) \
	typedef struct StructName Content
#else
#define TYPEDEF_PSEUDO_GMC_CSTRUCT(StructName, Content) \
	struct StructName; typedef struct StructName
#endif
TYPEDEF_PSEUDO_GMC_CSTRUCT(FubProcessing_csub, { long states[2]; }) TaskInteraction;
TYPEDEF_PSEUDO_GMC_CSTRUCT(IGmcAxisIf_csub, { plcdword vtable; }) IGmcAxisIf;
TYPEDEF_PSEUDO_GMC_CSTRUCT(IGmcAxesGrpIf_csub, { plcdword vtable; }) IGmcAxesGrpIf;
TYPEDEF_PSEUDO_GMC_CSTRUCT(IGmcLLMIf_csub, { plcdword vtable; }) IGmcLLMIf;
TYPEDEF_PSEUDO_GMC_CSTRUCT(IGmcLLMSegIf_csub, { plcdword vtable; }) IGmcLLMSegIf;
TYPEDEF_PSEUDO_GMC_CSTRUCT(IGmcLLMSectorIf_csub, { plcdword vtable; }) IGmcLLMSectorIf;
//TYPEDEF_PSEUDO_GMC_CSTRUCT(IGmcLLMShuttleIf_csub, { plcdword vtable; }) IGmcLLMShuttleIf;
#endif	/*< end plain C */
/** @endcond */

/* Datatypes and datatypes of function blocks */
typedef enum MCBufferModeEnum
{
	mcABORTING,
	mcBUFFERED
} MCBufferModeEnum;

typedef enum MCCoordinateSystemEnum
{
	mcACS = 0,
	mcMCS = 1,
	mcPCS = 2,
	mcSCS1 = 3,
	mcSCS2 = 4,
	mcSCS3 = 5,
	mcSCS4 = 6,
	mcSCS5 = 7,
	mcJACS = 100,
} MCCoordinateSystemEnum;

typedef enum MCDirectionEnum
{
	mcDIR_POSITIVE,
	mcDIR_NEGATIVE,
	mcDIR_CURRENT,
	mcDIR_SHORTEST_WAY,
	mcDIR_EXCEED_PERIOD = 8
} MCDirectionEnum;

typedef enum MCErrorCommandEnum
{
	mcWARNING_CMD = 0,
	mcERROR_CMD,
	mcERROR_STOP_CMD,
	mcERROR_STOP_CTRL_OFF_CMD,
	mcERROR_V_STOP_CTRL_OFF_CMD
} MCErrorCommandEnum;

typedef enum MCExecutionModeEnum
{
	mcEM_IMMEDIATELY,
	mcEM_QUEUED
} MCExecutionModeEnum;

typedef enum MCGroupOperationModeEnum
{
	mcOM_M1_STOP,
	mcOM_FEED_FORWARD,
	mcOM_OPTMOT
} MCGroupOperationModeEnum;

typedef enum MCUnloadProgramModeEnum
{
	mcUPRG_NAME,
	mcUPRG_ALL
} MCUnloadProgramModeEnum;

typedef enum MCHomingModeEnum
{
	mcHOMING_DIRECT = 0,
	mcHOMING_SWITCH_GATE,
	mcHOMING_ABSOLUTE_SWITCH,
	mcHOMING_LIMIT_SWITCH = 4,
	mcHOMING_ABSOLUTE,
	mcHOMING_DCM = 7,
	mcHOMING_BLOCK_TORQUE = 9,
	mcHOMING_BLOCK_LAG_ERROR = 10,
	mcHOMING_ABSOLUTE_CORRECTION = 133,
	mcHOMING_DCM_CORRECTION = 135,
	mcHOMING_DEFAULT = 140,
	mcHOMING_INIT,
	mcHOMING_RESTORE_POSITION
} MCHomingModeEnum;

typedef enum MCHomingOrderSourceEnum
{
	mcHO_CONFIGURATION = 0,
	mcHO_FUNCTIONBLOCK
} MCHomingOrderSourceEnum;

typedef enum MCInterpolationModeEnum
{
	mcIPLM_OFF,
	mcIPLM_LINEAR,
	mcIPLM_QUADRATIC,
	mcIPLM_QUADRATIC_NO_OVERSHOOT
} MCInterpolationModeEnum;

typedef enum MCOverrideEnum
{
	mcOVERRIDE_VELOCITY,
	mcOVERRIDE_VELOCITY_AXIS,
	mcOVERRIDE_ACCELERATION,
	mcOVERRIDE_ACCELERATION_AXIS,
	mcOVERRIDE_JERK,
	mcOVERRIDE_FEEDRATE = 10,
	mcOVERRIDE_RAPID,
	mcOVERRIDE_SPINDLE,
	mcOVERRIDE_TIMESTRETCH = 20
} MCOverrideEnum;

typedef enum MCPlcopenParameterEnum
{
	mcPAR_COMMANDED_AX_POSITION = 1,
	mcPAR_SW_LIMIT_POSITIVE,
	mcPAR_SW_LIMIT_NEGATIVE,
	mcPAR_ENABLE_LIMIT_POSITIVE,
	mcPAR_ENABLE_LIMIT_NEGATIVE,
	mcPAR_ENABLE_POS_LAG_MONITORING,
	mcPAR_MAX_AX_POSITION_LAG,
	mcPAR_MAX_AX_VELOCITY_SYSTEM,
	mcPAR_MAX_AX_VELOCITY_APPL,
	mcPAR_ACTUAL_AX_VELOCITY,
	mcPAR_COMMANDED_AX_VELOCITY,
	mcPAR_MAX_AX_ACCELERATION_SYSTEM,
	mcPAR_MAX_AX_ACCELERATION_APPL,
	mcPAR_MAX_AX_DECELERATION_SYSTEM,
	mcPAR_MAX_AX_DECELERATION_APPL,
	mcPAR_MAX_AX_JERK,
	mcPAR_AX_PERIOD = 1008,
	mcPAR_HOMING_OFFSET = 1019,
	mcPAR_AX_MEASUREMENT_RESOLUTION = 1020
} MCPlcopenParameterEnum;

typedef enum MCNetworkTypeEnum
{
	mcNETWORK_POWERLINK
} MCNetworkTypeEnum;

typedef enum MCPrgInfoInterruptEnum
{
	mcINTERRUPT_NOT_INTERRUPTED,
	mcINTERRUPT_SINGLESTEP,
	mcINTERRUPT_FB,
	mcINTERRUPT_INTERPRETER,
	mcINTERRUPT_MFUNCTION,
	mcINTERRUPT_PROGRAM
} MCPrgInfoInterruptEnum;

typedef enum MCRestartModeEnum
{
	mcRSM_ABORT_LINE,
	mcRSM_PATH_DISTANCE,
	mcRSM_BLOCK_NUMBER,
	mcRSM_LINE_NUMBER,
	mcRSM_TOOL_NUMBER,
	mcRSM_LABEL
} MCRestartModeEnum;

typedef enum MCRestartPhaseEnum
{
	mcRSP_INACTIVE,
	mcRSP_VALIDATE_PLAY_BACK_DATA,
	mcRSP_WAIT_START_AXES_REPOS,
	mcRSP_AXES_REPOSITIONING,
	mcRSP_WAIT_RESTART_PROGRAM,
	mcRSP_RUN_PROGRAM,
	mcRSP_PROGRAM_FINISHED
} MCRestartPhaseEnum;

typedef enum MCSimulationCommandEnum
{
	mcSIMULATION_SW_OFF,
	mcSIMULATION_SW_ON
} MCSimulationCommandEnum;

typedef enum MCSwitchEnum
{
	mcSWITCH_STATE_OFF,
	mcSWITCH_STATE_ON
} MCSwitchEnum;

typedef enum MCToolPointEnum
{
	mcTP_FLANGE,
	mcTP_TOOL_CENTER_POINT,
	mcTP_TOOL_CUT_POINT
} MCToolPointEnum;

typedef enum MCTransitionModeEnum
{
	mcTM_NONE
} MCTransitionModeEnum;

typedef enum MCValueSourceEnum
{
	mcVALUE_SET,
	mcVALUE_ACTUAL,
	mcVALUE_SET_AXIS_UNITS,
	mcVALUE_ACTUAL_AXIS_UNITS,
	mcVALUE_AUTOMATIC_SELECTION
} MCValueSourceEnum;

typedef enum MCEdgeEnum
{
	mcEDGE_POSITIVE,
	mcEDGE_NEGATIVE
} MCEdgeEnum;

typedef enum MCBrakeCommandEnum
{
	mcBRAKE_CLOSE,
	mcBRAKE_OPEN,
	mcBRAKE_GET_STATUS
} MCBrakeCommandEnum;

typedef enum MCBrakeStatusEnum
{
	mcBRAKE_STATUS_NOT_PROVIDED,
	mcBRAKE_CLOSED,
	mcBRAKE_OPENED
} MCBrakeStatusEnum;

typedef struct MCAdditionalGroupHome_15_Type
{
	enum MCHomingOrderSourceEnum HomingOrderSource;
	unsigned short HomingOrder[15];
} MCAdditionalGroupHome_15_Type;

typedef struct MCAdditionalStatusType
{
	plcbit TriggerSwitch1;
	plcbit TriggerSwitch2;
	plcbit DriveEnableSwitch;
	plcbit ResetDone;
	plcbit LagWarning;
} MCAdditionalStatusType;

typedef struct MCAdvancedMoveCycParType
{
	float Velocity;
	float Acceleration;
	float Deceleration;
	plcbit DisableJoltLimitation;
} MCAdvancedMoveCycParType;

typedef struct MCAdvancedVelCtrlParType
{
	float Acceleration;
	float Deceleration;
} MCAdvancedVelCtrlParType;

typedef struct MCAdvancedGearInParType
{
	float MasterMaxVelocity;
} MCAdvancedGearInParType;

typedef struct MCFrameOrientationType
{
	unsigned long Type;
	double Angle1;
	double Angle2;
	double Angle3;
} MCFrameOrientationType;

typedef struct MCFramePositionType
{
	double X;
	double Y;
	double Z;
} MCFramePositionType;

typedef struct MCFrameType
{
	struct MCFramePositionType Trans;
	struct MCFrameOrientationType Rot;
} MCFrameType;

typedef struct MCPrgInfoActiveProgramType
{
	plcstring Name[261];
	unsigned long Number;
	unsigned short Level;
} MCPrgInfoActiveProgramType;

typedef struct MCPrgInfoBlockMonType
{
	unsigned long LineNumber;
	unsigned long BlockNumber;
	plcstring LineLast2[261];
	plcstring LineLast1[261];
	plcstring LineActual[261];
	plcstring LineNext1[261];
	plcstring LineNext2[261];
	double RemainingDistance;
	double Length;
	double LengthNext;
} MCPrgInfoBlockMonType;

typedef struct MCPrgInfoPrgHierarchyLevelType
{
	unsigned long LineNumber;
} MCPrgInfoPrgHierarchyLevelType;

typedef struct MCPrgInfoPrgHierarchyType
{
	struct MCPrgInfoPrgHierarchyLevelType Level[15];
} MCPrgInfoPrgHierarchyType;

typedef struct MCPrgInfoType
{
	plcstring InitProgram[261];
	struct MCPrgInfoActiveProgramType ActiveProgram;
	enum MCPrgInfoInterruptEnum InterruptStatus;
	struct MCPrgInfoBlockMonType BlockMonitor;
	struct MCPrgInfoPrgHierarchyType ProgramHierarchy;
} MCPrgInfoType;

typedef struct MCTrackPathLimitsType
{
	double Velocity;
	double Acceleration;
	double Deceleration;
	double Jerk;
} MCTrackPathLimitsType;


struct GmcAxis; /*FORWARD-DECLARATION*/
struct GmcAxesGroup;
struct GmcLLMAssembly;
struct GmcLLMSegment;
struct GmcLLMSector;
//struct GmcLLMShuttle;

typedef struct MCInternalType
{
	unsigned long ID;
	unsigned long Check;
	unsigned long ParamHash;
	plcword State;
	unsigned short Error;
	TaskInteraction* Treating;
	unsigned long Memory[14];
#if !(defined(__cplusplus) || defined(_GMCMANAGER_HPP_INCLUDED_))
	unsigned long if_addr;
#else
	union
	{
		GmcAxis 		*Axis;
		GmcAxesGroup 	*AxesGroup;
		GmcLLMAssembly 	*LLMAssembly;
		GmcLLMSegment 	*LLMSegment;
		GmcLLMSector 	*LLMSector;
//		GmcLLMShuttle 	*LLMShuttle;
	};
#endif
} MCInternalType;



#if !(defined(__cplusplus) || defined(_GMCMANAGER_HPP_INCLUDED_))
typedef struct MCInternalTwoRefType
{
	unsigned long ID;
	unsigned long Check;
	unsigned long ParamHash;
	plcword State;
	unsigned short Error;
	TaskInteraction* Treating;
	unsigned long Memory[14];
	unsigned long if_addr;
	unsigned long if_ma_addr;
}MCInternalTwoRefType;
#else
typedef struct MCInternalTwoRefType : public MCInternalType
{
	union
	{
		GmcAxis 		*Master;
		GmcAxesGroup 	*MasterGroup;
		GmcLLMAssembly 	*MasterLLMAssembly;
		GmcLLMSegment 	*MasterLLMSegment;
		GmcLLMSector 	*MasterLLMSector;
//		GmcLLMShuttle 	*MasterLLMShuttle;
	};
}MCInternalTwoRefType;
#endif

#ifndef _GMCMANAGER_HPP_INCLUDED_
typedef struct GmcAxis
{
	IGmcAxisIf* controlif;
} GmcAxis;

typedef struct GmcAxesGroup
{
	IGmcAxesGrpIf* controlif;
} GmcAxesGroup;

typedef struct GmcLLMAssembly
{
	IGmcLLMIf* controlif;
} GmcLLMAssembly;

typedef struct GmcLLMSegment
{
	IGmcLLMSegIf* controlif;
} GmcLLMSegment;

typedef struct GmcLLMSector
{
	IGmcLLMSectorIf* controlif;
} GmcLLMSector;

//typedef struct GmcLLMShuttle
//{
//	IGmcLLMShuttleIf* controlif;
//} GmcLLMShuttle;
#endif

typedef unsigned long MCKinematicTrfType;

typedef unsigned long MCWorkspaceType;

typedef unsigned long MCFFCtrlParType;

/* Prototyping of functions and function blocks */
#ifdef __cplusplus
extern "C" {
#endif

GMCMANAGER_DLLAPI
unsigned short GmcManagerInit(signed long sysInitPhase);

#ifdef __cplusplus
} // End of C-Linkage
#endif
#endif /* _GMCMANAGER_ */

