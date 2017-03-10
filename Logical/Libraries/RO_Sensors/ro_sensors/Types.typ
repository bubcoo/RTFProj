
TYPE
	enum_opticalSensorInternal : 
		(
		OS_INITIALIZATION := 0,
		OS_ENABLED := 1,
		OS_CALCULATION := 2,
		OS_ERROR := 3
		);
	struct_opticalSensorInternal : 	STRUCT 
		index : ARRAY[0..1]OF USINT;
		auxiliary_pos : ARRAY[0..3]OF REAL;
		state : enum_opticalSensorInternal;
	END_STRUCT;
END_TYPE
