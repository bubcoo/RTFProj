FUNCTION grpApiInit : UINT
	VAR_INPUT
		sysInitPhase : DINT;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK MC_BR_ConditionalStop (*This FB returns the status and can deactive/reactivate the conditional stop with identifier.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*Reference to a group of axes.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		Identifier : UDINT; (*Conditional Stop Identifier.*)
		Deactivate : BOOL; (*Deactivates a Conditional Stop / continues a interrupted program.*)
		Reactivate : BOOL; (*Reactivates a Conditional Stop (optional).*)
	END_VAR
	VAR_OUTPUT
		Valid : BOOL; (*True if outputs are valid.*)
		Busy : BOOL; (*The FB is not finished.*)
		Error : BOOL; (*Signals that an error has occurred within the FB.*)
		ErrorID : DINT; (*Error identification.*)
		Programmed : BOOL; (*Conditional Stop is programmed (ip synch).*)
		Activated : BOOL; (*Conditional Stop will interrupt the movement.*)
		Interrupting : BOOL; (*Conditional Stop causes the interrupt of the movement.*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_DefineConveyorBelt (*Define a new conveyor belt mechanics for tracking.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		ConveyorAxis : REFERENCE TO MCGroupAxisType; (*The conveyor belt axis reference establishes the connection between the function block and a conveyor belt axis.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		CoordSystem : MCCoordinateSystemEnum ; (*Reference coordinate system for the position and orientation description of the conveyor belt.*)
		TransX : LREAL; (*Translatory offset in direction X.*)
		TransY : LREAL; (*Translatory offset in direction Y.*)
		TransZ : LREAL; (*Translatory offset in direction Z.*)
		RotAngle1 : LREAL; (*Orientation angle 1.*)
		RotAngle2 : LREAL; (*Orientation angle 2.*)
		RotAngle3 : LREAL; (*Orientation angle 3.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		MechId : UDINT; (*Identifier for the new defined mechanics.*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_DeleteMechanics (*Delete a mechanics for tracking.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		MechId : UDINT; (*Identifier of the defined mechanics.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupAxisJogAbsolute (*Executes movements with an axis from the group as long as the "Jog" input is set. *)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		IndexInCoordSystem : UINT; (*Index of the axis in the coordinate system*)
		CoordSystem : MCCoordinateSystemEnum; (*Selected coordinate system (see Coordinate systems)*)
		Position : LREAL; (*Target position for the movement [application units]*)
		Velocity : REAL; (*Maximum velocity [application units/s]*)
		Acceleration : REAL; (*Maximum acceleration [application units/s]*)
		Deceleration : REAL; (*Maximum deceleration [application units/s淫*)
		Jerk : REAL; (*Maximum jerk [application units/s設*)
		VelocityInSpace : ARRAY[0..9] OF REAL; (*Maximum velocity of the joint in space (see velocity limits of the joints in space).*)
		Jog : BOOL; (*Execution of the movement*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		Jogging : BOOL; (*Performing movement*)
		TargetReached : BOOL; (*Target position reached*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupAxisJogRelative (*Executes movements with an axis from the group as long as the "Jog" input is set.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		IndexInCoordSystem : UINT; (*Index of the axis in the coordinate system*)
		CoordSystem : MCCoordinateSystemEnum; (*Selected coordinate system (see Coordinate systems)*)
		Distance : LREAL; (*Target distance for the movement [application units]*)
		Velocity : REAL; (*Maximum velocity [application units/s]*)
		Acceleration : REAL; (*Maximum acceleration [application units/s]*)
		Deceleration : REAL; (*Maximum deceleration [application units/s淫*)
		Jerk : REAL; (*Maximum jerk [application units/s設*)
		VelocityInSpace : ARRAY[0..9] OF REAL; (*Maximum velocity of the joint in space (see velocity limits of the joints in space).*)
		Jog : BOOL; (*Execution of the movement*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		Jogging : BOOL; (*Performing movement*)
		TargetReached : BOOL; (*Target position reached*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupAxisJogVelocity (*Executes movements with an axis from the group as long as the "JogPositive" or "JogNegative" input is set.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		IndexInCoordSystem : UINT; (*Index of the axis in the coordinate system*)
		CoordSystem : MCCoordinateSystemEnum; (*Selected coordinate system (see Coordinate systems)*)
		Velocity : REAL; (*Maximum velocity [application units/s]*)
		Acceleration : REAL; (*Maximum acceleration [application units/s]*)
		Deceleration : REAL; (*Maximum deceleration [application units/s淫*)
		Jerk : REAL; (*Maximum jerk [application units/s設*)
		VelocityInSpace : ARRAY[0..9] OF REAL; (*Maximum velocity of the joint in space (see velocity limits of the joints in space).*)
		JogPositive : BOOL; (*Performs a movement in the positive direction.*)
		JogNegative : BOOL; (*Performs a movement in the negative direction.*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		Jogging : BOOL; (*Performing movement*)
		WorkspaceEnd : BOOL; (*End of workspace reached.*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupCommandError (*A group error can be set with this function block*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Command : MCErrorCommandEnum; (*Error command*)
		ExecutionMode : MCExecutionModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupHome_15 (*The group can be homed using the function block. Each axis is homed using the mode defined in the axis settings.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Position : ARRAY[0..14] OF LREAL; (*Array of positions in ACS order*)
		HomingMode : ARRAY[0..14] OF MCHomingModeEnum; (*Array of homing modes*)
		AdditionalParameters : MCAdditionalGroupHome_15_Type; (*Additional homing parameters*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupInitFFControl (*This function block sets parameters for feed forward control an the axes.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Parameter : MCFFCtrlParType; (*Feed forward control parameter.*)
		ExecutionMode : MCExecutionModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupJogAbsolute_15 (*Executes a movement to an absolute position in the selected coordinate system with n axes from the group as long as the "Jog" input is set.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		CoordSystem : MCCoordinateSystemEnum; (*Selected coordinate system (see Coordinate systems)*)
		Position : ARRAY[0..14] OF LREAL; (*Target position for the movement [application units]*)
		Velocity : ARRAY[0..14] OF REAL; (*Maximum velocity [application units/s]*)
		Acceleration : ARRAY[0..14] OF REAL; (*Maximum acceleration [application units/s]*)
		Deceleration : ARRAY[0..14] OF REAL; (*Maximum deceleration [application units/s淫*)
		Jerk : ARRAY[0..14] OF REAL; (*Maximum jerk [application units/s設*)
		VelocityInSpace : ARRAY[0..9] OF REAL; (*Maximum velocity of the joint in space (see velocity limits of the joints in space).*)
		Jog : BOOL; (*Execution of the movement*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		Jogging : BOOL; (*Performing movement*)
		TargetReached : BOOL; (*Target position reached*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupJogRelative_15 (*Executes a movement to a relative position in the selected coordinate system with n axes from the group as long as the "Jog" input is set.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		CoordSystem : MCCoordinateSystemEnum; (*Selected coordinate system (see Coordinate systems)*)
		Distance : ARRAY[0..14] OF LREAL; (*Movement distance [application units]*)
		Velocity : ARRAY[0..14] OF REAL; (*Maximum velocity [application units/s]*)
		Acceleration : ARRAY[0..14] OF REAL; (*Maximum acceleration [application units/s]*)
		Deceleration : ARRAY[0..14] OF REAL; (*Maximum deceleration [application units/s淫*)
		Jerk : ARRAY[0..14] OF REAL; (*Maximum jerk [application units/s設*)
		VelocityInSpace : ARRAY[0..9] OF REAL; (*Maximum velocity of the joint in space (see velocity limits of the joints in space).*)
		Jog : BOOL; (*Execution of the movement*)
	END_VAR
	VAR_OUTPUT
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		Jogging : BOOL; (*Performing movement*)
		TargetReached : BOOL; (*Target position reached*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupOperationMode (*This function block enables different operation modes of the axes group selected by the OperationMode input.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*Turns drive power stages on/off*)
		OperationMode : MCGroupOperationModeEnum; (*Operation Mode*)
	END_VAR
	VAR_OUTPUT
		Enabled : BOOL; (*Function block has been enabled and is active.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupPower (*Switches on/off the controllers of the axes in the axis group as well as the axis group itself.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*Turns drive power stages on/off*)
	END_VAR
	VAR_OUTPUT
		Status : BOOL; (*Indicates whether all axes in the group are on*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupReadInfo (*Returns the current cumulative status of the group.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
	END_VAR
	VAR_OUTPUT
		Valid : BOOL; (*Function block's output values can be used*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		CommunicationReady : BOOL; (*"Network" is initialized and ready for communication*)
		ReadyForPowerOn : BOOL; (*Controllers for all axes in the group are ready to be switched on*)
		PowerOn : BOOL; (*Controllers for all axes in the group are switched on*)
		IsHomed : BOOL; (*All axes in the group are homed*)
		GroupInterrupted : BOOL; (*Group movement interrupted by function block*)
		TrackedMovement : BOOL; (*A tracking movement is active*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupReadOverride (*Can be used to read the various axis group overrides.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		Type : MCOverrideEnum; (*Effect of override*)
	END_VAR
	VAR_OUTPUT
		Valid : BOOL; (*Function block's output values can be used*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		Factor : REAL; (*Override factor*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_GroupSetOverride (*Can be used to set the various overrides for the axes within the axis group. *)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		Type : MCOverrideEnum; (*Effect of override*)
		Factor : REAL; (*Override factor*)
	END_VAR
	VAR_OUTPUT
		Enabled : BOOL; (*Function block has been enabled and is active.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_MFunction (*Can be used to read and reset an individual MFunction.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		MFunction : UDINT; (*Code of the function*)
		Reset : BOOL; (*Resets the MFunction*)
	END_VAR
	VAR_OUTPUT
		Valid : BOOL; (*Function block's output values can be used*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		Value : BOOL; (*Current value of the MFunction*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_MoveBlock (*Starts a group movement according to the instructions on the function block's "Block" input.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Block : STRING[260]; (*Single instruction*)
		BufferMode : MCBufferModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
		TransitionMode : MCTransitionModeEnum; (*Defines the transition from the preceding function block.*)
		TransitionParameter : LREAL; (*Additional parameter for TransitionMode*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Active : BOOL; (*Indicates that the function block is currently controlling the axis group.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_MoveProgram (*A group movement program is started.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Name : STRING[260]; (*Program name*)
		BufferMode : MCBufferModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
		TransitionMode : MCTransitionModeEnum; (*Defines the transition from the preceding function block.*)
		TransitionParameter : LREAL; (*Additional parameter for TransitionMode*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Active : BOOL; (*Indicates that the function block is currently controlling the axis group.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_ProgramInfo (*Provides information about the program currently being executed.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
	END_VAR
	VAR_OUTPUT
		Valid : BOOL; (*Function block's output values can be used*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		Name : STRING[260]; (*Name of the active CNC program*)
		Number : UDINT; (*Number of the sequence program*)
		Position : LREAL; (*Current position on the path [units]*)
		Velocity : REAL; (*Current path speed [units / minute].*)
		Runtime : REAL; (*Elapsed time since the start of the current sequence program [seconds]*)
		Feedrate : REAL; (*Programmed feed rate [units / minute]*)
		ExtendedInfo : MCPrgInfoType; (*Extended program information*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_SetInitProgram (*Activates an init program.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Name : STRING[260]; (*Init programs*)
		ExecutionMode : MCExecutionModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_SetToolTable (*Activates a tool table stored on the controller.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Name : STRING[260]; (*Name of the tool table data object*)
		ToolNumber : UINT; (*Tool number that should be activated. Tool number 0 disables an active tool.*)
		ExecutionMode : MCExecutionModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_SetWorkspace (*Activates the work area monitoring function.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Workspace : MCWorkspaceType; (*Name of the workspace definition (given as a pointer).*)
		ExecutionMode : MCExecutionModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_SingleStep (*Activates single-step mode for an axis group.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		ModuleName : STRING[260]; (*Name of the motion chain module.*)
		Continue : BOOL; (*An interrupted motor chain module is continued.*)
	END_VAR
	VAR_OUTPUT
		Enabled : BOOL; (*Function block has been enabled and is active.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		Interrupted : BOOL; (*The motion chain module is interrupted.*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_TrackObject(*Track a object moving on a defined mechanics.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		MechId : UDINT; (*Identifier for the new defined mechanics.*)
		MechPos : LREAL; (*Latched position of the mechanics, where the object is valid. The mechanics position must be specified in axis units.*)
		BufferMode : MCBufferModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
		TransX : LREAL; (*Translatory offset in direction X.*)
		TransY : LREAL; (*Translatory offset in direction Y.*)
		TransZ : LREAL; (*Translatory offset in direction Z.*)
		RotAngle1 : LREAL; (*Orientation angle 1.*)
		RotAngle2 : LREAL; (*Orientation angle 2.*)
		RotAngle3 : LREAL; (*Orientation angle 3.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Active : BOOL; (*Indicates that the function block is currently controlling the axis group.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		InSync : BOOL; (*Movement of the axis group is synchronized with the conveyor belt.*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_BR_UnloadProgram (*Release the memory of loaded programs.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Name : STRING[260]; (*Program name*)
		Mode : MCUnloadProgramModeEnum; (*Defines which programs should be unloaded.*) 
		ExecutionMode : MCExecutionModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_GroupContinue (*A halted group movement is resumed.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_GroupDisable (*Changes the group's state to GroupDisabled*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_GroupEnable (*This function block changes the state of the group from GroupDisabled to GroupStandby*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_GroupHome (*The group can be homed using the function block. Each axis is homed using the mode defined in the axis settings.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_GroupInterrupt (*A group movement is halted.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_GroupReadActualPosition_15 (*Provides the current positions of the group with respect to the selected coordinate system. *)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		CoordSystem : MCCoordinateSystemEnum ; (*Selected coordinate system (see Coordinate systems)*)
	END_VAR
	VAR_OUTPUT
		Valid : BOOL; (*Function block's output values can be used*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		Position : ARRAY[0..14] OF LREAL; (*Current position in the specified coordinate system (see Coordinate systems)*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_GroupReadError (*This function block can be used to read the number (ID) of the actual pending group error.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
		ReadNext : BOOL; (*At a rising edge the next AxisErrorID is displayed if available. If no AxisErrorID is pending the value "0" is displayed at the output.*)
	END_VAR
	VAR_OUTPUT
		Valid : BOOL; (*Function block's output values can be used*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		GroupErrorID : DINT; (*Group error number*)
		RecordID : UDINT; (*Identification to the entry inside the EventLog-System*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_GroupReadStatus (*Provides the current status (see State diagram) of the group.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Enable : BOOL; (*The function block is active as long as this input is set.*)
	END_VAR
	VAR_OUTPUT
		Valid : BOOL; (*Function block's output values can be used*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
		GroupMoving : BOOL; (*State of the group (see State diagram)*)
		GroupHoming : BOOL; (*State of the group (see State diagram)*)
		GroupErrorStop : BOOL; (*State of the group (see State diagram)*)
		GroupStandby : BOOL; (*State of the group (see State diagram)*)
		GroupStopping : BOOL; (*State of the group (see State diagram)*)
		GroupDisabled : BOOL; (*State of the group (see State diagram)*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_GroupReset (*Takes the group out of GroupErrorStop and acknowledges all group errors.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_GroupStop (*The function block stops the group.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_MoveDirectAbsolute_15 (*Executes an interpolated direct absolute movement.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Position : ARRAY[0..14] OF LREAL; (*Array[0..N-1] of absolute end positions in every dimension of the selected coordinate system.*)
		Velocity : REAL; (*Maximum velocity [application units/s]*)
		Acceleration : REAL; (*Maximum acceleration [application units/s]*)
		Deceleration : REAL; (*Maximum deceleration [application units/s淫*)
		Jerk : REAL; (*Maximum jerk [application units/s設*)
		CoordSystem : MCCoordinateSystemEnum; (*Selected coordinate system (see Coordinate systems)*)
		BufferMode : MCBufferModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
		TransitionMode : MCTransitionModeEnum; (*Defines the transition from the preceding function block.*)
		TransitionParameter : LREAL; (*Additional parameter for TransitionMode*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Active : BOOL; (*Indicates that the function block is currently controlling the axis group.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_MoveDirectRelative_15 (*This function block commands a movement of an axes group to a relative position without taking care of how (on which path) the target position is reached.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Distance : ARRAY[0..14] OF LREAL; (*Array[0..N-1] of relative distances in every dimension of the selected coordinate system.*)
		Velocity : REAL; (*Maximum velocity [application units/s]*)
		Acceleration : REAL; (*Maximum acceleration [application units/s]*)
		Deceleration : REAL; (*Maximum deceleration [application units/s淫*)
		Jerk : REAL; (*Maximum jerk [application units/s設*)
		CoordSystem : MCCoordinateSystemEnum; (*Selected coordinate system (see Coordinate systems)*)
		BufferMode : MCBufferModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
		TransitionMode : MCTransitionModeEnum; (*Defines the transition from the preceding function block.*)
		TransitionParameter : LREAL; (*Additional parameter for TransitionMode*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Active : BOOL; (*Indicates that the function block is currently controlling the axis group.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_MoveLinearAbsolute_15 (*Executes an interpolated linear absolute movement.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Position : ARRAY[0..14] OF LREAL; (*Array[0..N-1] of absolute end positions in every dimension of the selected coordinate system.*)
		Velocity : REAL; (*Maximum velocity [application units/s]*)
		Acceleration : REAL; (*Maximum acceleration [application units/s]*)
		Deceleration : REAL; (*Maximum deceleration [application units/s淫*)
		Jerk : REAL; (*Maximum jerk [application units/s設*)
		CoordSystem : MCCoordinateSystemEnum; (*Selected coordinate system (see Coordinate systems)*)
		BufferMode : MCBufferModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
		TransitionMode : MCTransitionModeEnum; (*Defines the transition from the preceding function block.*)
		TransitionParameter : LREAL; (*Additional parameter for TransitionMode*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Active : BOOL; (*Indicates that the function block is currently controlling the axis group.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK MC_MoveLinearRelative_15 (*Executes an interpolated linear relative movement.*)
	VAR_INPUT
		AxesGroup : REFERENCE TO MCAxesGroupType; (*The axis group reference establishes the connection between the function block and the axis group.*)
		Execute : BOOL; (*Execution of the function block begins on a rising edge of this input.*)
		Distance : ARRAY[0..14] OF LREAL; (*Array[0..N-1] of relative distances in every dimension of the selected coordinate system.*)
		Velocity : REAL; (*Maximum velocity [application units/s]*)
		Acceleration : REAL; (*Maximum acceleration [application units/s]*)
		Deceleration : REAL; (*Maximum deceleration [application units/s淫*)
		Jerk : REAL; (*Maximum jerk [application units/s設*)
		CoordSystem : MCCoordinateSystemEnum; (*Selected coordinate system (see Coordinate systems)*)
		BufferMode : MCBufferModeEnum; (*Defines the chronological order of the function block and the preceding function block.*)
		TransitionMode : MCTransitionModeEnum; (*Defines the transition from the preceding function block.*)
		TransitionParameter : LREAL; (*Additional parameter for TransitionMode*)
	END_VAR
	VAR_OUTPUT
		Done : BOOL; (*Execution successful. Function block is finished.*)
		Busy : BOOL; (*Function block is active and must continue to be called.*)
		Active : BOOL; (*Indicates that the function block is currently controlling the axis group.*)
		CommandAborted : BOOL; (*Command aborted by another command.*)
		Error : BOOL; (*Execution error*)
		ErrorID : DINT; (*Error number*)
	END_VAR
	VAR
		Internal : MCInternalType;
	END_VAR
END_FUNCTION_BLOCK