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
IncludeDir["Glad"] = "Hana/vendor/Glad/include"
IncludeDir["ImGui"] = "Hana/vendor/imgui"
IncludeDir["glm"] = "Hana/vendor/glm"

-- Include the premake file in the glfw into here, c++ style copy paste include style
include "Hana/vendor/GLFW"
include "Hana/vendor/Glad"
include "Hana/vendor/imgui"

project "Hana"
	location "Hana"
	kind "SharedLib"
	language "C++"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hnpch.h"
	pchsource "Hana/src/hnpch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp",
		"%{prj.name}/vendor/glm/glm/**.hpp",
		"%{prj.name}/vendor/glm/glm/**.inl",
	}

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.ImGui}",
		"%{IncludeDir.glm}",
	}

	links
	{
		"GLFW",
		"Glad",
		"ImGui",
		"opengl32.lib"
	}

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"

		defines
		{
			"HN_PLATFORM_WINDOWS",
			"HN_BUILD_DLL",
			"GLFW_INCLUDE_NONE",
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} \"../bin/" .. outputdir .. "/Sandbox/\"")
		}

	filter "configurations:Debug"
		defines "HN_DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "HN_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines "HN_DIST"
		runtime "Release"
		optimize "On"

project "Sandbox"
	location "Sandbox"
	kind "ConsoleApp"
	language "C++"
	staticruntime "off"

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
		"Hana/src",
		"%{IncludeDir.glm}",
	}

	links
	{
		"Hana"
	}

	filter "system:windows"
		cppdialect "C++17"
		systemversion "latest"

		defines
		{
			"HN_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "HN_DEBUG"
		runtime "Debug"
		symbols "On"

	filter "configurations:Release"
		defines "HN_RELEASE"
		runtime "Release"
		optimize "On"

	filter "configurations:Dist"
		defines "HN_DIST"
		runtime "Release"
		optimize "On"
