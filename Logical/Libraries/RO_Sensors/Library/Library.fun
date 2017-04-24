
FUNCTION_BLOCK DetectionPositionAxis
	VAR_INPUT
		ActPosSens : ARRAY[0..3] OF REAL;
		ErrorStatusOptSens : ARRAY[0..3] OF BOOL;
		ErrorOptSens : ARRAY[0..3] OF BOOL;
		Enable : BOOL;
		ModulOK : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR_OUTPUT
		ActPosHumFig : ARRAY[0..10] OF REAL;
		ActPosHumAxis : ARRAY[0..3] OF REAL;
		ExternalModulOK : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR CONSTANT
		RefPosSens : ARRAY[0..3] OF REAL := [17927.4,19165.9,24150.6,22199.6];
		MaxPosSens : ARRAY[0..3] OF REAL := [25889.8,31531,29485.6,31114.4];
		MinPosSens : ARRAY[0..3] OF REAL := [9965,6800.8,18815.6,13284.8];
		RefPosHum : ARRAY[0..3] OF REAL := [4(0.0)];
		MaxPosHum : ARRAY[0..3] OF REAL := [1015,1615,655,955];
		MinPosHum : ARRAY[0..3] OF REAL := [-1015,-1615,-655,-955];
	END_VAR
	VAR
		TransConst : ARRAY[0..3] OF REAL;
		InternalPos : Stuct_OptSensInternal;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK DetectionRotation
	VAR_INPUT
		ActReflRotIP : ARRAY[0..3] OF BOOL;
		ErrorReflSens : ARRAY[0..3] OF BOOL;
		Enable : BOOL;
	END_VAR
	VAR_OUTPUT
		ActReflRotOP : ARRAY[0..3] OF BOOL;
		ErrorStatusRot : BOOL;
		ExternalModulRotOK : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR_INPUT
		ModulRotOK : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR
		InternalRot : Stuct_RexlSensInternal;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK DetPos_Figure
	VAR_INPUT
		ActPosHumAxisDP : ARRAY[0..3] OF REAL;
	END_VAR
	VAR_OUTPUT
		ActPosHumFigDP : ARRAY[0..10] OF REAL;
	END_VAR
	VAR
		DispAxisDP : ARRAY[0..10] OF REAL := [0,-1200,1200,-2400,-1200,0,1200,2400,-2100,0,2100];
		i1 : USINT;
		i2 : USINT;
		i3 : USINT;
		MaxPosHumDP : ARRAY[0..3] OF REAL := [1000,1850,650,975];
		MinPosHumDP : ARRAY[0..3] OF REAL := [-1000,-1850,-650,-975];
	END_VAR
END_FUNCTION_BLOCK
