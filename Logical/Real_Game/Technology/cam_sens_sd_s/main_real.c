/*********************************************************************************************
* B&R Automation - Perfection in Automation (https://www.br-automation.com)
    ******************************************************************************************
    * Program 	    : Bachelor's Thesis
    * Author  	    : Lubomir Bubenik, Radek Otradovský
    * Created 	    : date ... 
	* University    : Brno University of Technology(BUT)
	* Faculty       : Faculty of Mechanical Engineering(FME), Faculty of Electrical Engineering and Communication(FEEC)
**********************************************************************************************
* Implementation OF PROGRAM cam_sens_sd_s(Real_Game/Technology/sim_cam_sens_sd_s/main_real.c)
**********************************************************************************************/

#include <bur/plctypes.h>
#include <AsIecCon.h>
#include <sys_lib.h>



#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

_GLOBAL FBCamera_typ FBCamera_0;


void _INIT ProgramInit(void)
{
	FBCamera_0.Enable = 0;
}

void _CYCLIC ProgramCyclic(void)
{
	FBCamera(&FBCamera_0);

}

void _EXIT ProgramExit(void)
{
	// Insert code here 

}



