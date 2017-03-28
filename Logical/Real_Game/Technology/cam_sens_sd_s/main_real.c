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
#define Y_AXIS 100

_GLOBAL FBCamera_typ FBCamera_0;
_GLOBAL Light_typ Light_0;
_GLOBAL GoalKeeper_typ GoalKeeper_0;
_LOCAL RTCtime_typ ActTime_tmp;
_LOCAL LineChartAxis_type LineChartBuffer[Y_AXIS];
_LOCAL plcbit releaseBuffer;
_LOCAL INT LineChart[Y_AXIS];
_LOCAL UINT i;

void _INIT ProgramInit(void)
{
	FBCamera_0.Enable = 1;
	i = 100;
}

void _CYCLIC ProgramCyclic(void)
{
	
	FBCamera(&FBCamera_0);
	Light(&Light_0);
	GoalKeeper(&GoalKeeper_0);
	
/*	if (GoalKeeper_0.isGoal1 || releaseBuffer){
		int pom;
		int koef;
		int j;
		int k=0;
		releaseBuffer = 1;
		if (i>0){
			if ((pom = (abs((LineChartBuffer[k].X)-(LineChartBuffer[k+1].X)))) != 0){
				koef = (LineChartBuffer[k+1].X)-(LineChartBuffer[k].X)/pom;
				for(j = 0;j<pom;++j){
					if (i<0){
						j=pom;
						releaseBuffer = 0;
					}
					else{
						LineChart[i] = LineChartBuffer[i].Y*koef;
						i--;
					}
				}
			}
		}
		else i--;
	}

	else if ((FBCamera_0.Results.AxisX != FBCamera_0.Results.AxisXOld) || (FBCamera_0.Results.AxisY != FBCamera_0.Results.AxisYOld)){
	memcpy((UDINT)&LineChartBuffer[1],(UDINT)&LineChartBuffer,(UDINT)(sizeof(LineChartAxis_type)*(Y_AXIS-1)));
	LineChartBuffer[0].X = FBCamera_0.Results.AxisX;
	LineChartBuffer[0].Y = FBCamera_0.Results.AxisY;
}
	
	//	if((memcmp((UDINT)(FBCamera_0.Results.ActTime),(UDINT)ActTime_tmp,(UDINT)sizeof(FBCamera_0.Results.ActTime))) != 0){
	//	memcpy((UDINT)(FBCamera_0.Results.ActTime),(UDINT)ActTime_tmp,(UDINT)sizeof(FBCamera_0.Results.ActTime));
	//if (i < 4000){
	//	Y[(INT)(FBCamera_0.Results.AxisX*0.33057851239669421487603305785124)] = (INT)((FBCamera_0.Results.AxisY*0,07341)+225);
	//		i++;
*/
}

void _EXIT ProgramExit(void)
{
	// Insert code here 

}



