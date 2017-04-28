
TYPE
	PositionStatus : 
		(
		PosCalcPos, (*1*)
		PosInitial
		);
	Stuct_OptSensInternal : 	STRUCT 
		Index : ARRAY[0..4]OF USINT;
		DetRot_ModulOK_0 : DetectionRotation;
		DetPos_Figure_0 : DetPos_Figure;
		MinAccDiff : INT := 100;
		MaxAccDiff : ARRAY[0..3]OF INT := [4(100)];
		CurrentPosition : ARRAY[0..3]OF INT;
	END_STRUCT;
	Stuct_RexlSensInternal : 	STRUCT 
		IndexR : ARRAY[0..1]OF USINT;
	END_STRUCT;
END_TYPE
