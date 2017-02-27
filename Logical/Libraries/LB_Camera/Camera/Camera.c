#include <bur/plctypes.h>
#include <sys_lib.h>
#include <asstring.h>


#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

void initFB(struct FBCamera *inst);
void resetFB(struct FBCamera *inst);
void getRealAxes(struct FBCamera *inst);



void FBCamera(struct FBCamera *inst)
{	
	
	
	if ((!inst->Enable) && (!inst->Internal.disableBit))
		initFB(inst); 
	
	if (inst->Enable)
	{
		switch (inst->Internal.MainSwitch)										//Main switch, DISABLED FB, INITialising FB, ENABLED FB and ERROR case
		{
			case DISABLED:														//FB is disabled
				if (inst->Enable)												//Wait for Enable = TRUE, else do nothing
				{
					initFB(inst);												//Init settings
					inst->Internal.disableBit = 1;
					inst->Internal.MainSwitch = ENABLED;						//Go to init case
				}

				break;
		
			case ENABLED:														//FB is enabled
				inst->Active = 1;												//variable indicating active FB
				if (!(inst->InSight.ModuleOk))									//when camera InSight is not connected properly
				{	
					inst->isCameraReady = 0;
					if (inst->Search)											//If user allow searching for ball, change case to ERROR because you cannot find while the is no camera
					{
						inst->Internal.MainSwitch = ERROR;						//change state to ERROR
						inst->Status = ERR_CAM_NOTFOUND;						//description of error in Status
					}
				}
				else 
				{
					inst->isCameraReady = 1;
					inst->Internal.MainSwitch = RUN;
					inst->Status = ERR_OK;
				}
				break;
	
			case RUN:															//FB is enabled and camera communicating
				if (!(inst->InSight.ModuleOk))
					inst->Internal.MainSwitch = ENABLED;
			
				else if(inst->Search)
				{
					inst->isSearching = 1;									//FB is Searching ball
					if (!inst->Internal.Search_tmp)							//Needed to change to camera trigger loop but only once
					{
						
						inst->Internal.CameraControl.ControlSwitch = TRIGGER_RDY;				//First state of camera triggering
						inst->InSight.Control_I2000_S01 = ((inst->InSight.Control_I2000_S01 & 0xFFFFFF7F) | 1);				//Init condiotion in loop
						inst->Internal.Search_tmp = 1;						// 		-||-
					}
				}
				
				else
				{
					inst->Internal.Search_tmp = inst->isSearching = 0;			//if not searching reset variables
					inst->Internal.CameraControl.ControlSwitch = WAIT_CMD;
				}
			
				switch (inst->Internal.CameraControl.ControlSwitch) 						//Camera trigger switch, process to get position of ball
				{
					case WAIT_CMD:												//Searching for ball is stoped	
						inst->InSight.Control_I2000_S01 = inst->InSight.Control_I2000_S01 & 0xFFFFFFF0;				//control bit is set to 0 for no action
						break;
			
					case TRIGGER_RDY:
					if ((inst->InSight.Status_I2001_S01 & 1) == 1)				//waiting for trigger status ready
						{
							inst->InSight.Control_I2000_S01 =((inst->InSight.Control_I2000_S01 & 0xFFFFFFF3) | 3);				//#11 - enabled trigger and start trigger function 
							inst->InSight.Status_I2001_S01 = 0;
							inst->Internal.CameraControl.ControlSwitch = TRIGGER;
						}	
						break;
						
					case TRIGGER:
						if ((inst->InSight.Status_I2001_S01 & 3) == 3)
						{
							inst->InSight.Control_I2000_S01 =((inst->InSight.Control_I2000_S01 & 0xFFFFFFF1) | 1);
						//	inst->InSight.Control_I2000_S01 = inst->InSight.Control_I2000_S01 | 7;
							inst->InSight.Status_I2001_S01 = 0;
							inst->Internal.CameraControl.ControlSwitch = ACQ;
						}
						break;
						
					case ACQ:
						if ((inst->InSight.Status_I2001_S01 & 8) == 8)
						{
							//TODO: missed acquirision
							inst->Internal.CameraControl.ControlSwitch = TRIGGER_RDY;
						}
						if ((inst->InSight.Status_I2001_S01 & 4) != 4)
						{
						inst->Internal.CameraControl.ControlSwitch = INSP;
						/*	if ((inst->InSight.Status_I2001_S01 & 15) == 7)
								inst->isBallFound = 1;
							else
								inst->isBallFound = 0;
							
							inst->InSight.Control_I2000_S01 = ((inst->InSight.Control_I2000_S01 | 9) & 0xFFFFFFF9);
							inst->InSight.Status_I2001_S01 = 0;
							getRealAxes(inst);
							inst->Internal.CameraControl.ControlSwitch = TRIGGER;*/
						}
						break;
					case INSP:
						if ((inst->InSight.Status_I2001_S01 & 256) != 256)// && ((inst->InSight.Status_I2001_S01 & 512) == 512))
						{
							inst->isBallFound = 1;
							getRealAxes(inst);
					 		inst->Internal.CameraControl.ControlSwitch = TRIGGER_RDY;
						}
						break;
				}
				break;
		
			case ERROR:											//error case, to change state is needed error Reset variable or disable FB
				inst->Error = 1;								//Change Error variable
				inst->Internal.CameraControl.ControlSwitch = WAIT_CMD;		//Reset camera trigger state
				inst->isSearching = 0;							//FB cannot searching in error case
				if (inst->ErrorReset)							//waiting on ErrorReset
				{												
					resetFB(inst);
					inst->Internal.MainSwitch = ENABLED;			//change state
				}
				break;

		}
		if (inst->ErrorReset)
			resetFB(inst);
		if (inst->Internal.MainSwitch != ERROR)
			inst->Error = ERR_OK;
	}
}

void initFB(struct FBCamera *inst)
{
	inst->Active = 0;
	inst->Error = 0;
	inst->ErrorReset = 0;
	inst->isCameraReady = 0;
	inst->isBallFound = 0;
	inst->isSearching = 0;
	inst->Search = 0;
	inst->Status = ERR_OK;
	inst->Internal.CameraControl.ControlSwitch = WAIT_CMD;
	inst->Internal.MainSwitch = DISABLED;
	inst->Internal.Search_tmp = 0;
	inst->Internal.disableBit = 1;
	inst->InSight.Control_I2000_S01 = 128;
	memset(&inst->Results.ActTime,0,sizeof(inst->Results.ActTime));
}

void resetFB(struct FBCamera *inst)
{
	inst->ErrorReset = 0;							//Reset error reset
	inst->Error = 0;								//Reset Error
	inst->Status = ERR_OK;
}

void getRealAxes(struct FBCamera *inst)
{
	if (inst->isBallFound)
	{
		inst->Results.AxisX = inst->InSight.InspectionResults_I2011_S01*1.066666667;
		inst->Results.AxisY = inst->InSight.InspectionResults_I2011_S02;
		RTC_gettime(&inst->Results.ActTime);
	}
	else 
	{
		inst->Results.AxisX = -1;
		inst->Results.AxisY = -1;
		memset(&inst->Results.ActTime,0,sizeof(inst->Results.ActTime));
	}
}


