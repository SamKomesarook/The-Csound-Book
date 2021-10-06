# Microsoft Developer Studio Project File - Name="CsoundLib" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Static Library" 0x0104

CFG=CsoundLib - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "CsoundLib.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "CsoundLib.mak" CFG="CsoundLib - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "CsoundLib - Win32 Release" (based on "Win32 (x86) Static Library")
!MESSAGE "CsoundLib - Win32 Debug" (based on "Win32 (x86) Static Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
RSC=rc.exe

!IF  "$(CFG)" == "CsoundLib - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir ".."
# PROP Intermediate_Dir "Release"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /GB /MT /W3 /GX /Zd /O2 /Ob2 /I "../Maldonado" /I ".." /D "NDEBUG" /D "RESET" /D "CSOUND_REENTRANT_API" /D "GAB_RT" /D "_CONSOLE" /D "SFIRCAM" /D "PIPES" /D "MACROS" /D "RTAUDIO" /D "MSVC" /D "MBCS" /D "WIN32" /D "GOGINS" /D "_ATL_STATIC_REGISTRY" /FD /c
# SUBTRACT CPP /nologo /YX /Yc /Yu
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# SUBTRACT BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# SUBTRACT LIB32 /nologo

!ELSEIF  "$(CFG)" == "CsoundLib - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "../Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /W3 /GX /Z7 /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /YX /FD /c
# ADD CPP /G5 /MTd /W3 /GX /Z7 /Od /I "../Maldonado" /I ".." /D "_DEBUG" /D "AXCSOUND" /D "RESET" /D "CSOUND_REENTRANT_API" /D "GAB_RT" /D "_CONSOLE" /D "SFIRCAM" /D "PIPES" /D "MACROS" /D "RTAUDIO" /D "MSVC" /D "MBCS" /D "WIN32" /D "GOGINS" /D "_ATL_STATIC_REGISTRY" /FD /c
# SUBTRACT CPP /nologo /YX /Yc /Yu
# ADD BASE RSC /l 0x409
# ADD RSC /l 0x409
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# SUBTRACT BSC32 /nologo
LIB32=link.exe -lib
# ADD BASE LIB32 /nologo
# SUBTRACT LIB32 /nologo

!ENDIF 

# Begin Target

# Name "CsoundLib - Win32 Release"
# Name "CsoundLib - Win32 Debug"
# Begin Group "SourceGab"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\Maldonado\argdecode.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\biquad.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\ConsoleGab.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\DirectX.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\fof3.C
# End Source File
# Begin Source File

SOURCE=..\Maldonado\foldover.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\foscili2.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\fout.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\gab_osc.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\gabWaveCaps.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\gabWinMIDI.cpp
# End Source File
# Begin Source File

SOURCE=..\Maldonado\InstrCall.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\loscil2.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\lowPassRes.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\midi_cs_gab.cpp
# End Source File
# Begin Source File

SOURCE=..\Maldonado\midiops3.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\one_file.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\opcLoad.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\physGab.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\pvocext.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\rtaudio2.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\timer.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\wrap.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\Maldonado\3dug.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Aiff.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Aops.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Aoscilx.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Bowed.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Brass.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Butter.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Clarinet.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Cmath.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Complex.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Convolve.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Cs.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Cscore.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Dam.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\dcblockr.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Diskin.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Disprep.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Dpwelib.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Dsputil.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Dumpf.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Fft.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Fhtfun.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Filter.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Flute.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Fm4op.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Follow.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\foscili2.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ftgen.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Grain.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Grain4.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Hrtferx.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ieee80.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Insert.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\locsig.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Lpc.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Mandolin.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Marimba.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Midioops.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Midiops.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Midiops2.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Midiout.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Modal4.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Moog1.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Nlfilt.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\nreverb.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Oload.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Physutil.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pluck.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Prototyp.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ptrigtbl.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pvadd.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pvinterp.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pvoc.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\pvocext.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pvread.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Repluck.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Revsets.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Scot.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Sfheader.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Shaker.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Singwave.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Sndwarp.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Sort.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Soundio.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Space.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Spectra.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Sysdep.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens1.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens2.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens3.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens4.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens5.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens6.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens7.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens8.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens9.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugensa.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugrw1.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugrw2.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Vdelay.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Version.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Vibraphn.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Vpvoc.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Wave.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Wavegde.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Windin.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Window.h
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Wineps.h
# End Source File
# End Group
# Begin Group "Source Files"

# PROP Default_Filter ""
# Begin Source File

SOURCE=..\Maldonado\aifc.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Aiff.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Aops.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Aoscilx.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Auxfd.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Butter.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Cmath.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Complex.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Cross2.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Cscore.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Cscorfns.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Cvanal.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Dam.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\dcblockr.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Diskin.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Disprep.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Dsputil.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Dumpf.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Entry.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Express.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Extract.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Fft.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Fgens.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Filopen.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Filter.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Fm4op.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Follow.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Grain.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Grain4.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Hetro.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Hrtferx.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ieee80.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Insert.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Linevent.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\locsig.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Lpanal.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Lptrkfns.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Main.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Mandolin.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Memalloc.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Memfiles.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Midiops.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Midiops2.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Midiout.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Midirecv.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Midisend.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Modal4.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Moog1.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Musmon.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Nlfilt.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Oload.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Opcode.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Otran.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Physmod.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Physutil.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pluck.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pvadd.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pvanal.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pvinterp.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pvoc.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Pvread.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Rdorch.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Rdscor.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Repluck.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Rtaudio.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\schedule.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Scot.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Scsort.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Scxtract.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Sfheader.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Shaker.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Singwave.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Sndinfo.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Sndwarp.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Sort.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Soundin.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Soundio.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Space.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Spectra.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Sread.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Swrite.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Twarp.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens1.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens2.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens3.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens4.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens5.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens6.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens7.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens8.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugens9.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugensa.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugrw1.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ugrw2.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Ulaw.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Vdelay.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Vpvoc.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Wave.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Wavegde.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Winascii.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Windin.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Window.c
# End Source File
# Begin Source File

SOURCE=..\Maldonado\Wineps.c
# End Source File
# End Group
# Begin Source File

SOURCE=..\Csound.cpp
# End Source File
# Begin Source File

SOURCE=..\Csound.h
# End Source File
# Begin Source File

SOURCE=..\CsoundFile.cpp
# End Source File
# Begin Source File

SOURCE=..\CsoundFile.h
# End Source File
# Begin Source File

SOURCE=..\SynthesizerInterface.h
# End Source File
# End Target
# End Project
