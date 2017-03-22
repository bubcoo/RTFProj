#include <bur/plctypes.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif


void GoalKeeper(struct GoalKeeper *inst){
	
	if (inst->enable){
		if (!inst->Internal.init){
			inst->Internal.DisableTimer.PT = 500;
			inst->Internal.init = 1;
		}
	
	
		if (!inst->DI9371.ModuleOk)
			inst->status = ERR_DI_NOTFOUND;
		else
			inst->status = ERR_OK;
	
		TON_10ms(&inst->Internal.DisableTimer);
		
		if ((inst->Internal.DisableTimer.IN == 1) && (inst->Internal.DisableTimer.Q)){
			inst->Internal.DisableTimer.IN = 0;
		}
		else if ((!inst->DI9371.DigitalInput) && (!inst->isGoal) && (!inst->Internal.DisableTimer.IN)) {
			inst->isGoal = 1;
			inst->MappView.counter = inst->MappView.counter + 1;
			inst->Internal.DisableTimer.IN = 1;
		}			
		else{
				inst->isGoal = 0;
			}
	}
	else
		inst->status = ERR_FUB_ENABLE_FALSE;
}
