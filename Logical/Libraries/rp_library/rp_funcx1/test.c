
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
/* TODO: Add your comment here */
void test(struct test* inst)
{		
	inst->b = inst->a->Active;
}
