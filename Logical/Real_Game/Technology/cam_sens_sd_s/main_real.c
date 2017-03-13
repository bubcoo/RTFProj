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

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif


_GLOBAL FBCamera_typ FBCamera_0;
_GLOBAL Light_typ Light_0;
 
void _INIT ProgramInit(void)
{
	//strcpy(pSrc,"image.jpg");
}

void _CYCLIC ProgramCyclic(void)
{
	
	FBCamera(&FBCamera_0);
	Light(&Light_0);
}

void _EXIT ProgramExit(void)
{
	// Insert code here 

}



