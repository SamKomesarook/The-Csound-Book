#ifndef SYNTHESIZER_INTERFACE_H
#define SYNTHESIZER_INTERFACE_H
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1998 by Michael Gogins. All rights reserved.
//	This software is licensed under the GNU General Public License.
//	P U R P O S E
//	This file defines a C++ application programming interface (API) 
//	for a generic "Music N" type software synthesizer.
//	The synthesizer is driven by an XML file that contains all the data 
//	required to render a work of music.
//	This API is identical for all operating systems.
#include <stdio.h>

class SynthesizerInterface
{
public:
	virtual ~SynthesizerInterface(void){};
	//	Allows the user to supply a function to be called by the synthesizer
	//	for displaying messages generated during rendering.
	virtual void setLogCallback(void (*callback)(const char *logMessage))=0;
	//	Reads an XML file containing comands for synthesizing sound.
	virtual int read(const char *filename)=0;
	//	Issues a command to the synthesizer.
	virtual int command(const char *text)=0;
	//	Opens any required resources and renders the XML file.
	virtual int play(void)=0;
	//	Stops rendering and closes all open resources.
	virtual int stop(void)=0;
};

#endif	//	SYNTHESIZER_INTERFACE_H


