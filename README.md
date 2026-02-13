# EuroScope PDC Flag (fresh)

## What it does
- Adds a Departure List column type **PDC Flag**.
- It looks like a checkbox (blank/green X) when you set the column width small.
- Clicking it:
  1) Generates a single-line PDC in your format
  2) Writes the PDC identifier into the flightplan scratchpad
  3) Sends callsign + PDC to the companion app (PDCBridge)
- PDCBridge:
  - opens private chat with the pilot (types `.chat CALLSIGN` and presses Enter)
  - pastes the PDC (Ctrl+V)
  - does NOT press Enter (you press Enter)

## Required SDK files
Put your EuroScope SDK files in `SDK\`:
- EuroScopePlugIn.h
- EuroScopePlugInDll.lib  (exact name may vary)

## Build (x86) - Plugin DLL
From an **x86 Native Tools** Developer Command Prompt in repo root:

    mkdir build 2>nul
    cl /nologo /LD /EHsc /MD /std:c++17 ^
      /I SDK ^
      src\PreferredPDCPlugin.cpp ^
      /link ^
      /LIBPATH:SDK ^
      EuroScopePlugInDll.lib ^
      User32.lib ^
      /OUT:build\PreferredPDCPlugin.dll

## Build (x86) - Bridge EXE
    mkdir tools\PDCBridge\build 2>nul
    cl /nologo /EHsc /MD /std:c++17 ^
      tools\PDCBridge\PDCBridge.cpp ^
      /link ^
      User32.lib ^
      /OUT:tools\PDCBridge\build\PDCBridge.exe

## Configure EuroScope Departure List
In the Departure List column editor:
- Add a column
- Tag Item Type: `PDC Flag`
- Function: `Generate PDC (bridge)`
- Set column width to **1 or 2** so you only see '.' or 'X'

If you see the word `PDC` in the cells, EuroScope is NOT using the tag item type.
It must be exactly `PDC Flag`.

## IMPORTANT: chat-open command
In `tools/PDCBridge/PDCBridge.cpp` change:

    std::string openCmd = ".chat " + callsign;

to whatever command opens private chat in your EuroScope.
