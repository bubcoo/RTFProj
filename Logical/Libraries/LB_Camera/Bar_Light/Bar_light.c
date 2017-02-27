#include <bur/plctypes.h>
#include <MTBasics.h>
#include <brsystem.h>
#include <math.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

void resetFB(struct Light *inst);
void PWMControl(struct Light *inst);
void BlinkControl(struct Light *inst);

void Light(struct Light *inst)
{
	if ((!inst->Enable) && (inst->internal.MainControlBarLight != INIT_BARLIGHT))
	{
		inst->internal.MainControlBarLight = DISABLED_BARLIGHT;
	}
	
	switch (inst->internal.MainControlBarLight)
	{
		case INIT_BARLIGHT:
			inst->internal.TaskClass.RTInfo_0.enable = 1;
			RTInfo(&inst->internal.TaskClass.RTInfo_0);
			if (!(inst->internal.TaskClass.RTInfo_0.status) && (inst->internal.TaskClass.RTInfo_0.cycle_time > 0))
			{
				if (inst->internal.TaskClass.RTInfo_0.cycle_time <= 1000)
				{
					inst->isPWMEnabled = inst->internal.PWM.PWMEnabled = 1;
					inst->internal.PWM.PWM.MinPulseWidth = 0.001;						
					inst->internal.PWM.PWM.Period = 0.1;								
					inst->internal.PWM.PWM.Mode = mtBASICS_PULSE_BEGINNING;
				}
				else
					inst->isPWMEnabled = inst->internal.PWM.PWMEnabled = 0; 
		
				inst->internal.PWM.PWM.DutyCycle = 100;
				inst->internal.TaskClass.RTInfo_0.enable = 0;
				inst->internal.TaskClass.CyclicTime = ((inst->internal.TaskClass.RTInfo_0.cycle_time)/1000);
				inst->internal.MainControlBarLight = DISABLED_BARLIGHT;
			}
			break;
	
		case DISABLED_BARLIGHT:
			if (inst->Enable)
			{
				if (inst->DO9322.ModuleOK)
				{
					inst->internal.MainControlBarLight = ENABLED_BARLIGHT;
					resetFB(inst);
				}
				else 
				{
					inst->Status = DO9322_NOT_CONNECTED;
					inst->internal.MainControlBarLight = ERROR_BARLIGHT;
				}
			}
			break;
	
		case ENABLED_BARLIGHT:
			inst->Active = 1;
			if (inst->PowerOn)
			{
				if (inst->Blinking.StartBlinking)
				{
					BlinkControl(inst);
				}
				else if (inst->internal.PWM.PWMEnabled)
				{
					PWMControl(inst);
				}
				else inst->DO9322.DigitalOutput = 1;
			}
			else inst->DO9322.DigitalOutput = 0;
			break;
		
		case ERROR_BARLIGHT:
			inst->Error = 1;
			break;
	}
}

void resetFB(struct Light *inst)
{
	inst->Active = 0;
	inst->Blinking.StartBlinking = 0;
	inst->DO9322.DigitalOutput = 0;
	inst->DutyCycle = 100;
	inst->Error = 0;
	inst->PowerOn = 0;
	inst->isPowerOn = 0;
	inst->Status = ERR_OK;
}

void PWMControl(struct Light *inst)
{
	MTBasicsPWM(&inst->internal.PWM.PWM);
	inst->DO9322.DigitalOutput = inst->internal.PWM.PWM.Out;
}

void BlinkControl(struct Light *inst)
{
	inst->internal.BlinkingCounter += 1;
	if ((inst->internal.BlinkingCounter*inst->internal.TaskClass.CyclicTime) < inst->Blinking.BlinkingTime_ms)
	{
		if ((inst->internal.BlinkCounter*inst->internal.TaskClass.CyclicTime) >= inst->Blinking.BlinkPeriod_ms)
		{
			inst->DO9322.DigitalOutput = !inst->DO9322.DigitalOutput;
			inst->internal.BlinkCounter = 0;
		}
		else
		{
			inst->internal.BlinkCounter += 1;
		}
	}
	else
	{
		inst->internal.BlinkingCounter = 0;
		inst->internal.BlinkCounter = 0;
		inst->DO9322.DigitalOutput = 0;
		inst->Blinking.StartBlinking = 0;
	}
}
