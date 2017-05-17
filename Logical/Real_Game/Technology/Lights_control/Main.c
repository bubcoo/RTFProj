
#include <bur/plctypes.h>
#include "Bar_Light.h"

#ifdef _DEFAULT_INCLUDES
	#include <AsDefault.h>
#endif

_GLOBAL Light_typ Light_0;

void _INIT ProgramInit(void)
{
	Light_0.Enable = 1;
	Light(&Light_0);
	Light_0.PowerOn = 1;
}

void _CYCLIC ProgramCyclic(void)
{
	// Lights
	Light(&Light_0);

}


