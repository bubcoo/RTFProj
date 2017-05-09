
TYPE
	PositionStatus : 
		(
		PosCalcPos, (*1*)
		PosInitial
		);
	Stuct_OptSensInternal : 	STRUCT 
		TransConstant : ARRAY[0..3]OF INT;
		MaxPosHum : ARRAY[0..3]OF INT := [1025,1850,665,975];
		MinPosHum : ARRAY[0..3]OF INT := [-1025,-1850,-665,-975];
		RefPosHum : ARRAY[0..3]OF INT := [4(0)];
		MaxPosSens : ARRAY[0..3]OF INT := [26357,31402,29161,30516];
		MinPosSens : ARRAY[0..3]OF INT := [10382,6652,23050,12288];
		RefPosSens : ARRAY[0..3]OF INT := [19501,19027,26106,21401];
		Index : ARRAY[0..4]OF USINT;
		DR_ReflexSensStatus_0 : DetectionRotation;
		DP_Figure_0 : DetPos_Figure;
		MinAccDiff : INT := 100;
		MaxAccDiff : ARRAY[0..3]OF INT := [4(100)];
		CurrentPosition : ARRAY[0..3]OF INT;
	END_STRUCT;
	Stuct_RexlSensInternal : 	STRUCT 
		ActReflexSensStatusRS : ARRAY[0..3]OF BOOL;
		ErrorStatusRS : ARRAY[0..3]OF BOOL;
		ExternalReflexSensStatusRS : ARRAY[0..3]OF BOOL;
		ReflexSensStatusRS : ARRAY[0..3]OF BOOL;
		IndexR : ARRAY[0..1]OF USINT;
	END_STRUCT;
	Struct_OptSensFigInternal : 	STRUCT 
		MaxPosHumDP : ARRAY[0..3]OF INT;
		MinPosHumDP : ARRAY[0..3]OF INT;
		DispAxisDP : ARRAY[0..10]OF INT := [0,-1200,1200,-2400,-1200,0,1200,2400,-2100,0,2100];
		CurrentPosition : ARRAY[0..10]OF INT;
		Index : ARRAY[0..2]OF USINT;
	END_STRUCT;
END_TYPE
