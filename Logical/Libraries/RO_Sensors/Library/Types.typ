
TYPE
	PositionStatus : 
		(
		PosEnabled, (*0*)
		PosCalcPos, (*1*)
		PosSensError,
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
		Index : ARRAY[0..1]OF BOOL;
		State : PositionStatus;
		CurrentPosition : ARRAY[0..3]OF REAL;
	END_STRUCT;
	Stuct_RexlSensInternal : 	STRUCT 
		IndexR : ARRAY[0..1]OF BOOL;
		StateR : RotationStatus;
	END_STRUCT;
END_TYPE
