/*********************************************************************************************
* B&R Automation - Perfection in Automation (https://www.br-automation.com)
    ******************************************************************************************
    * Program 	    : Master's Thesis - Soccer Table (Table Football - real game)
    * Author  	    : Roman Parak
    * Created 	    : date ... 
	* University    : Brno University of Technology(BUT)
	* Faculty       : Faculty of Mechanical Engineering(FME)
	* Study Program : Applied Computer Science and Control
	* Institute     : Institute of Automation and Computer Science
**********************************************************************************************
* Implementation OF PROGRAM table_football(Real_Game/Technolog/table_football/Program/table_football.h)
**********************************************************************************************/

/*************************** LIBRARIES *********************************/
#include <bur/plc.h>
#include <bur/plctypes.h>
#include <stdio.h>
#include <math.h>

#include "rp_funcx1.h"
#include "Structures/table_football_str.h"
#include "Functions/mapp.h"

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

/*************************** DEFINITIONS *******************************/
#define EACH_FORMATION 1;

/************************ LOCAL VARIABLES ******************************/
// struct - MpAlarmX
_LOCAL MpAlarmXListUIConnectType AlarmListUI_ConnectType;
_LOCAL MpAlarmXHistoryUIConnectType AlarmHistoryUI_ConnectType;
// udint
_LOCAL UDINT alarm_device_address;
// bool
_LOCAL BOOL start;
_LOCAL BOOL stop;
// usint
_LOCAL USINT max_numberOfFormation;
_LOCAL USINT i_axisNum;
// lreal
_LOCAL LREAL temp_lin;
_LOCAL LREAL temp_rot;
_LOCAL LREAL define_posRotary;
_LOCAL LREAL angle_ofRotation;
// state machine
_LOCAL rp_MainSteps soccer_step;

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
    gLinkAxes_linear[0] = gk_mappAxisL;
    /*
    gLinkAxes_linear[1] = df_mappAxisL;
    gLinkAxes_linear[2] = md_mappAxisL;
    gLinkAxes_linear[3] = fw_mappAxisL;
    */
    // rotary
    gLinkAxes_rotary[0] = gk_mappAxisR;
   	/*
    gLinkAxes_rotary[1] = df_mappAxisR;
    gLinkAxes_rotary[2] = md_mappAxisR;
    gLinkAxes_rotary[3] = fw_mappAxisR;
    */
    /************************************ Control of AlarmX ************************************/
	
    // adjustment device name
    alarm_device_address = (UDINT) strcpy(mp_alarmX.deviceName_no1_exp,"EXPORT_HISTORY");
    // MpAlarmX Core
    mp_alarmX.mp_core.MpLink         = &gAlarmXCore;
    mp_alarmX.mp_core.Enable         = 1;
    // MpAlarmX ListUI
    mp_alarmX.mp_listUI.MpLink       = &gAlarmXCore;
    mp_alarmX.mp_listUI.Enable       = 1;
    mp_alarmX.mp_listUI.UIConnect    = &AlarmListUI_ConnectType;
    // MpAlarmX History
    mp_alarmX.mp_history.MpLink      = &gAlarmXHistory;
    mp_alarmX.mp_history.Enable      = 1;
    mp_alarmX.mp_history.DeviceName  = &mp_alarmX.deviceName_no1_exp;
    // MpAlarmX HistoryUI
    mp_alarmX.mp_historyUI.MpLink    = &gAlarmXHistory;
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
		// initialization parameters -> linear
		mp_Axis.param_axisLinear[i_axisNum].Home.Mode 	 		 	     = mpAXIS_HOME_MODE_BLOCK_TORQUE;
		mp_Axis.param_axisLinear[i_axisNum].Home.Position 		  	     = 900;
		mp_Axis.param_axisLinear[i_axisNum].Home.StartVelocity   		 = 350;
		mp_Axis.param_axisLinear[i_axisNum].Home.HomingVelocity  		 = 450;
		mp_Axis.param_axisLinear[i_axisNum].Home.Acceleration    		 = 350;
		mp_Axis.param_axisLinear[i_axisNum].Home.StartDirection  		 = mpAXIS_HOME_DIR_POSITIVE;
		mp_Axis.param_axisLinear[i_axisNum].Home.HomingDirection 		 = mpAXIS_HOME_DIR_NEGATIVE;
		mp_Axis.param_axisLinear[i_axisNum].Home.TorqueLimit	 		 = 0.05;
		mp_Axis.param_axisLinear[i_axisNum].Home.PositionErrorStopLimit	 = 900;
        // linear cyclic set
        mp_Axis.mp_cyclicSetLinear[i_axisNum].Enable     = 1;
        mp_Axis.mp_cyclicSetLinear[i_axisNum].MpLink     = &gLinkAxes_linear[i_axisNum];
        mp_Axis.mp_cyclicSetLinear[i_axisNum].Parameters = &mp_Axis.param_cyclicSetLinear[i_axisNum];
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
		// config
		mp_Axis.mp_configAxisRotary[i_axisNum].Enable 		 = 1;
		mp_Axis.mp_configAxisRotary[i_axisNum].MpLink 		 = &gLinkAxes_rotary[i_axisNum];
		mp_Axis.mp_configAxisRotary[i_axisNum].Configuration = &mp_Axis.param_configAxisRotary[i_axisNum];
		// temperature - linear
		mp_Axis.param_axisLinear[i_axisNum].CyclicRead.MotorTempMode = mpAXIS_READ_POLLING_1s;
		// temperature - rotary
		mp_Axis.param_axisRotary[i_axisNum].CyclicRead.MotorTempMode = mpAXIS_READ_POLLING_1s;
    }
	// initializatiom temp
	temp_lin = 0;
	temp_rot = 0;
	define_posRotary = 118520697;
	angle_ofRotation = 0;
	// initialization state machine
	soccer_step = STEP_INITIALIZATION;
}

/**********************************************************************************************************/
/********************************************** MAIN PROGRAM **********************************************/
/**********************************************************************************************************/
void _CYCLIC ProgramCyclic(void)
{    
	// initializatiom temp
	temp_lin = mp_Axis.mp_axisLinear[0].Info.CyclicRead.MotorTemperature.Value;
	temp_rot = mp_Axis.mp_axisRotary[0].Info.CyclicRead.MotorTemperature.Value;
	

    /************************** Call function & function blocks **************************/
    // AlarmX
    MpAlarmXCore(&mp_alarmX.mp_core);
    MpAlarmXListUI(&mp_alarmX.mp_listUI);
    MpAlarmXHistory(&mp_alarmX.mp_history);
    MpAlarmXHistoryUI(&mp_alarmX.mp_historyUI);
    // Active AxisBasic & AxisCyclicSet -> through the individual functions
    start_axesBasic(max_numberOfFormation,&mp_Axis.mp_axisLinear,&mp_Axis.mp_axisRotary);
    start_axesCyclic(max_numberOfFormation,&mp_Axis.mp_cyclicSetLinear,&mp_Axis.mp_cyclicSetRotary);

}






