# Microsoft Developer Studio Project File - Name="AXCsoundExe" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Application" 0x0101

CFG=AXCsoundExe - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "AXCsoundExe.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "AXCsoundExe.mak" CFG="AXCsoundExe - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "AXCsoundExe - Win32 Debug" (based on "Win32 (x86) Application")
!MESSAGE "AXCsoundExe - Win32 Release" (based on "Win32 (x86) Application")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "AXCsoundExe - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "../Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /Gm /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /MTd /W3 /Gm /GX /ZI /Od /I "../" /I "c:/Program Files/Wolfram Research/Mathematica/3.0/AddOns/MathLink/DevelopersKits/Windows/CompilerAdditions/mldev32/include" /D "_DEBUG" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /D "_ATL_STATIC_REGISTRY" /FD /GZ /c
# SUBTRACT CPP /nologo /YX /Yc /Yu
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /subsystem:windows /debug /machine:I386 /out:"../Debug/AXCsound.exe" /pdbtype:sept
# SUBTRACT LINK32 /pdb:none
# Begin Custom Build - Performing registration
OutDir=.\../Debug
TargetPath=\mkg\Csound\Debug\AXCsound.exe
InputPath=\mkg\Csound\Debug\AXCsound.exe
SOURCE="$(InputPath)"

"$(OutDir)\regsvr32.trg" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	"$(TargetPath)" /RegServer 
	echo regsvr32 exec. time > "$(OutDir)\regsvr32.trg" 
	echo Server registration done! 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "AXCsoundExe - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "AXCsoundExe___Win32_Release"
# PROP BASE Intermediate_Dir "AXCsoundExe___Win32_Release"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "AXCsoundExe___Win32_Release"
# PROP Intermediate_Dir "AXCsoundExe___Win32_Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /G5 /MT /W3 /GX /O2 /Ob2 /I "../" /I "c:/Program Files/Wolfram Research/Mathematica/3.0/AddOns/MathLink/DevelopersKits/Windows/CompilerAdditions/mldev32/include" /D "NDEBUG" /D "_ATL_STATIC_REGISTRY" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /FD /c
# SUBTRACT BASE CPP /nologo /YX /Yc /Yu
# ADD CPP /MT /W3 /GX /O2 /Ob2 /I "." /I ".." /I "../JCsound" /D "NDEBUG" /D "_ATL_STATIC_REGISTRY" /D "WIN32" /D "_WINDOWS" /D "_MBCS" /FD /c
# SUBTRACT CPP /nologo /YX /Yc /Yu
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /i "." /i ".." /i "../../JCsound" /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /subsystem:windows /machine:I386 /out:"../AXCsound.exe"
# SUBTRACT BASE LINK32 /nologo
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /subsystem:windows /machine:I386 /out:"../AXCsound.exe"
# SUBTRACT LINK32 /nologo
# Begin Custom Build - Performing registration
OutDir=.\AXCsoundExe___Win32_Release
TargetPath=\mkg\Csound\AXCsound.exe
InputPath=\mkg\Csound\AXCsound.exe
SOURCE="$(InputPath)"

"$(OutDir)\regsvr32.trg" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	"$(TargetPath)" /RegServer 
	echo regsvr32 exec. time > "$(OutDir)\regsvr32.trg" 
	echo Server registration done! 
	
# End Custom Build

!ENDIF 

# Begin Target

# Name "AXCsoundExe - Win32 Debug"
# Name "AXCsoundExe - Win32 Release"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\AXCsoundExe.cpp
# End Source File
# Begin Source File

SOURCE=.\AXCsoundExe.idl
# ADD MTL /tlb ".\AXCsoundExe.tlb" /h "AXCsoundExe.h" /iid "AXCsoundExe_i.c" /Oicf
# End Source File
# Begin Source File

SOURCE=.\AXCsoundExe.rc
# End Source File
# Begin Source File

SOURCE=.\MainWindow.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\MainWindow.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\res\AXCsoundExe.ico
# End Source File
# Begin Source File

SOURCE=.\AXCsoundExe.rgs
# End Source File
# End Group
# End Target
# End Project
