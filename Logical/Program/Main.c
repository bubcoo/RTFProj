
#include <bur/plctypes.h>
#include <AsIecCon.h>
#include <sys_lib.h>



#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

_GLOBAL FBCamera_typ FBCamera_0;


void _INIT ProgramInit(void)
{
	FBCamera_0.Enable = 0;
}

void _CYCLIC ProgramCyclic(void)
{
	FBCamera(&FBCamera_0);

}

void _EXIT ProgramExit(void)
{
	// Insert code here 

}

