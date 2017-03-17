/* Automation Studio generated header file */
/* Do not edit ! */

#ifndef _GMCARNCGRP_
#define _GMCARNCGRP_

#include <GmcManager.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif
#if defined(_WIN32) || defined(__WINDOWS__) || defined(__MINGW32__) || defined(__CYGWIN__)
#if defined(BUILD_GMCARNCGRP)
#define DECLSPEC_GMCARNCGRP __declspec(dllexport)
#else
#define DECLSPEC_GMCARNCGRP __declspec(dllimport)
#endif
#else	/* not Windows */
#define DECLSPEC_GMCARNCGRP _BUR_PUBLIC
#endif

/* Datatypes and datatypes of function blocks */
#ifndef _GMCARNCGRP_HPP_INCLUDED_
typedef struct GmcAxesGroup ArncAxesGroup;
#endif

typedef struct MCArncFFCtrlParType
{
	plcbit DisableAxis[15];
	unsigned long UserAxis[15];
	unsigned short UserParID[15];
	unsigned long UserDynModel;
	unsigned long RampCycles;
} MCArncFFCtrlParType;

typedef ArncAxesGroup MCAxesGroupType_Arnc;

/* Prototyping of functions and function blocks */
#ifdef __cplusplus
extern "C" {
#endif

#ifdef __cplusplus
} // End of C-Linkage
#endif
#endif /* _GMCARNCGRP_ */

