package GoginsChapters.ScoreGenerators.MinimalMuse;
import GoginsChapters.ScoreManager.*;
import java.util.*;
import java.io.*;
import java.awt.*;
import java.applet.*;
public class MinimalMuse extends java.applet.Applet
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
		getText();
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
			FileDialog fileDialog = new FileDialog(new Frame(), "Save", FileDialog.SAVE);
			fileDialog.setFile("*.s03");
			fileDialog.show();
			if(fileDialog.getFile() == null)
			{
				return;
			}
			getText();
			String pathname = fileDialog.getDirectory() + fileDialog.getFile();
			int i = pathname.indexOf(".");
			if(i != -1)
			{
				pathname = pathname.substring(0, i);
			}
			scoreManager.filenameSet(pathname + ".osc");
			pathname = pathname + ".s03";
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
	void buttonOpen_Clicked(Event event) 
	{
        //{{CONNECTION
		try
		{
			FileDialog fileDialog = new FileDialog(new Frame(), "Open", FileDialog.LOAD);
			fileDialog.show();
			String filename = fileDialog.getFile();
			if(filename == null)
			{
				return;
			}
			FileInputStream fileInputStream = new FileInputStream(filename);
			DataInputStream dataInputStream = new DataInputStream(fileInputStream);
			initialize();
			read(dataInputStream);
			setText();
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
		//}}
	}
	void buttonNew_Clicked(Event event) 
	{
    	//{{CONNECTION
		initialize();
		setText();
		//}}
	}
    boolean standAlone;
    String argumentValues[];
	//	VARIABLES FOR GENERATOR:
	//	Java objects for the components of a 0-L generative grammar.
	String axiom;
	Properties rules;
	int iterations;
	Note pen;
	Vector penStack;
	//	RENDERING:
	//	Declare a Csound score manager object as a member of this.
	ScoreManager scoreManager = null;
    //  All Java standalone applications must have this.    
    public static void main(String argv[])
    {
        MinimalMuse minimalMuse = new MinimalMuse();
        minimalMuse.standAlone = true;
        minimalMuse.argumentValues = argv;
        Frame frame = new Frame();
        frame.add(minimalMuse);
        minimalMuse.init();
        minimalMuse.start();
        frame.resize(minimalMuse.size());
        frame.show();
    }
    public MinimalMuse()
    {
        scoreManager = new ScoreManager();
        standAlone = false;
        argumentValues = null;
    }
    public void init()
    {
        initialize();
        if(!standAlone)
        {
       		addNotify();
       	}
   		//{{INIT_CONTROLS
		setLayout(null);
		resize(721,496);
		setFont(new Font("TimesRoman", Font.BOLD, 14));
		setBackground(new Color(12632256));
		buttonGenerate = new java.awt.Button("Generate");
		buttonGenerate.reshape(420,444,95,36);
		add(buttonGenerate);
		buttonScore = new java.awt.Button("Score");
		buttonScore.reshape(528,444,95,36);
		add(buttonScore);
		buttonSave = new java.awt.Button("Save");
		buttonSave.reshape(312,444,95,36);
		add(buttonSave);
		buttonOpen = new java.awt.Button("Open");
		buttonOpen.reshape(204,444,95,36);
		add(buttonOpen);
		buttonNew = new java.awt.Button("New");
		buttonNew.reshape(96,444,95,36);
		add(buttonNew);
		textAreaCode = new java.awt.TextArea();
		textAreaCode.reshape(12,72,696,360);
		add(textAreaCode);
		labelApplet = new java.awt.Label("Minimalist Generative Grammar",Label.CENTER);
		labelApplet.reshape(0,24,708,47);
		labelApplet.setFont(new Font("TimesRoman", Font.BOLD, 20));
		add(labelApplet);
		//}}
    }
	public void initialize()
	{
		//	Create components of generator.
		axiom = "";
		rules = new Properties();
		pen = new Note();
		penStack = new Vector();
		scoreManager.notesDelete();
	}
	void setText()
	{
		try
		{
			ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
			PrintStream printStream = new PrintStream(byteArrayOutputStream);
			write(printStream, false);
			textAreaCode.setText(byteArrayOutputStream.toString());
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
	}
	void getText()
	{
		try
		{
			StringBufferInputStream stringBufferInputStream = new StringBufferInputStream(textAreaCode.getText());
			DataInputStream dataInputStream = new DataInputStream(stringBufferInputStream);
			read(dataInputStream);
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
		}
	}
	void read(DataInputStream dataInputStream) throws IOException
	{
		String buffer = null;
		initialize();
		for(;;)
		{
			buffer = dataInputStream.readLine();
			if(buffer == null)
			{
				return;
			}
			else if(buffer.startsWith("<CsMinMuse"))
			{
				for(;;)
				{
					buffer = dataInputStream.readLine();
					if(buffer == null)
					{
						return;
					}
					else if(buffer.startsWith("<CsAxiom>"))
					{
						axiom = dataInputStream.readLine();
					}
					else if(buffer.startsWith("<CsRules>"))
					{
						for(;;)
						{
							buffer = dataInputStream.readLine();
							{
								if(buffer == null)
								{
									return;
								}
								else if(buffer.startsWith("</CsRules>"))
								{
									break;
								}
								else
								{
									int subscript = buffer.indexOf("=");
									if(subscript != -1)
									{
										String symbol = buffer.substring(0, subscript - 1).trim();
										String replacement = buffer.substring(subscript + 1).trim();
										rules.put(symbol, replacement);
									}
								}
							}
						}
					}
					else if(buffer.startsWith("<CsIterations"))
					{
						buffer = buffer.substring(buffer.indexOf(" "));
						if(buffer.indexOf(">") != -1)
						{
							buffer = buffer.substring(0, buffer.indexOf(">"));
						}
						iterations = Double.valueOf(buffer).intValue();
					}
					else if(buffer.startsWith("<CsScoreManager>"))
					{
						scoreManager.read(dataInputStream);
					}
					else if(buffer.startsWith("</CsMinMuse>"))
					{
						return;
					}
				}
			}
		}
	}
	void write(OutputStream outputStream) throws IOException
	{
		write(outputStream, true);
	}
	void write(OutputStream outputStream, boolean writeScore) throws IOException
	{
		PrintStream printStream = new PrintStream(outputStream);
		printStream.println("<CsMinMuse>");
		printStream.println("<CsAxiom>");
		printStream.println(axiom);
		printStream.println("</CsAxiom>");
		printStream.println("<CsRules>");
		if(rules.size() > 0)
		{
			for(Enumeration symbols = rules.keys(); symbols.hasMoreElements(); )
			{
				String symbol = (String) symbols.nextElement();
				printStream.println(symbol + " = " + rules.getProperty(symbol));
			}
		}
		printStream.println("</CsRules>");
		printStream.println("<CsIterations " + iterations + ">");
		if(writeScore)
		{
			scoreManager.write(printStream);
		}
		printStream.println("</CsMinMuse>");
	}
	//	GENERATE
	boolean generate()
	{
		try
		{
			File fileEven = new File("Product0.txt");
			File fileOdd = new File("Product1.txt");
			File finalFile = null;
			FileInputStream preProduction = null;
			FileOutputStream fileOutputStream = new FileOutputStream(fileOdd);
			PrintStream production = new PrintStream(fileOutputStream);
			production.print(axiom);
			production.close();
			String symbol = null;
			String parameter = null;
			String replacement = null;
			for(int i = 0; i < iterations; i++)
			{
				if(i % 2 == 0)
				{
					preProduction = new FileInputStream(fileOdd);
					fileOutputStream = new FileOutputStream(fileEven);
					production = new PrintStream(fileOutputStream);
					finalFile = fileEven;
				}
				else
				{
					preProduction = new FileInputStream(fileEven);
					fileOutputStream = new FileOutputStream(fileOdd);
					production = new PrintStream(fileOutputStream);
					finalFile = fileOdd;
				}
				StreamTokenizer tokenizer = new StreamTokenizer(preProduction);
				while(tokenizer.nextToken() != StreamTokenizer.TT_EOF)
				{
					switch(tokenizer.ttype)
					{
					case StreamTokenizer.TT_WORD:
						symbol = tokenizer.sval;
						replacement = rules.getProperty(symbol, symbol);
						production.print(replacement);
						production.print(" ");
						break;
					case StreamTokenizer.TT_NUMBER:
						parameter = String.valueOf(tokenizer.nval);
						production.print(parameter);
						production.print(" ");
						break;
					}
				}
				preProduction.close();
				production.close();
			}
			return render(finalFile);
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
			return false;
		}
	}
	//	MAP TO MUSIC AND RENDER TO SCORE
	boolean render(File productionFile)
	{
		try
		{
			//	Clear out the old score.
			scoreManager.notesDelete();
			//	Render a new score.
			//	Each symbol is either an ignorable single word,
			//	or a pen command word,
			//	or the one numerical parameter always following certain command words.
			//	Initialize pen at middle C 1/8th note.
			pen.instrumentSet(1);
			pen.startSet(0);
			pen.lengthSet(.125);
			pen.midiKeySet(60);
			pen.decibelsSet(60);
			pen.panSet(0);
			FileInputStream fileInputStream = new FileInputStream(productionFile);
			StreamTokenizer tokenizer = new StreamTokenizer(fileInputStream);
			while(tokenizer.nextToken() != StreamTokenizer.TT_EOF)
			{
				switch(tokenizer.ttype)
				{
				case StreamTokenizer.TT_WORD:
					String symbol = tokenizer.sval;
					//	RENDER
					//	note: Write a note in the score 
					//	using the current state of the pen,
					//	and advance by the current length.
					if(symbol.equals("note"))
					{
						scoreManager.noteAdd((Note)pen.clone());
						pen.startSet(pen.startGet() + pen.lengthGet());
					}
					//	rest: advance by the current length.
					else if(symbol.equals("rest"))
					{
						pen.startSet(pen.startGet() + pen.lengthGet());
					}
					//	MAP TO MUSIC
					//	instrument number: Set the current instrument to number.
					else if(symbol.equals("instrument"))
					{
						tokenizer.nextToken();
						if(tokenizer.ttype == StreamTokenizer.TT_NUMBER)
						{
							pen.instrumentSet(tokenizer.nval);
						}
					}
					//	start seconds: Set the current time to seconds.
					else if(symbol.equals("start"))
					{
						tokenizer.nextToken();
						if(tokenizer.ttype == StreamTokenizer.TT_NUMBER)
						{
							pen.startSet(tokenizer.nval);
						}
					}
					//	length seconds: Set the current length to seconds.
					else if(symbol.equals("length"))
					{
						tokenizer.nextToken();
						if(tokenizer.ttype == StreamTokenizer.TT_NUMBER)
						{
							pen.lengthSet(tokenizer.nval);
						}
					}
					//	tempo multiplier: Multiply the current time and length by multiplier.
					else if(symbol.equals("tempo"))
					{
						tokenizer.nextToken();
						if(tokenizer.ttype == StreamTokenizer.TT_NUMBER)
						{
							pen.lengthSet(pen.lengthGet() / tokenizer.nval);
						}
					}
					//	pitch semitones: Set the current pitch to semitones.
					else if(symbol.equals("pitch"))
					{
						tokenizer.nextToken();
						if(tokenizer.ttype == StreamTokenizer.TT_NUMBER)
						{
							pen.midiKeySet(tokenizer.nval);
						}
					}
					//	transpose semitones: Transpose the current pitch by semitones.
					else if(symbol.equals("transpose"))
					{
						tokenizer.nextToken();
						if(tokenizer.ttype == StreamTokenizer.TT_NUMBER)
						{
							pen.midiKeySet(pen.midiKeyGet() + tokenizer.nval);
						}
					}
					else if(symbol.equals("multiply"))
					{
						tokenizer.nextToken();
						if(tokenizer.ttype == StreamTokenizer.TT_NUMBER)
						{
							pen.midiKeySet(pen.midiKeyGet() * tokenizer.nval);
						}
					}
					//	decibels: Set the current loudness to decibels.
					else if(symbol.equals("decibels"))
					{
						tokenizer.nextToken();
						if(tokenizer.ttype == StreamTokenizer.TT_NUMBER)
						{
							pen.decibelsSet(tokenizer.nval);
						}
					}
					//	dynamics multiplier: Multiply the current decibels by multiplier.
					else if(symbol.equals("dynamics"))
					{
						tokenizer.nextToken();
						if(tokenizer.ttype == StreamTokenizer.TT_NUMBER)
						{
							pen.decibelsSet(pen.decibelsGet() + tokenizer.nval);
						}
					}
					//	pan value: Set the current pan to value.
					else if(symbol.equals("pan"))
					{
						tokenizer.nextToken();
						if(tokenizer.ttype == StreamTokenizer.TT_NUMBER)
						{
							pen.panSet(tokenizer.nval);
						}
					}
					//	push: push the current state of the pen on the pen stack.
					else if(symbol.equals("push"))
					{
						penStack.addElement(pen.clone());
					}
					//	pop: pop the earlier state of the pen from the pen stack.
					else if(symbol.equals("pop"))
					{
						pen = (Note) penStack.lastElement();
						penStack.removeElement(pen);
					}
				}
			}
		}
		catch(IOException e)
		{
			System.out.println(e.getMessage());
			return false;
		}
		return true;
	}
	public boolean handleEvent(Event evt)
	{
		if (evt.target == buttonOpen && evt.id == Event.ACTION_EVENT) 
		{
			buttonOpen_Clicked(evt);
			return true;
		} 
		else if (evt.target == buttonSave && evt.id == Event.ACTION_EVENT) 
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
		else if (evt.target == buttonNew && evt.id == Event.ACTION_EVENT) 
		{
			buttonNew_Clicked(evt);
			return true;
		}
		return false;
	}
	//{{DECLARE_CONTROLS
	java.awt.Button buttonGenerate;
	java.awt.Button buttonScore;
	java.awt.Button buttonSave;
	java.awt.Button buttonOpen;
	java.awt.Button buttonNew;
	java.awt.TextArea textAreaCode;
	java.awt.Label labelApplet;
	//}}
}

