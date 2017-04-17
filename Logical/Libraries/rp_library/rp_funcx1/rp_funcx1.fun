
FUNCTION_BLOCK measurement_ofScore (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		start_measurement : BOOL;
		exit_game : BOOL;
		pause : BOOL;
		restart_measurement : BOOL;
		sens_wicket_CPU : BOOL;
		sens_wicket_HUM : BOOL;
		PLAYER1_NAME : STRING[30];
		PLAYER2_NAME : STRING[30];
	END_VAR
	VAR_OUTPUT
		Error : BOOL;
		probability_CPU : USINT;
		probability_HUM : USINT;
		count_goals_CPU : USINT;
		match_informations : match_info;
		team_nameCPU : STRING[30];
		team_nameHUM : STRING[30];
		count_goals_HUM : USINT;
	END_VAR
	VAR
		Internal : internal_machtInfo;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK calculete_min
	VAR_INPUT
		cmp_num : ARRAY[0..4] OF REAL;
	END_VAR
	VAR_OUTPUT
		index : USINT;
		number : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK choosing_rightDummy
	VAR_INPUT
		index : USINT;
		real_cross : REAL;
		max_dispOfD : ARRAY[0..3] OF REAL;
		min_dispOfD : ARRAY[0..3] OF REAL;
		matrix_posOfCPU : ARRAY[0..3,0..4] OF REAL;
	END_VAR
	VAR_OUTPUT
		actual_displacement : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK arrival_timeOfBall
	VAR_INPUT
		ball1_x : REAL;
		ball1_y : REAL;
		ball2_x : REAL;
		ball2_y : REAL;
		first_reflection_x : REAL;
		first_reflection_y : REAL;
		act_posOfAxesX : ARRAY[0..3] OF REAL;
		act_posOfAxesY : ARRAY[0..3] OF REAL;
		time_B2B : REAL;
		tilted : BOOL;
		count_axesIntersection : ARRAY[0..1] OF USINT;
	END_VAR
	VAR_OUTPUT
		velocity : REAL;
		time_aI : ARRAY[0..3] OF REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK calculate_directionOfTilt
	VAR_INPUT
		ball1_x : REAL;
		ball1_y : REAL;
		ball2_x : REAL;
		ball2_y : REAL;
	END_VAR
	VAR_OUTPUT
		reflection_x : REAL;
		reflection_y : REAL;
		state_ofDirection : USINT;
		specific_direction : STRING[30];
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK calculate_nextDirection
	VAR_INPUT
		first_reflection_x : REAL;
		first_reflection_y : REAL;
		ball2_x : REAL;
		ball2_y : REAL;
		state_ofDirection : USINT;
	END_VAR
	VAR_OUTPUT
		second_reflection_x : REAL;
		second_reflection_y : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK calculation_crossingBall (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		x_positions : ARRAY[0..3] OF REAL;
		ball1_x : REAL;
		ball1_y : REAL;
		ball2_x : REAL;
		ball2_y : REAL;
		first_reflection_x : REAL;
		first_reflection_y : REAL;
		second_reflection_x : REAL;
		second_reflection_y : REAL;
		time_B2B : REAL;
		tilted : BOOL;
	END_VAR
	VAR_OUTPUT
		count_axesIntersection : ARRAY[0..1] OF USINT;
		act_posOfAxesX : ARRAY[0..3] OF REAL;
		act_posOfAxesY : ARRAY[0..3] OF REAL;
		overall_velocity : REAL;
		time_axisIntersection : ARRAY[0..3] OF REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK calculation_displacementOfAxes (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		tilted : BOOL;
		specific_direction : STRING[30];
		count_axesIntersectionHUM : ARRAY[0..1] OF USINT;
		act_posOfAxesCPU_Y : ARRAY[0..3] OF REAL;
		time_axisIntersection : ARRAY[0..3] OF REAL;
		act_displacementCPU : ARRAY[0..3] OF REAL;
		reversed_HUM : ARRAY[0..3] OF BOOL;
		act_posOfDummiesH : ARRAY[0..10] OF REAL;
		act_posOfAxesHUM_Y : ARRAY[0..3] OF REAL;
		x_posOfBall : ARRAY[0..1] OF REAL;
	END_VAR
	VAR_OUTPUT
		displacement : ARRAY[0..3] OF REAL;
		velocity : ARRAY[0..3] OF REAL;
		acceleration : ARRAY[0..3] OF REAL;
		deceleration : ARRAY[0..3] OF REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK calculation_newCrossing
	VAR_INPUT
		specific_direction : STRING[30];
		iteration : USINT;
		reversed_HUM : ARRAY[0..3] OF BOOL;
		predicted_position : REAL;
		act_posOfAxesCPU_Y : ARRAY[0..3] OF REAL;
		act_posOfAxesHUM_Y : ARRAY[0..3] OF REAL;
		x_posOfBall : ARRAY[0..1] OF REAL;
	END_VAR
	VAR_OUTPUT
		new_cross : ARRAY[0..3] OF REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK calculation_posDummiesOpponent (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		displacement_HUMAN : ARRAY[0..3] OF REAL;
	END_VAR
	VAR_OUTPUT
		actual_positionsOfDummies : ARRAY[0..10] OF REAL;
		real_displacement : ARRAY[0..3] OF REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK calculation_realCrossing
	VAR_INPUT
		tilted : BOOL;
		specific_direction : STRING[30];
		count_axesIntersectionHUM : ARRAY[0..1] OF USINT;
		act_posOfAxesCPU_Y : ARRAY[0..3] OF REAL;
		reversed_HUM : ARRAY[0..3] OF BOOL;
		act_posOfDummiesH : ARRAY[0..10] OF REAL;
		act_posOfAxesHUM_Y : ARRAY[0..3] OF REAL;
		x_posOfBall : ARRAY[0..1] OF REAL;
	END_VAR
	VAR_OUTPUT
		real_cross : ARRAY[0..3] OF REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK forecast_direction (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		ball1_x : REAL;
		ball1_y : REAL;
		ball2_x : REAL;
		ball2_y : REAL;
	END_VAR
	VAR_OUTPUT
		tilted : BOOL;
		specific_direction : STRING[30];
		first_reflectionX : REAL;
		first_reflectionY : REAL;
		second_reflectionX : REAL;
		second_reflectionY : REAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK get_rotationalPostition
	VAR_INPUT
		actual_position : ARRAY[0..3] OF LREAL;
		define_position : ARRAY[0..3] OF LREAL;
	END_VAR
	VAR_OUTPUT
		result : ARRAY[0..3] OF LREAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION random_number : INT (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		min_num : INT;
		max_num : INT;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK start_linearAxis (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		start_btn : BOOL;
		axis_name : REFERENCE TO MpAxisBasic;
		axis_param : REFERENCE TO MpAxisBasicParType;
		max_leftPosition : REAL;
	END_VAR
	VAR_OUTPUT
		succesfully : BOOL;
	END_VAR
	VAR
		Internal : internal_startAxisR;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK start_rotaryAxis (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		start_btn : BOOL;
		axis_name : REFERENCE TO MpAxisBasic;
		axis_param : REFERENCE TO MpAxisBasicParType;
		value_ofRotatation : LREAL;
	END_VAR
	VAR_OUTPUT
		succesfully : BOOL;
	END_VAR
	VAR
		Internal : internal_startAxisR;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK powerOn_axes (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		start_btn : BOOL;
		axis_name_R : REFERENCE TO MpAxisBasic;
		axis_name_L : REFERENCE TO MpAxisBasic;
	END_VAR
	VAR_OUTPUT
		succesfully : BOOL;
	END_VAR
	VAR
		Internal : internal_startAxisR;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK err_detection (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		rotary_ERR : ARRAY[0..3] OF BOOL;
		linear_ERR : ARRAY[0..3] OF BOOL;
	END_VAR
	VAR_OUTPUT
		err_detect : BOOL;
	END_VAR
END_FUNCTION_BLOCK
