package GoginsChapters.ScoreGenerators.LogMuse;
import GoginsChapters.ScoreManager.*;
//  S I L E N C E
//  A system for making music on computers by means of software alone.
//  Copyright (C) 1997 by Michael Gogins. All rights reserved.
import java.io.*;
import java.awt.*;
import java.applet.*;
//  A simple logistic equation score generator.
public class LogMuse extends Applet
{
    boolean standAlone;
	public String argumentValues[];
	ProcessConsole processConsole = new ProcessConsole();
    //  All Java standalone programs must have
    //  a static main() function.
    public static void main(String argv[])
    {
        LogMuse logMuse = new LogMuse();
        logMuse.standAlone = true;
        logMuse.argumentValues = argv;
        Frame frame = new Frame();
        frame.add(logMuse);
        frame.show();
        logMuse.init();
        frame.resize(logMuse.size().width + frame.insets().left * 2, logMuse.size().height + frame.insets().top);
        logMuse.move(frame.insets().left, frame.insets().top);
        logMuse.start();
    }
    public LogMuse()
    {
        standAlone = false;
    }
    public void generate()
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
		FileOutputStream fileOutputStream = null;
		PrintStream printStream = null;
		//  You can paste a Csound instrument definition right into BASIC code like this.
		String orchestra =
			"sr =    44100\n"
			+ "kr =    44100\n"
			+ "ksmps =     1\n"
			+ "nchnls =    2\n"
			+ "\n"
			+ "; Frequency modulation instrument.\n"
			+ "instr 1\n"
			+ "; LOGGING\n"
			+ "; p1 = Instrument\n"
			+ "; p2 = Start\n"
			+ "; p3 = Length\n"
			+ "; p4 = Octave\n"
			+ "; p5 = Decibels\n"
			+ "; p6 = Pan\n"
			+ "print p2, p3, p4, p5, p6\n"
			+ "\n"
			+ "; INITIALIZATION\n"
			+ "iwavetable = 1\n"
			+ "imodulator = .5\n"
			+ "ifmamplitude = 1\n"
			+ "index = 1.375\n"
			+ "iattack = .025\n"
			+ "irelease = .125\n"
			+ "isustain = p3  - (iattack + irelease)\n"
			+ "if isustain > 0 goto longenvelope\n"
			+ "isustain = 0.03\n"
			+ "p3 = iattack + isustain + irelease\n"
			+ "longenvelope:\n"
			+ "ifrequency = cpsoct(p4)\n"
			+ "icarrier =  .998\n"
			+ "icarrierb =  1.002\n"
			+ "; Normalize to 80 dB = ampdb(80).\n"
			+ "iamplitude = ampdb(p5) * 15848.926 / 12729.0\n"
			+ "ileftpan = (0.5 - p6) / 2.0\n"
			+ "irightpan = (0.5 + p6) / 2.0\n"
			+ "\n"
			+ "; KONTROL\n"
			+ "kindenv expseg .00001, iattack, 1, isustain, .1, irelease, .00001\n"
			+ "kindex = kindenv * index * ifmamplitude\n"
			+ "\n"
			+ "; AUDIO\n"
			+ "aouta foscili iamplitude, ifrequency, icarrier, imodulator, kindex, iwavetable\n"
			+ "aoutb foscili iamplitude, ifrequency, icarrierb, imodulator, kindex, iwavetable\n"
			+ "afmout = (aouta + aoutb) * kindenv * 2.556\n"
			+ "outs ileftpan * afmout, irightpan * afmout\n"
			+ "endin\n";
		//	Try to read c from the command line, otherwise use a default.
		try
		{
			Double buffer = new Double(argumentValues[1]);
			c = buffer.doubleValue();
		}
		catch(ArrayIndexOutOfBoundsException e)
		{
			c = .98473;
		}
		catch(NullPointerException e)
		{
			c = .98473;
		}
		//	Try to read n from the command line, otherwise use a default.
		try
		{
			Integer buffer = new Integer(argumentValues[2]);
			n = buffer.intValue();
		}
		catch(ArrayIndexOutOfBoundsException e)
		{
			n = 100;
		}
		catch(NullPointerException e)
		{
			n = 100;
		}
		//  Create a score file.
		try
		{
			fileOutputStream = new FileOutputStream("test.sco");
			printStream = new PrintStream(fileOutputStream);
			//  Initial value of y.
			y = .5;
			//  Write the initial state of the system as a Csound comment.
			printStream.println("; Hello Csound!\n; c = " + c + "\n; y = " + y + "\n; n = " + n);
			//  GENERATE THE SCORE
			//  Write the function table for the instrument.
			printStream.println("f 1 0 16384 10 1 ; High-fidelity sine wave.");
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
				printStream.println("i " + instrument + " " + start + " " + length + " " + octave + " " + decibels + " " + pan);
				//  Iterate.
				y = y1;
				////////////////////////////////////////////////////////////////////
			}
			//  RENDER THE SOUNDFILE
			//  Write the orchestra file.
			fileOutputStream = new FileOutputStream("test.orc");
			printStream = new PrintStream(fileOutputStream);
			printStream.println(orchestra);
			printStream.close();
			//  Render the generated files using Csound.
			processConsole.execWait("winsound -WsRo LogMuse.wav test.orc test.sco");
			//  PLAY THE SOUNDFILE
			processConsole.exec("MPLAYER LogMuse.wav");
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
    }
	public void init()
	{
		super.init();
		//{{INIT_CONTROLS
		setLayout(null);
		addNotify();
		resize(302,102);
		setFont(new Font("TimesRoman", Font.BOLD, 12));
		setBackground(new Color(12632256));
		buttonGenerate = new java.awt.Button("Generate");
		buttonGenerate.reshape(12,48,276,36);
		buttonGenerate.setFont(new Font("TimesRoman", Font.BOLD, 16));
		add(buttonGenerate);
		labelScoreGenerator = new java.awt.Label("Logistic Equation Score Generator version 1");
		labelScoreGenerator.reshape(0,12,300,30);
		labelScoreGenerator.setFont(new Font("TimesRoman", Font.BOLD, 14));
		add(labelScoreGenerator);
		//}}
	}
	public boolean handleEvent(Event event)
	{
		if (event.target == buttonGenerate && event.id == Event.ACTION_EVENT) 
		{
			generate();
			return true;
		}
		return super.handleEvent(event);
	}
	//{{DECLARE_CONTROLS
	java.awt.Button buttonGenerate;
	java.awt.Label labelScoreGenerator;
	//}}
}
