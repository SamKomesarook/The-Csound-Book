#ifndef CSOUND_FILE
#define CSOUND_FILE
#pragma warning(once: 4786)
#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <fstream>
#include <sstream>
#include <stdlib.h>
#include <io.h>
//	C S O U N D X
//	Copyright (c) 1998 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	XML file for containing all elements of a Csound orchestra and score.
//	It is assumed to be stored in an ".csd" file.
//	Functions return true for success or false for failure.

class CsoundFile
{
public:
	CsoundFile();
	virtual ~CsoundFile(void){};
	std::string getFilename(void);
	void setFilename(std::string name);
	int load(std::string filename);
	int load(std::istream &stream);
	int save(std::string filename) const;
	int save(std::ostream &stream) const;
	int import(std::string filename);
	int import(std::istream &stream);
	int importCommand(std::istream &stream);
	int exportCommand(std::ostream &stream) const;
	int importOrchestra(std::istream &stream);
	int exportOrchestra(std::ostream &stream) const;
	int importScore(std::istream &stream);
	int exportScore(std::ostream &stream) const;
	int importMidifile(std::istream &stream);
	int exportMidifile(std::ostream &stream) const;
	std::string getCommand(void) const;
	void setCommand(std::string commandLine);
	std::string getOrcFilename(void) const;
	std::string getScoFilename(void) const;
	std::string getMidiFilename(void) const;
	std::string getOutputSoundfileName(void) const;
	void removeCommand(void);
	std::string getOrchestra(void) const;
	void setOrchestra(std::string orchestra);
	int getInstrumentCount(void) const;
	void removeOrchestra(void);
	std::string getScore() const;
	void setScore(std::string score);
	int getScoreLineCount() const;
	void setScoreLineCount(int count);
	std::string getScoreLine(int index) const;
	int setScoreLine(int index, std::string note);
	void addScoreLine(std::string note);
	void addNote(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8, double p9, double p10);
	void addNote(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8, double p9);
	void addNote(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8);
	void addNote(double p1, double p2, double p3, double p4, double p5, double p6, double p7);
	void addNote(double p1, double p2, double p3, double p4, double p5, double p6);
	void addNote(double p1, double p2, double p3, double p4, double p5);
	void addNote(double p1, double p2, double p3, double p4);
	void addNote(double p1, double p2, double p3);
	int removeScoreLine(int index);
	void removeScoreExceptFunctions(void);
	void removeMidifile(void);
	void removeAll(void);
private:
	//	What are we storing, anyway?
	std::string filename;
	//	<Command>
	std::string command;
	//	<Orchestra>
	std::string orchestra;
	//	<Score>
	std::vector<std::string> score;
	//	<Midi>
	std::vector<unsigned char> midifile;
};

#endif


