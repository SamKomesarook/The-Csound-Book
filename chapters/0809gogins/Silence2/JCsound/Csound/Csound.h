#ifndef CSOUND_H
#define CSOUND_H
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1998 by Michael Gogins. All rights reserved.
//	This software is licensed under the GNU General Public License.
//	P U R P O S E
//	Implements SynthesizerInterface using "public-domain" Csound.
//	Normally, the user will call play() as the thread routine of 
//	a rendering thread, and call cleanUpAfterRendering() if the
//	thread is stopped before it returns.
#include "SynthesizerInterface.h"
#include <stdio.h>

#define CSOUND_REENTRANT_API

class Csound : public SynthesizerInterface
{
public:
	//	SynthesizerInterface functions.
	virtual ~Csound(void);
	virtual void setLogCallback(void (*function)(const char *logMessage));
	virtual int read(const char *xmlFilename);
	virtual int command(const char *text);
	//	Initializes for rendering, 
	//	and calls the old Csound main() with stored command options.
	virtual int play(void);
	virtual int stop(void);
	//	Other public functions.
	//	Default constructor, sets default log callback.
	Csound();
	//	Called to set command options from command line.
	static void command(int argc, const char **argv);
	//	Prepares Csound for rendering.
	static void initializeForRendering();
	//	Closes all open files and other resources after rendering.
	static void cleanUpAfterRendering();
	//	Returns whether or not Csound is rendering.
	bool isPlaying() const;
	//	Parses a Csound XML file:
	//	calls initializeForRendering(), 
	//	and calls command() to set options.
	static int read(FILE *file);
private:
	static void logCallback(const char *message);
	static int argc;
	static char **argv;
	bool playing;
};

#endif	//	CSOUND_H

