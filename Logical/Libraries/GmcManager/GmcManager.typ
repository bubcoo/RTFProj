TYPE
	(*Enum types*)

	MCBufferModeEnum :
	(
		mcABORTING, (*Default mode with no buffering. The function block aborts an active movement. The buffer is cleared.*)
		mcBUFFERED 	(*The movement is started as soon as the previous movement is completed. No smoothing is applied.*)
	);

	MCCoordinateSystemEnum :
	(
		mcACS := 0,	(*Axis coordinate system*)
		mcMCS := 1,	(*Machine coordinate system*)
		mcPCS := 2,	(*Product coordinate system*)
		mcSCS1 := 3,	(*System coordinate system 1*)
		mcSCS2 := 4,	(*System coordinate system 2*)
		mcSCS3 := 5,	(*System coordinate system 3*)
		mcSCS4 := 6,	(*System coordinate system 4*)
		mcSCS5 := 7,	(*System coordinate system 5*)
		mcJACS := 100	(*Joint axis coordinate system*)
	);

	MCDirectionEnum :
	(
		mcDIR_POSITIVE,	(*positive direction*)
		mcDIR_NEGATIVE,	(*negative direction*)
		mcDIR_CURRENT,	(*current direction*)
		mcDIR_SHORTEST_WAY,		(*shortest way*)
		mcDIR_EXCEED_PERIOD := 8	(*exceed period*)
	);

	MCErrorCommandEnum :
	(
		mcWARNING_CMD := 0, (*a warning is generated*)
		mcERROR_CMD, (*Generates an error*)
		mcERROR_STOP_CMD, (*Generates an error and stops.*)
		mcERROR_STOP_CTRL_OFF_CMD, (*an axis error is generated on the drive, any active movement is aborted and the controller is switched off*)
		mcERROR_V_STOP_CTRL_OFF_CMD (*an axis error is generated on the drive, any active movement is ended with a speed ramp and controller is switched off*)
	);


	MCExecutionModeEnum :
	(
		mcEM_IMMEDIATELY,	(*The function is executed immediately.*)
		mcEM_QUEUED			(*The function is executed with a buffer.*)
	);

	MCGroupOperationModeEnum :
	(
		mcOM_M1_STOP, (*Optional stop*)
		mcOM_FEED_FORWARD, (*Feed forward*)
		mcOM_OPTMOT (*Jerk-limiting trajectory planner*)
	);

	MCUnloadProgramModeEnum :
	(
		mcUPRG_NAME, (*Unload program by name*)
		mcUPGR_ALL (*Unload all programs*)
	);

	MCHomingModeEnum :
	(
		mcHOMING_DIRECT := 0,			(*Direct homing*)
		mcHOMING_SWITCH_GATE,			(*Homing with reference gate*)
		mcHOMING_ABSOLUTE_SWITCH,		(*Performs homing with absolute reference switch*)
		mcHOMING_LIMIT_SWITCH := 4,	    (*Homing with hardware limit switch*)
		mcHOMING_ABSOLUTE,				(*Homing by setting the homing offset*)
		mcHOMING_DCM := 7,				(*Homing using interval-encoded reference marks*)
		mcHOMING_BLOCK_TORQUE := 9,	    (*Performs homing to mechanical limit, torque as criteria*)
		mcHOMING_BLOCK_LAG_ERROR := 10,	(*Performs homing to mechanical limit, lag error as criteria*)
		mcHOMING_ABSOLUTE_CORRECTION := 133, (*Homing by setting the homing offset with counting range correction*)
		mcHOMING_DCM_CORRECTION := 135,	(*Homing using distance-coded reference marks with counting range correction*)
		mcHOMING_DEFAULT := 140,		(*Applies all parameters from the configuration*)
		mcHOMING_INIT,					(*init*)
		mcHOMING_RESTORE_POSITION		(*Restores position from permanent memory*)
	);

	MCHomingOrderSourceEnum :
	(
		mcHO_CONFIGURATION := 0,	(*Uses the homing order configured in the configuration*)
		mcHO_FUNCTIONBLOCK			(*Uses the homing order configured in the function block*)
	);

	MCInterpolationModeEnum :
	(
		mcIPLM_OFF,						(*interpolation off*)
		mcIPLM_LINEAR,					(*linear interpolation*)
		mcIPLM_QUADRATIC,				(*quadratic interpolation*)
		mcIPLM_QUADRATIC_NO_OVERSHOOT	(*quadratic interpolation without overshoot*)
	);

	MCOverrideEnum :
	(
		mcOVERRIDE_VELOCITY,			(*Speed override*)
		mcOVERRIDE_VELOCITY_AXIS,		(*Axis speed override*)
		mcOVERRIDE_ACCELERATION,		(*Acceleration override*)
		mcOVERRIDE_ACCELERATION_AXIS,	(*Axis acceleration override*)
		mcOVERRIDE_JERK,				(*Jerk override*)
		mcOVERRIDE_FEEDRATE := 10,		(*Feed override*)
		mcOVERRIDE_RAPID,				(*Rapid motion override*)
		mcOVERRIDE_SPINDLE,				(*Spindle override*)
		mcOVERRIDE_TIMESTRETCH := 20	(*Time stretch override*)
	);

	MCPlcopenParameterEnum :
	(
		mcPAR_COMMANDED_AX_POSITION := 1, 	(*Commanded position*)
		mcPAR_SW_LIMIT_POSITIVE,		(*Positive software limit*)
		mcPAR_SW_LIMIT_NEGATIVE,		(*Negative software limit*)
		mcPAR_ENABLE_LIMIT_POSITIVE,	(*Enable positive software limit switch*)
		mcPAR_ENABLE_LIMIT_NEGATIVE,	(*Enable negative software limit switch*)
		mcPAR_ENABLE_POS_LAG_MONITORING,	(*Enable monitoring of position lag*)
		mcPAR_MAX_AX_POSITION_LAG,		(*Maximum position lag*)
		mcPAR_MAX_AX_VELOCITY_SYSTEM,	(*Maximum velocity of the axis in the system*)
		mcPAR_MAX_AX_VELOCITY_APPL,		(*Maximum velocity of the axis in the application*)
		mcPAR_ACTUAL_AX_VELOCITY,  		(*Actual velocity of the axis*)
		mcPAR_COMMANDED_AX_VELOCITY,	(*Commanded velocity*)
		mcPAR_MAX_AX_ACCELERATION_SYSTEM,	(*Maximum acceleration of the axis in the system*)
		mcPAR_MAX_AX_ACCELERATION_APPL,	(*Maximum acceleration of the axis in the application*)
		mcPAR_MAX_AX_DECELERATION_SYSTEM,	(*Maximum deceleration of the axis in the system*)
		mcPAR_MAX_AX_DECELERATION_APPL,	(*Maximum deceleration of the axis in the application*)
		mcPAR_MAX_AX_JERK,			(*Maximum jerk of the axis*)
		mcPAR_AX_PERIOD := 1008,    (*Period of the axis*)
		mcPAR_HOMING_OFFSET := 1019, 	(*Homing offset of the axis*)
		mcPAR_AX_MEASUREMENT_RESOLUTION := 1020  (*Measurement resolution of the axis*)
	);

	MCNetworkTypeEnum :
	(
		mcNETWORK_POWERLINK	(*ETHERNET POWERLINK protocol*)
	);

	MCPrgInfoInterruptEnum :
	(
		mcINTERRUPT_NOT_INTERRUPTED,	(*The program has not been interrupted.*)
		mcINTERRUPT_SINGLESTEP,			(*The program has been interrupted by activation of single-step mode.*)
		mcINTERRUPT_FB,					(*The program has been interrupted by the "MC_GroupInterrupt" function block.*)
		mcINTERRUPT_INTERPRETER,		(*The program has been interrupted by an interpreter halt (G170).*)
		mcINTERRUPT_MFUNCTION,			(*The program has been interrupted by a blocking M-code.*)
		mcINTERRUPT_PROGRAM				(*The program has been interrupted by a programmed command.*)
	);

	MCRestartModeEnum :
	(
	   	mcRSM_ABORT_LINE,		(*Restart at abort line*)
		mcRSM_PATH_DISTANCE,	(*Restart at path distance*)
		mcRSM_BLOCK_NUMBER,		(*Restart at block number*)
		mcRSM_LINE_NUMBER,		(*Restart at line number*)
		mcRSM_TOOL_NUMBER,		(*Restart at tool number*)
		mcRSM_LABEL				(*Restart at label*)
	);

	MCRestartPhaseEnum :
	(
		mcRSP_INACTIVE,
		mcRSP_VALIDATE_PLAY_BACK_DATA,
		mcRSP_WAIT_START_AXES_REPOS,
		mcRSP_AXES_REPOSITIONING,
		mcRSP_WAIT_RESTART_PROGRAM,
		mcRSP_RUN_PROGRAM,
		mcRSP_PROGRAM_FINISHED
	);

	MCSimulationCommandEnum :
	(
		mcSIMULATION_SW_OFF,	(*simulation off*)
		mcSIMULATION_SW_ON		(*motor simulation*)
	);

	MCSwitchEnum :
	(
		mcSWITCH_STATE_OFF,		(*off*)
		mcSWITCH_STATE_ON		(*on*)
	);

	MCToolPointEnum :
	(
		mcTP_FLANGE, (*Flange*)
		mcTP_TOOL_CENTER_POINT, (*Tool center point*)
		mcTP_TOOL_CUT_POINT (*Tool cut point*)
	);

	MCTransitionModeEnum :
	(
		mcTM_NONE		(*No transition is applied*)
	);

	MCValueSourceEnum :
	(
		mcVALUE_SET, 					(*Set position is used*)
		mcVALUE_ACTUAL,					(*Actual position is used*)
		mcVALUE_SET_AXIS_UNITS,			(*Set position in axis units is used*)
		mcVALUE_ACTUAL_AXIS_UNITS,		(*Actual position in axis units is used*)
		mcVALUE_AUTOMATIC_SELECTION			(*Mode only for ReadCyclicPosition: use the value depending on the ctrl mode*)
	);

	MCEdgeEnum :
	(
		mcEDGE_POSITIVE,				(*change from logical low to logical high*)
		mcEDGE_NEGATIVE					(*change from logical high to logical low*)
	);

	MCBrakeCommandEnum :
	(
		mcBRAKE_CLOSE,					(*close brake*)
		mcBRAKE_OPEN,					(*open brake*)
		mcBRAKE_GET_STATUS				(*show status of brake*)
	);

	MCBrakeStatusEnum :
	(
		mcBRAKE_STATUS_NOT_PROVIDED,			(*command was not mcBRAKE_GET_STATUS*)
		mcBRAKE_CLOSED,					(*holding brake closed*)
		mcBRAKE_OPENED					(*holding brake open*)
	);




	(*Structure types*)

	MCAdditionalGroupHome_15_Type : STRUCT
		HomingOrderSource : MCHomingOrderSourceEnum;	(*Source of the homing order*)
    	HomingOrder : ARRAY[0..14] OF UINT;				(*Specifies the homing order (see HomingOrder) The array is in ACS order.*)
	END_STRUCT;

	MCAdditionalStatusType : STRUCT
		TriggerSwitch1 : BOOL;
		TriggerSwitch2 : BOOL;
		DriveEnableSwitch : BOOL;
		ResetDone : BOOL;
		LagWarning : BOOL;
	END_STRUCT;

	MCAdvancedMoveCycParType : STRUCT
		Velocity : REAL;
		Acceleration : REAL;
		Deceleration : REAL;
		DisableJoltLimitation : BOOL;
	END_STRUCT;

	MCAdvancedVelCtrlParType : STRUCT
		Acceleration : REAL;
		Deceleration : REAL;
	END_STRUCT;

	MCAdvancedGearInParType : STRUCT
		MasterMaxVelocity : REAL;
	END_STRUCT;

	MCFrameOrientationType : STRUCT
		Type : UDINT;		(*Describes the representation of rotation angles 1 to 3*)
		Angle1 : LREAL;		(*Rotation angle 1 for describing the orientation*)
		Angle2 : LREAL;		(*Rotation angle 2 for describing the orientation*)
		Angle3 : LREAL;		(*Rotation angle 3 for describing the orientation*)
	END_STRUCT;

	MCFramePositionType : STRUCT
		X : LREAL;		(*Offset in the direction of the X-axis*)
		Y : LREAL;		(*Offset in the direction of the Y-axis*)
		Z : LREAL;		(*Offset in the direction of the Z-axis*)
	END_STRUCT;

	MCFrameType : STRUCT
		Trans : MCFramePositionType;	(*Position*)
		Rot : MCFrameOrientationType;	(*Orientation*)
	END_STRUCT;

	MCKinematicTrfType : UDINT;

	MCPrgInfoActiveProgramType : STRUCT 		(*Informations about the active program*)
		Name : STRING[260];						(*Name of the active program*)
		Number : UDINT;							(*Number of the active program*)
		Level : UINT;							(*Current program level*)
	END_STRUCT;

	MCPrgInfoBlockMonType : STRUCT (*Block monitor*)
		LineNumber : UDINT;				(*Current line number*)
		BlockNumber : UDINT;			(*Current block number*)
		LineLast2 : STRING[260];		(*Second to last line in the sequence program*)
		LineLast1 : STRING[260];		(*Last line in the sequence program*)
		LineActual : STRING[260];		(*Current line in the sequence program*)
		LineNext1 : STRING[260];		(*Next line in the sequence program*)
		LineNext2 : STRING[260];		(*Line following the next line in the sequence program*)
		RemainingDistance : LREAL;		(*Distance remaining until the end of the block [units]*)
		Length : LREAL;					(*Length of the path of the current block [units]*)
		LengthNext : LREAL;				(*Length of the path of the next block [units]*)
	END_STRUCT;

	MCPrgInfoPrgHierarchyLevelType : STRUCT  (*Program Hierarchy Levels*)
		LineNumber : UDINT;				(*Current level line number*)
	END_STRUCT;

	MCPrgInfoPrgHierarchyType : STRUCT (*Program Hierarchy*)
		Level : ARRAY[0..14] OF MCPrgInfoPrgHierarchyLevelType; (*Program Hierarchy Levels*)
	END_STRUCT;

	MCPrgInfoType : STRUCT (*The structure contains extended information about the running program*)
		InitProgram : STRING[260];						(*Name of the initialization subroutine*)
		ActiveProgram : MCPrgInfoActiveProgramType;		(*Information about the active program*)
		InterruptStatus : MCPrgInfoInterruptEnum;		(*Interrupt informations*)
		BlockMonitor : MCPrgInfoBlockMonType;			(*Block monitor*)
		ProgramHierarchy : MCPrgInfoPrgHierarchyType;	(*Program Hierarchy*)
	END_STRUCT;

	MCTrackPathLimitsType : STRUCT (*Tracking path limit parameters*)
		Velocity : LREAL; 			(*Maximum path speed*)
		Acceleration : LREAL; 		(*Maximum path acceleration*)
		Deceleration : LREAL; 		(*Maximum path deceleration*)
		Jerk : LREAL; 				(*Maximum path jerk*)
	END_STRUCT;

	MCWorkspaceType : UDINT;	(*Function blocks with the input MCWorkspaceType receive a pointer to a STRING, which contains the name of the CNC program with the workspace definition.*)
	MCFFCtrlParType : UDINT;	(*Function blocks with the input MCFFCtrlParType receive a pointer to a parameter structure.*)

	(*FB internals*)
	FubProcessing_csub : STRUCT (*Partial struct type (C only)*)
		states : ARRAY[0..1] OF DINT;
	END_STRUCT;

	TaskInteraction : FubProcessing_csub;

	MCInternalType : STRUCT (*internal variable*)
		ID : UDINT;
		Check : UDINT;
		ParamHash : UDINT;
		State : WORD;
		Error : UINT;
		Treating : REFERENCE TO TaskInteraction;
		Memory : ARRAY[0..13] OF UDINT;
		if_addr : UDINT;
	END_STRUCT;

	MCInternalTwoRefType : STRUCT (*internal variable*)
		ID : UDINT;
		Check : UDINT;
		ParamHash : UDINT;
		State : WORD;
		Error : UINT;
		Treating : REFERENCE TO TaskInteraction;
		Memory : ARRAY[0..13] OF UDINT;
		if_addr : UDINT;
		if_ma_addr : UDINT;
	END_STRUCT;

	IGmcAxisIf_csub : STRUCT (*Partial interface type (C only)*)
		vtable : DWORD;
	END_STRUCT;

	IGmcAxisIf : IGmcAxisIf_csub;

	GmcAxis : STRUCT
		controlif : REFERENCE TO IGmcAxisIf;
	END_STRUCT;

	IGmcAxesGrpIf_csub : STRUCT (*Partial interface type (C only)*)
		vtable : DWORD;
	END_STRUCT;
	IGmcAxesGrpIf : IGmcAxesGrpIf_csub;
	GmcAxesGroup : STRUCT
		controlif : REFERENCE TO IGmcAxesGrpIf;
	END_STRUCT;

	IGmcLLMIf_csub : STRUCT (*Partial interface type (C only)*)
		vtable : DWORD;
	END_STRUCT;
	IGmcLLMIf : IGmcLLMIf_csub;
	GmcLLMAssembly : STRUCT
		controlif : REFERENCE TO IGmcLLMIf;
	END_STRUCT;

	IGmcLLMSegIf_csub : STRUCT (*Partial interface type (C only)*)
		vtable : DWORD;
	END_STRUCT;
	IGmcLLMSegIf : IGmcLLMSegIf_csub;
	GmcLLMSegment : STRUCT
		controlif : REFERENCE TO IGmcLLMSegIf;
	END_STRUCT;

	IGmcLLMSectorIf_csub : STRUCT (*Partial interface type (C only)*)
		vtable : DWORD;
	END_STRUCT;
	IGmcLLMSectorIf : IGmcLLMSectorIf_csub;
	GmcLLMSector : STRUCT
		controlif : REFERENCE TO IGmcLLMSectorIf;
	END_STRUCT;

END_TYPE
