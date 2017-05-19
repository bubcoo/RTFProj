(*Enumerations*)

TYPE
	internal_turnPos : 	STRUCT 
		auxiliary_move_pos : REAL;
		distance_ofMoveNeg : REAL;
		distance_ofMovePos : REAL;
		min_pos_ofAxes : ARRAY[0..3]OF REAL;
		max_pos_ofAxes : ARRAY[0..3]OF REAL;
		state : USINT;
	END_STRUCT;
	param_ac : 	STRUCT 
		displacement : REAL;
		velocity : REAL;
		acceleration : REAL;
		deceleration : REAL;
	END_STRUCT;
	internal_ballShooting : 	STRUCT 
		state : USINT;
	END_STRUCT;
	internal_controlAxis : 	STRUCT 
		before_state : USINT;
		state : USINT;
	END_STRUCT;
	internal_startAxisR : 	STRUCT 
		before_state : USINT;
		state : USINT;
	END_STRUCT;
	internal_machtInfo : 	STRUCT 
		WINNER : USINT;
		DRAW : USINT;
		LOSE : USINT;
		length : UDINT;
		write_matchInfo : BOOL;
		auxiliary_str : ARRAY[0..10]OF UDINT;
		counter : USINT;
		results : ARRAY[0..1]OF DINT;
		UtcDTStructureGetTime_1 : UtcDTStructureGetTime;
		e_r_str : ARRAY[0..3]OF UDINT;
		DTStruct : DTStructure;
		state : USINT;
		before_state : USINT;
		string : ARRAY[0..8]OF STRING[25];
	END_STRUCT;
	match_info : 	STRUCT 
		team_name_CPU : ARRAY[0..50]OF STRING[10];
		team_name_HUM : ARRAY[0..50]OF STRING[20];
		score_HUM : ARRAY[0..50]OF USINT;
		score_CPU : ARRAY[0..50]OF USINT;
		date : ARRAY[0..50]OF STRING[25];
	END_STRUCT;
	soccer_table_ENUM : 
		(
		RST_EMPTY := -1,
		RST_INITIALIZATION_1 := 1,
		RST_INITIALIZATION_2 := 2,
		RST_INITIALIZATION_3 := 3,
		RST_INITIALIZATION_4 := 4,
		RST_INITIALIZATION_5 := 5,
		RST_CHECK_MODE := 6,
		RST_CALCULATION_DEFENSE := 10,
		RST_MOVE_INTO_DEFENSE_POS1 := 11,
		RST_MOVE_INTO_DEFENSE_POS2 := 12,
		RST_ATTACK_MODE_SHOOT1 := 20,
		RST_ATTACK_MODE_SHOOT2 := 21,
		RST_ATTACK_MODE_SHOOT3 := 22,
		RST_ATTACK_MODE_TURN_POS := 25,
		RST_RUN1 := 100,
		RST_RUN2 := 101,
		RST_RUN3 := 102,
		RST_RUN4 := 103,
		RST_RUN5 := 104,
		RST_SERVICE := 200,
		RST_STOP := 300,
		RST_AFTER_STOP := 301,
		RST_NULL_POS1 := 310,
		RST_NULL_POS2 := 311,
		RST_SAFETY := 400,
		RST_AFTER_SAFETY := 401,
		RST_AFTER_SAFETY_HOME := 402,
		RST_ERROR := 500,
		RST_ERROR2 := 501
		);
	rp_MainSteps : 
		(
		STEP_INITIALIZATION0 := 0,
		STEP_INITIALIZATION1 := 1,
		STEP_INITIALIZATION2 := 2,
		STEP_INITIALIZATION3 := 3,
		STEP_INITIALIZATION4 := 4,
		STEP_INITIALIZATION5 := 5,
		STEP_INITIALIZATION6 := 6,
		STEP_INITIALIZATION7 := 7,
		STEP_INITIALIZATION8 := 8,
		STEP_START := 10,
		STEP_RUN1 := 100,
		STEP_RUN2 := 101,
		STEP_RUN3 := 102,
		STEP_RUN4 := 103,
		STEP_RUN5 := 104,
		STEP_RUN6 := 105,
		STEP_RUN7 := 106,
		STEP_RUN8 := 107,
		STEP_RUN9 := 108,
		STEP_RUN10 := 109,
		STEP_RUN11 := 110,
		STEP_RUN12 := 111,
		STEP_RUN13 := 112,
		STEP_RUN14 := 113,
		STEP_RUN15 := 114,
		STEP_RUN16 := 115,
		STEP_RUN17 := 116,
		STEP_RUN18 := 117,
		STEP_RUN19 := 118,
		STEP_RUN20 := 119,
		STEP_RUN21 := 120,
		STEP_RUN22 := 121,
		STEP_RUN23 := 122,
		STEP_RUN24 := 123,
		STEP_RUN25 := 124,
		STEP_RUN26 := 125,
		STEP_RUN27 := 126,
		STEP_RUN28 := 127,
		STEP_RUN29 := 128,
		STEP_RUN30 := 129,
		STEP_RUN31 := 130,
		STEP_RUN32 := 131,
		STEP_RUN33 := 132,
		STEP_RUN34 := 133,
		STEP_RUN35 := 134,
		STEP_RUN36 := 135,
		STEP_RUN37 := 136,
		STEP_RUN38 := 137,
		STEP_RUN39 := 138,
		STEP_RUN40 := 139,
		STEP_RUN41 := 140,
		STEP_RUN42 := 141,
		STEP_RUN43 := 142,
		STEP_RUN44 := 143,
		STEP_RUN45 := 144,
		STEP_RUN46 := 145,
		STEP_RUN47 := 146,
		STEP_RUN48 := 147,
		STEP_RUN49 := 148,
		STEP_RUN50 := 149,
		STEP_SERVICE1 := 200,
		STEP_SERVICE2 := 201,
		STEP_SERVICE3 := 202,
		STEP_STOP1 := 300,
		STEP_STOP2 := 301,
		STEP_STOP3 := 302,
		STEP_E_STOP := 350,
		STEP_ERROR1 := 400,
		STEP_ERROR2 := 401,
		STEP_ERROR3 := 402
		);
END_TYPE
