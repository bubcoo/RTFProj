/*********************************************************************************************
* B&R Automation - Perfection in Automation (https://www.br-automation.com)
    ******************************************************************************************
    * Program 	    : Bachelor's Thesis
    * Author  	    : Lubo Bubco, Radek Otradovský
    * Created 	    : date ... 
	* University    : Brno University of Technology(BUT)
	* Faculty       : Faculty of Mechanical Engineering(FME), Faculty of Electrical Engineering and Communication(FEEC)
**********************************************************************************************
* Implementation OF PROGRAM sim_cam_sens_sd_s(Simulation/Technology/sim_cam_sens_sd_s/main_sim.c)
**********************************************************************************************/

#include <bur/plctypes.h>
#include <string.h>
#include <math.h>

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

_LOCAL struct calculation_displacementOfAxes c_dispOfA;
_LOCAL UDINT str;

void _INIT ProgramInit(void)
{
	c_dispOfA.tilted = 1;
	str = (UDINT) strcpy(c_dispOfA.specific_direction, "up_backward");
	c_dispOfA.count_axesIntersectionHUM[0] = 2;
	c_dispOfA.count_axesIntersectionHUM[1] = 1;
	c_dispOfA.act_posOfAxesCPU_Y[0] = 150;
	c_dispOfA.act_posOfAxesCPU_Y[1] = 1350;
	c_dispOfA.act_posOfAxesCPU_Y[2] = 3280;
	c_dispOfA.act_posOfAxesCPU_Y[3] = 2080;
	c_dispOfA.time_axisIntersection[0] = 0.2280;
	c_dispOfA.time_axisIntersection[1] = 0.1710;
	c_dispOfA.time_axisIntersection[2] = 0.0570;
	c_dispOfA.time_axisIntersection[3] = 0.0038;
	c_dispOfA.act_displacementCPU[0] = 0;
	c_dispOfA.act_displacementCPU[1] = 0;
	c_dispOfA.act_displacementCPU[2] = 0;
	c_dispOfA.act_displacementCPU[3] = 0;
	c_dispOfA.reversed_HUM[0] = 1;
	c_dispOfA.reversed_HUM[1] = 1;
	c_dispOfA.reversed_HUM[2] = 1;
	c_dispOfA.reversed_HUM[3] = 1;
	c_dispOfA.act_posOfDummiesH[0] = 0;
	c_dispOfA.act_posOfDummiesH[1] = -1200;
	c_dispOfA.act_posOfDummiesH[2] = 1200;
	c_dispOfA.act_posOfDummiesH[3] = -2400;
	c_dispOfA.act_posOfDummiesH[4] = -1200;
	c_dispOfA.act_posOfDummiesH[5] = 0;
	c_dispOfA.act_posOfDummiesH[6] = 1200;
	c_dispOfA.act_posOfDummiesH[7] = 2400;
	c_dispOfA.act_posOfDummiesH[8] = -2100;
	c_dispOfA.act_posOfDummiesH[9] = 0;
	c_dispOfA.act_posOfDummiesH[10] = 2100;
	c_dispOfA.act_posOfAxesHUM_Y[0] = 2080;
	c_dispOfA.act_posOfAxesHUM_Y[1] = 2080;
	c_dispOfA.act_posOfAxesHUM_Y[2] = 2080;
	c_dispOfA.act_posOfAxesHUM_Y[3] = 2550;
	c_dispOfA.x_posOfBall[0] = 6900;
	c_dispOfA.x_posOfBall[1] = 6800;
}

void _CYCLIC ProgramCyclic(void)
{
	calculation_displacementOfAxes(&c_dispOfA);
}


