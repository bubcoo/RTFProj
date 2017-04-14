#include <bur/plctypes.h>
#include <math.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif

#define NaN sqrt(-1)
#define CAM_OFFLINE_MASK 0x10000

#define ABS_F(X) ((X) < (0) ? -(X) : (X))
							//		  |						9800
#define X1_REF_PLGND 800.0	//(UNITS) |			   3800 6800  | 11300
#define X2_REF_PLGND 11300.0//(UNITS) |			 _____|___|___|_|_
#define X1_REF_CAM 1215.0	//(PIXELS)|			| | | O O O O | | |		SCHEME OF X AXIS
#define X2_REF_CAM 82.0		//(PIXELS)|			| | O | O O | O | |		AND PLAYGROUND WITH
 							//		  |		    | O | O O O O | O |		DISTANCE OF PLAYERS
#define Y1_REF_PLGND 820.0	//(UNITS) |	 	  	| | O | O O | O | |		IN UNITS
#define Y2_REF_PLGND -950.0 //(UNITS) |			|_|_|_O_O_O_O_|_|_|		(10 UNITS = 1 MM)
#define Y1_REF_CAM 414.0	//(PIXELS)| 		  | |   |   |
#define Y2_REF_CAM 604.0	//(PIXELS)|		   800  | 5300 8300
							//		  |		       2300

#define X_LIN_EQ_K ((X1_REF_PLGND-X2_REF_PLGND)/(X1_REF_CAM-X2_REF_CAM))
#define X_LIN_EQ_Q (X1_REF_PLGND-(X1_REF_CAM*X_LIN_EQ_K))

#define Y_LIN_EQ_K ((Y1_REF_PLGND-Y2_REF_PLGND)/(Y1_REF_CAM-Y2_REF_CAM))
#define Y_LIN_EQ_Q (Y1_REF_PLGND-(Y1_REF_CAM*Y_LIN_EQ_K))

#define X_MAX_DIFF ABS_F((X_LIN_EQ_K+X_LIN_EQ_Q)-((2*X_LIN_EQ_K)+X_LIN_EQ_Q))
#define Y_MAX_DIFF ABS_F((Y_LIN_EQ_K+Y_LIN_EQ_Q)-((2*Y_LIN_EQ_K)+Y_LIN_EQ_Q))

void setError(struct FBCamera *inst,unsigned int status);
void initFB(struct FBCamera *inst);
void resetFB(struct FBCamera *inst);
void getRealAxes(struct FBCamera *inst);
void cleanFB(struct FBCamera *inst);
REAL RctToReal_ms (struct RTCtime_typ RTCtime);

void FBCamera(struct FBCamera *inst)
{	
	if ((!inst->Enable) && (!inst->Internal.disableBit))
		cleanFB(inst); 
	
	
	getRealAxes(inst);
	
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
					inst->isCameraReady = 1;									//Bit for user that Camera is working
					inst->Internal.MainSwitch = RUN;							//Change state to RUN
					inst->Status = ERR_OK;										//No error in enable case
			}
			break;
	
		case RUN:															//FB is enabled and camera communicating
			if (!(inst->InSight.ModuleOk))									//if camera is disconnected change state to ENABLE where waiting for connect
				inst->Internal.MainSwitch = ENABLED;
			
			if (inst->MappView.LoadImage){

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
							inst->Internal.CameraControl.ControlSwitch = TRIGGER;*/
					}
					break;
				
				case INSP:
					if ((inst->InSight.Status_I2001_S01 & 256) != 256){// && ((inst->InSight.Status_I2001_S01 & 512) == 512))
						inst->isBallFound = 1;
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
	inst->Results.AxisXOld = NaN;
	inst->Results.AxisYOld = NaN;
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

void setError(struct FBCamera *inst,unsigned int status) {
	inst->Error = 1;
	inst->Status = status;
}

void getRealAxes(struct FBCamera *inst)
{
	if (inst->Internal.SuccesCount != inst->InSight.InspectionResults_I2011_S03){			
		if(((ABS_F(((inst->InSight.InspectionResults_I2011_S01*X_LIN_EQ_K)+X_LIN_EQ_Q)-(inst->Results.AxisX))) < (X_MAX_DIFF + (0.1*X_MAX_DIFF))) &&
		((ABS_F(((inst->InSight.InspectionResults_I2011_S02*Y_LIN_EQ_K)+Y_LIN_EQ_Q)-(inst->Results.AxisY))) < (Y_MAX_DIFF + (0.1*Y_MAX_DIFF)))) {
			inst->Results.AxisX = ((((inst->InSight.InspectionResults_I2011_S01*(X_LIN_EQ_K))+X_LIN_EQ_Q)+inst->Results.AxisX)/2);
			inst->Results.AxisY = ((((inst->InSight.InspectionResults_I2011_S02*(Y_LIN_EQ_K))+Y_LIN_EQ_Q)+inst->Results.AxisY)/2);
			inst->Results.AxisXOld = inst->Results.AxisYOld = NaN;
		}
		else{
			inst->Results.AxisXOld = inst->Results.AxisX;
			inst->Results.AxisYOld = inst->Results.AxisY;
			inst->Results.AxisX = ((inst->InSight.InspectionResults_I2011_S01*(X_LIN_EQ_K))+X_LIN_EQ_Q);
			inst->Results.AxisY = ((inst->InSight.InspectionResults_I2011_S02*(Y_LIN_EQ_K))+Y_LIN_EQ_Q);
		}
		memcpy((UDINT)&inst->Results.ActTimeOld,(UDINT)&inst->Results.ActTime,sizeof(inst->Results.ActTime));
		RTC_gettime(&inst->Results.ActTime);
		inst->Results.TimeDiff_ms = ((RctToReal_ms(inst->Results.ActTime)) - (RctToReal_ms(inst->Results.ActTimeOld)));

		
		inst->Internal.SuccesCount = inst->InSight.InspectionResults_I2011_S03;
	}
	else if ((inst->Internal.FailCount != inst->InSight.InspectionResults_I2011_S04) && ((!isnan(inst->Results.AxisXOld)) && (!isnan(inst->Results.AxisYOld)))){ 
		inst->Results.AxisX = inst->Results.AxisXOld;
		inst->Results.AxisY = inst->Results.AxisYOld;
		inst->Results.AxisXOld = inst->Results.AxisYOld = NaN;
		inst->Internal.FailCount = inst->InSight.InspectionResults_I2011_S04;
	}
}

REAL RctToReal_ms (struct RTCtime_typ RTCtime){
	return(((REAL)RTCtime.hour*3600000)+((REAL)RTCtime.minute*60000)+((REAL)RTCtime.second*1000)+((REAL)RTCtime.millisec)+((REAL)RTCtime.microsec/1000));
}

