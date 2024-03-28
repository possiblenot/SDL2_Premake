@echo off

IF "%~1" == "" GOTO PrintHelp
IF "%~1" == "compile" GOTO Compile

vendor\premake\premake5.exe %1
GOTO Done


:PrintHelp

echo.
echo Enter 'build.bat action' where action is one of the following:
echo.
echo compile           Will generate make file then compile using the make file.
echo clean             Remove all binaries and generated files
echo addDLLs           Add all necessary dlls to executable
echo vs2022            Generate Visual Studio 2022 project files


GOTO Done

:Compile

vendor\premake\premake5.exe vs2022

if not defined DevEnvDir (
  call "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\VsDevCmd.bat"
)

set solutionFile="HelloWorld.sln"
msbuild /t:Build /p:Configuration=Debug /p:Platform=x64 %solutionFile%

vendor\premake\premake5.exe addDLLs



:Done
