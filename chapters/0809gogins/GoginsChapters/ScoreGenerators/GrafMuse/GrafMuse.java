package GoginsChapters.ScoreGenerators.GrafMuse;
import GoginsChapters.ScoreManager.*;
import java.io.*;
import java.applet.*;
import java.awt.*;
import java.awt.image.*;

public class GrafMuse extends Applet
{
	void buttonExit_Clicked(Event event) 
	{
		//{{CONNECTION
		System.exit(0);
		//}}
	}
	void buttonScore_Clicked(Event event) 
	{
    	//{{CONNECTION
		scoreManager.openWindow();
		//}}
	}
	void buttonRenderScore_Clicked(Event event) 
	{
		//{{CONNECTION
		dialogScore = new DialogScore(this);
		dialogScore.show();
		//}}
	}
	void buttonImportImage_Clicked(Event event) 
	{
		//{{CONNECTION
		FileDialog fileDialog = new FileDialog(frame, "Import image", FileDialog.LOAD);
		fileDialog.setFile("*.gif");
		fileDialog.show();
		if(fileDialog.getFile() == null)
		{
			return;
		}
		String pathname = fileDialog.getDirectory() + fileDialog.getFile();
		Toolkit toolkit = getToolkit();
		image = toolkit.getImage(pathname);
		repaint();
		//}}
	}
	void buttonImportOrchestra_Clicked(Event event)
	{
		//{{CONNECTION
		try
		{
			FileDialog fileDialog = new FileDialog(frame, "Import orchestra template", FileDialog.LOAD);
			fileDialog.setFile("*.osc");
			fileDialog.show();
			String filename = fileDialog.getFile();
			if(filename == null)
			{
				return;
			}
			filename = fileDialog.getDirectory() + File.separator + filename;
			FileInputStream fileInputStream = new FileInputStream(filename);
			DataInputStream dataInputStream = new DataInputStream(fileInputStream);
			scoreManager.read(dataInputStream);
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
		//}}
	}
	void buttonSaveAs_Clicked(Event event) 
	{
		//{{CONNECTION
		try
		{
			FileDialog fileDialog = new FileDialog(frame, "Save", FileDialog.SAVE);
			fileDialog.setFile("*.pim");
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
			scoreManager.filenameSet(pathname + ".scr");
			pathname = pathname + ".pim";
			FileOutputStream fileOutputStream = new FileOutputStream(pathname);
			PrintStream printStream = new PrintStream(fileOutputStream);
			write(printStream);
			printStream.close();
			fileOutputStream.close();
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
		//}}
	}
	void buttonSave_Clicked(Event event) 
	{
		//{{CONNECTION
		try
		{
			FileOutputStream fileOutputStream = new FileOutputStream(filename);
			PrintStream printStream = new PrintStream(fileOutputStream);
			write(printStream);
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
			FileDialog fileDialog = new FileDialog(frame, "Open", FileDialog.LOAD);
			fileDialog.setFile("*.pim");
			fileDialog.show();
			String pathname = fileDialog.getDirectory() + fileDialog.getFile();
			int i = pathname.indexOf(".");
			if(i != -1)
			{
				pathname = pathname.substring(0, i);
			}
			scoreManager.filenameSet(pathname + ".osc");
			filename = pathname + ".pim";
			FileInputStream fileInputStream = new FileInputStream(filename);
			DataInputStream dataInputStream = new DataInputStream(fileInputStream);
			initialize();
			scoreManager.initialize();
			read(dataInputStream);
			scoreManager.filenameSet(filename);
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
		//}}
	}
	Frame frame;
    public boolean standAlone;
	//	MAP TO MUSIC:
	int voiceCount;
	int instrumentCount;
	double durationSeconds;
	double divisionsPerOctave;
	//	RENDERING:
	String filename = null;
	Image image = null;
	PixelGrabber pixelGrabber = null;
	int[] pixels = null;
	int pixelsWide;
	int pixelsHigh;
	ScoreManager scoreManager = null;
	Process process = null;
	//	GUI:
	DialogScore dialogScore;
	//  All standalone Java applications must have one of these.
	public static void main(String args[])
	{
		GrafMuse grafMuse = new GrafMuse();
		grafMuse.standAlone = true;
		grafMuse.resize(640, 480);
		grafMuse.frame = new Frame();
		grafMuse.frame.add(grafMuse);
		grafMuse.init();
		grafMuse.start();
		grafMuse.frame.show();
	}
	public void init()
	{
		if(!standAlone)
		{
    	    addNotify();
		}
		else
		{
		    frame = (Frame) getParent();
		}
		//{{INIT_CONTROLS
		setLayout(null);
		setSize(640,480);
		setBackground(new Color(-12582848));
		buttonOpen = new java.awt.Button();
		buttonOpen.setLabel("Open...");
		buttonOpen.setBounds(12,36,144,24);
		buttonOpen.setFont(new Font("TimesRoman", Font.BOLD, 14));
		add(buttonOpen);
		buttonSave = new java.awt.Button();
		buttonSave.setLabel("Save");
		buttonSave.setBounds(12,60,144,24);
		buttonSave.setFont(new Font("TimesRoman", Font.BOLD, 14));
		add(buttonSave);
		buttonSaveAs = new java.awt.Button();
		buttonSaveAs.setLabel("Save as...");
		buttonSaveAs.setBounds(12,84,144,24);
		buttonSaveAs.setFont(new Font("TimesRoman", Font.BOLD, 14));
		add(buttonSaveAs);
		buttonExit = new java.awt.Button();
		buttonExit.setLabel("Exit");
		buttonExit.setBounds(12,228,144,24);
		buttonExit.setFont(new Font("TimesRoman", Font.BOLD, 14));
		add(buttonExit);
		buttonScore = new java.awt.Button();
		buttonScore.setLabel("Score...");
		buttonScore.setBounds(12,204,144,24);
		buttonScore.setFont(new Font("TimesRoman", Font.BOLD, 14));
		add(buttonScore);
		buttonRenderScore = new java.awt.Button();
		buttonRenderScore.setLabel("Render as score...");
		buttonRenderScore.setBounds(12,180,144,24);
		buttonRenderScore.setFont(new Font("TimesRoman", Font.BOLD, 14));
		add(buttonRenderScore);
		buttonImportImage = new java.awt.Button();
		buttonImportImage.setLabel("Import image...");
		buttonImportImage.setBounds(12,144,144,24);
		buttonImportImage.setFont(new Font("TimesRoman", Font.BOLD, 14));
		add(buttonImportImage);
		buttonImportOrchestra = new java.awt.Button();
		buttonImportOrchestra.setLabel("Import orchestra...");
		buttonImportOrchestra.setBounds(12,120,144,24);
		buttonImportOrchestra.setFont(new Font("TimesRoman", Font.BOLD, 14));
		add(buttonImportOrchestra);
		//}}
		if(standAlone)
		{
		    frame.resize(size());
		    frame.setResizable(false);
		}
    }
	public GrafMuse()
	{
	    standAlone = false;
		setBackground(Color.black);
		scoreManager = new ScoreManager();
		initialize();
	}
	void initialize()
	{
		voiceCount = 16;
		instrumentCount = 4;
		durationSeconds = 240;
		divisionsPerOctave = 12;
	}
	public void paint(Graphics g)
	{
		if(image == null)
		{
			return;
		}
		g.drawImage(image, 0, 0, this);
	}
	public void pixelsGrab()
	{
		int x = 0;
		int y = 0;
		pixelsWide = image.getWidth(null);
		pixelsHigh = image.getHeight(null);
		pixels = new int[pixelsWide * pixelsHigh];
		int offset = 0;
		pixelGrabber = new PixelGrabber(image, x, y, pixelsWide, pixelsHigh, pixels, offset, pixelsWide);
		try
		{
			pixelGrabber.grabPixels();
		}
		catch(InterruptedException e)
		{
			System.out.println(e.getMessage());
		}
	}
	public final int pixelGet(int x, int y)
	{
		return pixels[y * pixelsWide + x];
	}
	public void imageToSco()
	{
		if(image == null)
		{
			return;
		}
		pixelsGrab();
		int notesCreatedCount;
		double currentTimeSeconds;
		int columnSubscript;
		int columnCount;
		double secondsPerPixel = durationSeconds / ((double) pixelsWide);
		int newVoicesSubscript;
		int oldVoicesSubscript;
		int rowSubscript;
		int rowCount;
		float hsb[] = new float[3];
		double temperamentRound = 0.5;
		Note swapNote = null;
		boolean starting;
		boolean ending;
		Color currentColor = null;
		double instrument;
		double octave;
		double decibels;
		int columnsTranslatedCount = 0;
		//	Translate lines of consecutively nonblack pixels into notes.
		//	Proceed column by column.
		Note[] oldVoices = new Note[voiceCount + 1];
		Note[] newVoices = new Note[voiceCount + 1];
		for(notesCreatedCount = 0;
		notesCreatedCount < voiceCount + 1;
		notesCreatedCount++)
		{
			oldVoices[notesCreatedCount] = new Note();
			newVoices[notesCreatedCount] = new Note();
		}
		scoreManager.notesDelete();
		for(notesCreatedCount = 0,
		currentTimeSeconds = 0,
		columnSubscript = 0,
		columnCount = pixelsWide;
		columnSubscript < columnCount;
		++columnSubscript)
		{
			currentTimeSeconds = ((double) columnSubscript) * secondsPerPixel;
			//	Copy newly sounding voices into the previously sounding voices array.
			for(newVoicesSubscript = 0;
			newVoicesSubscript <= voiceCount;
			++newVoicesSubscript)
			{
				oldVoices[newVoicesSubscript] = newVoices[newVoicesSubscript];
				newVoices[newVoicesSubscript] = new Note();
			}
			//	Examine the current column of the screen shot
			//	and create a potential note at every row.
			for(rowSubscript = 0,
			rowCount = pixelsHigh;
			rowSubscript < rowCount;
			++rowSubscript)
			{
				currentColor = new Color(pixelGet(columnSubscript, rowSubscript));
				Color.RGBtoHSB(currentColor.getRed(), currentColor.getGreen(), currentColor.getBlue(), hsb);
				instrument = (int) (1.0 + (hsb[0] * instrumentCount));
				octave = 12.0 - ((double) rowSubscript) / ((double)(rowCount - 1)) * 6.0;
				if(divisionsPerOctave != 0.0)
				{
					octave = (double)((int)((octave + temperamentRound) * divisionsPerOctave) / divisionsPerOctave);
				}
				decibels = hsb[2] * 78.0;
				newVoices[0].instrumentSet(instrument);
				newVoices[0].startSet(currentTimeSeconds);
				newVoices[0].octaveSet(octave);
				newVoices[0].decibelsSet(decibels);
				//	If the potential note is louder than any newly sounding voice,
				//	bubble it up into the newly sounding voice array.
				for(newVoicesSubscript = 1;
				newVoicesSubscript <= voiceCount;
				newVoicesSubscript++)
				{
					if(newVoices[newVoicesSubscript - 1].decibelsGet() > newVoices[newVoicesSubscript].decibelsGet())
					{
						swapNote = newVoices[newVoicesSubscript - 1];
						newVoices[newVoicesSubscript - 1] = newVoices[newVoicesSubscript];
						newVoices[newVoicesSubscript] = swapNote;
					}
					else
					{
						break;
					}
				}
			}
			//	Compare the newly sounding voices with the previously sounding voices.
			//	If a note is newly sounding but not previously sounding, it is starting.
			for(newVoicesSubscript = 1;
			newVoicesSubscript <= voiceCount;
			++newVoicesSubscript)
			{
				//	If a newly sounding note is not starting,
				//	it is continuing a previously sounding note.
				for(starting = true,
				oldVoicesSubscript = 1;
				oldVoicesSubscript <= voiceCount;
				oldVoicesSubscript++)
				{
					if(newVoices[newVoicesSubscript].octaveGet() == oldVoices[oldVoicesSubscript].octaveGet() &&
						newVoices[newVoicesSubscript].instrumentGet() == oldVoices[oldVoicesSubscript].instrumentGet())
					{
					    starting = false;
					    break;
					}
				}
				if(starting)
				{
				    newVoices[newVoicesSubscript].startSet(currentTimeSeconds);
				}
				else
				{
				    newVoices[newVoicesSubscript] = oldVoices[oldVoicesSubscript];
				}
			}
			//	If a note is previously sounding but not newly sounding, it is ending.
			for(oldVoicesSubscript = 1;
			oldVoicesSubscript <= voiceCount;
			++oldVoicesSubscript)
			{
				for(ending = true,
				newVoicesSubscript = 1;
				newVoicesSubscript <= voiceCount;
				++newVoicesSubscript)
				{
					if(oldVoices[oldVoicesSubscript].octaveGet() == newVoices[newVoicesSubscript].octaveGet() &&
						oldVoices[oldVoicesSubscript].instrumentGet() == newVoices[newVoicesSubscript].instrumentGet())
					{
						ending = false;
					}
				}
				//	If a note is ending, add it to the score.
				if(ending)
				{
				    if(oldVoices[oldVoicesSubscript].decibelsGet() > 0.0)
				    {
				        oldVoices[oldVoicesSubscript].lengthSet(currentTimeSeconds - oldVoices[oldVoicesSubscript].startGet());
				        scoreManager.noteAdd(oldVoices[oldVoicesSubscript]);
				        ++notesCreatedCount;
				    }
				}
			}
			columnsTranslatedCount = columnSubscript + 1;
			if(dialogScore != null)
			{
				dialogScore.iddDialog.IDC_EDIT_COLUMNSRENDERED.setText(String.valueOf(columnsTranslatedCount));
			}
		}
	}
	void read(DataInputStream dataInputStream) throws IOException
	{
		String buffer = null;
		Double d = null;
		int i;
		while((buffer = dataInputStream.readLine()) != null)
		{
			if(buffer.equals("<GrafMuse>"))
			{
				while((buffer = dataInputStream.readLine()) != null)
				{
					if(buffer.startsWith("voiceCount"))
					{
						i = buffer.indexOf("=");
						if(i != -1)
						{
							d = Double.valueOf(buffer.substring(i + 1));
							voiceCount = d.intValue();
						}
					}
					else if(buffer.startsWith("instrumentCount"))
					{
						i = buffer.indexOf("=");
						if(i != -1)
						{
							d = Double.valueOf(buffer.substring(i + 1));
							instrumentCount = d.intValue();
						}
					}
					else if(buffer.startsWith("durationSeconds"))
					{
						i = buffer.indexOf("=");
						if(i != -1)
						{
							d = Double.valueOf(buffer.substring(i + 1));
							durationSeconds= d.doubleValue();
						}
					}
					else if(buffer.startsWith("divisionsPerOctave"))
					{
						i = buffer.indexOf("=");
						if(i != -1)
						{
							d = Double.valueOf(buffer.substring(i + 1));
							divisionsPerOctave = d.doubleValue();
						}
					}
					else if(buffer.startsWith("<CsImage>"))
					{

					}
					else if(buffer.startsWith("<CsScoreManager>"))
					{
						scoreManager.read(dataInputStream);
					}
					else if(buffer.startsWith("</GrafMuse>"))
					{
						return;
					}
				}
			}
		}
	}
	void write(PrintStream printStream) throws IOException
	{
		printStream.println("<GrafMuse>");
		printStream.println("voiceCount = " + voiceCount);
		printStream.println("instrumentCount = " + instrumentCount);
		printStream.println("durationSeconds = " + durationSeconds);
		printStream.println("divisionsPerOctave = " + divisionsPerOctave);
		scoreManager.write(printStream);
		printStream.println("</GrafMuse>");
	}
	public boolean handleEvent(Event evt)
	{
		if (evt.target == buttonSave && evt.id == Event.ACTION_EVENT) 
		{
			buttonSave_Clicked(evt);
			return true;
		} 
		else if (evt.target == buttonSaveAs && evt.id == Event.ACTION_EVENT) 
		{
			buttonSaveAs_Clicked(evt);
			return true;
		} 
		else if (evt.target == buttonImportOrchestra && evt.id == Event.ACTION_EVENT) 
		{
			buttonImportOrchestra_Clicked(evt);
			return true;
		} 
		else if (evt.target == buttonImportImage && evt.id == Event.ACTION_EVENT) 
		{
			buttonImportImage_Clicked(evt);
			return true;
		} 
		else if (evt.target == buttonRenderScore && evt.id == Event.ACTION_EVENT)
		{
			buttonRenderScore_Clicked(evt);
			return true;
		} 
		else if (evt.target == buttonScore && evt.id == Event.ACTION_EVENT)
		{
			buttonScore_Clicked(evt);
			return true;
		} 
		else if (evt.target == buttonExit && evt.id == Event.ACTION_EVENT) 
		{
			buttonExit_Clicked(evt);
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
	java.awt.Button buttonOpen;
	java.awt.Button buttonSave;
	java.awt.Button buttonSaveAs;
	java.awt.Button buttonExit;
	java.awt.Button buttonScore;
	java.awt.Button buttonRenderScore;
	java.awt.Button buttonImportImage;
	java.awt.Button buttonImportOrchestra;
	//}}
}

