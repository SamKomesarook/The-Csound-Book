package GoginsChapters.ScoreManager;
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1997 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	A platform-independent graphical user interface for Csound.
import java.io.*;
import java.awt.*;

class DialogInstrumentTest extends Dialog
{
	ScoreManager scoreManager;
	IDD_DIALOG_INSTRUMENT_TEST iddDialog;
	String instrumentName;

	DialogInstrumentTest(ScoreManagerFrame frame, String name)
	{
		super(frame, name, true);
		instrumentName = name;
		scoreManager = frame.scoreManager;
		setBackground(Color.lightGray);
		iddDialog = new IDD_DIALOG_INSTRUMENT_TEST(this);
		iddDialog.CreateControls();
		iddDialog.IDC_EDIT_INSTRUMENT_TEST_SCORE.setText(scoreManager.instrumentTestScore);
		move(50, 50);
	}

	public boolean handleEvent(Event event)
	{
		switch(event.id)
		{
			case Event.WINDOW_DESTROY:
				hide();
				return true;
			case Event.ACTION_EVENT:
				if(event.target instanceof Button)
				{
					String string = ((Button)event.target).getLabel();
					if(string.equals("OK"))
					{
						scoreManager.instrumentTestScore = iddDialog.IDC_EDIT_INSTRUMENT_TEST_SCORE.getText();
						hide();
						return true;
					}
					else if(string.equals("Cancel"))
					{
						hide();
						return true;
					}
					else if(string.equals("Render"))
					{
						try
						{
							String instrument = scoreManager.instruments.getProperty(instrumentName);
							FileOutputStream fileOutputStream = new FileOutputStream("CSTest.orc");
							PrintStream printStream = new PrintStream(fileOutputStream);
							printStream.println("sr=44100\nkr=44100\nksmps=1\nnchnls=2\n\ninstr 1\n" + instrument + "\nendin\n");
							printStream.close();
							fileOutputStream = new FileOutputStream("CSTest.sco");
							printStream = new PrintStream(fileOutputStream);
							printStream.println(scoreManager.functions);
							printStream.println(scoreManager.instrumentTestScore);
							printStream.close();
							String commandLine = "CSOUND -RWso CSTest.wav CSTest.orc CSTest.sco";
							Runtime runtime = Runtime.getRuntime();
							Process csoundProcess = runtime.exec(commandLine);
						}
						catch(Exception e)
						{
							scoreManager.showStatus(e.getMessage());
						}
						return true;
					}
					else if(string.equals("Play"))
					{
						try
						{
							String commandLine = scoreManager.soundfileOptions.getProperty("SoundPlayer", "MPLAYER.EXE") + " " + "CSTest.wav";
							Runtime runtime = Runtime.getRuntime();
							Process process = runtime.exec(commandLine);
						}
						catch(Exception e)
						{
							scoreManager.showStatus(e.getMessage());
						}
						return true;
					}
				}
			}
		return super.handleEvent(event);
	}
}