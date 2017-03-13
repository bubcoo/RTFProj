
TYPE
	MainSwitch_enum : 
		(
		DISABLED := 0,
		ENABLED := 1,
		RUN := 2,
		ERROR := 255
		);
	FTPSwitch_enum : 
		(
		DEVLINK := 1,
		FILECOPY := 2,
		DEVUNLINK := 3
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
		FTP : FTP_type;
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
		PicEnable : BOOL;
		LoadImage : BOOL;
	END_STRUCT;
	FTP_type : 	STRUCT 
		FileCopy_0 : FileCopy;
		DevLink_0 : DevLink;
		DevUnlink_0 : DevUnlink;
		Status : USINT;
		FTPSwitch : FTPSwitch_enum;
		pParam : STRING[200];
		handle : UDINT;
		pDevice : STRING[20];
		pDest : STRING[80];
		pSrc : STRING[80];
		pDestDev : STRING[20];
	END_STRUCT;
END_TYPE
