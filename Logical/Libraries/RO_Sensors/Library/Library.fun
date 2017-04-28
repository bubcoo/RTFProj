
FUNCTION_BLOCK DetectionPositionAxis
	VAR_INPUT
		ActPosSens : ARRAY[0..3] OF INT;
		ErrorOptSens : ARRAY[0..3] OF BOOL;
		ModulOK : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR_OUTPUT
		ActPosHumFig : ARRAY[0..10] OF INT;
		ActPosHumAxis : ARRAY[0..3] OF INT;
		ExternalModulOK : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR CONSTANT
		RefPosSens : ARRAY[0..3] OF INT := [4(0)];
		MaxPosSens : ARRAY[0..3] OF INT := [4(0)];
		MinPosSens : ARRAY[0..3] OF INT := [4(0)];
		RefPosHum : ARRAY[0..3] OF INT := [4(0)];
		MaxPosHum : ARRAY[0..3] OF INT := [4(0)];
		MinPosHum : ARRAY[0..3] OF INT := [4(0)];
	END_VAR
	VAR
		TransConst : ARRAY[0..3] OF INT;
		InternalPos : Stuct_OptSensInternal;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK DetectionRotation
	VAR_OUTPUT
		ExternalModulRotOK : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR_INPUT
		ErrorReflSens : ARRAY[0..3] OF BOOL;
		ModulRotOK : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR_OUTPUT
		ActReflRotOP : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR
		InternalRot : Stuct_RexlSensInternal;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK DetPos_Figure
	VAR_INPUT
		ActPosHumAxisDP : ARRAY[0..3] OF INT;
	END_VAR
	VAR_OUTPUT
		ActPosHumFigDP : ARRAY[0..10] OF INT;
	END_VAR
	VAR
		DispAxisDP : ARRAY[0..10] OF INT := [11(0)];
		i1 : USINT;
		i2 : USINT;
		i3 : USINT;
		MaxPosHumDP : ARRAY[0..3] OF INT := [4(0)];
		MinPosHumDP : ARRAY[0..3] OF INT := [4(0)];
	END_VAR
END_FUNCTION_BLOCK
