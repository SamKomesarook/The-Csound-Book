#pragma warning(once: 4786)
#include "CsoundFile.h"

//	C S O U N D X
//	Copyright (c) 1998 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	Structured text file for containing all elements of a Csound orchestra and score.

char staticBuffer[0x1000];

static void gatherArgs(int argc, const char **argv, std::string &commandLine)
{
	for(int i = 0; i < argc; i++)
	{
		if(i == 0)
		{
			commandLine = argv[i];
		}
		else
		{
			commandLine += " ";
			commandLine += argv[i];
		}
	}
}

static void scatterArgs(const std::string commandLine, int *argc, char ***argv)
{
	char *buffer = strdup(commandLine.c_str());
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

static std::string &trim(std::string &value)
{
	int i = value.find_first_of(" ");
	if(i == value.npos)
	{
		return value;
	}
	int n = value.find_first_not_of(" ", i);
	if(n == value.npos)
	{
		value.erase(i);
		return value;
	}
	value.erase(i, n - i);
	return value;
}

static getline(std::istream &stream, std::string &buffer)
{
	stream.getline(staticBuffer, 0xfff);
	if(stream.eof() || stream.bad() || stream.fail())
	{
		return false;
	}
	int index = strcspn(staticBuffer, "\n\r");
	if(index)
	{
		staticBuffer[index] = 0;
	}
	buffer = staticBuffer;
	return true;
}

CsoundFile::CsoundFile()
{
	removeAll();
}

int CsoundFile::load(std::string filename)
{
	removeAll();
	return import(filename);
}

int CsoundFile::load(std::istream &stream)
{
	removeAll();
	return import(stream);
}

int CsoundFile::save(std::string filename) const
{
	int returnValue = false;
	std::ofstream stream(filename.c_str(), std::ios::binary);
	if(!((filename.find(".orc") == filename.npos) && (filename.find(".ORC") == filename.npos)))
	{
		returnValue += exportOrchestra(stream);
	}
	else if(!((filename.find(".sco") == filename.npos) && (filename.find(".SCO") == filename.npos)))
	{
		returnValue += exportScore(stream);
	}
	else if(!((filename.find(".mid") == filename.npos) && (filename.find(".MID") == filename.npos)))
	{
		returnValue += exportMidifile(stream);
	}
	else
	{
		returnValue += save(stream);
	}
	stream.close();
	return returnValue;
}

int CsoundFile::save(std::ostream &stream) const
{
	int returnValue = 0;
	stream << "<CsoundSynthesizer>" << std::endl;
	stream << "<CsOptions>" << std::endl;
	returnValue += exportCommand(stream);
	stream << "</CsOptions>" << std::endl;
	stream << "<CsInstruments>" << std::endl;
	returnValue += exportOrchestra(stream);
	stream << "</CsInstruments>" << std::endl;
	stream << "<CsScore>" << std::endl;
	returnValue += exportScore(stream);
	stream << "</CsScore>" << std::endl;
	if(midifile.size() > 0)
	{
		stream << "<CsMidifile>" << std::endl;
		stream << "<Size>" << std::endl;
		stream << midifile.size() << std::endl;
		stream << "</Size>" << std::endl;
		returnValue += exportMidifile(stream);
		stream << "</CsMidifile>" << std::endl;
	}
	stream << "</CsoundSynthesizer>" << std::endl;
	return returnValue;
}

int CsoundFile::import(std::string filename)
{
	struct _finddata_t findData;
	int returnValue = _findfirst(filename.c_str(), &findData);
	if(returnValue == -1)
	{
		return false;
	}
	std::ifstream stream(filename.c_str(), std::ios::binary);
	if((filename.find(".orc") != filename.npos) || (filename.find(".ORC") != filename.npos))
	{
		returnValue += importOrchestra(stream);
	}
	else if((filename.find(".sco") != filename.npos) || (filename.find(".SCO") != filename.npos))
	{
		returnValue += importScore(stream);
	}
	else if((filename.find(".mid") != filename.npos) || (filename.find(".MID") != filename.npos))
	{
		returnValue += importMidifile(stream);
	}
	else
	{
		returnValue += import(stream);
	}
	stream.close();
	return returnValue;
}

int CsoundFile::import(std::istream &stream)
{
	std::string buffer;
	while(getline(stream, buffer))
	{
		if(buffer.find("<CsoundSynthesizer>") == 0)
		{
			while(getline(stream, buffer))
			{
				if(buffer.find("</CsoundSynthesizer>") == 0)
				{
					return true;
				}
				else if(buffer.find("<CsOptions>") == 0)
				{
					importCommand(stream);
				}
				else if(buffer.find("<CsInstruments>") == 0)
				{
					importOrchestra(stream);
				}
				else if(buffer.find("<CsScore>") == 0)
				{
					importScore(stream);
				}
				else if(buffer.find("<CsMidifile>") == 0)
				{
					importMidifile(stream);
				}
			}
		}
	}
	return false;
}

int CsoundFile::importCommand(std::istream &stream)
{
	std::string buffer;
	while(getline(stream, buffer))
	{
		if(buffer.find("</CsOptions") != buffer.npos)
		{
			return true;
		}
		command += buffer;
	}
	return false;
}

int CsoundFile::exportCommand(std::ostream &stream) const
{
	stream << command.c_str() << std::endl;
	return stream.good();
}

int CsoundFile::importOrchestra(std::istream &stream)
{
	std::string buffer;
	while(getline(stream, buffer))
	{
		if(buffer.find("</CsInstruments") == 0)
		{
			return true;
		}
		orchestra += buffer.c_str();
		orchestra += "\n";
		buffer.resize(0);
	}
	return false;
}

int CsoundFile::exportOrchestra(std::ostream &stream) const
{
	stream << orchestra;
	stream.flush();
	return stream.good();
}

int CsoundFile::importScore(std::istream &stream)
{
	std::string buffer;
	while(getline(stream, buffer))
	{
		if(buffer.find("</CsScore>") == 0)
		{
			return true;
		}
		else
		{
			score.push_back(buffer.c_str());
		}
	}
	return false;
}

int CsoundFile::exportScore(std::ostream &stream) const
{
	for(int i = 0, n = score.size(); i < n; i++)
	{
		stream << score[i].c_str() << std::endl;
	}
	return stream.good();
}

std::string CsoundFile::getFilename()
{
	return filename.c_str();
}

void CsoundFile::setFilename(std::string name)
{
	filename = name;
}

std::string CsoundFile::getCommand() const
{
	return command;
}

void CsoundFile::setCommand(std::string value)
{
	command = value;
}

void CsoundFile::removeCommand(void)
{
	command.erase(command.begin(), command.end());
}

std::string CsoundFile::getOrcFilename() const
{
	int argc;
	char **argv;
	std::string buffer;
	scatterArgs(command, &argc, &argv);
	if(argc >= 3)
	{
		buffer = argv[argc - 2];
	}
	deleteArgs(argc, argv);
	buffer.erase();
	return buffer.c_str();
}

std::string CsoundFile::getScoFilename() const
{
	int argc;
	char **argv;
	std::string buffer;
	scatterArgs(command, &argc, &argv);
	if(argc >= 3)
	{
		buffer = argv[argc - 1];
	}
	deleteArgs(argc, argv);
	buffer.erase();
	return buffer;
}

std::string CsoundFile::getMidiFilename() const
{
	int argc;
	char **argv;
	std::string buffer;
	scatterArgs(command, &argc, &argv);
	for(int i = 1, n = argc - 2; i < n; i++)
	{
		std::string buffer = argv[i];
		if(buffer.find("F") != buffer.npos)
		{
			if(buffer.find("F") == buffer.length() - 1)
			{
				buffer = argv[i + 1];
				deleteArgs(argc, argv);
				return buffer.c_str();
			}
			else
			{
				buffer = buffer.substr(buffer.find("F") + 1);
				deleteArgs(argc, argv);
				return buffer.c_str();
			}
		}
	}
	deleteArgs(argc, argv);
	buffer.erase();
	return buffer.c_str();
}

std::string CsoundFile::getOutputSoundfileName() const
{
	int argc;
	char **argv;
	std::string buffer;
	scatterArgs(command, &argc, &argv);
	for(int i = 1, n = argc - 2; i < n; i++)
	{
		std::string buffer = argv[i];
		if(buffer.find("o") != buffer.npos)
		{
			if(buffer.find("o") == buffer.length() - 1)
			{
				buffer = argv[i + 1];
				deleteArgs(argc, argv);
				return buffer.c_str();
			}
			else
			{
				buffer = buffer.substr(buffer.find("o") + 1);
				deleteArgs(argc, argv);
				return buffer.c_str();
			}
		}
	}
	deleteArgs(argc, argv);
	buffer.erase();
	return buffer.c_str();
}

std::string CsoundFile::getOrchestra() const
{
	return orchestra;
}

void CsoundFile::setOrchestra(std::string value)
{
	orchestra = value;
}

void CsoundFile::removeOrchestra()
{
	orchestra.erase();
}

std::string CsoundFile::getScore() const
{
	std::string buffer;
	buffer.empty();
	for(int i = 0, n = score.size(); i < n; i++)
	{
		buffer.append(score[i]);
		buffer.append("\n");
	}
	return buffer;
}

void CsoundFile::setScore(std::string scoreText)
{
	std::istringstream stream(scoreText, std::ios::binary);
	importScore(stream);
}

int CsoundFile::getScoreLineCount() const
{
	return score.size();
}

void CsoundFile::setScoreLineCount(int count)
{
	score.resize(count);
}

std::string CsoundFile::getScoreLine(int index) const
{
	if(index < 0 || index >= score.size())
	{
		return 0;
	}
	return score[index];
}

int CsoundFile::setScoreLine(int index, std::string scoreLine)
{
	if(index < 0 || index >= score.size())
	{
		return false;
	}
	int eol = scoreLine.find_first_of("\n");
	if(eol == scoreLine.npos)
	{
		score[index] = scoreLine.c_str();
	}
	else
	{
		score[index] = scoreLine.substr(0, eol).c_str();
	}
	return true;
}

void CsoundFile::addScoreLine(std::string scoreLine)
{
	int index = scoreLine.find_first_of("\n");
	if(index == scoreLine.npos)
	{
		score.push_back(scoreLine.c_str());
	}
	else
	{
		score.push_back(scoreLine.substr(0, index).c_str());
	}
}

int CsoundFile::removeScoreLine(int index)
{
	if(index < 0 || index >= score.size())
	{
		return false;
	}
    score.erase(score.begin() + index);
	return true;
}

void CsoundFile::removeAll()
{
	command.erase();
	orchestra.erase();
	removeMidifile();
	score.resize(0);
}

int CsoundFile::importMidifile(std::istream &stream)
{
	//	Importing from a standard MIDI file
	//	(Chunk ID == MThd or RIFF).
	if(stream.peek() == 'M' || stream.peek() == 'R')
	{
		midifile.resize(0);
		char buffer;
		while(!(stream.get(buffer).eof()))
		{
			midifile.push_back(buffer);
		}
		return true;
	}
	//	Importing from a "csd" file.
	else
	{
		std::string buffer;
		while(getline(stream, buffer))
		{
			if(buffer.find("</CsMidifile>") == 0)
			{
				return true;
			}
			else if(buffer.find("<Size>") == 0)
			{
				getline(stream, buffer);
				int size = atoi(buffer.c_str());
				getline(stream, buffer);
				if(size > 0)
				{
					midifile.resize(0);
					char charbuffer = 0;
					for(int i = 0; i < size; i++)
					{
						stream.get(charbuffer);
						midifile.push_back(charbuffer);
					}
				}
			}
		}
	}
	return false;
}

int CsoundFile::exportMidifile(std::ostream &stream) const
{
	for(int i = 0, n = midifile.size(); i < n; i++)
	{
		stream.put(midifile[i]);
	}
	return stream.good();
}

void CsoundFile::removeMidifile()
{
	midifile.resize(0);
}

void CsoundFile::removeScoreExceptFunctions()
{
	std::vector<std::string> buffer;
	for(int i = 0, n = score.size(); i < n; i++)
	{
		int position = score[i].find_first_not_of(" ");
		if(position == std::string.npos)
		{
			position = score[i].find("f");
		}
		else
		{
			position = score[i].substr(position).find("f");
		}
		if(position == 0)
		{
			buffer.push_back(score[i]);
		}
	}
	score = buffer;
}

void CsoundFile::addNote(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8, double p9, double p10)
{
	std::string note = "i ";
	_gcvt(p1, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p2, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p3, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p4, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p5, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p6, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p7, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p8, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p9, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p10, 10, staticBuffer);
	note += staticBuffer;
	score.push_back(note.c_str());
}

void CsoundFile::addNote(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8, double p9)
{
	std::string note = "i ";
	_gcvt(p1, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p2, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p3, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p4, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p5, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p6, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p7, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p8, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p9, 10, staticBuffer);
	note += staticBuffer;
	score.push_back(note.c_str());
}

void CsoundFile::addNote(double p1, double p2, double p3, double p4, double p5, double p6, double p7, double p8)
{
	std::string note = "i ";
	_gcvt(p1, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p2, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p3, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p4, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p5, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p6, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p7, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p8, 10, staticBuffer);
	note += staticBuffer;
	score.push_back(note.c_str());
}

void CsoundFile::addNote(double p1, double p2, double p3, double p4, double p5, double p6, double p7)
{
	std::string note = "i ";
	_gcvt(p1, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p2, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p3, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p4, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p5, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p6, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p7, 10, staticBuffer);
	note += staticBuffer;
	score.push_back(note.c_str());
}

void CsoundFile::addNote(double p1, double p2, double p3, double p4, double p5, double p6)
{
	std::string note = "i ";
	_gcvt(p1, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p2, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p3, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p4, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p5, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p6, 10, staticBuffer);
	note += staticBuffer;
	score.push_back(note.c_str());
}

void CsoundFile::addNote(double p1, double p2, double p3, double p4, double p5)
{
	std::string note = "i ";
	_gcvt(p1, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p2, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p3, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p4, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p5, 10, staticBuffer);
	note += staticBuffer;
	score.push_back(note.c_str());
}

void CsoundFile::addNote(double p1, double p2, double p3, double p4)
{
	std::string note = "i ";
	_gcvt(p1, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p2, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p3, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p4, 10, staticBuffer);
	note += staticBuffer;
	score.push_back(note.c_str());
}

void CsoundFile::addNote(double p1, double p2, double p3)
{
	std::string note = "i ";
	_gcvt(p1, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p2, 10, staticBuffer);
	note += staticBuffer;
	note += " ";
	_gcvt(p3, 10, staticBuffer);
	note += staticBuffer;
	score.push_back(note.c_str());
}


