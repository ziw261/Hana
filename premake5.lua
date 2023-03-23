workspace "Hana"
	architecture "x64"
	startproject "Sandbox"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (solution directory)
IncludeDir = {}
IncludeDir["GLFW"] = "Hana/vendor/GLFW/include"

-- Include the premake file in the glfw into here, c++ style copy paste include style
include "Hana/vendor/GLFW"

project "Hana"
	location "Hana"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hnpch.h"
	pchsource "Hana/src/hnpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}"
	}

	links
	{
		"GLFW",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HN_PLATFORM_WINDOWS",
			"HN_BUILD_DLL"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
		}

	filter "configurations:Debug"
		defines "HN_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "HN_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "HN_DIST"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"Hana/vendor/spdlog/include",
		"Hana/src"
	}

	links
	{
		"Hana"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"HN_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "HN_DEBUG"
		symbols "On"

	filter "configurations:Release"
		defines "HN_RELEASE"
		optimize "On"

	filter "configurations:Dist"
		defines "HN_DIST"
		optimize "On"
