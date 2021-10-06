package GoginsChapters.ScoreGenerators.LogMap;
import GoginsChapters.ScoreManager.*;
//  S I L E N C E
//  A system for making music on computers by means of software alone.
//  Copyright (C) 1997 by Michael Gogins. All rights reserved.
import java.util.*;
import java.io.*;
import java.applet.*;
import java.awt.*;
//  Generate scores based on maps of the logistic equation.
public class LogMap extends Applet
{
	void buttonScore_Clicked(Event event) 
	{
    	//{{CONNECTION
		scoreManager.openWindow();
		//}}
	}
	void buttonGenerate_Clicked(Event event) 
	{
    	//{{CONNECTION
		//	Transfer values from window controls to generator.
		dataFromForm();
		//	Generate a score.
		generate();
		//	Automatically display it.
		scoreManager.openWindow();
		//}}
	}
	void buttonSave_Clicked(Event event) 
	{
		//{{CONNECTION
		try
		{
		    Frame frame = (Frame) getParent();
			FileDialog fileDialog = new FileDialog(frame, "Save", FileDialog.SAVE);
			fileDialog.setFile("*.s02");
			fileDialog.show();
			if(fileDialog.getFile() == null)
			{
				return;
			}
			String pathname = fileDialog.getDirectory() + fileDialog.getFile();
			int i = pathname.indexOf(".");
			if(i != -1)
			{
				pathname = pathname.substring(0, i);
			}
			pathname = pathname + ".s02";
			scoreManager.filenameSet(pathname);
			FileOutputStream fileOutputStream = new FileOutputStream(pathname);
			PrintStream printStream = new PrintStream(fileOutputStream);
			printStream.println("<CsSample2>");
			printStream.println("cInitial " + cInitial);
			printStream.println("cFinal " + cFinal);
			printStream.println("cn " + cn);
			printStream.println("n " + n);
			scoreManager.write(printStream);
			printStream.println("</CsSample2>");
			printStream.close();
			fileOutputStream.close();
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
		//}}
	}
	void buttonOpen_Clicked(Event event) 
	{
		//{{CONNECTION
		try
		{
		    Frame frame = (Frame) getParent();
			FileDialog fileDialog = new FileDialog(frame, "Load", FileDialog.LOAD);
			fileDialog.show();
			String filename = fileDialog.getFile();
			if(filename == null)
			{
				return;
			}
			FileInputStream fileInputStream = new FileInputStream(filename);
			DataInputStream dataInputStream = new DataInputStream(fileInputStream);
			for(;;)
			{
				String buffer = dataInputStream.readLine();
				if(buffer.startsWith("<CsSample2>"))
				{
					for(;;)
					{
						buffer = dataInputStream.readLine();
						StringTokenizer stringTokenizer = new StringTokenizer(buffer);
						String name = stringTokenizer.nextToken();
						String value = null;
						if(name.startsWith("cInitial"))
						{
							cInitial = Double.valueOf(stringTokenizer.nextToken()).doubleValue();
						}
						else if(name.startsWith("cFinal"))
						{
							cFinal = Double.valueOf(stringTokenizer.nextToken()).doubleValue();
						}
						else if(name.startsWith("cn"))
						{
							cn = Double.valueOf(stringTokenizer.nextToken()).intValue();
						}
						else if(name.startsWith("n"))
						{
							n = Double.valueOf(stringTokenizer.nextToken()).intValue();
						}
						else if(name.startsWith("<CsScoreManager>"))
						{
							scoreManager.read(dataInputStream);
						}
						else if(name.startsWith("</CsSample2>"))
						{
							dataInputStream.close();
							fileInputStream.close();
							dataToForm();
							scoreManager.filenameSet(filename);
							return;
						}
					}
				}
			}
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
		//}}
	}
	public boolean standAlone;
	//	VARIABLES FOR GENERATOR:
	double cInitial;
	double cFinal;
	int cn = 10;
	int n = 100;
	//	VARIABLES FOR MUSIC:
	//	The dimensions that are not generated have default values.
	double instrument;
	double start;
	double length;
	double octave;
	double decibels;
	double pan;
	//	Variables for mapping:
	double pulse;
	double bass;
	double range;
	//	RENDERING:
	//	Declare a Csound score manager object as a member of this.
	ScoreManager scoreManager = null;
    //  Every standalone Java program must have one of these.	
	public static void main(String args[])
	{
	    LogMap logMap = new LogMap();
	    logMap.standAlone = true;
	    Frame frame = new Frame();
	    frame.add(logMap);
	    logMap.init();
	    logMap.start();
	    frame.resize(logMap.size());
	    frame.show();
	}
	public LogMap()
	{
		standAlone = false;
		setBackground(Color.lightGray);
		//	Can't be 0 or all notes are 0 pitch.
		cInitial = 0.66;
		cFinal = .9999;
		cn = 1000;
		n = 10;
		//	Dimensions that are not generated have default values.
		instrument = 1;
		length = .75;
		decibels = 70;
		pan = 0;
		pulse = .25;
		bass = 6.0;
		range = 4.0;
		//	Create a score manager and try to initialize it with
		//	a template containing an orchestra.
		scoreManager = new ScoreManager();
    }
    public void init()
    {
        super.init();
		if(!standAlone)
		{
		    addNotify();
		}
		//{{INIT_CONTROLS
		setLayout(null);
		resize(360,325);
		setFont(new Font("TimesRoman", Font.BOLD, 14));
		setBackground(new Color(12632256));
		labelApplet = new java.awt.Label("Logistic Map Score Generator",Label.CENTER);
		labelApplet.reshape(0,24,348,36);
		labelApplet.setFont(new Font("TimesRoman", Font.BOLD, 20));
		add(labelApplet);
		labelInitialC = new java.awt.Label("Initial value of constant");
		labelInitialC.reshape(0,72,210,24);
		add(labelInitialC);
		labelFinalC = new java.awt.Label("Final value of constant");
		labelFinalC.reshape(0,108,210,24);
		add(labelFinalC);
		buttonOpen = new java.awt.Button("Open");
		buttonOpen.reshape(12,228,120,36);
		add(buttonOpen);
		buttonSave = new java.awt.Button("Save");
		buttonSave.reshape(12,276,120,36);
		add(buttonSave);
		buttonGenerate = new java.awt.Button("Generate");
		buttonGenerate.reshape(228,228,120,36);
		add(buttonGenerate);
		buttonScore = new java.awt.Button("Score");
		buttonScore.reshape(228,276,120,36);
		add(buttonScore);
		textFieldInitialC = new java.awt.TextField();
		textFieldInitialC.setText(".66");
		textFieldInitialC.reshape(228,72,120,24);
		add(textFieldInitialC);
		textFieldFinalC = new java.awt.TextField();
		textFieldFinalC.setText("1");
		textFieldFinalC.reshape(228,108,120,24);
		add(textFieldFinalC);
		labelIntermediateValues = new java.awt.Label("Number of intermediate values");
		labelIntermediateValues.reshape(0,144,210,24);
		add(labelIntermediateValues);
		labelIterationsPerValue = new java.awt.Label("Number of iterations per value");
		labelIterationsPerValue.reshape(0,180,210,24);
		add(labelIterationsPerValue);
		textFieldIterations = new java.awt.TextField();
		textFieldIterations.setText("10");
		textFieldIterations.reshape(228,180,120,24);
		add(textFieldIterations);
		textFieldIntermediateValues = new java.awt.TextField();
		textFieldIntermediateValues.setText("1000");
		textFieldIntermediateValues.reshape(228,144,120,24);
		add(textFieldIntermediateValues);
		//}}
		//	Load the default parameters into the dialog controls.
		dataToForm();
    }
	void dataToForm()
	{
		textFieldInitialC.setText(String.valueOf(cInitial));
		textFieldFinalC.setText(String.valueOf(cFinal));
		textFieldIntermediateValues.setText(String.valueOf(cn));
		textFieldIterations.setText(String.valueOf(n));
	}
	void dataFromForm()
	{
		Double buffer = null;
		buffer = Double.valueOf(textFieldInitialC.getText());
		cInitial = buffer.doubleValue();
		buffer = Double.valueOf(textFieldFinalC.getText());
		cFinal = buffer.doubleValue();
		buffer = Double.valueOf(textFieldIntermediateValues.getText());
		cn = buffer.intValue();
		buffer = Double.valueOf(textFieldIterations.getText());
		n = buffer.intValue();
	}
	void generate()
	{
		//	Clear out the score.
		scoreManager.notesDelete();
		//	Generate a new score.
		double cIncrement = (cFinal - cInitial) / cn;
		double c = cInitial;
		double y1;
		for(int ci = 0; ci < cn; ci++)
		{
			//	Start each increment at the same value of y.
			double y = .5;
			//	Pre-iterate to find the attractor.
			for(int i = 0; i < 100; i++)
			{
				y1 = y * c * 4.0 * (1.0 - y);
				y = y1;
			}
			//	Make notes only from the attractor.
			for(int i = 0; i < n; i++)
			{
				////////////////////////////////////////////////////////////////
				//  GENERATE
				y1 = y * c * 4.0 * (1.0 - y);
				//  MAP TO MUSIC
				start = ((ci * n) + i) * pulse;
				octave = bass + y1 * range;
				//  RENDER THE SCORE
				//  Store a note in the score manager.
				scoreManager.noteAdd(instrument, start, length, octave, decibels, pan);
				//  Iterate n.
				y = y1;
				////////////////////////////////////////////////////////////////
			}
			//	Iterate c to explore chaos.
			c += cIncrement;
		}
	}
	public boolean handleEvent(Event evt)
	{
		if (evt.target == buttonSave && evt.id == Event.ACTION_EVENT) 
		{
			buttonSave_Clicked(evt);
			return true;
		} 
		else if (evt.target == buttonGenerate && evt.id == Event.ACTION_EVENT) 
		{
			buttonGenerate_Clicked(evt);
			return true;
		} 
		else if (evt.target == buttonScore && evt.id == Event.ACTION_EVENT) 
		{
			buttonScore_Clicked(evt);
			return true;
		} 
		else if (evt.target == buttonOpen && evt.id == Event.ACTION_EVENT) 
		{
			buttonOpen_Clicked(evt);
			return true;
		}
		return false;
	}
	//{{DECLARE_CONTROLS
	java.awt.Label labelApplet;
	java.awt.Label labelInitialC;
	java.awt.Label labelFinalC;
	java.awt.Button buttonOpen;
	java.awt.Button buttonSave;
	java.awt.Button buttonGenerate;
	java.awt.Button buttonScore;
	java.awt.TextField textFieldInitialC;
	java.awt.TextField textFieldFinalC;
	java.awt.Label labelIntermediateValues;
	java.awt.Label labelIterationsPerValue;
	java.awt.TextField textFieldIterations;
	java.awt.TextField textFieldIntermediateValues;
	//}}
}

