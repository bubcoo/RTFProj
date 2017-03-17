TYPE
	ArncAxesGroup : GmcAxesGroup; (*Arnc Axes Group Data type; derived from GmcAxesGroup*)
	MCAxesGroupType_Arnc : ArncAxesGroup; (*AxesGroup Data type; I.e. alias of GmcAxesGroup*)
	MCArncFFCtrlParType : 	STRUCT 
		DisableAxis : ARRAY[0..14]OF BOOL; (*Exclude axis from feed forward control.*)
		UserAxis : ARRAY[0..14]OF UDINT; (*Axis reference of an alternative axis for feed forward control.*)
		UserParID : ARRAY[0..14]OF UINT; (*ACOPOS parameter ID for additional torque value.*)
		UserDynModel : UDINT; (*Adress of the dynamic model of the mechanics.*)
		RampCycles : UDINT; (*Task cycles to increase/decrease additive torque.*)
	END_STRUCT;
END_TYPE