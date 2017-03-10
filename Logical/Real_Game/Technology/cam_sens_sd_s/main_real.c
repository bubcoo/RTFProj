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
#include <FileIO.h>
#include <string.h>

#ifdef _DEFAULT_INCLUDES
#include <AsDefault.h>
#endif


_GLOBAL FBCamera_typ FBCamera_0;
_GLOBAL Light_typ Light_0;
_LOCAL DevLink_typ DevLink_0;
_LOCAL INT state;
_LOCAL STRING FTP[300];
_LOCAL STRING pDevice[80];
_LOCAL STRING pDevice1[80];

_LOCAL FileCopy_typ FileCopy_0;

_LOCAL DirInfo_typ DirInfo_0;
 
void _INIT ProgramInit(void)
{

	FBCamera_0.Enable = 0;
	TestVar = 1;
	strcpy(FTP,"/DEVICE=IF1 /SIP=192.168.100.1 /SNAME=is7402_TR02 /PROTOCOL=ftp /USER=PLC /PASSWORD=PLC");
	strcpy(pDevice,"CAMDEVICE");
	strcpy(pDevice1,"USERDISK");
}

void _CYCLIC ProgramCyclic(void)
{
	
	FBCamera(&FBCamera_0);
	Light(&Light_0);
	TestVar;
	
	switch (state)
	{
		case 1:
			DevLink_0.enable = 1;
			DevLink_0.pDevice = &pDevice;
			DevLink_0.pParam = &FTP;
			DevLink(&DevLink_0);
			if (DevLink_0.status == 65535) 
				state = 1;
			else
				state = 0;
			break;
		case 2:
			DirInfo_0.enable = 1;
			DirInfo_0.pDevice = &pDevice;
			DirInfo(&DirInfo_0);
			if (DirInfo_0.status == 65535) 
				state = 2;
			else
				state = 0;
			break;
		case 3:
			FileCopy_0.enable = 1;
			FileCopy_0.option = fiOVERWRITE;
			FileCopy_0.pDestDev = &pDevice1;
			FileCopy_0.pSrcDev = &pDevice;
			FileCopy(&FileCopy_0);
			if (FileCopy_0.status == 65535) 
				state = 3;
			else
				state = 0;
			break;
	}

}

void _EXIT ProgramExit(void)
{
	// Insert code here 

}



