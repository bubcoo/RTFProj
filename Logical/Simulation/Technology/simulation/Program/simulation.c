/*********************************************************************************************
* B&R Automation - Perfection in Automation (https://www.br-automation.com)
    ******************************************************************************************
    * Program 	    : Master's Thesis - Soccer Table (Simulation)
    * Author  	    : Roman Parak
    * Created 	    : date ... 
	* University    : Brno University of Technology(BUT)
	* Faculty       : Faculty of Mechanical Engineering(FME)
	* Study Program : Applied Computer Science and Control
	* Institute     : Institute of Automation and Computer Science
**********************************************************************************************
* Implementation OF PROGRAM simulation(Simulation/Technology/simulation/Program/simulation.c)
**********************************************************************************************/

/*************************** LIBRARIES *********************************/
#include <bur/plc.h>
#include <bur/plctypes.h>
#include <math.h>

#include "rp_funcx1.h"
#include "Structures/simulation_str.h"

#include "Functions/sim_mapp.h"

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

/*************************** DEFINITIONS *******************************/
#define EACH_FORMATION 1;

/************************ LOCAL VARIABLES ******************************/
_LOCAL struct forecast_direction fD;
_LOCAL struct calculation_posDummiesOpponent cppd;
// struct - MpAlarmX
_LOCAL MpAlarmXListUIConnectType AlarmListUI_ConnectType;
_LOCAL MpAlarmXHistoryUIConnectType AlarmHistoryUI_ConnectType;
// udint
_LOCAL UDINT alarm_device_address;
// bool
_LOCAL BOOL start_forecast;
_LOCAL BOOL start;
_LOCAL BOOL stop;
// usint
_LOCAL USINT max_numberOfFormation;
_LOCAL USINT i_axisNum;
// state machine
_LOCAL rp_MainSteps simulation_step;
// lreal
_LOCAL LREAL testNAN;
_LOCAL REAL pp[4];
_LOCAL REAL pp_N[4];
_LOCAL INT i_pp;
/**********************************************************************************************************/
/********************************************** INIT PROGRAM **********************************************/
/**********************************************************************************************************/
void _INIT ProgramInit(void)
{
    /*********************************** declaration variables **********************************/
    // generally
    max_numberOfFormation = EACH_FORMATION;
    // axis type -> MAPP
    // linear
	gLinkAxes_linear[0] = gk_mappAxisLS;
    gLinkAxes_linear[1] = df_mappAxisLS;
    gLinkAxes_linear[2] = md_mappAxisLS;
    gLinkAxes_linear[3] = fw_mappAxisLS;
    // rotary
    gLinkAxes_rotary[0] = gk_mappAxisRS;
    gLinkAxes_rotary[1] = df_mappAxisRS;
    gLinkAxes_rotary[2] = md_mappAxisRS;
    gLinkAxes_rotary[3] = fw_mappAxisRS;
    
    /************************************ control of AlarmX ************************************/
    // adjustment device name
    alarm_device_address = (UDINT) strcpy(mp_alarmX.deviceName_no1_exp,"EXPORT_HISTORY");
    // MpAlarmX Core
    mp_alarmX.mp_core.MpLink         = &gAlarmXCoreS;
    mp_alarmX.mp_core.Enable         = 1;
    // MpAlarmX ListUI
    mp_alarmX.mp_listUI.MpLink       = &gAlarmXCoreS;
    mp_alarmX.mp_listUI.Enable       = 1;
    mp_alarmX.mp_listUI.UIConnect    = &AlarmListUI_ConnectType;
    // MpAlarmX History
    mp_alarmX.mp_history.MpLink      = &gAlarmXHistoryS;
    mp_alarmX.mp_history.Enable      = 1;
    mp_alarmX.mp_history.DeviceName  = &mp_alarmX.deviceName_no1_exp;
    // MpAlarmX HistoryUI
    mp_alarmX.mp_historyUI.MpLink    = &gAlarmXHistoryS;
    mp_alarmX.mp_historyUI.Enable    = 1;
    mp_alarmX.mp_historyUI.UIConnect = &AlarmHistoryUI_ConnectType;
    
    /************************************* control of axes **************************************/
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
		mp_Axis.param_axisLinear[i_axisNum].CyclicRead.MotorTempMode = mpAXIS_READ_POLLING_5s;
		// temperature - rotary
		mp_Axis.param_axisRotary[i_axisNum].CyclicRead.MotorTempMode = mpAXIS_READ_POLLING_5s;
    }
	// variables
	start = 0;
	start_forecast = 0;
	// state machine
	simulation_step = STEP_INITIALIZATION1;
	
	testNAN = sqrt(-1);
}

/**********************************************************************************************************/
/********************************************** MAIN PROGRAM **********************************************/
/**********************************************************************************************************/
void _CYCLIC ProgramCyclic(void)
{  
	/*
	pp[0] = 1;
	pp[1] = 8;
	pp[2] = 11;
	pp[3] = 4;
	qsort(pp,(sizeof(pp)/sizeof(pp[0])),sizeof(REAL),cmpfunc);
	
	for(i_pp = 0; i_pp <= (int)(sizeof(pp)/sizeof(pp[0])); i_pp++) // done
		pp_N[i_pp] = pp[i_pp];
	*/
	//grp.actual_position = 118529697;
	//grp.define_position = 118520697;
	//get_rotationalPostition(&grp); // done
	//forecast_direction(&fD); // done
	//calculation_posDummiesOpponent(&cppd); // done
	// calculation crossing ball -> done
    /************************** call function & function blocks **************************/
    // AlarmX
    MpAlarmXCore(&mp_alarmX.mp_core);
    MpAlarmXListUI(&mp_alarmX.mp_listUI);
    MpAlarmXHistory(&mp_alarmX.mp_history);
    MpAlarmXHistoryUI(&mp_alarmX.mp_historyUI);
    // Active AxisBasic & AxisCyclicSet -> through the individual functions
    start_axesBasic(max_numberOfFormation,&mp_Axis.mp_axisLinear,&mp_Axis.mp_axisRotary);
    start_axesCyclic(max_numberOfFormation,&mp_Axis.mp_cyclicSetLinear,&mp_Axis.mp_cyclicSetRotary);	
}





