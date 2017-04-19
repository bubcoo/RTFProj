
#include <bur/plctypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <MpAxis.h>

#ifdef __cplusplus
	extern "C"
	{
#endif
	#include "rp_funcx1.h"
#ifdef __cplusplus
	};
#endif
void initialization_sla(struct start_linearAxis* s_la);

void start_linearAxis(struct start_linearAxis* s_la)
{		
	if(!s_la->start_btn){
		initialization_sla(s_la);
	}
	
	switch(s_la->Internal.state){
		case 0:
			{
				s_la->Internal.before_state     = s_la->Internal.state;
				// adjustment parameters -> axis
				s_la->axis_param->Home.Mode 				  = mpAXIS_HOME_MODE_BLOCK_TORQUE;
				s_la->axis_param->Home.Position 		  	  = s_la->max_leftPosition;
				s_la->axis_param->Home.StartVelocity   		  = 400;
				s_la->axis_param->Home.HomingVelocity  		  = 400;
				s_la->axis_param->Home.Acceleration    		  = 1000;
				s_la->axis_param->Home.StartDirection  		  = mpAXIS_HOME_DIR_POSITIVE;
				s_la->axis_param->Home.HomingDirection 		  = mpAXIS_HOME_DIR_NEGATIVE;
				s_la->axis_param->Home.TorqueLimit	 		  = 0.02;
				s_la->axis_param->Home.PositionErrorStopLimit = s_la->max_leftPosition + 1;
				
				if(s_la->axis_name->Error == 1 || s_la->axis_name->StatusID != 0){
					s_la->Internal.state = 10;
				}else{
					if(s_la->start_btn == 1){
						s_la->Internal.state = 1;
					}
				}
			}
			break;
		case 1:
			{
				s_la->Internal.before_state = s_la->Internal.state;
				// power on -> axis
				s_la->axis_name->Power = 1;
			
				if(s_la->axis_name->PowerOn == 1){
					s_la->Internal.state = 2;
				}else if(s_la->axis_name->Error == 1 || s_la->axis_name->StatusID != 0){
					s_la->Internal.state = 10;
				}else{
					s_la->Internal.state = s_la->Internal.before_state;
				}
			}
			break;
		case 2:
			{
				s_la->Internal.before_state = s_la->Internal.state;
				// update -> axis
				s_la->axis_name->Update = 1;
			
				if(s_la->axis_name->UpdateDone == 1){
					s_la->axis_name->Update = 0;
					s_la->Internal.state 	= 3;
				}else if(s_la->axis_name->Error == 1 || s_la->axis_name->StatusID != 0){
					s_la->Internal.state = 10;
				}else{
					s_la->Internal.state = s_la->Internal.before_state;
				}
			}
		case 3:
			{
				s_la->Internal.before_state = s_la->Internal.state;
				// home -> axis
				s_la->axis_name->Home = 1;
			
				if(s_la->axis_name->IsHomed == 1){
					s_la->axis_name->Home = 0;
					s_la->succesfully     = 1;
				}else if(s_la->axis_name->Error == 1 || s_la->axis_name->StatusID != 0){
					s_la->Internal.state = 10;
				}else{
					s_la->Internal.state = s_la->Internal.before_state;
				}
			}
			break;
		case 10:
			{
				s_la->axis_name->ErrorReset = 1;
				
				if(s_la->axis_name->Error == 1 || s_la->axis_name->StatusID != 0){
					s_la->Internal.state = 10;
				}else{
					s_la->axis_name->ErrorReset = 0;
					s_la->Internal.state 		= s_la->Internal.before_state;
				}
			}
			break;			
	}// end switch
}// end function

void initialization_sla(struct start_linearAxis* s_la)
{
	s_la->Internal.state 		= 0;
	s_la->Internal.before_state = 0;
	s_la->start_btn				= 0;
	s_la->succesfully     		= 0;
}// end function
