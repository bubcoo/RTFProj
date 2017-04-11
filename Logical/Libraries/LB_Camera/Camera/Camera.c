#include <bur/plctypes.h>
#include <math.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

void setError(struct FBCamera *inst,unsigned int status);
void initFB(struct FBCamera *inst);
void resetFB(struct FBCamera *inst);
void getRealAxes(struct FBCamera *inst);
void cleanFB(struct FBCamera *inst);
unsigned int FTPConnect(struct FBCamera *inst,FTPSwitch_enum action);

void FBCamera(struct FBCamera *inst)
{	
	if ((!inst->Enable) && (!inst->Internal.disableBit))
		cleanFB(inst); 
	
	switch (inst->Internal.MainSwitch){										//Main switch, DISABLED FB, INITialising FB, ENABLED FB and ERROR case
		/******************************************************************/
		/*							FB is DISABLED					 	  */
		/******************************************************************/
		
		case DISABLED:														//FB is disabled
			if (inst->Internal.disableBit){
				cleanFB(inst);
				//TODO: settings after disable, do only once
				//TODO: DevUnlink
				inst->Internal.disableBit = 1;
			}
			if (inst->Enable){												//Wait for Enable = TRUE, else do nothing
				inst->Internal.MainSwitch = ENABLED;						//Go to ENABLED case
				inst->Internal.disableBit = 0;	
			}
			else
				inst->Status = ERR_FUB_ENABLE_FALSE;							//Status 65534, FB is called but not enabled
			break;
		
		/******************************************************************/
		/*				FB is ENABLED but Camera is not ready		 	  */
		/******************************************************************/
		
		case ENABLED:														//FB is enabled and working
			inst->Active = 1;												//variable indicating active FB
			if (!inst->InSight.ModuleOk){									//InSight Camera is not connected properly
				inst->isCameraReady = 0;									//Bit for user that Camera is not working
				if (inst->Search)											//If user allow searching for ball, change case to ERROR because you cannot find while there is no camera
					setError(inst,ERR_CAM_NOTFOUND);						//Error, Status 65533 - camera not found
				if (inst->MappView.LoadImage)
					setError(inst,ERR_FTP_NOTREADY);	
			}
			else {
				unsigned int status;
				inst->Internal.NaN = sqrt(-1);
				if ((status = FTPConnect(inst,DEVLINK)) == ERR_OK){
					inst->isCameraReady = 1;									//Bit for user that Camera is working
					inst->Internal.MainSwitch = RUN;							//Change state to RUN
					inst->Status = ERR_OK;										//No error in enable case
				}
				else if(status != ERR_FUB_BUSY)
					setError(inst,status);
			}
			break;
	
		case RUN:															//FB is enabled and camera communicating
			if (!(inst->InSight.ModuleOk))									//if camera is disconnected change state to ENABLE where waiting for connect
				inst->Internal.MainSwitch = ENABLED;
			
			if (inst->MappView.LoadImage){
				unsigned int status;
				if ((status = (FTPConnect(inst,FILECOPY))) == ERR_OK)
					inst->MappView.LoadImage = 0;
				else if (status != ERR_FUB_BUSY)
					setError(inst,status);
			}
				
			else if(inst->Search){
				inst->isSearching = 1;										//FB is Searching ball
				if (!inst->Internal.Search_tmp)								//Needed to change to camera trigger loop but only once
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
			getRealAxes(inst);
			switch (inst->Internal.CameraControl.ControlSwitch){ 			//Camera trigger switch, process to get position of ball
	
				case WAIT_CMD:												//Searching for ball is stoped	
					inst->InSight.Control_I2000_S01 = inst->InSight.Control_I2000_S01 & 0xFFFFFFF0;				//control bit is set to 0 for no action
					break;
			
				case TRIGGER_RDY:
					if ((inst->InSight.Status_I2001_S01 & 1) == 1){				//waiting for trigger status ready
					
						inst->InSight.Control_I2000_S01 =((inst->InSight.Control_I2000_S01 & 0xFFFFFFF3) | 3);				//#11 - enabled trigger and start trigger function 
						inst->InSight.Status_I2001_S01 = 0;
						inst->Internal.CameraControl.ControlSwitch = TRIGGER;
					}	
					break;
						
				case TRIGGER:
					if ((inst->InSight.Status_I2001_S01 & 3) == 3){
						inst->InSight.Control_I2000_S01 =((inst->InSight.Control_I2000_S01 & 0xFFFFFFF1) | 1);
						//	inst->InSight.Control_I2000_S01 = inst->InSight.Control_I2000_S01 | 7;
						inst->InSight.Status_I2001_S01 = 0;
						inst->Internal.CameraControl.ControlSwitch = ACQ;
					}
					break;
						
				case ACQ:
					if ((inst->InSight.Status_I2001_S01 & 8) == 8){
						//TODO: missed acquirision
						inst->Internal.CameraControl.ControlSwitch = TRIGGER_RDY;
					}
					if ((inst->InSight.Status_I2001_S01 & 4) != 4){
					
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
					if ((inst->InSight.Status_I2001_S01 & 256) != 256){// && ((inst->InSight.Status_I2001_S01 & 512) == 512))
						inst->isBallFound = 1;
						getRealAxes(inst);
						inst->Internal.CameraControl.ControlSwitch = TRIGGER_RDY;
					}
					break;
			}
			break;
		
		case ERROR:														//error case, to change state is needed error Reset variable or disable FB
			inst->Error = 1;											//Change Error variable
			inst->Internal.CameraControl.ControlSwitch = WAIT_CMD;		//Reset camera trigger state
			inst->isSearching = 0;										//FB cannot searching in error case
			if (inst->ErrorReset)										//waiting on ErrorReset
			{	
				inst->Error = 0;
				inst->Status = ERR_OK;
				resetFB(inst);
				inst->Internal.MainSwitch = ENABLED;					//change state
			}
			break;

	}
		
	if (inst->ErrorReset)										
		resetFB(inst);
		
	if (inst->Error == 1)						
		inst->Internal.MainSwitch = ERROR;
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
	inst->Results.AxisXOld = inst->Internal.NaN;
	inst->Results.AxisYOld = inst->Internal.NaN;
}

void resetFB(struct FBCamera *inst)
{
	inst->ErrorReset = 0;							//Reset error reset
	inst->Error = 0;								//Reset Error
	inst->Status = ERR_OK;	
}

void cleanFB(struct FBCamera *inst)
{
	initFB(inst);
	resetFB(inst);
}

void getRealAxes(struct FBCamera *inst)
{
	if (inst->InSight.InspectionResults_I2011_S01 && inst->InSight.InspectionResults_I2011_S02){ 
		inst->Results.AxisXOld = inst->Results.AxisX;
		inst->Results.AxisYOld = inst->Results.AxisY;
		memcpy((UDINT)&inst->Results.ActTimeOld,(UDINT)&inst->Results.ActTime,sizeof(inst->Results.ActTime));
		inst->Results.AxisX = ((inst->InSight.InspectionResults_I2011_S02*(-9.2674315975286849073256840247132))+12059.929390997352162400706090026);
		inst->Results.AxisY = ((inst->InSight.InspectionResults_I2011_S01*(-9.3157894736842105263157894736842))+4667.4210526315789473684210526316);
		RTC_gettime(&inst->Results.ActTime);
		inst->Results.TimeDiff = (REAL)((inst->Results.ActTime.millisec + (inst->Results.ActTime.second*1000)) - (inst->Results.ActTimeOld.millisec +(inst->Results.ActTimeOld.second*1000)));
	}
}

void setError(struct FBCamera *inst,unsigned int status) {
	inst->Error = 1;
	inst->Status = status;
}

unsigned int FTPConnect(struct FBCamera *inst,FTPSwitch_enum action) {
	if (inst->Internal.FTP.Status == 0)
		inst->Internal.FTP.FTPSwitch = action;
	strcpy(inst->Internal.FTP.pDevice,"CAMDEVICE");
	
	switch (inst->Internal.FTP.FTPSwitch) {
		case DEVLINK:
			strcpy(inst->Internal.FTP.pParam,"/DEVICE=IF1 /SIP=192.168.100.1 /SNAME=is7402_TR02 /PROTOCOL=ftp /USER=PLC /PASSWORD=PLC");
			inst->Internal.FTP.DevLink_0.enable = 1;
			inst->Internal.FTP.DevLink_0.pDevice = (UDINT)&(inst->Internal.FTP.pDevice);
			inst->Internal.FTP.DevLink_0.pParam = (UDINT)&(inst->Internal.FTP.pParam);
			DevLink(&inst->Internal.FTP.DevLink_0);
			switch (inst->Internal.FTP.DevLink_0.status) {
				case ERR_OK:
					inst->Internal.FTP.handle = inst->Internal.FTP.DevLink_0.handle;
					inst->Internal.FTP.Status = 0;
					return (ERR_OK);
					break;
				case fiERR_DEVICE_ALREADY_EXIST:
					if (inst->Internal.FTP.handle != 0){
						inst->Internal.FTP.Status = 1;
						inst->Internal.FTP.FTPSwitch = DEVUNLINK;
					}
					else {
						inst->Internal.FTP.Status = 0;
						return (fiERR_DEVICE_ALREADY_EXIST);
					}
					break;
				case ERR_FUB_BUSY:
					inst->Internal.FTP.FTPSwitch = DEVLINK;
					return (ERR_FUB_BUSY);
					break;
				default:
					inst->Internal.FTP.Status = 0;
					return (inst->Internal.FTP.DevLink_0.status);
					break;
			}
			break;
		
		case DEVUNLINK:
			inst->Internal.FTP.DevUnlink_0.enable = 1;
			inst->Internal.FTP.DevUnlink_0.handle = inst->Internal.FTP.handle;
			DevUnlink(&inst->Internal.FTP.DevUnlink_0);
			switch (inst->Internal.FTP.DevUnlink_0.status){
				case ERR_OK:
					if (action == DEVLINK){
						inst->Internal.FTP.Status = 1;
						inst->Internal.FTP.FTPSwitch = DEVLINK;
						return (ERR_FUB_BUSY);
					}
					else{
						inst->Internal.FTP.Status = 0;
						return (ERR_OK);
					}
					break;
			
				case ERR_FUB_BUSY:
					return (ERR_FUB_BUSY);
					break;
				
				default:
					inst->Internal.FTP.Status = 0;
					return (inst->Internal.FTP.DevUnlink_0.status);
					break;
			}
			break;
		
		case FILECOPY:
			strcpy(inst->Internal.FTP.pDest,"image4.bmp");
			strcpy(inst->Internal.FTP.pDestDev,"USER_DISK");
			strcpy(inst->Internal.FTP.pSrc,"image.bmp");
			inst->Internal.FTP.FileCopy_0.enable = 1;
			inst->Internal.FTP.FileCopy_0.option = fiOVERWRITE;
			inst->Internal.FTP.FileCopy_0.pDest = (UDINT)&inst->Internal.FTP.pDest;
			inst->Internal.FTP.FileCopy_0.pDestDev = (UDINT)&inst->Internal.FTP.pDestDev;
			inst->Internal.FTP.FileCopy_0.pSrc = (UDINT)&inst->Internal.FTP.pSrc;
			inst->Internal.FTP.FileCopy_0.pSrcDev = (UDINT)&(inst->Internal.FTP.pDevice);
			FileCopy(&inst->Internal.FTP.FileCopy_0);
			switch (inst->Internal.FTP.FileCopy_0.status){
				case ERR_OK:
					return (ERR_OK);
					break;
			
				case ERR_FUB_BUSY:
					return (ERR_FUB_BUSY);
					break;
				default:
					return (inst->Internal.FTP.FileCopy_0.status);
					break;
			}
			break;
	}
	return ERR_FUB_BUSY;
}
