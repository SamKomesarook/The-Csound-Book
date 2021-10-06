package GoginsChapters.ScoreGenerators.LogMuseDialog;
//  Import the ScoreManager Csound front end.
import GoginsChapters.ScoreManager.*;
//  S I L E N C E
//  A system for making music on computers by means of software alone.
//  Copyright (C) 1997 by Michael Gogins. All rights reserved.
import java.io.*;
import java.awt.*;
import java.util.*;
import java.applet.*;
//  Simple logistic equation score generator with parameter dialog.
public class LogMuseDialog extends Applet
{
    //  Running as standalone application rather than applet?
    public boolean standAlone;
    //  Reference for command-line arguments.
    String argumentValues[];
	//  Score manager object.
    public ScoreManager scoreManager;
	//  Variables for the generator.
	double c;
	double y;
	double y1;
	int i;
	int n;
	//  Variables for music.
	double instrument;
	double start;
	double length;
	double octave;
	double decibels;
	double pan;
	//  Mapping coefficients.
	double pulse;
	double bass;
	double range;
	//	All Java applications must have a static main() function.
    public static void main(String argv[])
    {
    	//  Create an instance of the applet class.
        LogMuseDialog logMuseDialog = new LogMuseDialog();
        logMuseDialog.standAlone = true;
        //  An applet running standalone must have a frame.
        Frame frame = new Frame();
        frame.add(logMuseDialog);
        logMuseDialog.init();
        logMuseDialog.start();
        frame.resize(logMuseDialog.size());
        frame.show();
    }
    public LogMuseDialog()
    {
        standAlone = false;
        //  Create the Score Manager object.
		scoreManager = new ScoreManager();
    }
	public void init()
	{
		//  Open the user interface.
		super.init();
		//  Variables for music.
		//  The dimensions that are not generated have default values.
		instrument = 1;
		start = 0;
		length = 2;
		octave = 0;
		decibels = 70;
		pan = 0;
		//  Mapping coefficients.
		pulse = .25;
		bass = 6;
		range = 4;
		//	Try to read c from the command line, otherwise use a default.
		try
		{
			Double buffer = new Double(argumentValues[0]);
			c = buffer.doubleValue();
		}
		catch(NullPointerException e)
		{
			c = .998;
		}
		catch(ArrayIndexOutOfBoundsException e)
		{
			c = .998;
		}
		//	Try to read n from the command line, otherwise use a default.
		try
		{
			Integer buffer = new Integer(argumentValues[1]);
			n = buffer.intValue();
		}
		catch(NullPointerException e)
		{
			n = 1000;
		}
		catch(ArrayIndexOutOfBoundsException e)
		{
			n = 1000;
		}
		if(!standAlone)
		{
		    addNotify();
		}
		//{{INIT_CONTROLS
		setLayout(null);
		resize(400,201);
		setFont(new Font("TimesRoman", Font.BOLD, 14));
		setBackground(new Color(12632256));
		labelApplet = new java.awt.Label("Logistic Equation Score Generator version 3",Label.CENTER);
		labelApplet.reshape(0,36,384,19);
		add(labelApplet);
		labelIterationCount = new java.awt.Label("Number of iterations");
		labelIterationCount.reshape(0,108,183,19);
		add(labelIterationCount);
		labelConstant = new java.awt.Label("Constant");
		labelConstant.reshape(0,72,183,19);
		add(labelConstant);
		buttonGenerate = new java.awt.Button("Generate");
		buttonGenerate.reshape(204,156,84,32);
		add(buttonGenerate);
		buttonScore = new java.awt.Button("Score");
		buttonScore.reshape(300,156,84,32);
		add(buttonScore);
		buttonSave = new java.awt.Button("Save");
		buttonSave.reshape(108,156,84,32);
		add(buttonSave);
		buttonLoad = new java.awt.Button("Load");
		buttonLoad.reshape(12,156,84,32);
		add(buttonLoad);
		textFieldIterationCount = new java.awt.TextField();
		textFieldIterationCount.reshape(204,108,180,24);
		add(textFieldIterationCount);
		textFieldConstant = new java.awt.TextField();
		textFieldConstant.reshape(204,72,180,24);
		add(textFieldConstant);
		//}}
		dataToDialog();
	}
	//{{DECLARE_CONTROLS
	java.awt.Label labelApplet;
	java.awt.Label labelIterationCount;
	java.awt.Label labelConstant;
	java.awt.Button buttonGenerate;
	java.awt.Button buttonScore;
	java.awt.Button buttonSave;
	java.awt.Button buttonLoad;
	java.awt.TextField textFieldIterationCount;
	java.awt.TextField textFieldConstant;
	//}}
    void dataToDialog()
    {
        textFieldConstant.setText(String.valueOf(c));
        textFieldIterationCount.setText(String.valueOf(n));
    }
    void dataFromDialog()
    {
        Double buffer = new Double(textFieldConstant.getText());
        c = buffer.doubleValue();
        buffer = new Double(textFieldIterationCount.getText());
        n = buffer.intValue();
    }
	void buttonGenerate_Clicked(Event event)
	{
    	//{{CONNECTION
		generate();
		//}}
	}
	void buttonScore_Clicked(Event event)
	{
    	//{{CONNECTION
		scoreManager.openWindow();
		//}}
	}
	void buttonSave_Clicked(Event event)
	{
    	//{{CONNECTION
		save();
		//}}
	}
	void buttonLoad_Clicked(Event event)
	{
    	//{{CONNECTION
		load();
		//}}
	}
	public boolean handleEvent(Event event)
	{
		if (event.target == buttonLoad && event.id == Event.ACTION_EVENT)
		{
			buttonLoad_Clicked(event);
			return true;
		}
		if (event.target == buttonSave && event.id == Event.ACTION_EVENT)
		{
			buttonSave_Clicked(event);
			return true;
		}
		if (event.target == buttonGenerate && event.id == Event.ACTION_EVENT)
		{
			buttonGenerate_Clicked(event);
			return true;
		}
		if (event.target == buttonScore && event.id == Event.ACTION_EVENT)
		{
			buttonScore_Clicked(event);
			return true;
		}
		return super.handleEvent(event);
    }
    //  Event handlers:
    //  Generate a score.
	public void generate()
	{
	    dataFromDialog();
	    //  Erase existing notes.
	    scoreManager.notesDelete();
		//  Initial value of y.
		y = .5;
		//  GENERATE THE SCORE
		//  Iterate to generate the notes.
		for(i = 0; i < n; ++i)
		{
			////////////////////////////////////////////////////////////////////
			//  GENERATION
			y1 = y * c * 4 * (1.0 - y);
			//  MAPPING
			start = i * pulse;
			octave = bass + y1 * range;
			//  RENDERING
			//  Write the note into the ScoreManager.
			scoreManager.noteAdd(instrument, start, length, octave, decibels, pan);
			//  Iterate.
			y = y1;
			////////////////////////////////////////////////////////////////////
		}
		//  RENDERING
		//  Graphical user interface for arrangement, rescaling, actual rendering, etc.
		scoreManager.openWindow();
    }
    public void load()
    {
		try
		{
		    Frame frame = (Frame)getParent();
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
				if(buffer.startsWith("<CsLogMuse>"))
				{
					for(;;)
					{
						buffer = dataInputStream.readLine();
						StringTokenizer stringTokenizer = new StringTokenizer(buffer);
						String name = stringTokenizer.nextToken();
						String value = null;
						if(name.startsWith("c"))
						{
							c = Double.valueOf(stringTokenizer.nextToken()).doubleValue();
						}
						else if(name.startsWith("n"))
						{
							n = Double.valueOf(stringTokenizer.nextToken()).intValue();
						}
						else if(name.startsWith("<CsScoreManager>"))
						{
							scoreManager.read(dataInputStream);
						}
						else if(name.startsWith("</CsLogMuse>"))
						{
							dataInputStream.close();
							fileInputStream.close();
							dataToDialog();
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
    }
    public void save()
    {
		try
		{
		    //  Get data from user interface.
		    dataToDialog();
		    //  Get file to save to.
		    Frame frame = (Frame)getParent();
			FileDialog fileDialog = new FileDialog(frame, "Save", FileDialog.SAVE);
			fileDialog.setFile("*.lm");
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
			pathname = pathname + ".lm";
			scoreManager.filenameSet(pathname);
			//  Typical pattern for tag-delimited text storage.
			FileOutputStream fileOutputStream = new FileOutputStream(pathname);
			PrintStream printStream = new PrintStream(fileOutputStream);
			printStream.println("<CsLogMuse>");
			printStream.println("c " + c);
			printStream.println("n " + n);
			scoreManager.write(printStream);
			printStream.println("</CsLogMuse>");
			printStream.close();
			fileOutputStream.close();
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
    }
}
