@echo off
setlocal

mkdir build 2>nul

REM Open the "x86 Native Tools Command Prompt for VS" before running this.
REM Put the EuroScope SDK files into .\SDK first:
REM   - EuroScopePlugIn.h
REM   - EuroScopePlugIn.dll
REM   - EuroScopePlugInDll.lib   (or your import lib name)

cl /nologo /LD /EHsc /MD /std:c++17 ^
  /I SDK ^
  src\PreferredPDCPlugin.cpp ^
  /link ^
  /LIBPATH:SDK ^
  EuroScopePlugInDll.lib ^
  /OUT:build\PreferredPDCPlugin.dll

endlocal
