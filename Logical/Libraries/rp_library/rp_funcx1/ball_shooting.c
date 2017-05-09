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
void init_ball_shooting(struct ball_shooting* b_s);
void ball_shooting(struct ball_shooting* b_s)
{
	if(b_s->Enable == 0){
		init_ball_shooting(&b_s);
	}
	
	switch(b_s->Internal.state){
		case 0:
			{
				// initialization parameters of axes for shooting ball
				b_s->axes_control->rotary_param.acceleration = 1000;
				b_s->axes_control->rotary_param.deceleration = 1000;
				b_s->axes_control->rotary_param.velocity     = 100;
			
				// start function
				if(b_s->start_shoot == 1){
					b_s->successfully = 0;
					if(b_s->axes_control->Enable == 1 && b_s->successfully == 0){
						// first position
						b_s->axes_control->rotary_param.displacement = -500;
						b_s->axes_control->start_move = 1;
						if(b_s->axes_control->start_move == 1){
							// change state
							b_s->Internal.state = 1;
						}
						
					}
				}
			}
			break;
		case 1:
			{	
				if(b_s->axes_control->successfully == 1){
					b_s->axes_control->start_move = 0;
					if(b_s->axes_control->rotary_param.displacement == b_s->rotary_axes->Info.SlavePosition){
						// second position
						b_s->axes_control->rotary_param.displacement = 500;
						b_s->axes_control->start_move = 1;
						if(b_s->axes_control->start_move == 1){
							b_s->Internal.state = 2;
						}
					}
				}
			}
			break;
		case 2:
			{
				if(b_s->axes_control->successfully == 1){
					b_s->axes_control->start_move = 0;
					if(b_s->axes_control->rotary_param.displacement == b_s->rotary_axes->Info.SlavePosition){
						// initial position
						b_s->axes_control->rotary_param.displacement = -250;
						b_s->axes_control->start_move = 1;
						if(b_s->axes_control->start_move == 1){
							// change state
							b_s->Internal.state = 3;
						}
					}
				}
			}
			break;
		case 3:
			{

				if(b_s->axes_control->successfully == 1){
					b_s->axes_control->start_move = 0;
					if(b_s->axes_control->rotary_param.displacement == b_s->rotary_axes->Info.SlavePosition){
						b_s->successfully = 1;
						if(b_s->successfully == 1){
							b_s->Internal.state = 0;
						}
					}
				}
			}
			break;
	}// end switch
}// end function

void init_ball_shooting(struct ball_shooting* b_s)
{
	b_s->Internal.state = 0;
	b_s->successfully   = 0;
	b_s->start_shoot    = 0;
}
