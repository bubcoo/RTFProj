
TYPE
	DI9371_type : 	STRUCT 
		ModuleOk : BOOL;
		DigitalInput : BOOL;
	END_STRUCT;
	InternalG_type : 	STRUCT 
		init : BOOL;
		DisableTimer : TON_10ms;
	END_STRUCT;
	MappViewG_type : 	STRUCT 
		counter : INT;
	END_STRUCT;
END_TYPE
