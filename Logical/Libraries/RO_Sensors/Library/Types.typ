
TYPE
	PositionStatus : 
		(
		PosEnabled, (*0*)
		PosCalcPos, (*1*)
		PosInitial
		);
	RotationStatus : 
		(
		RotEnabled, (*0*)
		RotWatchPos, (*1*)
		RotSensError,
		RotInitial
		);
	Stuct_OptSensInternal : 	STRUCT 
		Index : ARRAY[0..4]OF USINT;
		State : PositionStatus;
		DetRot_ModulOK_0 : DetectionRotation;
		DetPos_Figure_0 : DetPos_Figure;
		CurrentPosition : ARRAY[0..3]OF REAL;
	END_STRUCT;
	Stuct_RexlSensInternal : 	STRUCT 
		IndexR : ARRAY[0..1]OF USINT;
		StateR : RotationStatus;
	END_STRUCT;
END_TYPE
