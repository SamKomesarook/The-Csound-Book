package JCsound;
import java.applet.*;
import java.awt.*;
import java.io.*;
import java.net.*;
import java.util.*;
import javax.swing.*;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JPanel;
import javax.swing.JTable;
import javax.swing.event.TableModelEvent;
import javax.swing.filechooser.FileFilter;
import javax.swing.JPopupMenu;
/**
 *  Provides a high-level Java interface, with a graphical user interface, 
 *  to a native implementation of "public-domain" Csound.
 *  Can be used as a standalone application,
 *  or embedded in other software (like score generators) 
 *  as a general-purpose software synthesizer.
 *  <H4>
 *  INSTALLATION
 *  </H4>
 *  Copy JCsound_Csound.dll to a directory in your executable PATH, 
 *  such as c:\Windows\system.
 *  Set your CLASSPATH to include the directory where JCsound is located.
 *  Modify JCsound.bat to reflect the classpath.
 *  <H4>
 *  USAGE
 *  </H4>
 *  Run as a standalone application, JCsound serves as a graphical user interface and orchestra editor for Csound.
 *  <P>
 *  JCsound can also be used as a component of a score generating program:
 *  <P>
 *  Create an instance.
 *  <pre>
 *      JCsound.CsoundManager csoundManager = new JCsound.CsoundManager();
 *  </pre>
 *  Read a ".csd" file containing an orchestra:
 *  <pre>
 *      csoundManager.read("Trapped.csd");
 *  </pre>
 *  Remove existing notes, and build up a new score:
 *  <pre>
 *      csoundManager.removeScoreExceptFunctions();
 *      csoundManager.addScoreLine("i 1 2 3 4");
 *      csoundManager.addScoreLine("i 2 2 3 4");
 *  </pre>
 *      Open in an independent frame window:
 *  <pre>
 *      casoundManager.openView();
 *  </pre>
 *  Or add to an existing java.awt.Component:
 *  <pre>
 *      panel.add("Center", csoundManager);
 *      csoundManager.setFrame(frame);
 *  </pre>
 *  Or just render the score programmatically:
 *  <pre>
 *      csoundManager.setCommand("csound -hdo devaudio test.orc. test.sco");
 *      csoundManager.save("NewScore.csd");
 *      csoundManager.csound.start();
 *  </pre>
 */
public class CsoundManager extends javax.swing.JPanel implements Cloneable
{
    public Csound csound = null;
    String filename = null;
    Vector score = new Vector();
    char[] midiSequence = null;
    Frame myFrame = null;
    AudioClip audioClip = null;
    String soundfilePlayer = null;
    JTabbedPane tabs = null;
    
    /**
     *  Runs this as a standalone application, importing all files specified in args.
     *  The "-deleteNotes" option can be used to delete all notes imported at that point.
     *  The "-name" option causes the final
     */
	static public void main(String args[])
	{
	    CsoundManager csoundManager = new CsoundManager();
	    int i = 0;
	    while(i < args.length)
	    {
	        if(args[i].compareTo("-deleteNotes") == 0)
	        {
	            csoundManager.removeScoreExceptFunctions();
	        }
	        else if(args[i].compareTo("-name") == 0)
	        {
	            i++;
	            if(i < args.length)
	            {
	                csoundManager.filename = args[i].trim();
	                csoundManager.save(csoundManager.filename);
	            }
	            break;
	        }
	        else
	        {
	            csoundManager.load(args[i]);
	        }
	        i++;
	    }
	    csoundManager.openView();
	}
	
	public class CSMgrFrame extends JFrame
	{
	    CSMgrFrame(CsoundManager manager)
	    {
    	    setSize(640, 480);
    	    getContentPane().setLayout(new BorderLayout());
    	    getContentPane().add("Center", manager);
	        addWindowListener(new CSMgrWindowListener());
	        manager.myFrame = this;
	    }
	    
    	class CSMgrWindowListener extends java.awt.event.WindowAdapter
    	{
    		public void windowClosing(java.awt.event.WindowEvent event)
    		{
    		    System.exit(0);
    		}
    	}
	}
     
    /**
     *  This constructor takes a java.awt.Frame argument,
     *  which can be null. The filename and number of lines in the score
     *  are printed as the title of the frame.
     */
	public CsoundManager()
	{
	    setVisible(false);
	    try
	    {
	        csound = new Csound();
	    }
	    catch(UnsatisfiedLinkError e)
	    {
	        e.printStackTrace();
	    }
	    loadConfiguration();
		//{{INIT_CONTROLS
		GridBagLayout gridBagLayout;
		gridBagLayout = new GridBagLayout();
		setLayout(gridBagLayout);
		setSize(640,480);
		setFont(new Font("Dialog", Font.PLAIN, 12));
		setForeground(new Color(0));
		setBackground(new Color(-3355444));
		cardsPanel = new javax.swing.JPanel();
		cardsPanel.setDoubleBuffered(false);
		cardsPanel.setLayout(new CardLayout(0,0));
		cardsPanel.setBounds(12,12,612,456);
		cardsPanel.setFont(new Font("Dialog", Font.PLAIN, 12));
		cardsPanel.setForeground(new Color(0));
		cardsPanel.setBackground(new Color(12632256));
		GridBagConstraints gbc;
		gbc = new GridBagConstraints();
		gbc.gridx = 0;
		gbc.gridy = 0;
		gbc.weightx = 1.0;
		gbc.weighty = 1.0;
		gbc.fill = GridBagConstraints.BOTH;
		gbc.insets = new Insets(12,12,12,16);
		gbc.ipadx = 612;
		gbc.ipady = 456;
		((GridBagLayout)getLayout()).setConstraints(cardsPanel, gbc);
		add(cardsPanel);
		orchestraScrollPane = new javax.swing.JScrollPane();
		orchestraScrollPane.setAutoscrolls(true);
		orchestraScrollPane.setOpaque(true);
		orchestraScrollPane.setDoubleBuffered(true);
		orchestraScrollPane.setVisible(false);
		orchestraScrollPane.setBounds(0,0,612,456);
		orchestraScrollPane.setFont(new Font("Dialog", Font.PLAIN, 12));
		orchestraScrollPane.setForeground(new Color(0));
		orchestraScrollPane.setBackground(new Color(-3355444));
		cardsPanel.add("orchestraPanel", orchestraScrollPane);
		orchestraTextArea = new javax.swing.JTextArea();
		orchestraTextArea.setLineWrap(true);
		orchestraTextArea.setBounds(12,12,588,384);
		orchestraTextArea.setFont(new Font("MonoSpaced", Font.PLAIN, 12));
		orchestraTextArea.setForeground(new Color(0));
		orchestraTextArea.setBackground(new Color(16777215));
		orchestraScrollPane.getViewport().add(orchestraTextArea);
		scorePanel = new javax.swing.JPanel();
		gridBagLayout = new GridBagLayout();
		scorePanel.setLayout(gridBagLayout);
		scorePanel.setVisible(false);
		scorePanel.setBounds(0,0,612,456);
		scorePanel.setFont(new Font("Dialog", Font.PLAIN, 12));
		scorePanel.setForeground(new Color(0));
		scorePanel.setBackground(new Color(-3355444));
		cardsPanel.add("scorePanel", scorePanel);
		scoreScrollPane = new javax.swing.JScrollPane();
		scoreScrollPane.setAutoscrolls(true);
		scoreScrollPane.setOpaque(true);
		scoreScrollPane.setBounds(12,48,588,396);
		scoreScrollPane.setFont(new Font("Dialog", Font.PLAIN, 12));
		scoreScrollPane.setForeground(new Color(0));
		scoreScrollPane.setBackground(new Color(-3355444));
		gbc = new GridBagConstraints();
		gbc.gridx = 0;
		gbc.gridy = 1;
		gbc.gridwidth = 4;
		gbc.weightx = 1.0;
		gbc.weighty = 1.0;
		gbc.fill = GridBagConstraints.BOTH;
		gbc.insets = new Insets(12,12,12,12);
		gbc.ipadx = 587;
		gbc.ipady = 347;
		((GridBagLayout)scorePanel.getLayout()).setConstraints(scoreScrollPane, gbc);
		scorePanel.add(scoreScrollPane);
		scoreTextArea = new javax.swing.JTextArea();
		scoreTextArea.setLineWrap(true);
		scoreTextArea.setBounds(12,12,564,324);
		scoreTextArea.setFont(new Font("MonoSpaced", Font.PLAIN, 12));
		scoreTextArea.setForeground(new Color(0));
		scoreTextArea.setBackground(new Color(16777215));
		scoreScrollPane.getViewport().add(scoreTextArea);
		remvoeScoreButton = new javax.swing.JButton();
		remvoeScoreButton.setText("Remove score");
		remvoeScoreButton.setActionCommand("Remove score");
		remvoeScoreButton.setLabel("Remove score");
		remvoeScoreButton.setBounds(12,12,132,24);
		remvoeScoreButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		remvoeScoreButton.setForeground(new Color(0));
		remvoeScoreButton.setBackground(new Color(-3355444));
		gbc = new GridBagConstraints();
		gbc.gridx = 0;
		gbc.gridy = 0;
		gbc.fill = GridBagConstraints.NONE;
		gbc.insets = new Insets(12,12,0,0);
		gbc.ipadx = 17;
		gbc.ipady = -1;
		((GridBagLayout)scorePanel.getLayout()).setConstraints(remvoeScoreButton, gbc);
		scorePanel.add(remvoeScoreButton);
		removeAllButFunctionsButton = new javax.swing.JButton();
		removeAllButFunctionsButton.setText("Remove all but functions");
		removeAllButFunctionsButton.setActionCommand("Remove all but functions");
		removeAllButFunctionsButton.setLabel("Remove all but functions");
		removeAllButFunctionsButton.setBounds(156,12,180,24);
		removeAllButFunctionsButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		removeAllButFunctionsButton.setForeground(new Color(0));
		removeAllButFunctionsButton.setBackground(new Color(-3355444));
		gbc = new GridBagConstraints();
		gbc.gridx = 1;
		gbc.gridy = 0;
		gbc.fill = GridBagConstraints.NONE;
		gbc.insets = new Insets(12,12,0,0);
		gbc.ipadx = 11;
		gbc.ipady = -1;
		((GridBagLayout)scorePanel.getLayout()).setConstraints(removeAllButFunctionsButton, gbc);
		scorePanel.add(removeAllButFunctionsButton);
		updateScoreButton = new javax.swing.JButton();
		updateScoreButton.setText("Update");
		updateScoreButton.setActionCommand("Update");
		updateScoreButton.setLabel("Update");
		updateScoreButton.setBounds(348,12,132,24);
		updateScoreButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		updateScoreButton.setForeground(new Color(0));
		updateScoreButton.setBackground(new Color(-3355444));
		gbc = new GridBagConstraints();
		gbc.gridx = 2;
		gbc.gridy = 0;
		gbc.fill = GridBagConstraints.NONE;
		gbc.insets = new Insets(12,12,0,0);
		gbc.ipadx = 57;
		gbc.ipady = -1;
		((GridBagLayout)scorePanel.getLayout()).setConstraints(updateScoreButton, gbc);
		scorePanel.add(updateScoreButton);
		commandPanel = new javax.swing.JPanel();
		commandPanel.setLayout(null);
		commandPanel.setVisible(false);
		commandPanel.setBounds(0,0,612,456);
		commandPanel.setFont(new Font("Dialog", Font.PLAIN, 12));
		commandPanel.setForeground(new Color(0));
		commandPanel.setBackground(new Color(-3487030));
		cardsPanel.add("commandPanel", commandPanel);
		commandScrollPane = new javax.swing.JScrollPane();
		commandScrollPane.setOpaque(true);
		commandScrollPane.setBounds(12,12,576,96);
		commandScrollPane.setFont(new Font("Dialog", Font.PLAIN, 12));
		commandScrollPane.setForeground(new Color(0));
		commandScrollPane.setBackground(new Color(-3355444));
		commandPanel.add(commandScrollPane);
		commandTextArea = new javax.swing.JTextArea();
		commandTextArea.setLineWrap(true);
		commandTextArea.setWrapStyleWord(true);
		commandTextArea.setBounds(12,12,552,72);
		commandTextArea.setFont(new Font("Monospaced", Font.PLAIN, 12));
		commandTextArea.setForeground(new Color(0));
		commandTextArea.setBackground(new Color(16777215));
		commandScrollPane.getViewport().add(commandTextArea);
		newButton = new javax.swing.JButton();
		newButton.setText("New");
		newButton.setActionCommand("File");
		newButton.setLabel("New");
		newButton.setBounds(12,120,108,24);
		newButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		newButton.setForeground(new Color(0));
		newButton.setBackground(new Color(-3355444));
		commandPanel.add(newButton);
		openButton = new javax.swing.JButton();
		openButton.setText("Open...");
		openButton.setActionCommand("File");
		openButton.setLabel("Open...");
		openButton.setBounds(12,156,108,24);
		openButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		openButton.setForeground(new Color(0));
		openButton.setBackground(new Color(-3355444));
		commandPanel.add(openButton);
		saveButton = new javax.swing.JButton();
		saveButton.setText("Save");
		saveButton.setActionCommand("File");
		saveButton.setLabel("Save");
		saveButton.setBounds(12,192,108,24);
		saveButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		saveButton.setForeground(new Color(0));
		saveButton.setBackground(new Color(-3355444));
		commandPanel.add(saveButton);
		saveAsButton = new javax.swing.JButton();
		saveAsButton.setText("Save as...");
		saveAsButton.setActionCommand("File");
		saveAsButton.setLabel("Save as...");
		saveAsButton.setBounds(12,228,108,24);
		saveAsButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		saveAsButton.setForeground(new Color(0));
		saveAsButton.setBackground(new Color(-3355444));
		commandPanel.add(saveAsButton);
		importButton = new javax.swing.JButton();
		importButton.setText("Import...");
		importButton.setActionCommand("File");
		importButton.setLabel("Import...");
		importButton.setBounds(12,264,108,24);
		importButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		importButton.setForeground(new Color(0));
		importButton.setBackground(new Color(-3355444));
		commandPanel.add(importButton);
		playButton = new javax.swing.JButton();
		playButton.setText("Render");
		playButton.setActionCommand("File");
		playButton.setLabel("Render");
		playButton.setBounds(132,120,108,24);
		playButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		playButton.setForeground(new Color(0));
		playButton.setBackground(new Color(-3355444));
		commandPanel.add(playButton);
		pauseButton = new javax.swing.JButton();
		pauseButton.setText("Pause");
		pauseButton.setActionCommand("File");
		pauseButton.setLabel("Pause");
		pauseButton.setBounds(132,156,108,24);
		pauseButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		pauseButton.setForeground(new Color(0));
		pauseButton.setBackground(new Color(-3355444));
		commandPanel.add(pauseButton);
		resumeButton = new javax.swing.JButton();
		resumeButton.setText("Resume");
		resumeButton.setActionCommand("File");
		resumeButton.setLabel("Resume");
		resumeButton.setBounds(132,192,108,24);
		resumeButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		resumeButton.setForeground(new Color(0));
		resumeButton.setBackground(new Color(-3355444));
		commandPanel.add(resumeButton);
		stopButton = new javax.swing.JButton();
		stopButton.setText("Stop");
		stopButton.setActionCommand("File");
		stopButton.setLabel("Stop");
		stopButton.setBounds(132,228,108,24);
		stopButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		stopButton.setForeground(new Color(0));
		stopButton.setBackground(new Color(-3355444));
		commandPanel.add(stopButton);
		playSoundfileButton = new javax.swing.JButton();
		playSoundfileButton.setText("Play");
		playSoundfileButton.setActionCommand("File");
		playSoundfileButton.setLabel("Play");
		playSoundfileButton.setBounds(132,264,108,24);
		playSoundfileButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		playSoundfileButton.setForeground(new Color(0));
		playSoundfileButton.setBackground(new Color(-3355444));
		commandPanel.add(playSoundfileButton);
		csoundLabel = new javax.swing.JLabel();
		csoundLabel.setText("JCsound 1.0");
		csoundLabel.setHorizontalAlignment(0);
		csoundLabel.setBounds(12,324,108,24);
		csoundLabel.setFont(new Font("Serif", Font.BOLD, 20));
		csoundLabel.setForeground(new Color(-10066279));
		csoundLabel.setBackground(new Color(-3355444));
		commandPanel.add(csoundLabel);
		setPlayerButton = new javax.swing.JButton();
		setPlayerButton.setText("Set player...");
		setPlayerButton.setActionCommand("File");
		setPlayerButton.setLabel("Set player...");
		setPlayerButton.setBounds(132,324,108,24);
		setPlayerButton.setFont(new Font("Dialog", Font.PLAIN, 12));
		setPlayerButton.setForeground(new Color(0));
		setPlayerButton.setBackground(new Color(-3355444));
		commandPanel.add(setPlayerButton);
		//}}
	    tabs = new JTabbedPane();
	    tabs.addTab("Command", commandPanel);
	    tabs.addTab("Orchestra", orchestraScrollPane);
	    tabs.addTab("Score", scorePanel);
		gbc = new GridBagConstraints();
		gbc.gridx = 0;
		gbc.gridy = 0;
		gbc.weightx = 1.0;
		gbc.weighty = 1.0;
		gbc.fill = GridBagConstraints.BOTH;
		gbc.insets = new Insets(12,12,12,16);
		gbc.ipady = 48;
		((GridBagLayout)getLayout()).setConstraints(tabs, gbc);
        remove(cardsPanel);
        add(tabs);
		
		//{{REGISTER_LISTENERS
		SymAction lSymAction = new SymAction();
		newButton.addActionListener(lSymAction);
		openButton.addActionListener(lSymAction);
		saveButton.addActionListener(lSymAction);
		saveAsButton.addActionListener(lSymAction);
		importButton.addActionListener(lSymAction);
		playButton.addActionListener(lSymAction);
		pauseButton.addActionListener(lSymAction);
		resumeButton.addActionListener(lSymAction);
		stopButton.addActionListener(lSymAction);
    	playSoundfileButton.addActionListener(lSymAction);
		remvoeScoreButton.addActionListener(lSymAction);
		removeAllButFunctionsButton.addActionListener(lSymAction);
		updateScoreButton.addActionListener(lSymAction);
		setPlayerButton.addActionListener(lSymAction);
		//}}
	    removeAll();
	    setVisible(true);
	}
	
	//{{DECLARE_CONTROLS
	javax.swing.JPanel cardsPanel;
	javax.swing.JScrollPane orchestraScrollPane;
	javax.swing.JTextArea orchestraTextArea;
	javax.swing.JPanel scorePanel;
	javax.swing.JScrollPane scoreScrollPane;
	javax.swing.JTextArea scoreTextArea;
	javax.swing.JButton remvoeScoreButton;
	javax.swing.JButton removeAllButFunctionsButton;
	javax.swing.JButton updateScoreButton;
	javax.swing.JPanel commandPanel;
	javax.swing.JScrollPane commandScrollPane;
	javax.swing.JTextArea commandTextArea;
	javax.swing.JButton newButton;
	javax.swing.JButton openButton;
	javax.swing.JButton saveButton;
	javax.swing.JButton saveAsButton;
	javax.swing.JButton importButton;
	javax.swing.JButton playButton;
	javax.swing.JButton pauseButton;
	javax.swing.JButton resumeButton;
	javax.swing.JButton stopButton;
	javax.swing.JButton playSoundfileButton;
	javax.swing.JLabel csoundLabel;
	javax.swing.JButton setPlayerButton;
	//}}

    /**
     *  File filter. 
     */
    class CsoundFileFilter extends javax.swing.filechooser.FileFilter
    {
        String description;
        String filter;
        
        CsoundFileFilter(String desc, String filt)
        {
            description = desc;
            filter = filt;
        }
        
        public boolean accept(File file)
        {
            if(file.isDirectory())
            {
                return true;
            }
            else if(file.getAbsolutePath().endsWith(filter))
            {
                return true;
            }
            return false;
        }
        
        public String getDescription()
        {
            return description;
        }
    }
    
    /**
     *  Returns a complete copy of this.
     */
    public Object clone()
    {
        CsoundManager myClone = new CsoundManager();
        myClone.filename = filename;
        myClone.commandTextArea.setText(commandTextArea.getText());
        myClone.orchestraTextArea.setText(orchestraTextArea.getText());
        myClone.score = (Vector) score.clone();
        myClone.midiSequence = (char[]) midiSequence.clone();
        return myClone;        
    }
    
    /**
     *  Opens an "open file" dialog.
     */
    public String openFileDialog(String title)
    {
        JFileChooser fileChooser = new JFileChooser(title);
        fileChooser.setFileFilter(new CsoundFileFilter("Csound files", ".csd"));
        fileChooser.addChoosableFileFilter(new CsoundFileFilter("Csound score files", ".sco"));
        fileChooser.addChoosableFileFilter(new CsoundFileFilter("Csound orchestra files", ".oc"));
        fileChooser.addChoosableFileFilter(new CsoundFileFilter("MIDI files", ".mid"));
        if(fileChooser.showOpenDialog(this) == fileChooser.APPROVE_OPTION)
        {
            return fileChooser.getSelectedFile().getAbsolutePath();
        }
        return null;
    }

    /**
     *  Opens a "save file" dialog.
     */
    public String saveFileDialog(String title)
    {
        JFileChooser fileChooser = new JFileChooser(title);
        fileChooser.setFileFilter(new CsoundFileFilter("Csound files", ".csd"));
        fileChooser.addChoosableFileFilter(new CsoundFileFilter("Csound score files", ".sco"));
        fileChooser.addChoosableFileFilter(new CsoundFileFilter("Csound orchestra files", ".oc"));
        fileChooser.addChoosableFileFilter(new CsoundFileFilter("MIDI files", ".mid"));
        if(fileChooser.showSaveDialog(this) == fileChooser.APPROVE_OPTION)
        {
            return fileChooser.getSelectedFile().getAbsolutePath();
        }
        return null;
    }
    
    /**
     *  Reads data from a Csound XML stream into this.
     *  Skips non-Csound elements of XML.
     *  The elements of a Csound XML stream are:
     *  <pre>
     *  Csound
     *      Command
     *          Any legal Csound command line.
     *      Orchestra
     *          Any legal Csound orchestra (".orc") file.
     *      Score
     *          Any legal Csound score (".sco") file.
     *      Midi
     *          Size
     *              Size in bytes of MIDI data.
     *          Binary MIDI data.
     *  </pre>
     */     
	public void read(BufferedReader bufferedReader) throws IOException
	{
	    System.out.println("Starting CsoundManager.read().");
	    String buffer = null;
	    while((buffer = bufferedReader.readLine()) != null)
	    {
            if(buffer.indexOf("</CsoundSynthesizer>") != -1)
            {
                System.out.println("Finished CsoundManager.read().");
                updateView();
                return;
            }
            else if(buffer.indexOf("<CsOptions>") != -1)
            {
                readCommand(bufferedReader);
            }
            else if(buffer.indexOf("<CsInstruments>") != -1)
            {
                readOrchestra(bufferedReader);
            }
            else if(buffer.indexOf("<CsScore>") != -1)
            {
   			    readScore(bufferedReader);
            }
            else if(buffer.indexOf("<CsMidifile>") != -1)
            {
                readMidi(bufferedReader);
            }
            else if(buffer.indexOf("<CsoundSynthesizer>") != -1)
            {
                //  Do nothing.
            }
            else
            {
                //  Skip non-Csound elements.
                int start = buffer.indexOf("<");
                int end = buffer.indexOf(">");
                if(start != -1 && end != -1)
                {
                    String endTag = "</" + buffer.substring(start, end) + ">";
                    buffer = bufferedReader.readLine();
                    if(buffer == null)
                    {
                        return;
                    }
                    if(buffer.indexOf(endTag) != -1)
                    {
                        break;
                    }
                }                    
            }
        }
    }
    
    /**
     *  Reads the "Command" element of a Csound XML stream into this.
     */
	public boolean readCommand(BufferedReader bufferedReader) throws IOException
	{
	    String buffer = null;
   	    while((buffer = bufferedReader.readLine()) != null)
	    {
	        if(buffer.indexOf("</CsOptions>") != -1)
	        {
	            return true;
	        }
            commandTextArea.append(buffer);
	    }
	    return false;
	}
	
	/**
	 *  Reads the "Orchestra" element of a Csound XML stream into this.
	 */
	public boolean readOrchestra(BufferedReader bufferedReader) throws IOException
	{
	    String buffer = null;
	    StringBuffer stringBuffer = new StringBuffer();
	    while((buffer = bufferedReader.readLine()) != null)
	    {
	        if(buffer.indexOf("</CsInstruments>") != -1)
	        {
	            orchestraTextArea.append(stringBuffer.toString());
	            return true;
	        }
	        stringBuffer.append(buffer);
	        stringBuffer.append("\n");
	    }
	    return false;
	}
	
	/**
	 *  Writes the "Orchestra" data of this into a stream.
	 */		
	public void writeOrchestra(PrintWriter printWriter) throws IOException
	{
	    printWriter.println(getOrchestra());
	    printWriter.flush();
	}

	/**
	 *  Reads the "Score" element of a Csound XML stream into this.
	 */
	public boolean readScore(BufferedReader bufferedReader) throws IOException
	{
	    String buffer = null;
   	    while((buffer = bufferedReader.readLine()) != null)
	    {
	        if(buffer.indexOf("</CsScore>") != -1)
	        {
	            return true;
	        }
	        score.addElement(buffer);
	    }
	    return false;
	}
	
	/**
	 *  Writes the "Score" data of this into a stream.
	 */	
	public void writeScore(PrintWriter printWriter) throws IOException
	{
	    for(int i = 0, n = score.size(); i < n; i++)
	    {
	        printWriter.println((String) score.elementAt(i));
	    }
	    printWriter.flush();
	}

	/**
	 *  Writes the "Midi" data of this into a stream.
	 */	
	public void writeMidi(PrintWriter printWriter) throws IOException
	{
	    printWriter.write(midiSequence);
	    printWriter.flush();
	}

    /**
     *  Writes all elements in this to a Csound XML stream.
     */
    public void write(PrintWriter printWriter) throws IOException
	{
	    System.out.println("Starting CsoundManager.write().");
	    printWriter.println("<CsoundSynthesizer>");
	    printWriter.println("<CsOptions>");
	    printWriter.println(commandTextArea.getText());
	    printWriter.println("</CsOptions>");
	    printWriter.println("<CsInstruments>");
	    writeOrchestra(printWriter);
	    printWriter.println("</CsInstruments>");
	    printWriter.println("<CsScore>");
	    writeScore(printWriter);
	    printWriter.println("</CsScore>");
	    if(midiSequence != null)
	    {
    	    if(midiSequence.length > 0)
    	    {
    	        printWriter.println("<CsMidifile>");
    	        printWriter.println("<Size>");
    	        printWriter.println(String.valueOf(midiSequence.length * 2));
    	        printWriter.println("</Size");
    	        writeMidi(printWriter);
    	        printWriter.println("</CsMidifile>");
    	    }
	    }
		printWriter.println("</CsoundSynthesizer>");
	    System.out.println("Finished CsoundManager.write().");
	}
	
	/**
	 *  Saves data in this into the named file.
	 *  If saveFilename ends with ".csd", 
	 *  all elements are saved as a Csound XML stream.
	 *  If saveFilename ends with ".orc", 
	 *  only the "Orchestra" data is saved 
	 *  as a Csound orchestra file.
	 *  If saveFilename ends with ".sco",
	 *  only the "Score" data is saved
	 *  as a Csound standard numeric score file.
	 *  If saveFilename ends with ".mid",
	 *  only the "Midi" data is saved
	 *  as a MIDI data file.
	 */
    public boolean save(String saveFilename)
	{
		boolean returnValue = false;
		try
		{
			FileOutputStream fileOutputStream = new FileOutputStream(saveFilename.trim());
			BufferedOutputStream bufferedOutputStream = new BufferedOutputStream(fileOutputStream);
			PrintWriter printWriter = new PrintWriter(bufferedOutputStream);
			if(saveFilename.endsWith(".csd"))
			{
			    write(printWriter);
			}
			else if(saveFilename.endsWith(".orc"))
			{
			    writeOrchestra(printWriter);
			}
			else if(saveFilename.endsWith(".sco"))
			{
			    writeScore(printWriter);
			}
			else if(saveFilename.endsWith(".mid"))
			{
			    writeMidi(printWriter);
			}
			printWriter.close();
			returnValue = true;
		}
		catch(IOException e)
		{
		    e.printStackTrace();
			returnValue = false;
		}
		return returnValue;
	}	
	
	/**
	 *  Loads data from loadFilename into this.
	 *  If loadFilename ends with ".csd",
	 *  the file is read as a Csound XML stream.
	 *  If loadFilename ends with ".orc",
	 *  the file is read as a Csound orchestra file.
	 *  If loadFilename ends with ".sco",.
	 *  the file is read as a Csound standard numeric score.
	 *  If loadFilename ends with ".mid",
	 *  the file is read as a standard MIDI file.
	 *  All data read (except MIDI) is appended to the existing data, if any. 
	 */    
    public boolean load(String loadFilename)
    {
		try
		{
			FileReader fileReader = new FileReader(loadFilename.trim());
			BufferedReader bufferedReader = new BufferedReader(fileReader);
			if(loadFilename.endsWith(".csd"))
			{
			    read(bufferedReader);
			}
			else if(loadFilename.endsWith(".orc"))
			{
		        String buffer = null;
			    StringBuffer stringBuffer = new StringBuffer();
		        while((buffer = bufferedReader.readLine()) != null)
		        {
		            stringBuffer.append(buffer);
		            stringBuffer.append("\n");
			    }
		        orchestraTextArea.append(stringBuffer.toString());
			}
			else if(loadFilename.endsWith(".sco"))
			{
		        String buffer = null;
		        while((buffer = bufferedReader.readLine()) != null)
		        {
    		        score.addElement(buffer);
		        }
			}
			fileReader.close();
		}
		catch(IOException e)
		{
		    e.printStackTrace();
			return false;
		}
		return true;
    }
    
	class SymAction implements java.awt.event.ActionListener
	{
		public void actionPerformed(java.awt.event.ActionEvent event)
		{
			Object object = event.getSource();
			if (object == newButton)
				newButton_actionPerformed(event);
			else if (object == openButton)
				openButton_actionPerformed(event);
			else if (object == saveAsButton)
				saveAsButton_actionPerformed(event);
			else if (object == importButton)
				importButton_actionPerformed(event);
			else if (object == playButton)
				playButton_actionPerformed(event);
			else if (object == pauseButton)
				pauseButton_actionPerformed(event);
			else if (object == resumeButton)
				resumeButton_actionPerformed(event);
			else if (object == stopButton)
				stopButton_actionPerformed(event);
			else if (object == playSoundfileButton)
				playSoundfileButton_actionPerformed(event);
			else if (object == saveButton)
				saveButton_actionPerformed(event);
			else if (object == remvoeScoreButton)
				remvoeScoreButton_actionPerformed(event);
			else if (object == removeAllButFunctionsButton)
				removeAllButFunctionsButton_actionPerformed(event);
			else if (object == updateScoreButton)
				updateScoreButton_actionPerformed(event);
			else if (object == setPlayerButton)
				setPlayerButton_actionPerformed(event);
		}
	}

	void newButton_actionPerformed(java.awt.event.ActionEvent event)
	{
		removeAll();
	}

	void openButton_actionPerformed(java.awt.event.ActionEvent event)
	{
	    String newFilename = openFileDialog("Open file");
	    if(newFilename != null)
	    {
	        Cursor cursor = getCursor();
	        filename = newFilename.trim();
	        setCursor(new Cursor(Cursor.WAIT_CURSOR));
	        removeAll();
	        load(filename);
	        if(myFrame != null)
	        {
	            myFrame.setTitle("JCsound - " + filename + " - " + score.size() + " lines");
	        }
	        setCursor(cursor);
	    }
    }

	void saveAsButton_actionPerformed(java.awt.event.ActionEvent event)
	{
		String newFilename = saveFileDialog("Save file");
	    if(newFilename != null)
	    {
	        filename = newFilename.trim();
   	        Cursor cursor = getCursor();
            setCursor(new Cursor(Cursor.WAIT_CURSOR));
	        save(filename);
	        setCursor(cursor);
		}		
	}

	void importButton_actionPerformed(java.awt.event.ActionEvent event)
	{
		String importFilename = openFileDialog("Import file");
        Cursor cursor = getCursor();
        setCursor(new Cursor(Cursor.WAIT_CURSOR));
	    if(importFilename != null)
	    {
	        load(importFilename.trim());
	    }
	    setCursor(cursor);
	}

	void playButton_actionPerformed(java.awt.event.ActionEvent event)
	{
	    start();
	}

	void pauseButton_actionPerformed(java.awt.event.ActionEvent event)
	{
		csound.suspend();
	}

	void resumeButton_actionPerformed(java.awt.event.ActionEvent event)
	{
		csound.resume();
	}

	void stopButton_actionPerformed(java.awt.event.ActionEvent event)
	{
		csound.stopRunning();
	}
	
	/**
	 *  Plays the output soundfile, if it exists.
	 */
	public void playOutputSoundfile()
	{
        try
        {
            File file = new File(getOutputSoundfileName());
            if(soundfilePlayer != null)
            {
                Runtime.getRuntime().exec(soundfilePlayer + " " + file.getAbsolutePath());
                return;
            }
            URL url = new URL("file", null, file.getAbsolutePath());
            if(audioClip == null)
            {
                System.out.println("Began playing " + url.toString() + ".");
                audioClip = Applet.newAudioClip(url);
                audioClip.play();
                
            }
            else
            {
                System.out.println("Ended playing " + url.toString() + ".");
                audioClip.stop();
                audioClip = null;
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
	}
	
	/**
	 *  Plays the output soundfile, if it exists, 
	 *  specified in the "Command" element of this.
	 */
	void playSoundfileButton_actionPerformed(java.awt.event.ActionEvent event)
	{
		csound.stopRunning();
	    playOutputSoundfile();
	}
	
	/**
	 *  Returns the "Command" element in this,
	 *  which should be a complete standard Csound command line.
	 */
	public String getCommand()
	{
	    return commandTextArea.getText();
	}
	
	/**
	 *  Sets the "Command" element in this,
	 *  which should be a complete standard Csound command line.
	 */
	public void setCommand(String text)
	{
	    commandTextArea.setText(text);
	}
	
	/**
	 *  Appends text to the "Command" element in this.
	 */
	public void appendToCommand(String text)
	{
	    commandTextArea.append(text);
	}
	
	/**
	 *  Returns the "Orchestra" element of this.
	 */
	public String getOrchestra()
	{
	    return orchestraTextArea.getText();
	}
	
	/**
	 *  Sets the "Orchestra" element of this.
	 */
	public void setOrchestra(String text)
	{
	    orchestraTextArea.setText(text);
	}
	
	/**
	 *  Appends text to the "Orchestra" element of this.
	 */
	public void appendToOrchestra(String text)
	{
	    orchestraTextArea.append(text);
	}
	
	/**
	 *  Returns the "Score" element of this.
	 */
	public String getScore()
	{
	    StringBuffer stringBuffer = new StringBuffer();
	    for(int i = 0, n = score.size(); i < n; i++)
	    {
	        if(i > 0)
	        {
    	        stringBuffer.append("\n");
	        }
	        stringBuffer.append((String) score.elementAt(i));
	    }
	    return stringBuffer.toString();
	}

    /**
     *  Sets the "Score" element of this.
     */
	public void setScore(String text)
	{
	    score.setSize(0);
	    appendToScore(text);
	}
	
	/**
	 *  Appends text to the "Score" element of this.
	 */
	public void appendToScore(String text)
	{
	    StringTokenizer stringTokenizer = new StringTokenizer(text, "\n");
	    while(stringTokenizer.hasMoreTokens())
	    {
	        score.addElement(stringTokenizer.nextToken());
	    }
	}
	
	/**
	 *  Returns a line from the "Score" element of this.
	 */
	public String getScoreLine(int index)
	{
	    if(index < 0 || index >= score.size())
	    {
	        return null;
	    }
	    return (String) score.elementAt(index);
	}
	
	/**
	 *  Adds a line to the "Score" element of this.
	 */
	public void addScoreLine(String text)
	{
	    score.addElement(text);
	}
	
	/**
	 *  Inserts a line into the "Score" element of this
	 *  at the indicated index, moving elements up as required.
	 */
	public void insertScoreLine(int index, String text)
	{
	    if(index < 0 || index >= score.size())
	    {
	        return;
	    }
	    score.insertElementAt(text, index);
	}
	
	/**
	 *  Replaces the indicated line in the "Score" element of this.,
	 */
	public void setScoreLine(int index, String text)
	{
	    if(index < 0 || index >= score.size())
	    {
	        return;
	    }
	    score.setElementAt(text, index);
	}
	
	/**
	 *  Removes the indicated line from the "Score" element of this.
	 */
	public void removeScoreLine(int index)
	{
	    if(index < 0 || index >= score.size())
	    {
	        return;
	    }
	    score.removeElementAt(index);
	}
	
	/**
	 *  Returns the number of lines in the "Score" element of this.
	 */
    public int getScoreLineCount()
    {
        return score.size();
    }
    
    /**
     *  Sets the number of lines in the "Score" element of this.
     */
    public void setScoreLineCount(int count)
    {
        score.setSize(count);
    }

    /**
     *  Reads the "Midi" element of this from a stream.
     *  The "Midi" element can be used to store a Midifile to be used
     *  with Csound's "-F" option.
     */
	public boolean readMidi(BufferedReader bufferedReader) throws IOException
	{
	    String buffer = null;
   	    while((buffer = bufferedReader.readLine()) != null)
	    {
	        if(buffer.indexOf("</CsMidifile>") != -1)
	        {
	            return true;
	        }
            else if(buffer.indexOf("<Size>") != -1)
            {
                buffer = bufferedReader.readLine();
                if(buffer == null)
                {
                    return false;
                }
                int midiFileSize = Integer.valueOf(buffer).intValue();
                buffer = bufferedReader.readLine();
                if(buffer == null)
                {
                    return false;
                }
                if(buffer.indexOf("</Size>") == -1)
                {
                    return false;
                }
                midiSequence = new char[midiFileSize / 2];
                bufferedReader.read(midiSequence);
            }
	    }
	    return false;
	}

	void saveButton_actionPerformed(java.awt.event.ActionEvent event)
	{
	    if(filename != null)
	    {
   	        Cursor cursor = getCursor();
            setCursor(new Cursor(Cursor.WAIT_CURSOR));
	        save(filename);
	        setCursor(cursor);
		}		
	}
	
	/**
	 *  Opens a frame window containing this.
	 *  Useful for embedding CsoundManager in a score generating program.
	 */	
	public void openView()
	{
	    CSMgrFrame frame = new CSMgrFrame(this);
        frame.setSize(640, 480);
        frame.move(100, 100);
        updateView();
	    frame.setVisible(true);
	}
	
	/**
	 *  Returns the filename for this.
	 */
	public String getFilename()
	{
	    return filename;
	}
	
	/**
	 *  Sets the filename for this.
	 *  Useful for allowing Csound to parse and render an XML file containg
	 *  other data as well as an embedded Csound XML element.
	 */
	public void setFilename(String value)
	{
	    filename = value.trim();
	}
	
    /**
     *  Removes all data from this.
     */
    public void removeAll()
    {
        removeCommand();
        removeOrchestra();
        removeScore();
    }
    
    /**
     *  Removes all data from this 
     *  except the data in the "Command" element 
     *  and the "f" statements in the "Score" element.
     *  Useful for removing a previously generated score
     *  in a score-generating program in preparation
     *  for generating a new score with the same
     *  orchestra and function tables.
     */
    public void removeAllExceptCommandAndFunctions()
    {
        removeOrchestra();
        removeScoreExceptFunctions();
    }
    
    /**
     *  Removes all data from the "Command" element of this.
     */
    public void removeCommand()
    {
        commandTextArea.setText(null);
    }
     
    /**
     *  Removes all data from the "Orchestra" element of this.
     */
    public void removeOrchestra()
    {
        orchestraTextArea.setText(null);
    }
    
    /**
     *  Removes all data from the "Score" element of this.
     */
	public void removeScore()
	{
	    setScoreLineCount(0);
	    updateView();
	}
	
    /**
     *  Removes all data except for "f" statements from the "Score" element of this.
     */
	public void removeScoreExceptFunctions()
	{
	    for(int i = score.size() - 1; i >= 0; i--)
	    {
	        String line = (String) score.elementAt(i);
	        if(line.trim().indexOf("f") != 0)
	        {
	            score.removeElementAt(i);
	        }       
	    }
	    updateView();
	}
	
	/**
	 *  Updates the elements of this from the controls in the graphical user interface.
	 */
	public void updateModel()
	{
	    StringTokenizer stringTokenizer = new StringTokenizer(scoreTextArea.getText(), "\n");
	    score.setSize(0);
	    while(stringTokenizer.hasMoreTokens())
	    {
	        score.addElement(stringTokenizer.nextToken());
	    }
	}
	
	/**
	 *  Updates the controls in the graphical user interface from the elements of this.
	 */
	public void updateView()
	{
	    int n = score.size();
	    if(myFrame != null)
	    {
	        String title = "JCsound";
	        if(filename != null)
	        {
	            title = title + " - " + filename;
	        }
            title = title + " - " + n + " lines";
	        myFrame.setTitle(title);
	    }
	    StringBuffer stringBuffer = new StringBuffer();
	    for(int i = 0; i < n; i++)
	    {
	        stringBuffer.append((String) score.elementAt(i));
	        stringBuffer.append("\n");
	    }
	    scoreTextArea.setText(stringBuffer.toString());
	}

	void remvoeScoreButton_actionPerformed(java.awt.event.ActionEvent event)
	{
		removeScore();
		updateView();
	}

	void removeAllButFunctionsButton_actionPerformed(java.awt.event.ActionEvent event)
	{
		removeScoreExceptFunctions();
		updateView();
	}

	void updateScoreButton_actionPerformed(java.awt.event.ActionEvent event)
	{
	    updateModel();
		updateView();
	}
	
	void removeInstrument(int instrNumber)
	{
	    setInstrument(instrNumber, null);
	}
	
	/**
	 *  Replaces the indicated instrument with the text argument,
	 *  or appends it to the orchestra if the number is not already used.
	 */
	public void setInstrument(int instrNumber, String newInstrumentText)
	{
	    try
	    {
    	    int instrumentStart = 0;
    	    int instrumentEnd = 0;
    	    for(int i = 0, n = orchestraTextArea.getLineCount(); i < n; i++)
    	    {
    	        int start = orchestraTextArea.getLineStartOffset(i);
    	        int end = orchestraTextArea.getLineEndOffset(i);
    	        String instrLineText = orchestraTextArea.getText(start, end - start).trim();
    	        if(instrLineText.startsWith("instr"))
    	        {
    	            instrumentStart = start;
    	            instrLineText = instrLineText.substring(5);
    	            StringTokenizer stringTokenizer = new StringTokenizer(instrLineText, " ,;\n\r\t");
    	            String numberToken = stringTokenizer.nextToken();
    	            int instrumentNumber = Integer.valueOf(numberToken).intValue();
    	            for( ; i < n; i++)
    	            {
               	        start = orchestraTextArea.getLineStartOffset(i);
    	                end = orchestraTextArea.getLineEndOffset(i);
    	                String instrEndinText = orchestraTextArea.getText(start, end - start).trim();
    	                if(instrEndinText.startsWith("endin"))
    	                {
    	                    if(instrNumber == instrumentNumber)
    	                    {
    	                        instrumentEnd = end;
    	                        orchestraTextArea.replaceRange(newInstrumentText, instrumentStart, instrumentEnd);
    	                        updateView();
    	                        return;
    	                    }
    	                    else
    	                    {
    	                        break;
    	                    }
    	                }
    	            }
    	        }
    	    }
	    }
	    catch(javax.swing.text.BadLocationException e)
	    {
	        e.printStackTrace();
	    }
	    catch(Exception e)
	    {
	        e.printStackTrace();
	    }
	    appendToOrchestra(newInstrumentText);
	    updateView();
	}
	
	/**
	 *  Returns the text of the indicated instrument,
	 *  or null if it does not exist in the orchestra.
	 */
	public String getInstrument(int instrNumber)
	{
	    try
	    {
    	    int instrumentStart = 0;
    	    int instrumentEnd = 0;
    	    for(int i = 0, n = orchestraTextArea.getLineCount(); i < n; i++)
    	    {
    	        int start = orchestraTextArea.getLineStartOffset(i);
    	        int end = orchestraTextArea.getLineEndOffset(i);
    	        String instrLineText = orchestraTextArea.getText(start, end - start).trim();
    	        if(instrLineText.startsWith("instr"))
    	        {
    	            instrumentStart = start;
    	            instrLineText = instrLineText.substring(5);
    	            StringTokenizer stringTokenizer = new StringTokenizer(instrLineText, " ,;\n\r\t");
    	            String numberToken = stringTokenizer.nextToken();
    	            int instrumentNumber = Integer.valueOf(numberToken).intValue();
    	            for( ; i < n; i++)
    	            {
               	        start = orchestraTextArea.getLineStartOffset(i);
    	                end = orchestraTextArea.getLineEndOffset(i);
    	                String instrEndinText = orchestraTextArea.getText(start, end - start).trim();
    	                if(instrEndinText.startsWith("endin"))
    	                {
    	                    if(instrNumber == instrumentNumber)
    	                    {
    	                        instrumentEnd = end;
    	                        return orchestraTextArea.getText(instrumentStart, instrumentEnd - instrumentStart);
    	                    }
    	                    else
    	                    {
    	                        break;
    	                    }
    	                }
    	            }
    	        }
    	    }
	    }
	    catch(javax.swing.text.BadLocationException e)
	    {
	        e.printStackTrace();
	    }
	    catch(Exception e)
	    {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	/**
	 *  Returns a vector of tokens parsed from the "Command" element of this.
	 */
	public Vector getArgv()
	{
	    StringTokenizer stringTokenizer = new StringTokenizer(commandTextArea.getText(), " ");
	    Vector argv = new Vector();
	    while(stringTokenizer.hasMoreTokens())
	    {
	        argv.addElement(stringTokenizer.nextToken());
	    }
	    return argv;
	}
	
	/**
	 *  Returns the name of the output soundfile parsed from the "Command" element of this.
	 */
	public String getOutputSoundfileName()
	{
	    Vector argv = getArgv();
	    for(int i = 1, n = argv.size() - 3; i < n; i++)
	    {
	        String arg = (String) argv.elementAt(i);
	        int oindex = arg.indexOf("o");
	        if(oindex != -1)
	        {
	            if(oindex == arg.length() - 1)
	            {
	                return (String) argv.elementAt(i + 1);
	            }
	            else
	            {
	                return arg.substring(oindex + 1);
	            }
	        }
	    }
	    return "test";
	}
	
	/**
	 *  Returns the orchestra filename parsed from the "Command" element of this.
	 */
	public String getOrcFilename()
	{
	    Vector argv = getArgv();
	    return (String) argv.elementAt(argv.size() - 2);
	}
	
	/**
	 *  Returns the score filename parsed from the "Command" element of this.
	 */
	public String getScoFilename()
	{
	    Vector argv = getArgv();
	    return (String) argv.elementAt(argv.size() - 1);
	}
	
	/**
	 *  Sets the command line and starts rendering using csound.
	 */
	public void start()
	{
	    if(filename == null)
	    {
	        return;
	    }
	    csound.setCommand("csound " + filename);
		csound.start();
	}
	
	/**
	 *  Stops rendering with csound.
	 */
	public void stop()
	{
	    csound.stopRunning();
	}

	void setPlayerButton_actionPerformed(java.awt.event.ActionEvent event)
	{
        JFileChooser fileChooser = new JFileChooser("Select soundfiler player");
        if(fileChooser.showOpenDialog(this) == fileChooser.APPROVE_OPTION)
        {
            soundfilePlayer = fileChooser.getSelectedFile().getAbsolutePath();
            saveConfiguration();
            
        }
	}
	
	void loadConfiguration()
	{
        try
        {
            File file = new File("JCsoundManager.cfg");
            FileReader fileReader = new FileReader(file.getAbsolutePath());
            BufferedReader bufferedReader = new BufferedReader(fileReader);
            for(;;)
            {
                String buffer = bufferedReader.readLine();
                if(buffer == null)
                {
                    break;
                }
                String property = buffer.substring(0, buffer.indexOf("=")).trim();
                String value = buffer.substring(buffer.indexOf("=") + 1).trim();
                if(property.compareTo("soundfilePlayer") == 0)
                {
                    soundfilePlayer = value;
                }
            }
            System.out.println("Loaded JCsoundManager options from " + file.getAbsolutePath() + ".");
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
    }
	
	void saveConfiguration()
	{
        try
        {
            File file = new File("JCsoundManager.cfg");
            FileWriter fileWriter = new FileWriter(file.getAbsolutePath());
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            bufferedWriter.write("soundfilePlayer = " + soundfilePlayer + "\n");
            bufferedWriter.close();
            System.out.println("Saved Silence options to " + file.getAbsolutePath() + ".");
        }
        catch(IOException e)
        {
            e.printStackTrace();
        }
	}
}
