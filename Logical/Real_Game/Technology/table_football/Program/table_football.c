/*********************************************************************************************
* B&R Automation - Perfection in Automation (https://www.br-automation.com)
    ******************************************************************************************
    * Program 	    : Master's Thesis - Soccer Table (Table Football - real game)
    * Author  	    : Bc. Roman Parak
    * Created 	    : 2016/2017
	* University    : Brno University of Technology(BUT)
	* Faculty       : Faculty of Mechanical Engineering(FME)
	* Study Program : Applied Computer Science and Control
	* Institute     : Institute of Automation and Computer Science
**********************************************************************************************
* Implementation OF PROGRAM table_football(Real_Game/Technology/table_football/Program/table_football.c)
**********************************************************************************************/

/*************************** LIBRARIES *********************************/
#include <bur/plc.h>
#include <bur/plctypes.h>
#include <stdio.h>
#include <math.h>
#include <AsMem.h>

#include "rp_funcx1.h"
#include "Structures/table_football_str.h"
#include "Functions/mapp.h"

#include "Camera.h"
#include "Bar_Light.h"
#include "RO_Sensors.h"

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

/*************************** DEFINITIONS *******************************/
#define EACH_FORMATION 1;

/************************ GLOBAL VARIABLES ******************************/
_GLOBAL FBCamera_typ cam_det;
_GLOBAL GoalKeeper_typ GoalKeeper_0;
_GLOBAL Light_typ Light_0;

/************************ LOCAL VARIABLES ******************************/
// struct - MpAlarmX
_LOCAL MpAlarmXListUIConnectType AlarmListUI_ConnectType;
_LOCAL MpAlarmXHistoryUIConnectType AlarmHistoryUI_ConnectType;
// struct - rp_funcx1
_LOCAL struct forecast_direction f_d;
_LOCAL struct calculation_posDummies c_ppd;
_LOCAL struct calculation_crossingBall c_cb[2];
_LOCAL struct calculation_displacementOfAxes c_doa;
_LOCAL struct get_rotationalPostition get_rotPos;
_LOCAL struct get_rotationalPostition get_rotPosASH;
_LOCAL struct measurement_ofScore m_ofScore;
_LOCAL struct start_rotaryAxis start_rotA[4];
_LOCAL struct start_linearAxis start_linA[4];
_LOCAL struct err_detection e_detect;
_LOCAL struct axes_control axes_c[4];
_LOCAL struct ball_shooting ball_shoot;
_LOCAL struct turn_position turn_pos;
_LOCAL struct check_attack_mode check_aM;
// struct - camera
_LOCAL RTCtime_typ ActTime_tmp;
// struct - sensors
_LOCAL struct DetectionPositionAxis dpA;
// udint
_LOCAL UDINT alarm_device_address;
_LOCAL UDINT specific_directionOfBall;
// bool
_LOCAL BOOL reset_safetyESTOP;
_LOCAL BOOL ESTOP;
_LOCAL BOOL OSSD2;
_LOCAL BOOL SAFETY_MODUL_OK;
_LOCAL BOOL START_GAME, STOP_GAME, START_INIT, EXIT_GAME, RESTART_GAME;
// usint
_LOCAL USINT max_numberOfFormation;
_LOCAL USINT i_axisNum;
_LOCAL USINT vis_linearPower[4], vis_linearHome[4], vis_rotaryPower[4], vis_rotaryHome[4];
_LOCAL USINT vis_warning, vis_safety;
_LOCAL USINT i_visPH;
_LOCAL USINT i_act, i_bs, i_bs2, i_sAx, i_initS, i_errD, i_rstE, i_rstE2;
_LOCAL USINT i_home, i_int3, i_def, i_dp1, i_dp2, i_cm;
_LOCAL USINT c_ofActive, c_bState, c_sAx, c_initS, c_int3, c_dp, c_astop, c_nmp;
_LOCAL USINT i_stop, i_astop, i_mnp1, i_mnp2, i_shoot, i_turnp;
_LOCAL USINT i_ppd, i_ccd, i_ccdCPU, i_ccdHUM, i_cdoa1, i_cdoa2, i_cdoa3;
_LOCAL USINT index_ofAxesAM;
// real
_LOCAL REAL x_posOfCPU[4];
_LOCAL REAL x_posOfHUM[4];
_LOCAL REAL linear_maxPos[4];
// lreal
_LOCAL LREAL temp_lin[4];
_LOCAL LREAL temp_rot[4];
_LOCAL LREAL define_posRotary[4];
_LOCAL LREAL angle_ofRotation[4];
_LOCAL LREAL act_pos;
// OUPTUT from the SENSOR & CAMERA
_LOCAL REAL ball1[2], ball2[2], time_B2B;
_LOCAL REAL optical_sensor[4];
_LOCAL REAL reflex_sensor[4];
// state machine
_LOCAL soccer_table_ENUM SOCCER_TABLE_STEP;
_LOCAL soccer_table_ENUM BEFORE_STATE;

/**********************************************************************************************************/
/********************************************** INIT PROGRAM **********************************************/
/**********************************************************************************************************/
void _INIT ProgramInit(void)
{
    /*********************************** Declaration variables **********************************/
    // generally
    max_numberOfFormation = EACH_FORMATION;
    
    // axis type -> MAPP
    // linear
    gLinkAxes_linear[0] = gk_mappAxisLR;
    gLinkAxes_linear[1] = df_mappAxisLR;
    gLinkAxes_linear[2] = md_mappAxisLR;
    gLinkAxes_linear[3] = fw_mappAxisLR;
    // rotary
    gLinkAxes_rotary[0] = gk_mappAxisRR;
    gLinkAxes_rotary[1] = df_mappAxisRR;
    gLinkAxes_rotary[2] = md_mappAxisRR;
    gLinkAxes_rotary[3] = fw_mappAxisRR;
	
    /************************************ Control of AlarmX ************************************/
    // adjustment device name
    alarm_device_address = (UDINT) strcpy(mp_alarmX.deviceName_no1_exp,"EXPORT_HISTORY");
    // MpAlarmX Core
    mp_alarmX.mp_core.MpLink         = &gAlarmXCoreR;
    mp_alarmX.mp_core.Enable         = 1;
    // MpAlarmX ListUI
    mp_alarmX.mp_listUI.MpLink       = &gAlarmXCoreR;
    mp_alarmX.mp_listUI.Enable       = 1;
    mp_alarmX.mp_listUI.UIConnect    = &AlarmListUI_ConnectType;
    // MpAlarmX History
    mp_alarmX.mp_history.MpLink      = &gAlarmXHistoryR;
    mp_alarmX.mp_history.Enable      = 1;
    mp_alarmX.mp_history.DeviceName  = &mp_alarmX.deviceName_no1_exp;
    // MpAlarmX HistoryUI
    mp_alarmX.mp_historyUI.MpLink    = &gAlarmXHistoryR;
    mp_alarmX.mp_historyUI.Enable    = 1;
    mp_alarmX.mp_historyUI.UIConnect = &AlarmHistoryUI_ConnectType;
    
    /************************************* Control of Axes **************************************/
    for(i_axisNum = 0; i_axisNum <= max_numberOfFormation - 1; i_axisNum++){
        // initialization ACOPOS variables through function(get_axisParam), that returns two variables type of UDINT
        // into the structure -> axesAcopos(have two parameters : linear, rotary)
        axis_acopos = get_axisParam(i_axisNum);
        // linear -> LinMot
        // linear axis basic
        mp_Axis.mp_axisLinear[i_axisNum].Enable     = 1;
        mp_Axis.mp_axisLinear[i_axisNum].MpLink     = &gLinkAxes_linear[i_axisNum];
        mp_Axis.mp_axisLinear[i_axisNum].Parameters = &mp_Axis.param_axisLinear[i_axisNum];
        mp_Axis.mp_axisLinear[i_axisNum].Axis       = axis_acopos.linear;
        // linear cyclic set
        mp_Axis.mp_cyclicSetLinear[i_axisNum].Enable     = 1;
        mp_Axis.mp_cyclicSetLinear[i_axisNum].MpLink     = &gLinkAxes_linear[i_axisNum];
        mp_Axis.mp_cyclicSetLinear[i_axisNum].Parameters = &mp_Axis.param_cyclicSetLinear[i_axisNum];
		// adjust parameters cyclic set
		mp_Axis.param_cyclicSetLinear[i_axisNum].PositionModeMaxVelocity = 30000;
		mp_Axis.param_cyclicSetLinear[i_axisNum].Acceleration 			 = 489000;
		mp_Axis.param_cyclicSetLinear[i_axisNum].Deceleration			 = 489000;
		// config
		mp_Axis.mp_configAxisLinear[i_axisNum].Enable 		 = 1;
		mp_Axis.mp_configAxisLinear[i_axisNum].MpLink 		 = &gLinkAxes_linear[i_axisNum];
		mp_Axis.mp_configAxisLinear[i_axisNum].Configuration = &mp_Axis.param_configAxisLinear[i_axisNum];
        // rotary -> EnDat
        // rotary axis basic
        mp_Axis.mp_axisRotary[i_axisNum].Enable     = 1;
        mp_Axis.mp_axisRotary[i_axisNum].MpLink     = &gLinkAxes_rotary[i_axisNum];
        mp_Axis.mp_axisRotary[i_axisNum].Parameters = &mp_Axis.param_axisRotary[i_axisNum];
        mp_Axis.mp_axisRotary[i_axisNum].Axis       = axis_acopos.rotary;
        // rotary cyclic set
        mp_Axis.mp_cyclicSetRotary[i_axisNum].Enable     = 1;
        mp_Axis.mp_cyclicSetRotary[i_axisNum].MpLink     = &gLinkAxes_rotary[i_axisNum];
        mp_Axis.mp_cyclicSetRotary[i_axisNum].Parameters = &mp_Axis.param_cyclicSetRotary[i_axisNum];
		// adjust parameters cyclic set
		mp_Axis.param_cyclicSetRotary[i_axisNum].PositionModeMaxVelocity = 85000;
		mp_Axis.param_cyclicSetRotary[i_axisNum].Acceleration 			 = 125000;
		mp_Axis.param_cyclicSetRotary[i_axisNum].Deceleration			 = 125000;
		// config
		mp_Axis.mp_configAxisRotary[i_axisNum].Enable 		 = 1;
		mp_Axis.mp_configAxisRotary[i_axisNum].MpLink 		 = &gLinkAxes_rotary[i_axisNum];
		mp_Axis.mp_configAxisRotary[i_axisNum].Configuration = &mp_Axis.param_configAxisRotary[i_axisNum];
		// temperature - linear
		mp_Axis.param_axisLinear[i_axisNum].CyclicRead.MotorTempMode = mpAXIS_READ_POLLING_1s;
		// temperature - rotary
		mp_Axis.param_axisRotary[i_axisNum].CyclicRead.MotorTempMode = mpAXIS_READ_POLLING_1s;
		// FB for linear and rotary axes -> Homing
		// rotary
		start_rotA[i_axisNum].Enable	 = 1;
		start_rotA[i_axisNum].axis_name	 = &mp_Axis.mp_axisRotary[i_axisNum];
		start_rotA[i_axisNum].axis_param = &mp_Axis.param_axisRotary[i_axisNum];
		// linear
		start_linA[i_axisNum].Enable	 = 1;
		start_linA[i_axisNum].axis_name	 = &mp_Axis.mp_axisLinear[i_axisNum];
		start_linA[i_axisNum].axis_param = &mp_Axis.param_axisLinear[i_axisNum];
		// FB for linear and fotary axes -> Control
		axes_c[i_axisNum].Enable			 = 1;
		axes_c[i_axisNum].linear_axis_cyclic = &mp_Axis.mp_cyclicSetLinear[i_axisNum];
		axes_c[i_axisNum].linear_axis_param  = &mp_Axis.param_cyclicSetLinear[i_axisNum];
		axes_c[i_axisNum].rotary_axis_cyclic = &mp_Axis.mp_cyclicSetRotary[i_axisNum];
		axes_c[i_axisNum].rotary_axis_param  = &mp_Axis.param_cyclicSetRotary[i_axisNum];
    }
	/************************************* Camera initialization **************************************/
	cam_det.Enable = 1;
	cam_det.Internal.ChangeZone = ONE_ZONE;
	/************************************* GoakKeeper Sensor Initialization ***************************/
	GoalKeeper_0.enable = 1;
	/************************************* Light initialization **************************************/
	Light_0.Enable = 1;
	Light_0.PowerOn = 1;
	/********************************** Ball shooting initialization **********************************/
	ball_shoot.Enable = 1;
	/********************************** Turn position initialization **********************************/
	turn_pos.Enable = 1;
	/********************************** Measurement of score initialization ***************************/
	m_ofScore.Enable = 1;
	/*************************************** INITIALIZATIONS ******************************************/
	// initialization x axes for CPU
	x_posOfCPU[0] = 800;
	x_posOfCPU[1] = 2300;
	x_posOfCPU[2] = 5300;
	x_posOfCPU[3] = 8300;
	// initialization x axes for HUMAN	
	x_posOfHUM[0] = 3800;
	x_posOfHUM[1] = 6800;
	x_posOfHUM[2] = 9800;
	x_posOfHUM[3] = 11300;	
	// OUPTUT from the SENSOR & CAMERA
	// CAMERA
	// step k - 1
	ball1[0] = 0;
	ball1[1] = 0;
	// step k
	ball2[0] = 0;
	ball2[1] = 0;
	// time between two balls
	time_B2B = 0;
	// SENSOR
	// optical
	optical_sensor[0] = 0;
	optical_sensor[1] = 0;
	optical_sensor[2] = 0;
	optical_sensor[3] = 0;
    // reflective	
	reflex_sensor[0] = 1;
	reflex_sensor[1] = 1;
	reflex_sensor[2] = 1;
	reflex_sensor[3] = 1;
	// initialization temperature
	temp_lin[0] = 0;
	temp_rot[0] = 0;
	// initialization counters
	c_ofActive = 0;
	c_sAx	   = 0;
	c_bState   = 0;
	// initi index attack mode
	index_ofAxesAM = 0;
	// initialization define position of rotary Axis
	define_posRotary[0] = 117956383;	
	// linear max positions
	linear_maxPos[0]    = 820;
	// intialization state machine
	//SOCCER_TABLE_STEP = RST_INITIALIZATION_1;
	SOCCER_TABLE_STEP = RST_EMPTY;
	// initialization start buttons
	START_GAME 	 = 0;
	START_INIT 	 = 0;
	STOP_GAME  	 = 0;
	EXIT_GAME  	 = 0;
	RESTART_GAME = 0;
	// initialization safety reset
	reset_safetyESTOP = 0;
}

/**********************************************************************************************************/
/********************************************** MAIN PROGRAM **********************************************/
/**********************************************************************************************************/
void _CYCLIC ProgramCyclic(void)
{    
	// initializatiom temperature
	temp_lin[0] = mp_Axis.mp_axisLinear[0].Info.CyclicRead.MotorTemperature.Value;
	temp_rot[0] = mp_Axis.mp_axisRotary[0].Info.CyclicRead.MotorTemperature.Value;
	
	switch(SOCCER_TABLE_STEP){
		case RST_EMPTY:
			{
				/************************************* START INITIALIZATION ******************************************/
				BEFORE_STATE = RST_EMPTY;
				
				if(START_INIT == 1){
					SOCCER_TABLE_STEP = RST_INITIALIZATION_1;
				}
			}
			break;
		case RST_INITIALIZATION_1:
			{	
				/*************************************** INITIALIZATION no.1 ******************************************/
				BEFORE_STATE = RST_INITIALIZATION_1;
				
				// safety modul ok -> turn on program
				if(SAFETY_MODUL_OK == 1 && ESTOP == 1 && OSSD2 == 1 && reset_safetyESTOP == 0){
					// safety initialization & reset safety -> turn on
					reset_safetyESTOP = 1;
					// initial check
					if(reset_safetyESTOP == 1){
						for(i_act = 0; i_act <= max_numberOfFormation - 1; i_act++){
							if(mp_Axis.mp_axisLinear[i_act].Active == 1 && mp_Axis.mp_axisRotary[i_act].Active == 1){
								if(c_ofActive == i_act){
									c_ofActive++;
								}
							}
						}
						if(c_ofActive == max_numberOfFormation){
	
							for(i_initS = 0; i_initS <= max_numberOfFormation - 1; i_initS++)
							{
								// get rotation position
								get_rotPos.actual_position[i_initS] = mp_Axis.mp_axisRotary[i_initS].Position;
								get_rotPos.define_position[i_initS] = define_posRotary[i_initS];
								// call function
								get_rotationalPostition(&get_rotPos);
								// output
								angle_ofRotation[i_initS] = get_rotPos.result[i_initS];
								// update axes cyclic set
								mp_Axis.mp_cyclicSetLinear[i_initS].Update = 1;
								mp_Axis.mp_cyclicSetRotary[i_initS].Update = 1;
								
								if(mp_Axis.mp_cyclicSetLinear[i_initS].UpdateDone == 1 && mp_Axis.mp_cyclicSetRotary[i_initS].UpdateDone == 1){
									mp_Axis.mp_cyclicSetLinear[i_initS].Update = 0;
									mp_Axis.mp_cyclicSetRotary[i_initS].Update = 0;
									
									if(labs(angle_ofRotation[i_initS]) <= 3600){
										c_initS++;
									}
								}
							}

							if(c_initS == max_numberOfFormation){
								if(ESTOP == 0 || OSSD2 == 0){
									SOCCER_TABLE_STEP = RST_SAFETY;
								}else if(e_detect.err_detect == 1){
									SOCCER_TABLE_STEP = RST_ERROR;
								}else {
									SOCCER_TABLE_STEP = RST_INITIALIZATION_2;
								}
							}
						}
					}
				}else{
					SOCCER_TABLE_STEP = RST_SAFETY;
				}
			}
			break;
		case RST_INITIALIZATION_2:
			{
				/****************************** INITIALIZATION no.2 POWER ON & HOME AXES ******************************/
				BEFORE_STATE = RST_INITIALIZATION_2;
				
				// reset safety -> turn off
				if(reset_safetyESTOP == 1){
					reset_safetyESTOP = 0;
				}
				
				for(i_sAx = 0; i_sAx <= max_numberOfFormation - 1; i_sAx++){
					// input parameters -> Rotary
					start_rotA[i_sAx].value_ofRotatation = angle_ofRotation[i_sAx];
					start_rotA[i_sAx].start_btn		     = 1;
					// call function block
					start_rotaryAxis(&start_rotA[i_sAx]);
					
					if(start_rotA[i_sAx].succesfully == 1){
						// input parameter -> Rotary : Off
						start_rotA[i_sAx].start_btn		    = 0;
						// input parameters -> Linear
						start_linA[i_sAx].max_leftPosition  = linear_maxPos[i_sAx];
						start_linA[i_sAx].start_btn			= 1;
						
						// call function block
						start_linearAxis(&start_linA[i_sAx]);
					}
					// output
					if(start_linA[i_sAx].succesfully == 1){
						// input parameter -> Linear : Off
						start_linA[i_sAx].start_btn = 0;
						if(c_sAx == i_sAx){
							c_sAx++;
						}
					}
				}
				if(c_sAx == max_numberOfFormation){
					if(ESTOP == 0 || OSSD2 == 0){
						SOCCER_TABLE_STEP = RST_SAFETY;
					}else if(e_detect.err_detect == 1){
						SOCCER_TABLE_STEP = RST_ERROR;
					}else {
						SOCCER_TABLE_STEP = RST_INITIALIZATION_3;
					}
				}
			}
			break;
		case RST_INITIALIZATION_3:
			{	
				/*************************************** INITIALIZATION no.3 ******************************************/
				BEFORE_STATE = RST_INITIALIZATION_3;
				
				for(i_int3 = 0; i_int3 <= max_numberOfFormation - 1; i_int3++){
					// axes parameters
					// linear
					axes_c[i_int3].linear_param.acceleration = 489000.0;
					axes_c[i_int3].linear_param.deceleration = 489000.0;
					// rotary
					axes_c[i_int3].rotary_param.acceleration = 125000;
					axes_c[i_int3].rotary_param.deceleration = 125000;
					// axes cyclic parameters
					// linear
					axes_c[i_int3].linear_param.velocity 	 = 29000.0;
					axes_c[i_int3].linear_param.displacement = 0;
					// rotary
					axes_c[i_int3].rotary_param.velocity     = 10000;
					axes_c[i_int3].rotary_param.displacement = -250;
										
					// start move
					axes_c[i_int3].start_move = 1;
					
					if(axes_c[i_int3].successfully == 1){
						axes_c[i_int3].start_move = 0;
						
						if(c_int3 == i_int3){
							c_int3++;
						}
					}
				}
				
				if(c_int3 == max_numberOfFormation){
					if(ESTOP == 0 || OSSD2 == 0){
						SOCCER_TABLE_STEP = RST_SAFETY;
					}else if(e_detect.err_detect == 1){
						SOCCER_TABLE_STEP = RST_ERROR;
					}else {
						SOCCER_TABLE_STEP = RST_INITIALIZATION_4;
					}
				}
			}
			break;
		case RST_INITIALIZATION_4:
			{
				/*************************************** INITIALIZATION no.4 ******************************************/
				BEFORE_STATE = RST_INITIALIZATION_4;
				
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					STOP_GAME = 0;
					EXIT_GAME = 0;
					// start searching 
					cam_det.Search 	  = 1;
					SOCCER_TABLE_STEP = RST_INITIALIZATION_5;
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME	 = 0;
					RESTART_GAME = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_INITIALIZATION_5:
			{
				/*************************************** INITIALIZATION no.5 ******************************************/
				// values -> camera
				if(isnan(cam_det.Results.AxisX) || isnan(cam_det.Results.AxisY)){
					// ball step -> k - 1
					ball1[0] = cam_det.Results.AxisXOld;
					ball1[1] = cam_det.Results.AxisYOld;
					// ball step -> k
					ball2[0] = cam_det.Results.AxisXOld + 1;
					ball2[1] = cam_det.Results.AxisYOld + 1;
				}else{
					// ball step -> k - 1
					ball1[0] = cam_det.Results.AxisXOld;
					ball1[1] = cam_det.Results.AxisYOld;
					// ball step -> k
					ball2[0] = cam_det.Results.AxisX;
					ball2[1] = cam_det.Results.AxisY;
				}
				// time between two balls
				time_B2B = cam_det.Results.TimeDiff_ms/1000;
				// values -> optical sensor
				optical_sensor[0] = 0;
				optical_sensor[1] = 0;
				optical_sensor[2] = 0;
				optical_sensor[3] = 0;
				// values -> reflex sensor
				reflex_sensor[0] = 1;
				reflex_sensor[1] = 1;
				reflex_sensor[2] = 1;
				reflex_sensor[3] = 1;
												
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					SOCCER_TABLE_STEP = RST_CHECK_MODE;
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_CHECK_MODE:
			{
				/******************************************* CHECK MODE ***********************************************/
				check_aM.ball1_x = ball1[0];
				check_aM.ball1_y = ball1[1];
				check_aM.ball2_x = ball2[0];
				check_aM.ball2_y = ball2[1];
				
				for(i_cm = 0; i_cm <= max_numberOfFormation - 1; i_cm++){
					check_aM.act_displacement_cpu[i_cm] = mp_Axis.mp_cyclicSetLinear[i_cm].Info.SlavePosition;
					check_aM.angle_ofRotation[i_cm] 	= mp_Axis.mp_cyclicSetRotary[i_cm].Info.SlavePosition;
				}
				// call function
				check_attack_mode(&check_aM);
				
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					index_ofAxesAM = check_aM.index_ofAxis;
					if(index_ofAxesAM == 0){
						if(check_aM.attack_mode == 0){
							// If ball it isn't near of dummy -> Defences
							SOCCER_TABLE_STEP = RST_CALCULATION_DEFENSE;
						}else if(check_aM.attack_mode == 1){
							// attack mode If ball is behind of dummy -> turn position
							SOCCER_TABLE_STEP = RST_ATTACK_MODE_TURN_POS;
						}else if(check_aM.attack_mode == 2){
							// attack mode If ball is before of dummy -> shoot
							SOCCER_TABLE_STEP = RST_ATTACK_MODE_SHOOT2;
						}
					}else{
						// If ball it isn't near of dummy -> Defences
						SOCCER_TABLE_STEP = RST_CALCULATION_DEFENSE;
					}
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_CALCULATION_DEFENSE:
			{
				/*************************************** CALCULATION DEFENSE ******************************************/
				BEFORE_STATE = RST_CALCULATION_DEFENSE;
				
				// calculation forecast direction
				f_d.ball1_x = ball1[0];
				f_d.ball1_y = ball1[1];
				f_d.ball2_x = ball2[0];
				f_d.ball2_y = ball2[1];
				forecast_direction(&f_d);
				// calculation pos dummies opponent
				// maximum displacement of individual axes
				c_ppd.max_disp[0] = 1025;
				c_ppd.max_disp[0] = 1850;
				c_ppd.max_disp[0] = 665;
				c_ppd.max_disp[0] = 975;
				// minimum displacement of individual axes
				c_ppd.min_disp[0] = -1025;
				c_ppd.min_disp[0] = -1850;
				c_ppd.min_disp[0] = -665;
				c_ppd.min_disp[0] = -975;
				for(i_ppd = 0; i_ppd < (int)(sizeof(optical_sensor)/sizeof(optical_sensor[0])); i_ppd++){
					c_ppd.displacement[i_ppd] = optical_sensor[i_ppd];
				}

				calculation_posDummies(&c_ppd);
				// calculation crossing ball
				for(i_ccd = 0; i_ccd < (int)(sizeof(ball1)/sizeof(ball1[0])); i_ccd++){
					c_cb[i_ccd].ball1_x = ball1[0];
					c_cb[i_ccd].ball1_y = ball1[1];
					c_cb[i_ccd].ball2_x = ball2[0];
					c_cb[i_ccd].ball2_y = ball2[1];
					c_cb[i_ccd].first_reflection_x  = f_d.first_reflectionX;
					c_cb[i_ccd].first_reflection_y  = f_d.first_reflectionY;
					c_cb[i_ccd].second_reflection_x = f_d.second_reflectionX;
					c_cb[i_ccd].second_reflection_y = f_d.second_reflectionY;
					c_cb[i_ccd].tilted   = f_d.tilted;
					c_cb[i_ccd].time_B2B = time_B2B;
                    
					if(i_ccd == 0){
						for(i_ccdCPU = 0; i_ccdCPU < (int)(sizeof(x_posOfCPU)/sizeof(x_posOfCPU[0])); i_ccdCPU++){
							c_cb[i_ccd].x_positions[i_ccdCPU] = x_posOfCPU[i_ccdCPU];
						}
					}else if(i_ccd == 1){
						for(i_ccdHUM = 0; i_ccdHUM < (int)(sizeof(x_posOfHUM)/sizeof(x_posOfHUM[0])); i_ccdHUM++){
							c_cb[i_ccd].x_positions[i_ccdHUM] = x_posOfHUM[i_ccdHUM];
						}
					}              
					calculation_crossingBall(&c_cb[i_ccd]);
				}
				// calculation displacement
				c_doa.tilted             = f_d.tilted;
				specific_directionOfBall = (UDINT) strcpy(c_doa.specific_direction,f_d.specific_direction);
				
				for(i_cdoa1 = 0; i_cdoa1 < (int)(sizeof(c_cb[1].count_axesIntersection)/sizeof(c_cb[1].count_axesIntersection[0])); i_cdoa1++){
					c_doa.count_axesIntersectionHUM[i_cdoa1] = c_cb[1].count_axesIntersection[i_cdoa1];
				}
				for(i_cdoa2 = 0; i_cdoa2 < (int)(sizeof(c_cb[0].act_posOfAxesY)/sizeof(c_cb[0].act_posOfAxesY[0])); i_cdoa2++){
					c_doa.act_posOfAxesCPU_Y[i_cdoa2]    = c_cb[0].act_posOfAxesY[i_cdoa2];
					c_doa.time_axisIntersection[i_cdoa2] = c_cb[0].time_axisIntersection[i_cdoa2];
					c_doa.act_displacementCPU[i_cdoa2]   = mp_Axis.mp_cyclicSetLinear[i_cdoa2].Info.SlavePosition;
					c_doa.reversed_HUM[i_cdoa2]          = reflex_sensor[i_cdoa2];
				}
				c_doa.act_posOfAxesHUM_Y[0] = c_cb[1].act_posOfAxesY[3];
				c_doa.act_posOfAxesHUM_Y[1] = c_cb[1].act_posOfAxesY[2];
				c_doa.act_posOfAxesHUM_Y[2] = c_cb[1].act_posOfAxesY[1];
				c_doa.act_posOfAxesHUM_Y[3] = c_cb[1].act_posOfAxesY[0];
				for(i_cdoa3 = 0; i_cdoa3 < (int)(sizeof(c_ppd.actual_positionsOfDummies)/sizeof(c_ppd.actual_positionsOfDummies[0])); i_cdoa3++){
					c_doa.act_posOfDummiesH[i_cdoa3] = c_ppd.actual_positionsOfDummies[i_cdoa3];
				}
				c_doa.x_posOfBall[0] = ball1[0];
				c_doa.x_posOfBall[1] = ball2[0];
				calculation_displacementOfAxes(&c_doa);
				
				for(i_def = 0; i_def <= max_numberOfFormation - 1; i_def++){
					if(!isnan(c_doa.velocity[i_def])){
						// linear parameters adjustment
						axes_c[i_def].linear_param.acceleration = c_doa.acceleration[i_def];
						axes_c[i_def].linear_param.deceleration = c_doa.deceleration[i_def];
						axes_c[i_def].linear_param.velocity     = c_doa.velocity[i_def];
						axes_c[i_def].linear_param.displacement = c_doa.displacement[i_def];
						// rotary parameters aadjustment
						axes_c[i_def].rotary_param.acceleration = 125000;
						axes_c[i_def].rotary_param.deceleration = 125000;
						axes_c[i_def].rotary_param.velocity		= 10000;
						if(i_def < (c_cb[0].count_axesIntersection[0] - 1)){
							axes_c[i_def].rotary_param.displacement = -250;
						}else{
							axes_c[i_def].rotary_param.displacement = 250;
						}
					}
				}
				
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					c_dp = 0;
					
					if(c_dp == 0){
						SOCCER_TABLE_STEP = RST_MOVE_INTO_DEFENSE_POS1;
					}
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_MOVE_INTO_DEFENSE_POS1:
			{
				/*************************************** DEF. MOVE no.1 ******************************************/
				for(i_dp1 = 0; i_dp1 <= max_numberOfFormation - 1; i_dp1++){
					axes_c[i_dp1].start_move = 1;
				}
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					c_dp		      = 0;
					SOCCER_TABLE_STEP = RST_MOVE_INTO_DEFENSE_POS2;
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_MOVE_INTO_DEFENSE_POS2:
			{
				/*************************************** DEF. MOVE no.2 ******************************************/
				for(i_dp2 = 0; i_dp2 <= max_numberOfFormation - 1; i_dp2++){
					if(axes_c[i_dp2].successfully == 1){
						axes_c[i_dp2].start_move = 0;
						c_dp++;
					}
				}
				
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					if(c_dp == max_numberOfFormation){
						SOCCER_TABLE_STEP = RST_INITIALIZATION_5;
					}
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_ATTACK_MODE_SHOOT1:
			{
				/*************************************** ATTACK MODE SHOOT no.1 *************************************/
				for(i_shoot = 0; i_shoot <= max_numberOfFormation - 1; i_shoot++){
					if(index_ofAxesAM < i_shoot){
						mp_Axis.mp_cyclicSetRotary[index_ofAxesAM].Position = 600;
					}
				}
				
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					SOCCER_TABLE_STEP = RST_ATTACK_MODE_SHOOT2;
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_ATTACK_MODE_SHOOT2:
			{
				/*************************************** ATTACK MODE SHOOT no.2 *************************************/
				ball_shoot.axes_control = &axes_c[index_ofAxesAM];
				ball_shoot.rotary_axes  = &mp_Axis.mp_cyclicSetRotary[index_ofAxesAM];
				ball_shoot.start_shoot	= 1;
				ball_shooting(&ball_shoot);
				
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					if(ball_shoot.start_shoot == 1){
						if(ball_shoot.successfully == 1){
							ball_shoot.start_shoot = 0;
						
							if(ball_shoot.start_shoot == 0){
								SOCCER_TABLE_STEP = RST_ATTACK_MODE_SHOOT3;
							}
						}
					}
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_ATTACK_MODE_SHOOT3:
			{
				/*************************************** ATTACK MODE SHOOT no.3 *************************************/
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					if(cam_det.Results.AxisXOld != ball1[0] && cam_det.Results.AxisYOld != ball1[1]){
						SOCCER_TABLE_STEP = RST_INITIALIZATION_5;
					}
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_ATTACK_MODE_TURN_POS:
			{
				/*************************************** ATTACK MODE TURN POS. *************************************/
				turn_pos.axes_control = &axes_c[index_ofAxesAM];
				turn_pos.linear_axes  = &mp_Axis.mp_cyclicSetLinear[index_ofAxesAM];
				turn_pos.rotary_axes  = &mp_Axis.mp_cyclicSetRotary[index_ofAxesAM];
				turn_position(&turn_pos);
				
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					if(turn_pos.start_turn == 1){
						if(turn_pos.successfully == 1){
							turn_pos.start_turn = 0;
						
							if(turn_pos.start_turn == 0){
								SOCCER_TABLE_STEP = RST_INITIALIZATION_5;
							}
						}
					}
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_SAFETY:
			{	
				/******************************************* SAFETY STATE *********************************************/
				if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else{
					// power off engines
					for(i_bs2 = 0; i_bs2 <= max_numberOfFormation - 1; i_bs2++){
						mp_Axis.mp_axisRotary[i_bs2].Power = 0;
						mp_Axis.mp_axisLinear[i_bs2].Power = 0;
					}
					
					if(ESTOP == 1 && OSSD2 == 1){
						// reset safety
						if(reset_safetyESTOP == 0){
							reset_safetyESTOP = 1;
						}
						// reset counter
						c_bState = 0;
						// change state
						if(reset_safetyESTOP == 1){
							SOCCER_TABLE_STEP = RST_AFTER_SAFETY;
						}
					}
				}
			}
			break;
		case RST_AFTER_SAFETY:
			{
				/************************************ AFTER SAFETY: POWER ON AXES *************************************/
				for(i_bs = 0; i_bs <= max_numberOfFormation - 1; i_bs++){
					mp_Axis.mp_axisRotary[i_bs].Power = 1;
					mp_Axis.mp_axisLinear[i_bs].Power = 1;
					
					if(mp_Axis.mp_axisRotary[i_bs].PowerOn == 1 && mp_Axis.mp_axisLinear[i_bs].PowerOn == 1){
						if(c_bState == i_bs){
							c_bState++;
						}
					}
					
				}
				
				if(c_bState == max_numberOfFormation){
					if(reset_safetyESTOP == 1){
						reset_safetyESTOP = 0;
					}
					
					if(reset_safetyESTOP == 0){
						if(ESTOP == 0 || OSSD2 == 0){
							SOCCER_TABLE_STEP = RST_SAFETY;
						}else if(e_detect.err_detect == 1){
							SOCCER_TABLE_STEP = RST_ERROR;
						}else {
							SOCCER_TABLE_STEP = BEFORE_STATE;
						}
					}
				}else if(ESTOP == 0 || OSSD2 == 0){				
					reset_safetyESTOP = 0;
					if(reset_safetyESTOP == 0){
						SOCCER_TABLE_STEP = RST_SAFETY;
					}
				}
			}
			break;
		case RST_ERROR:
			{
				/******************************************* ERROR STATE **********************************************/
				for(i_rstE = 0; i_rstE <= max_numberOfFormation - 1; i_rstE++){
					mp_Axis.mp_axisRotary[i_rstE].ErrorReset = 0;
					mp_Axis.mp_axisLinear[i_rstE].ErrorReset = 0;
					
					if(mp_Axis.mp_axisRotary[i_rstE].ErrorReset == 0 && mp_Axis.mp_axisLinear[i_rstE].ErrorReset == 0){
						// rotary error reset -> On
						if(mp_Axis.mp_axisRotary[i_rstE].Error == 1){
							mp_Axis.mp_axisRotary[i_rstE].ErrorReset = 1;
						}
						// linear error reset -> On
						if(mp_Axis.mp_axisLinear[i_rstE].Error == 1){
							mp_Axis.mp_axisLinear[i_rstE].ErrorReset = 1;
						}
					}
				}
				
				for(i_rstE2 = 0; i_rstE2 <= max_numberOfFormation - 1; i_rstE2++){
					// rotary error reset -> Off
					if(mp_Axis.mp_axisRotary[i_rstE2].Error == 0 && mp_Axis.mp_axisRotary[i_rstE2].ErrorReset == 1){
						mp_Axis.mp_axisRotary[i_rstE2].ErrorReset = 0;
					}
					// linear error reset -> Off
					if(mp_Axis.mp_axisLinear[i_rstE2].Error == 0 && mp_Axis.mp_axisLinear[i_rstE2].ErrorReset == 1){
						mp_Axis.mp_axisLinear[i_rstE2].ErrorReset = 0;
					}
				}
									
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else {
					SOCCER_TABLE_STEP = BEFORE_STATE;
				}
			}
			break;
		case RST_STOP:
			{
				/****************************************** STOP -> MODE *********************************************/
				EXIT_GAME = 0;
				
				for(i_stop = 0; i_stop <= max_numberOfFormation - 1; i_stop++){
					mp_Axis.mp_axisLinear[i_stop].Stop = 1;
					mp_Axis.mp_axisRotary[i_stop].Stop = 1;
				}
				
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					STOP_GAME = 0;
					EXIT_GAME = 0;
					c_astop   = 0;
					if(STOP_GAME == 0 || EXIT_GAME == 0){
						START_GAME		  = 0;
						RESTART_GAME	  = 0;
						// stop searching 
						cam_det.Search = 0;
						SOCCER_TABLE_STEP = RST_AFTER_STOP;
					}
				}
			}
			break;
		case RST_AFTER_STOP:
			{
				/************************************ AFTER STOP -> MODE ********************************************/
				for(i_astop = 0; i_astop <= max_numberOfFormation - 1; i_astop++){
					mp_Axis.mp_axisLinear[i_astop].Stop = 0;
					mp_Axis.mp_axisRotary[i_astop].Stop = 0;
					
										
					if(mp_Axis.mp_axisLinear[i_astop].Stopped == 0 && mp_Axis.mp_axisRotary[i_astop].Stopped == 0){
						c_astop++;
					}
				}
				
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					if(c_astop == max_numberOfFormation){
						SOCCER_TABLE_STEP = RST_NULL_POS1;
					}
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_NULL_POS1:
			{
				/****************************************** MOVE NULL POS no.1 ***************************************/
				for(i_mnp1 = 0; i_mnp1 <= max_numberOfFormation - 1; i_mnp1++){
					// axes parameters
					// linear
					axes_c[i_int3].linear_param.acceleration = 489000.0;
					axes_c[i_int3].linear_param.deceleration = 489000.0;
					// rotary
					axes_c[i_int3].rotary_param.acceleration = 125000;
					axes_c[i_int3].rotary_param.deceleration = 125000;
					// axes cyclic parameters
					// linear
					axes_c[i_int3].linear_param.velocity 	 = 29000.0;
					axes_c[i_int3].linear_param.displacement = 0;
					// rotary
					axes_c[i_int3].rotary_param.velocity     = 10000;
					axes_c[i_int3].rotary_param.displacement = -250;
					// start move
					axes_c[i_mnp1].start_move = 1;
				}
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					c_nmp 			  = 0;
					SOCCER_TABLE_STEP = RST_NULL_POS2;
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
		case RST_NULL_POS2:
			{
				/****************************************** MOVE NULL POS no.1 ***************************************/
				for(i_mnp2 = 0; i_mnp2 <= max_numberOfFormation - 1; i_mnp2++){
					if(axes_c[i_mnp2].successfully == 1){
						axes_c[i_mnp2].start_move = 0;
						c_nmp++;
					}
				}
				
				if(ESTOP == 0 || OSSD2 == 0){
					SOCCER_TABLE_STEP = RST_SAFETY;
				}else if(e_detect.err_detect == 1){
					SOCCER_TABLE_STEP = RST_ERROR;
				}else if((START_GAME == 1 && STOP_GAME == 0) || (RESTART_GAME == 1 && STOP_GAME == 0)){
					if(c_nmp == max_numberOfFormation){
						SOCCER_TABLE_STEP = RST_INITIALIZATION_4;
					}
				}else if(STOP_GAME == 1 || EXIT_GAME == 1){
					START_GAME		  = 0;
					RESTART_GAME	  = 0;
					// stop searching 
					cam_det.Search = 0;
					SOCCER_TABLE_STEP = RST_STOP;
				}
			}
			break;
	}// end switch
	
	/************************************ VISUALIZATION **********************************/
	// images power and home axes
	for(i_visPH = 0; i_visPH <= max_numberOfFormation - 1; i_visPH++){
		if(mp_Axis.mp_axisLinear[i_visPH].PowerOn == 1){
			vis_linearPower[i_visPH] = 1;
		}else{
			vis_linearPower[i_visPH] = 0;
		}
		if(mp_Axis.mp_axisLinear[i_visPH].IsHomed == 1){
			vis_linearHome[i_visPH] = 1;
		}else{
			vis_linearHome[i_visPH] = 0;
		}
		if(mp_Axis.mp_axisRotary[i_visPH].PowerOn == 1){
			vis_rotaryPower[i_visPH] = 1;
		}else{
			vis_rotaryPower[i_visPH] = 0;
		}
		if(mp_Axis.mp_axisRotary[i_visPH].IsHomed == 1){
			vis_rotaryHome[i_visPH] = 1;
		}else{
			vis_rotaryHome[i_visPH] = 0;
		}
	}
	// images warning and safety
	if(ESTOP == 0 || OSSD2 == 0){
		vis_safety  = 1;
		vis_warning = 1;
	}else if(e_detect.err_detect == 1){
		vis_safety  = 0;
		vis_warning = 1;
	}else{
		vis_safety  = 0;
		vis_warning = 0;
	}
	m_ofScore.start_measurement   = START_GAME;
	m_ofScore.exit_game			  = EXIT_GAME;
	m_ofScore.restart_measurement = RESTART_GAME;
	if(STOP_GAME == 1){
		m_ofScore.pause = 1;
	}else{
		m_ofScore.pause = 0;
	}
	/************************** Call function & function blocks **************************/
	// AlarmX
	MpAlarmXCore(&mp_alarmX.mp_core);
	MpAlarmXListUI(&mp_alarmX.mp_listUI);
	MpAlarmXHistory(&mp_alarmX.mp_history);
	MpAlarmXHistoryUI(&mp_alarmX.mp_historyUI);
	// Active AxisBasic & AxisCyclicSet -> through the individual functions
	start_axesBasic(max_numberOfFormation,&mp_Axis.mp_axisLinear,&mp_Axis.mp_axisRotary);
	start_axesCyclic(max_numberOfFormation,&mp_Axis.mp_cyclicSetLinear,&mp_Axis.mp_cyclicSetRotary);
	// Camera
	FBCamera(&cam_det);
	// Detection score
	GoalKeeper(&GoalKeeper_0);
	// Measuremet of score
	measurement_ofScore(&m_ofScore);
	// Light
	Light(&Light_0);
	if(SOCCER_TABLE_STEP >= 1){
		// axes control
		axes_control(&axes_c[0]);
		//axes_control(&axes_c[1]);
		//axes_control(&axes_c[2]);
		//axes_control(&axes_c[3]);
	}
	// error detection Axes
	// error rotary
	e_detect.rotary_ERR[0] = mp_Axis.mp_axisRotary[0].Error;
	e_detect.rotary_ERR[1] = 0;
	e_detect.rotary_ERR[2] = 0;
	e_detect.rotary_ERR[3] = 0;
	// error linear
	e_detect.linear_ERR[0] = mp_Axis.mp_axisLinear[0].Error;
	e_detect.linear_ERR[1] = 0;
	e_detect.linear_ERR[2] = 0;
	e_detect.linear_ERR[3] = 0;
	// call function error detection
	err_detection(&e_detect);

}






