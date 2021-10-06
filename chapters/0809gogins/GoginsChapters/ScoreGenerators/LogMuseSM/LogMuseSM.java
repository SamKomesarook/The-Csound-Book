package GoginsChapters.ScoreGenerators.LogMuseSM;
import GoginsChapters.ScoreManager.*;
//  S I L E N C E
//  A system for making music on computers by means of software alone.
//  Copyright (C) 1997 by Michael Gogins. All rights reserved.
import java.io.*;
import java.awt.*;
import java.applet.*;
//  Import the ScoreManager package.
//  A simple logistic equation score generator.
public class LogMuseSM extends Applet
{
    //  Reference to command-line arguments.
    String argumentValues[];
    //  Reference to the ScoreManager.
    public ScoreManager scoreManager;
    //  All Java standalone programs must have
    //  a static main() function.
    public static void main(String argv[])
    {
        LogMuseSM logMuse = new LogMuseSM();
        logMuse.argumentValues = argv;
        Frame frame = new Frame();
        frame.add(logMuse);
        frame.show();
        logMuse.init();
        frame.resize(logMuse.size().width + frame.insets().left * 2, logMuse.size().height + frame.insets().top);
        logMuse.move(frame.insets().left, frame.insets().top);
        logMuse.start();
    }
    public LogMuseSM()
    {
        scoreManager = new ScoreManager();
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
			n = 1000;
		}
		catch(NullPointerException e)
		{
			n = 1000;
		}
		//  Create a score file.
		//  Initial value of y.
		y = .5;
		//  GENERATE THE SCORE
		//  Delete any existing notes.
		scoreManager.notesDelete();
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
			scoreManager.noteAdd(instrument, start, length, octave, decibels, pan);
			//  Iterate.
			y = y1;
			////////////////////////////////////////////////////////////////////
		}
		//  RENDER THE SOUNDFILE
		//  Render the generated files using ScoreManager.
		scoreManager.openWindow();
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
		labelScoreGenerator = new java.awt.Label("Logistic Equation Score Generator version 2");
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
