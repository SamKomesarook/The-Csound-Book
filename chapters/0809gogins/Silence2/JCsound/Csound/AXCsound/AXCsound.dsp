# Microsoft Developer Studio Project File - Name="CsoundAx" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=CsoundAx - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "AXCsound.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "AXCsound.mak" CFG="CsoundAx - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "CsoundAx - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "CsoundAx - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "CsoundAx - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /Yu"stdafx.h" /FD /GZ /c
# ADD CPP /G5 /MTd /W3 /GX /Z7 /Od /I "c:/jdk1.2/include" /I "c:/jdk1.2/include/win32" /I "../Maldonado" /I "../CsoundLib" /I "c:/DXMedia/Include" /I "c:/DXMedia/classes/base" /I ".." /I "c:/Program Files/Windows Media Player" /D "_DEBUG" /D "INC_OLE2" /D "_USRDLL" /D "_WINDOWS" /D "AXCSOUND" /D "MBCS" /D "WIN32" /D "GOGINS" /D "_ATL_STATIC_REGISTRY" /FD /c
# ADD BASE RSC /l 0x409 /d "_DEBUG"
# ADD RSC /l 0x409 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /subsystem:windows /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 Winmm.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib comctl32.lib CsoundLib.lib dsound.lib /subsystem:windows /dll /pdb:"../Debug/JCsound_Csound.pdb" /debug /machine:I386 /out:"../Debug/JCsound_Csound.dll" /implib:"../Debug/JCsound_Csound.lib" /pdbtype:sept /libpath:"../Debug"
# SUBTRACT LINK32 /pdb:none
# Begin Custom Build - Performing registration
OutDir=.\Debug
TargetPath=\mkg\Csound\Debug\JCsound_Csound.dll
InputPath=\mkg\Csound\Debug\JCsound_Csound.dll
SOURCE="$(InputPath)"

"$(OutDir)\regsvr32.trg" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	regsvr32 /s /c "$(TargetPath)" 
	echo regsvr32 exec. time > "$(OutDir)\regsvr32.trg" 
	
# End Custom Build

!ELSEIF  "$(CFG)" == "CsoundAx - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "CsoundAx___Win32_Release"
# PROP BASE Intermediate_Dir "CsoundAx___Win32_Release"
# PROP BASE Ignore_Export_Lib 0
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "../JCsound"
# PROP Intermediate_Dir "CsoundAx___Win32_Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /MT /W3 /GX /Zd /O2 /Ob2 /I "c:/jdk1.2/include" /I "c:/jdk1.2/include/win32" /I "../Maldonado" /I "../CsoundLib" /I "c:/DXMedia/Include" /I "c:/DXMedia/classes/base" /I ".." /I "c:/Program Files/Windows Media Player" /D "NDEBUG" /D "INC_OLE2" /D "_USRDLL" /D "_WINDOWS" /D "AXCSOUND" /D "MBCS" /D "WIN32" /D "GOGINS" /D "_ATL_STATIC_REGISTRY" /Fo"Release/" /Fd"Release/" /FD /c
# ADD CPP /MT /W3 /GX /Zd /O2 /Ob2 /I "." /I ".." /I "../.." /I "c:/jdk1.2/include" /I "c:/jdk1.2/include/win32" /I "../Maldonado" /I "../CsoundLib" /I "c:/DXMedia/Include" /I "c:/DXMedia/classes/base" /D "NDEBUG" /D "INC_OLE2" /D "_USRDLL" /D "_WINDOWS" /D "AXCSOUND" /D "MBCS" /D "WIN32" /D "GOGINS" /D "_ATL_STATIC_REGISTRY" /Fo"Release/" /Fd"Release/" /FD /c
# ADD BASE RSC /l 0x409 /d "NDEBUG"
# ADD RSC /l 0x409 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 Winmm.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib comctl32.lib CsoundLib.lib dsound.lib /subsystem:windows /dll /incremental:yes /pdb:"../JCsound_Csound.pdb" /debug /machine:I386 /out:"../JCsound_Csound.dll" /implib:"../JCsound_Csound.lib" /pdbtype:sept /libpath:".."
# SUBTRACT BASE LINK32 /pdb:none
# ADD LINK32 Winmm.lib kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib comctl32.lib CsoundLib.lib dsound.lib /subsystem:windows /dll /incremental:yes /pdb:"../JCsound_Csound.pdb" /debug /machine:I386 /out:"../JCsound/JCsound_Csound.dll" /implib:"../JCsound_Csound.lib" /pdbtype:sept /libpath:".."
# SUBTRACT LINK32 /pdb:none
# Begin Custom Build - Performing registration
OutDir=.\../JCsound
TargetPath=\mkg\Csound\JCsound\JCsound_Csound.dll
InputPath=\mkg\Csound\JCsound\JCsound_Csound.dll
SOURCE="$(InputPath)"

"$(OutDir)\regsvr32.trg" : $(SOURCE) "$(INTDIR)" "$(OUTDIR)"
	regsvr32 /s /c "$(TargetPath)" 
	echo regsvr32 exec. time > "$(OutDir)\regsvr32.trg" 
	
# End Custom Build

!ENDIF 

# Begin Target

# Name "CsoundAx - Win32 Debug"
# Name "CsoundAx - Win32 Release"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=.\AXCsound.cpp
# End Source File
# Begin Source File

SOURCE=.\AXCsound.def
# End Source File
# Begin Source File

SOURCE=.\AXCsound.idl

!IF  "$(CFG)" == "CsoundAx - Win32 Debug"

!ELSEIF  "$(CFG)" == "CsoundAx - Win32 Release"

# ADD MTL /I "../JCsound"

!ENDIF 

# End Source File
# Begin Source File

SOURCE=.\AXCsound.rc
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409 /i ".."
# End Source File
# Begin Source File

SOURCE=.\AXCsoundImpl.cpp
# End Source File
# Begin Source File

SOURCE=.\CommandDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\CopyrightDialog.cpp
# End Source File
# Begin Source File

SOURCE=..\Csound.cpp
# End Source File
# Begin Source File

SOURCE=..\CsoundFile.cpp
# End Source File
# Begin Source File

SOURCE=.\dlldatax.c
# PROP Exclude_From_Scan -1
# PROP BASE Exclude_From_Build 1
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=..\JCsound\JCsound_Csound.cpp
# End Source File
# Begin Source File

SOURCE=.\OrchestraDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\ScoreDialog.cpp
# End Source File
# Begin Source File

SOURCE=.\StdAfx.cpp
# ADD CPP /Yc"stdafx.h"
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=.\AXCsound.h
# End Source File
# Begin Source File

SOURCE=.\AXCsoundImpl.h
# End Source File
# Begin Source File

SOURCE=.\CommandDialog.h
# End Source File
# Begin Source File

SOURCE=.\CopyrightDialog.h
# End Source File
# Begin Source File

SOURCE=..\Csound.h
# End Source File
# Begin Source File

SOURCE=..\CsoundFile.h
# End Source File
# Begin Source File

SOURCE=.\dlldatax.h
# PROP Exclude_From_Scan -1
# PROP BASE Exclude_From_Build 1
# PROP Exclude_From_Build 1
# End Source File
# Begin Source File

SOURCE=..\JCsound\JCsound_Csound.h
# End Source File
# Begin Source File

SOURCE=.\OrchestraDialog.h
# End Source File
# Begin Source File

SOURCE=.\Resource.h
# End Source File
# Begin Source File

SOURCE=.\ScoreDialog.h
# End Source File
# Begin Source File

SOURCE=.\StdAfx.h
# End Source File
# Begin Source File

SOURCE=..\SynthesizerInterface.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\NoteHead.ico
# End Source File
# End Group
# Begin Source File

SOURCE=.\AXCsound.htm
# End Source File
# Begin Source File

SOURCE=.\AXCsound.rgs
# End Source File
# End Target
# End Project
# Section AXCsound : {00000011-0410-0000-9100-000000000000}
# 	1:19:IDD_COPYRIGHTDIALOG:107
# End Section
# Section AXCsound : {00000000-0000-0000-0000-000000000000}
# 	1:17:IDD_COMMANDDIALOG:106
# End Section
# Section AXCsound : {00000000-0000-0000-0000-800000800000}
# 	1:19:IDD_ORCHESTRADIALOG:105
# End Section
# Section AXCsound : {510088FC-0013-0000-0000-000024BE495F}
# 	1:12:IDB_AXCSOUND:101
# 	1:12:IDD_AXCSOUND:103
# 	1:12:IDR_AXCSOUND:102
# End Section
