//  L O G M U S E
//  A simple algorithmic score generator for Csound in ANSI C.
//  Michael Gogins
//  21 January 1997

//	Almost all C programs include these header files.
#include <stdlib.h>
#include <stdio.h>

//	All C console programs have a main() function.
int main(int argc, const char *argv[], const char *envp[])
{
	//  Variables for the generator.
	double c;
	double y;
	double y1;
	int i;
	int n;
	//  Variables for music.
	//  The dimensions that are not generated have default values.
	double instrument = 1;
	double start;
	double length = 2;
	double octave;
	double decibels = 70;
	double pan = 0;
	//  Mapping coefficients.
	double pulse = .25;
	double bass = 6;
	double range = 4;
	//  Variables for rendering the score.
	FILE *file;
	//  You can paste a Csound instrument definition right into C code like this.
	char orchestra[] = 
		"sr =    44100\n"
		"kr =    44100\n"
		"ksmps =     1\n"
		"nchnls =    2\n"
		"\n"
		"; Frequency modulation instrument.\n"
		"instr 1\n"
		"; LOGGING\n"
		"; p1 = Instrument\n"
		"; p2 = Start\n"
		"; p3 = Length\n"
		"; p4 = Octave\n"
		"; p5 = Decibels\n"
		"; p6 = Pan\n"
		"print p2, p3, p4, p5, p6\n"
		"\n"
		"; INITIALIZATION\n"
		"iwavetable = 1\n"
		"imodulator = .5\n"
		"ifmamplitude = 1\n"
		"index = 1.375\n"
		"iattack = .025\n"
		"irelease = .125\n"
		"isustain = p3  - (iattack + irelease)\n"
		"if isustain > 0 goto longenvelope\n"
		"isustain = 0.03\n"
		"p3 = iattack + isustain + irelease\n"
		"longenvelope:\n"
		"ifrequency = cpsoct(p4)\n"
		"icarrier =  .998\n"
		"icarrierb =  1.002\n"
		"; Normalize to 80 dB = ampdb(80).\n"
		"iamplitude = ampdb(p5) * 15848.926 / 12729.0\n"
		"ileftpan = (0.5 - p6) / 2.0\n"
		"irightpan = (0.5 + p6) / 2.0\n"
		"\n"
		"; KONTROL\n"
		"kindenv expseg .00001, iattack, 1, isustain, .1, irelease, .00001\n"
		"kindex = kindenv * index * ifmamplitude\n"
		"\n"
		"; AUDIO\n"
		"aouta foscili iamplitude, ifrequency, icarrier, imodulator, kindex, iwavetable\n"
		"aoutb foscili iamplitude, ifrequency, icarrierb, imodulator, kindex, iwavetable\n"
		"afmout = (aouta + aoutb) * kindenv * 2.556\n"
		"outs ileftpan * afmout, irightpan * afmout\n"
		"endin\n";
	//	Try to read c from the command line, otherwise use a default.
	if(argc > 1)
	{
		c = atof(argv[1]);
	}
	else
	{
		c = .91954;
	}
	//	Try to read n from the command line, otherwise use a default.
	if(argc > 2)
	{
		n = atoi(argv[2]);
	}
	else
	{
		n = 100;
	}
	//  Create a score file.
	file = fopen("test.sco", "w+");
	//  Initial value of y.
		y = .5;
	//  Write the initial state of the system as a Csound comment.
	fprintf(file, "; Hello Csound!\n; c = %g\n; y = %g\n; c = %d\n", c, y, n);
	//  GENERATE THE SCORE
	//  Write the function table for the instrument.
	fprintf(file, "f 1 0 16384 10 1 ; High-fidelity sine wave.\n");
	//  Iterate to write the notes.
	for(i = 0; i < n; ++i)
	{
		////////////////////////////////////////////////////////////////////
		//  GENERATION
		y1 = y * c * 4 * (1.0 - y);
		//  MAPPING
		start = i * pulse;
		octave = bass + y1 * range;
		//  Round off to 12 tone equal temperament.
		octave = ((int)(octave * 12.0 + .5)) / 12.0;
		//  RENDERING
		//  Write a note into the Csound score.
		fprintf(file, "i %0.9g %0.9g %0.9g %0.9g %0.9g %0.9g\n", instrument, start, length, octave, decibels, pan);
		//  Iterate.
		y = y1;
		////////////////////////////////////////////////////////////////////
	}
	fclose(file);
	//  RENDER THE SOUNDFILE
	//  Write the orchestra file.
	file = fopen("test.orc", "w+");
	fprintf(file, orchestra);
	fclose(file);
	//  Render the generated files using Csound.
	system("winsound -RWso LogMuse.wav test.orc test.sco");
	//  PLAY THE SOUNDFILE
	system("MPLAYER LogMuse.wav");
	return 0;
}
