/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _GMCGRPAPI_
#define _GMCGRPAPI_

#ifndef _GMCMANAGER_
#include <GmcManager.h>
#endif
#ifndef _PLCTYPES_H_
#include <bur/plctypes.h>
#endif

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#if defined(_WIN32) || defined(__WINDOWS__) || defined(__MINGW32__) || defined(__CYGWIN__)
#if defined(BUILD_GMCGRPAPI)
#define DECLSPEC_GMCGRPAPI __declspec(dllexport)
#else
#define DECLSPEC_GMCGRPAPI __declspec(dllimport)
#endif
#else	/* not Windows */
#define DECLSPEC_GMCGRPAPI _BUR_PUBLIC
#endif

/* Datatypes and datatypes of function blocks */
typedef GmcAxesGroup MCAxesGroupType;

typedef struct MC_BR_ConditionalStop
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	unsigned long Identifier;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Deactivate;
	plcbit Reactivate;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
	plcbit Programmed;
	plcbit Activated;
	plcbit Interrupting;
} MC_BR_ConditionalStop_typ;

typedef GmcAxis MCGroupAxisType;

typedef struct MC_BR_DefineConveyorBelt
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCGroupAxisType* ConveyorAxis;
	MCCoordinateSystemEnum CoordSystem;
	double TransX;
	double TransY;
	double TransZ;
	double RotAngle1;
	double RotAngle2;
	double RotAngle3;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	unsigned long MechId;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_DefineConveyorBelt_typ;

typedef struct MC_BR_DeleteMechanics
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	unsigned long MechId;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_BR_DeleteMechanics_typ;

typedef struct MC_BR_GroupAxisJogAbsolute
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	unsigned short IndexInCoordSystem;
	MCCoordinateSystemEnum CoordSystem;
	double Position;
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	float VelocityInSpace[10];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Jog;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
	plcbit Jogging;
	plcbit TargetReached;
} MC_BR_GroupAxisJogAbsolute_typ;

typedef struct MC_BR_GroupAxisJogRelative
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	unsigned short IndexInCoordSystem;
	MCCoordinateSystemEnum CoordSystem;
	double Distance;
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	float VelocityInSpace[10];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Jog;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
	plcbit Jogging;
	plcbit TargetReached;
} MC_BR_GroupAxisJogRelative_typ;

typedef struct MC_BR_GroupAxisJogVelocity
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	unsigned short IndexInCoordSystem;
	MCCoordinateSystemEnum CoordSystem;
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	float VelocityInSpace[10];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit JogPositive;
	plcbit JogNegative;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
	plcbit Jogging;
	plcbit WorkspaceEnd;
} MC_BR_GroupAxisJogVelocity_typ;

typedef struct MC_BR_GroupCommandError
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCErrorCommandEnum Command;
	MCExecutionModeEnum ExecutionMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_GroupCommandError_typ;

typedef struct MC_BR_GroupHome_15
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	double Position[15];
	MCHomingModeEnum HomingMode[15];
	MCAdditionalGroupHome_15_Type AdditionalParameters;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_GroupHome_15_typ;

typedef struct MC_BR_GroupInitFFControl
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCFFCtrlParType Parameter;
	MCExecutionModeEnum ExecutionMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_GroupInitFFControl_typ;

typedef struct MC_BR_GroupJogAbsolute_15
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCCoordinateSystemEnum CoordSystem;
	double Position[15];
	float Velocity[15];
	float Acceleration[15];
	float Deceleration[15];
	float Jerk[15];
	float VelocityInSpace[10];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Jog;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
	plcbit Jogging;
	plcbit TargetReached;
} MC_BR_GroupJogAbsolute_15_typ;

typedef struct MC_BR_GroupJogRelative_15
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCCoordinateSystemEnum CoordSystem;
	double Distance[15];
	float Velocity[15];
	float Acceleration[15];
	float Deceleration[15];
	float Jerk[15];
	float VelocityInSpace[10];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Jog;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
	plcbit Jogging;
	plcbit TargetReached;
} MC_BR_GroupJogRelative_15_typ;

typedef struct MC_BR_GroupJogVelocity_15
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCCoordinateSystemEnum CoordSystem;
	float Velocity[15];
	float Acceleration[15];
	float Deceleration[15];
	float Jerk[15];
	float VelocityInSpace[10];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Jog;
	/* VAR_OUTPUT (digital) */
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
	plcbit Jogging;
	plcbit WorkspaceEnd;
} MC_BR_GroupJogVelocity_15_typ;

typedef struct MC_BR_GroupOperationMode
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCGroupOperationModeEnum OperationMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Enabled;
	plcbit Busy;
	plcbit Error;
} MC_BR_GroupOperationMode_typ;

typedef struct MC_BR_GroupPower
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Status;
	plcbit Busy;
	plcbit Error;
} MC_BR_GroupPower_typ;

typedef struct MC_BR_GroupReadInfo
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
	plcbit CommunicationReady;
	plcbit ReadyForPowerOn;
	plcbit PowerOn;
	plcbit IsHomed;
	plcbit GroupInterrupted;
	plcbit TrackedMovement;
} MC_BR_GroupReadInfo_typ;

typedef struct MC_BR_GroupReadOverride
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCOverrideEnum Type;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	float Factor;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_GroupReadOverride_typ;

typedef struct MC_BR_GroupReadSetPosition_15
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCCoordinateSystemEnum CoordSystem;
	MCToolPointEnum ToolPoint;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	double Position[15];
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_GroupReadSetPosition_15_typ;

typedef struct MC_BR_GroupSetOverride
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCOverrideEnum Type;
	float Factor;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Enabled;
	plcbit Busy;
	plcbit Error;
} MC_BR_GroupSetOverride_typ;

typedef struct MC_BR_MFunction
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	unsigned long MFunction;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Reset;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
	plcbit Value;
} MC_BR_MFunction_typ;

typedef struct MC_BR_MoveBlock
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	plcstring Block[261];
	MCBufferModeEnum BufferMode;
	MCTransitionModeEnum TransitionMode;
	double TransitionParameter;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_MoveBlock_typ;

typedef struct MC_BR_MoveProgram
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	plcstring Name[261];
	MCBufferModeEnum BufferMode;
	MCTransitionModeEnum TransitionMode;
	double TransitionParameter;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_MoveProgram_typ;

typedef struct MC_BR_ProgramInfo
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	plcstring Name[261];
	unsigned long Number;
	double Position;
	float Velocity;
	float Runtime;
	float Feedrate;
	struct MCPrgInfoType ExtendedInfo;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_BR_ProgramInfo_typ;

typedef struct MC_BR_RestartProgram
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	plcstring Name[261];
	MCRestartModeEnum Mode;
	double Parameter;
	unsigned long AdditionalParameter;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	MCRestartPhaseEnum RestartPhase;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	plcbit Continue;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
	plcbit WaitingForContinue;
} MC_BR_RestartProgram_typ;

typedef struct MC_BR_SetInitProgram
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	plcstring Name[261];
	MCExecutionModeEnum ExecutionMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_SetInitProgram_typ;

typedef struct MC_BR_SetToolTable
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	plcstring Name[261];
	unsigned short ToolNumber;
	MCExecutionModeEnum ExecutionMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_SetToolTable_typ;

typedef struct MC_BR_SetWorkspace
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCWorkspaceType Workspace;
	MCExecutionModeEnum ExecutionMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_SetWorkspace_typ;

typedef struct MC_BR_SingleStep
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	plcstring ModuleName[261];
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit Continue;
	/* VAR_OUTPUT (digital) */
	plcbit Enabled;
	plcbit Busy;
	plcbit Error;
	plcbit Interrupted;
} MC_BR_SingleStep_typ;

typedef struct MC_BR_TrackObject
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	unsigned long MechId;
	double MechPos;
	MCBufferModeEnum BufferMode;
	double TransX;
	double TransY;
	double TransZ;
	double RotAngle1;
	double RotAngle2;
	double RotAngle3;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
	plcbit InSync;
} MC_BR_TrackObject_typ;

typedef struct MC_BR_UnloadProgram
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	plcstring Name[261];
	MCUnloadProgramModeEnum Mode;
	MCExecutionModeEnum ExecutionMode;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_BR_UnloadProgram_typ;

typedef struct MC_GroupContinue
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_GroupContinue_typ;

typedef struct MC_GroupDisable
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_GroupDisable_typ;

typedef struct MC_GroupEnable
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_GroupEnable_typ;

typedef struct MC_GroupHome
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_GroupHome_typ;

typedef struct MC_GroupInterrupt
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_GroupInterrupt_typ;

typedef struct MC_GroupReadActualPosition_15
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	MCCoordinateSystemEnum CoordSystem;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	double Position[15];
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_GroupReadActualPosition_15_typ;

typedef struct MC_GroupReadError
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	signed long GroupErrorID;
	unsigned long RecordID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	plcbit ReadNext;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
} MC_GroupReadError_typ;

typedef struct MC_GroupReadStatus
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Enable;
	/* VAR_OUTPUT (digital) */
	plcbit Valid;
	plcbit Busy;
	plcbit Error;
	plcbit GroupMoving;
	plcbit GroupHoming;
	plcbit GroupErrorStop;
	plcbit GroupStandby;
	plcbit GroupStopping;
	plcbit GroupDisabled;
} MC_GroupReadStatus_typ;

typedef struct MC_GroupReset
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Error;
} MC_GroupReset_typ;

typedef struct MC_GroupStop
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit CommandAborted;
	plcbit Error;
} MC_GroupStop_typ;

typedef struct MC_MoveDirectAbsolute_15
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	double Position[15];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	MCCoordinateSystemEnum CoordSystem;
	MCBufferModeEnum BufferMode;
	MCTransitionModeEnum TransitionMode;
	double TransitionParameter;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_MoveDirectAbsolute_15_typ;

typedef struct MC_MoveDirectRelative_15
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	double Distance[15];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	MCCoordinateSystemEnum CoordSystem;
	MCBufferModeEnum BufferMode;
	MCTransitionModeEnum TransitionMode;
	double TransitionParameter;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_MoveDirectRelative_15_typ;

typedef struct MC_MoveLinearAbsolute_15
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	double Position[15];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	MCCoordinateSystemEnum CoordSystem;
	MCBufferModeEnum BufferMode;
	MCTransitionModeEnum TransitionMode;
	double TransitionParameter;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_MoveLinearAbsolute_15_typ;

typedef struct MC_MoveLinearRelative_15
{
	/* VAR_INPUT (analog) */
	MCAxesGroupType* AxesGroup;
	double Distance[15];
	float Velocity;
	float Acceleration;
	float Deceleration;
	float Jerk;
	MCCoordinateSystemEnum CoordSystem;
	MCBufferModeEnum BufferMode;
	MCTransitionModeEnum TransitionMode;
	double TransitionParameter;
	/* VAR_OUTPUT (analog) */
	signed long ErrorID;
	/* VAR (analog) */
	struct MCInternalType Internal;
	/* VAR_INPUT (digital) */
	plcbit Execute;
	/* VAR_OUTPUT (digital) */
	plcbit Done;
	plcbit Busy;
	plcbit Active;
	plcbit CommandAborted;
	plcbit Error;
} MC_MoveLinearRelative_15_typ;

/* Prototyping of functions and function blocks */
#ifdef __cplusplus
extern "C" {
#endif

_BUR_PUBLIC void MC_BR_ConditionalStop(struct MC_BR_ConditionalStop* inst);
_BUR_PUBLIC void MC_BR_DefineConveyorBelt(struct MC_BR_DefineConveyorBelt* inst);
_BUR_PUBLIC void MC_BR_DeleteMechanics(struct MC_BR_DeleteMechanics* inst);
_BUR_PUBLIC void MC_BR_GroupAxisJogAbsolute(struct MC_BR_GroupAxisJogAbsolute* inst);
_BUR_PUBLIC void MC_BR_GroupAxisJogRelative(struct MC_BR_GroupAxisJogRelative* inst);
_BUR_PUBLIC void MC_BR_GroupAxisJogVelocity(struct MC_BR_GroupAxisJogVelocity* inst);
_BUR_PUBLIC void MC_BR_GroupCommandError(struct MC_BR_GroupCommandError* inst);
_BUR_PUBLIC void MC_BR_GroupHome_15(struct MC_BR_GroupHome_15* inst);
_BUR_PUBLIC void MC_BR_GroupInitFFControl(struct MC_BR_GroupInitFFControl* inst);
_BUR_PUBLIC void MC_BR_GroupJogAbsolute_15(struct MC_BR_GroupJogAbsolute_15* inst);
_BUR_PUBLIC void MC_BR_GroupJogRelative_15(struct MC_BR_GroupJogRelative_15* inst);
_BUR_PUBLIC void MC_BR_GroupJogVelocity_15(struct MC_BR_GroupJogVelocity_15* inst);
_BUR_PUBLIC void MC_BR_GroupOperationMode(struct MC_BR_GroupOperationMode* inst);
_BUR_PUBLIC void MC_BR_GroupPower(struct MC_BR_GroupPower* inst);
_BUR_PUBLIC void MC_BR_GroupReadInfo(struct MC_BR_GroupReadInfo* inst);
_BUR_PUBLIC void MC_BR_GroupReadOverride(struct MC_BR_GroupReadOverride* inst);
_BUR_PUBLIC void MC_BR_GroupReadSetPosition_15(struct MC_BR_GroupReadSetPosition_15* inst);
_BUR_PUBLIC void MC_BR_GroupSetOverride(struct MC_BR_GroupSetOverride* inst);
_BUR_PUBLIC void MC_BR_MFunction(struct MC_BR_MFunction* inst);
_BUR_PUBLIC void MC_BR_MoveBlock(struct MC_BR_MoveBlock* inst);
_BUR_PUBLIC void MC_BR_MoveProgram(struct MC_BR_MoveProgram* inst);
_BUR_PUBLIC void MC_BR_ProgramInfo(struct MC_BR_ProgramInfo* inst);
_BUR_PUBLIC void MC_BR_RestartProgram(struct MC_BR_RestartProgram* inst);
_BUR_PUBLIC void MC_BR_SetInitProgram(struct MC_BR_SetInitProgram* inst);
_BUR_PUBLIC void MC_BR_SetToolTable(struct MC_BR_SetToolTable* inst);
_BUR_PUBLIC void MC_BR_SetWorkspace(struct MC_BR_SetWorkspace* inst);
_BUR_PUBLIC void MC_BR_SingleStep(struct MC_BR_SingleStep* inst);
_BUR_PUBLIC void MC_BR_TrackObject(struct MC_BR_TrackObject* inst);
_BUR_PUBLIC void MC_BR_UnloadProgram(struct MC_BR_UnloadProgram* inst);
_BUR_PUBLIC void MC_GroupContinue(struct MC_GroupContinue* inst);
_BUR_PUBLIC void MC_GroupDisable(struct MC_GroupDisable* inst);
_BUR_PUBLIC void MC_GroupEnable(struct MC_GroupEnable* inst);
_BUR_PUBLIC void MC_GroupHome(struct MC_GroupHome* inst);
_BUR_PUBLIC void MC_GroupInterrupt(struct MC_GroupInterrupt* inst);
_BUR_PUBLIC void MC_GroupReadActualPosition_15(struct MC_GroupReadActualPosition_15* inst);
_BUR_PUBLIC void MC_GroupReadError(struct MC_GroupReadError* inst);
_BUR_PUBLIC void MC_GroupReadStatus(struct MC_GroupReadStatus* inst);
_BUR_PUBLIC void MC_GroupReset(struct MC_GroupReset* inst);
_BUR_PUBLIC void MC_GroupStop(struct MC_GroupStop* inst);
_BUR_PUBLIC void MC_MoveDirectAbsolute_15(struct MC_MoveDirectAbsolute_15* inst);
_BUR_PUBLIC void MC_MoveDirectRelative_15(struct MC_MoveDirectRelative_15* inst);
_BUR_PUBLIC void MC_MoveLinearAbsolute_15(struct MC_MoveLinearAbsolute_15* inst);
_BUR_PUBLIC void MC_MoveLinearRelative_15(struct MC_MoveLinearRelative_15* inst);
_BUR_PUBLIC unsigned short grpApiInit(signed long sysInitPhase);

#ifdef __cplusplus
} // End of C-Linkage
#endif
#endif /* _GMCGRPAPI_ */

