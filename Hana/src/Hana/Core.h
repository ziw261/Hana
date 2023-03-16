#pragma once

#ifdef HN_PLATFORM_WINDOWS
	#ifdef HN_BUILD_DLL
		#define HANA_API __declspec(dllexport)
	#else
		#define HANA_API __declspec(dllimport)
	#endif
#else
	#error Hana only supports Windows!
#endif
