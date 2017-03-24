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
#include <AsMem.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif


_GLOBAL FBCamera_typ FBCamera_0;
_GLOBAL Light_typ Light_0;
_GLOBAL GoalKeeper_typ GoalKeeper_0;
_LOCAL RTCtime_typ ActTime_tmp;
_LOCAL INT Y[4000];
_LOCAL UINT i;

void _INIT ProgramInit(void)
{
	FBCamera_0.Enable = 1;
	memset((UDINT)Y,10,(UDINT)sizeof(Y));
	i = 0;
}

void _CYCLIC ProgramCyclic(void)
{
	
	FBCamera(&FBCamera_0);
	Light(&Light_0);
	GoalKeeper(&GoalKeeper_0);
	
//	if((memcmp((UDINT)(FBCamera_0.Results.ActTime),(UDINT)ActTime_tmp,(UDINT)sizeof(FBCamera_0.Results.ActTime))) != 0){
	//	memcpy((UDINT)(FBCamera_0.Results.ActTime),(UDINT)ActTime_tmp,(UDINT)sizeof(FBCamera_0.Results.ActTime));
	if (i < 4000){
		Y[(INT)(FBCamera_0.Results.AxisX*0.33057851239669421487603305785124)] = (INT)((FBCamera_0.Results.AxisY*0,07341)+225);
			i++;
		}
	else
		i=0;
//	}
}

void _EXIT ProgramExit(void)
{
	// Insert code here 

}



