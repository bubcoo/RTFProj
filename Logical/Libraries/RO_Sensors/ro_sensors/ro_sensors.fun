
FUNCTION err_modDetect : BOOL
	VAR_INPUT
		detect_err : ARRAY[0..3] OF BOOL;
		modul_ok : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR
		i2 : USINT;
		i1 : USINT;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK FB_DetectionPosition
	VAR_INPUT
		Enable : BOOL;
		Distance_Error : ARRAY[0..3] OF BOOL;
		Positions_FromTheSensors : ARRAY[0..3] OF REAL;
		Detection_Error : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR_OUTPUT
		Actual_Positions : ARRAY[0..3] OF REAL;
		ModulOk : ARRAY[0..3] OF BOOL;
		Error : BOOL;
	END_VAR
	VAR
		Internal : struct_opticalSensorInternal;
	END_VAR
END_FUNCTION_BLOCK
