C S O U N D X
An ActiveX control enabling "public domain" Csound to serve as a
programmable yet user-friendly software synthesizer and signal processing plugin 
for Windows digital audio sequencers, soundfile editors, and other programs;
also serves as a standalone software synthesizer with a graphical user interface.
C O P Y R I G H T
This software is copyright (C) 1998 by Michael Gogins.
It is licensed under the terms of the GNU Public Library License.
Csound is copyright by the Massachusetts Institute of Technology;
see the Csound documentation for the terms of the Csound copyright.
P U R P O S E
This is the master Developer Studio Workspace file 
for tracking the dependencies of all projects required 
to make public domain Csound into an ActiveX control 
and DirectShow transform filter with XML data files.
S T R A T E G Y
o	Revive Richard Dobson's code to make Csound re-entrant, 
	only as a Windows dynamic link library (Csound.dll) rather than for Winsound.
	-	Csound.dll will log output to its own console window.
	-	My plugin opcode mechanism will be implemented.
	-	Gabriel Maldonaldo's DirectSound work may be included.
o	Add to Csound.dll the ability to parse all data from an XML file.
o	Create an ActiveX control (CsoundX.dll) that edits the Csound XML file
	and runs Csound.dll.
o	Add to CsoundX the ability to function as a DirectSound transform filter
	with a filter graph manager for audio and MIDI input and output.

