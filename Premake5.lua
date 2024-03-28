-- premake5.lua
workspace("HelloWorld")
	architecture("x64")
	configurations({ "Debug", "Release" })

	project("Hello")
		kind("ConsoleApp")
		language("C++")
		cppdialect("C++17")
		targetdir("bin/%{cfg.buildcfg}")
	outputdir = "%{cfg.buildcfg}.%{cfg.system}.%{cfg.architecture}"
	targetdir("bin/" .. outputdir .. "/%{prj.name}")
	objdir("obj/" .. outputdir .. "/%{prj.name}")

-- * only searches the directory
-- ** searches all subdirectories
	files({ "include/**.h", "src/**.cpp" })

	includedirs {
		"include"
	}
	libdirs {"lib"}
	links {"SDL2"}
	links {"SDL2main"}
	

	filter("configurations:Debug")
			defines({ "DEBUG" })
			symbols("On")

	filter("configurations:Release")
			defines({ "NDEBUG" })
			optimize("On")


	newaction {
		trigger = "clean",
		description = "Remove all binaries, intermediate binaries, and vs files.",
		execute = function()
			print("Removing binaries")
			os.rmdir("./bin")
			print("Removing intermediate binaries")
			os.rmdir("./obj")
			print("Removing project files")
			os.rmdir("./.vs")
			os.remove("**.sln")
			os.remove("**.vcxproj")
			os.remove("**.vcxproj.filters")
			os.remove("**.vcxproj.user")
			print("Done")
		end
	}
	--Make sure to change "Hello" in the path to whatever project name you use
	newaction {
		trigger = "addDLLs",
		description = "Adds necessary dlls to the .exe folder",
		execute = function()
			print("Coppying necessary dlls")
			os.execute("xcopy" .. "/Y" .. "\t" .. "\"lib\\*.dll\"" .. "\t" .. "\"bin\\Debug.windows.x86_64\\Hello\\\"")
			print("Done")
		end
	}