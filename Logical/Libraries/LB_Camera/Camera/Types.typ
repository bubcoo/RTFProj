
TYPE
	MainSwitch_enum : 
		(
		DISABLED := 0,
		ENABLED := 2,
		RUN,
		ERROR := 255
		);
	ControlSwitch_enum : 
		(
		WAIT_CMD := 0,
		TRIGGER_RDY := 1,
		TRIGGER := 2,
		ACQ := 3,
		INSP := 4
		);
	InSight_type : 	STRUCT 
		ModuleOk : BOOL;
		Control_I2000_S01 : UDINT; (*Camera control including trigger*)
		Status_I2001_S01 : UDINT;
		InspectionResults_I2011_S02 : UDINT;
		InspectionResults_I2011_S01 : UDINT;
	END_STRUCT;
	Internal_type : 	STRUCT 
		CameraControl : CameraControl_type;
		MainSwitch : MainSwitch_enum;
		disableBit : USINT;
		Search_tmp : BOOL;
	END_STRUCT;
	Results_type : 	STRUCT 
		ActTime : RTCtime_typ;
		AxisX : REAL;
		AxisY : REAL;
	END_STRUCT;
	CameraControl_type : 	STRUCT 
		ControlSwitch : ControlSwitch_enum;
	END_STRUCT;
	MappView_type : 	STRUCT 
		LoadImage : BOOL;
	END_STRUCT;
END_TYPE
