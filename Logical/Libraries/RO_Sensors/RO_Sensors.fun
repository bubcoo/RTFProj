
FUNCTION_BLOCK DetectionPositionAxis
	VAR_INPUT
		ActPosSens : ARRAY[0..3] OF INT;
		ErrorOptSens : ARRAY[0..3] OF BOOL;
		ReflexSensStatus : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR_OUTPUT
		ActPosHumFig : ARRAY[0..10] OF INT;
		ActPosHumAxis : ARRAY[0..3] OF INT;
		ExternalReflexSensStatus : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR
		InternalPos : Stuct_OptSensInternal;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK DetectionRotation
	VAR_INPUT
		ErrorReflSensRS : ARRAY[0..3] OF BOOL;
		ReflexSensStatusRS : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR_OUTPUT
		ExternalReflexSensStatusRS : ARRAY[0..3] OF BOOL;
		ActReflRotRS : ARRAY[0..3] OF BOOL;
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
		InternalPosFig : Struct_OptSensFigInternal;
	END_VAR
END_FUNCTION_BLOCK
