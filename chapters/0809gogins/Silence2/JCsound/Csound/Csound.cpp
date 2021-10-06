//	A Csound XML file consists of well-formed XML 
//	with the following additional restrictions:
//		No elements are empty.
//		No elements have attributes.
//		Each line of text contains either a start tag, 
//		or an end tag, or CDATA without markup.
//	The permissible elements are defined below.
//	They must appear in the order shown.
//	Required elements are marked *.
//	End tags are required but not shown.
//	
//	<CsoundSynthesizer>*
//		<CsOptions>
//			A legal Csound command line.
//		<CsInstruments>*
//			A legal Csound orchestra file.
//		<CsScore>*
//			A legal Csound score file.
//		<CsMidifile>
//			<Size>
//				Size of binary data in bytes.
//			Binary data.

#ifdef WIN32
#include <windows.h>
#include <process.h>
#endif

#include "Csound.h"
#include "cs.h"
#include <stdio.h>
#include <string.h>
#include <gabWinMIDI.h>

//	Things required from Csound.

extern WinMIDI_IN *midi_in_port;
extern WinMIDI_OUT *midi_out_port;

extern "C"
{
	extern OPARMS O;
	extern int nrecs;
	extern char *orchname;
	extern char *scorename;
	extern void adsynreset(void);
	extern void cscorereset(void);
	extern void expreset(void);
	extern void ftreset(void);
	extern void insertreset(void);
	extern void lpcreset(void);
	extern void memreset(void);
	extern void musreset(void);
	extern void oloadreset(void);
	extern void orchreset(void);
    extern void sfclosein();
	extern void sfcloseout();
	extern void soundinreset(void);
	extern void tranreset(void);

	extern float *zkstart;
	extern float *zastart;
	extern long zklast;
	extern long zalast;
	void zakreset(void)
	{
		free(zkstart);
		zkstart = 0;
		zklast = 0;
		free(zastart);
		zastart = 0;
		zalast = 0;
	}

	extern int lib_main(int argc, char **argv);
	extern void (*csLogCallback)(const char *message);
	int keepPlayingFlag;
	extern void rtclose();
	extern int midi_in_p_num;
	extern int midi_out_p_num;

	void midireset()
	{
		if(midi_in_port)
		{
			delete midi_in_port;
			midi_in_port = 0;
			midi_in_p_num = -1;
		}
		if(midi_out_port)
		{
			delete midi_out_port;
			midi_out_port = 0;
			midi_out_p_num = -1;
		}
	}

	extern int pipdevin;
	extern int pipdevout;
};

static void writeLine(FILE *file, const char *text)
{
	int length = strcspn(text, "\n\r\0");
	fwrite(text, sizeof(char), length, file);
	fputs("\n\0", file);
}

//	A simple XML parser.
//	It assumes that each start tag and each end tag is on a separate line,
//	and that all values consist either of separate lines or of binary data.

class XMLParser
{
public:
	XMLParser(FILE *f)
	{
		file = f;
	}
	char *readLine()
	{
		fgets(xmlBuffer, sizeof(xmlBuffer), file);
		return xmlBuffer;
	}
	char *getLine()
	{
		return xmlBuffer;
	}
	int readByte(unsigned char &byte)
	{
		if(fread(&byte, sizeof(byte), 1, file) != 1)
		{
			return 0;
		}
		return 1;
	}
	int isStartTag(const char *tag)
	{
		int length = strlen(tag);
		char *start = strstr(xmlBuffer, "<");
		if(!start)
		{
			return 0;
		}
		char *text = strstr(start, tag);
		if(!text)
		{
			return 0;
		}
		char *stop = strstr(text, ">");
		if(!stop)
		{
			return 0;
		}
		if((text - start) != 1)
		{
			return 0;
		}
		if((text + length) != stop)
		{
			return 0;
		}
		return 1;
	}
	int isEndTag(const char *tag)
	{
		int length = strlen(tag);
		char *start = strstr(xmlBuffer, "</");
		if(!start)
		{
			return 0;
		}
		char *text = strstr(start, tag);
		if(!text)
		{
			return 0;
		}
		char *stop = strstr(text, ">");
		if(!stop)
		{
			return 0;
		}
		if((text - start) != 2)
		{
			return 0;
		}
		if((text + length) != stop)
		{
			return 0;
		}
		return 1;
	}
	int readEndTag(const char *tag)
	{
		if(!readLine())
		{
			return 0;
		}
		return isEndTag(tag);
	}
protected:
	FILE *file;
	char xmlBuffer[0x1000];
};

static void gatherArgs(int argc, const char **argv, char *command)
{
	for(int i = 0; i < argc; i++)
	{
		if(i == 0)
		{
			strcpy(command, argv[i]);
		}
		else
		{
			strcat(command, " ");
			strcat(command, argv[i]);
		}
	}
}

static void scatterArgs(const char *command, int *argc, char ***argv)
{
	char *buffer = strdup(command);
	char *separators = " \t\n\r";
	int argcc = 0;
	char **argvv = (char **) calloc(sizeof(char *), 100);
	char *token = strtok(buffer, separators);   
	while(token)
	{
		argvv[argcc] = strdup(token);
		argcc++;
    	token = strtok(0, separators);
	}
	*argc = argcc;
	*argv = (char **) realloc(argvv, sizeof(char *) * argcc);
	free(buffer);
}

static void deleteArgs(int argc, char **argv)
{
	for(int i = 0; i < argc; i++)
	{
		free(argv[i]);
	}
	free(argv);
}

//	Local helper stuff.

static char orcFilename[0x100];
static FILE *orcFile = 0;
static char scoFilename[0x100];
static FILE *scoFile = 0;
static char midiFilename[0x100];
static FILE *midiFile = 0;
static char commandLine[0x1000];

static int readCommand(XMLParser &parser)
{
	char *str = 0;
	while(parser.readLine())
	{
		if(parser.isEndTag("CsOptions"))
		{
			int argc = 0;
			char **argv = 0;
			scatterArgs(commandLine, &argc, &argv);
			if(argc < 3)
			{
				return 0;
			}
			for(int i = 1; i < argc - 2; i++)
			{
				if(strstr(argv[i], "-"))
				{
					str = strstr(argv[i], "F");
					if(str)
					{
						if(strlen(str) > 1)
						{
							strcpy(midiFilename, str + 1);
						}
						else
						{
							strcpy(midiFilename, argv[i + 1]);
						}
					}
				}
			}			
			strcpy(orcFilename, argv[argc - 2]);
			strcpy(scoFilename, argv[argc - 1]);
			Csound::command(argc, (const char **)argv);
			deleteArgs(argc, argv);
			return 1;
		}
		strcpy(commandLine, parser.getLine());
	}
	return 0;
}

static int readOrchestra(XMLParser &parser)
{
	orcFile = fopen(orcFilename, "w");
	if(!orcFile)
	{
		return 0;
	}
	while(parser.readLine())
	{
		if(parser.isEndTag("CsInstruments"))
		{
			fclose(orcFile);
			return 1;
		}
		writeLine(orcFile, parser.getLine());
	}
	return 0;
}

static int readScore(XMLParser &parser)
{
	scoFile = fopen(scoFilename, "w");
	if(!scoFile)
	{
		return 0;
	}
	while(parser.readLine())
	{
		if(parser.isEndTag("CsScore"))
		{
			fclose(scoFile);
			return 1;
		}
		writeLine(scoFile, parser.getLine());
	}
	return 0;
}

static int readMidi(XMLParser &parser)
{
	midiFile = fopen(midiFilename, "wb");
	if(!midiFile)
	{
		return 0;
	}
	int midiSize = 0;
	unsigned char byte = 0;
	while(parser.readLine())
	{
		if(parser.isEndTag("CsMidifile"))
		{
			fclose(midiFile);
			return 1;
		}
		else if(parser.isStartTag("Size"))
		{
			midiSize = atoi(parser.readLine());
			if(!parser.readEndTag("Size"))
			{
				return 0;
			}
			for(int i = 0; i < midiSize; i++)
			{
				if(!parser.readByte(byte))
				{
					return 0;
				}
				fwrite(&byte, sizeof(byte), 1, midiFile);
			}			
		}
	}
	return 0;
}

//	Class members.

int Csound::argc;
char **Csound::argv;

Csound::Csound()
{
	setLogCallback(&logCallback);
}

Csound::~Csound()
{
	stop();
}

void Csound::logCallback(const char *message)
{
	writeLine(stderr, message);
}

void Csound::setLogCallback(void (*callback)(const char *logMessage))
{
	csLogCallback = callback;
}

int Csound::command(const char *commandLine)
{
	int argn = 0;
	char **args = 0;
	scatterArgs(commandLine, &argn, &args);
	Csound::command(argn, (const char **)args);
	deleteArgs(argn, args);
	return 1;
}

void Csound::command(int newArgc, const char **newArgv)
{
	if(argv)
	{
		for(int i = 0; i < argc; i++)
		{
			free(argv[i]);
		}
		delete[] argv;
	}
	argc = newArgc;
	argv = new char *[newArgc];
	for(int i = 0; i < argc; i++)
	{
		argv[i] = strdup(newArgv[i]);
	}
}

void Csound::initializeForRendering()
{
	//	Clean up any previously allocated memory,
	//	and otherwise prepare for running Csound (adds to Richard Dobson's code).
	if(O.infilename)
	{
		_unlink(O.infilename);
	}
	if(O.outfilename)
	{
		_unlink(O.outfilename);
	}
	adsynreset();
	cscorereset();
	expreset();
	ftreset();
	insertreset();
	lpcreset();
	memreset();
	musreset();
	oloadreset();
	orchreset();
    sfclosein();
	sfcloseout();
	soundinreset();
	tranreset();
	zakreset();
	orchname = 0;
	scorename = 0;
	nrecs = 0;
	memset(&O, 0, sizeof(O));
	O.sfheader = 1;
	O.sfwrite = 1;
	keepPlayingFlag = 1;
	midireset();
	sfclosein();
	sfcloseout();
	pipdevin = 0;
	pipdevout = 0;
}

void Csound::cleanUpAfterRendering()
{
	midireset();
	sfclosein();
	sfcloseout();
	if(orcFile)
	{
		remove(orcFilename);
		orcFile = 0;
	}
	if(scoFile)
	{
		remove(scoFilename);
		scoFile = 0;
	}
	if(midiFile)
	{
		remove(midiFilename);
		midiFile = 0;
	}
	keepPlayingFlag = 0;
}

int Csound::play(void)
{
	int returnValue = 0;
	try
	{
		initializeForRendering();
		if(argc == 2)
		{
			read(argv[1]);
		}
		(csLogCallback)("Command: ");
		(csLogCallback)(commandLine);
		(csLogCallback)("\n");
		returnValue = lib_main(argc, argv);
		cleanUpAfterRendering();
		returnValue = 1;
	}
	catch(...)
	{
		(csLogCallback)("Unidentified exception in Csound::playRoutine().\nDebug orc and sco and try again.");
		cleanUpAfterRendering();
		returnValue = 0;
	}
	return returnValue;
}

int Csound::stop()
{
	keepPlayingFlag = 0;
	Sleep(10);
	cleanUpAfterRendering();
	return 1;
}

int Csound::read(const char *xmlFilename)
{
	FILE *file = fopen(xmlFilename, "rb");
	if(file)
	{
		return read(file);
	}
	return 0;	
}

int Csound::read(FILE *file)
{
	XMLParser parser(file);
	while(parser.readLine())
	{
		if(parser.isEndTag("CsoundSynthesizer"))
		{
			return 1;
		}
		else if(parser.isStartTag("CsOptions"))
		{
			if(!readCommand(parser))
			{
				return 0;
			}
		}
		else if(parser.isStartTag("CsInstruments"))
		{
			if(!readOrchestra(parser))
			{
				return 0;
			}
		}
		else if(parser.isStartTag("CsScore"))
		{
			if(!readScore(parser))
			{
				return 0;
			}
		}
		else if(parser.isStartTag("CsMidifile"))
		{
			if(!readMidi(parser))
			{
				return 0;
			}
		}
	}
	return 0;
}

bool Csound::isPlaying() const
{
	return (bool) keepPlayingFlag;
}
