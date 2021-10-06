package GoginsChapters.ScoreManager;
//------------------------------------------------------------------------------
// IDR_MENU.java:
//		Implementation for menu creation class IDR_MENU
//
//------------------------------------------------------------------------------
import java.awt.*;

public class IDR_MENU
{
	Frame   m_Frame        = null;
	boolean m_fInitialized = false;

	// MenuBar definitions
	//--------------------------------------------------------------------------
	MenuBar mb;

	// Menu and Menu item definitions
	//--------------------------------------------------------------------------
	Menu m1;	// Score
	MenuItem ID_SCORE_NEWSCORE;	// New score...
	MenuItem ID_SCORE_OPENSCORE;	// Open score...
	MenuItem ID_SCORE_SAVESCORE;	// Save score
	MenuItem ID_SCORE_SAVESCOREAS;	// Save score as...
	MenuItem m6;	// Separator
	MenuItem ID_SCORE_IMPORTSCORE;	// Import score...
	MenuItem ID_SCORE_EXPORTSCORE;	// Export score...
	MenuItem m9;	// Separator
	MenuItem ID_SCORE_EXIT;	// Exit...
	Menu m11;	// Functions
	MenuItem ID_FUNCTIONS_EDITFUNCTIONS;	// Edit functions...
	MenuItem ID_FUNCTIONS_DELETEALLFUNCTIONS;	// Delete all functions
	MenuItem m14;	// Separator
	MenuItem ID_FUNCTIONS_IMPORTFUNCTIONS;	// Import functions...
	MenuItem ID_FUNCTIONS_EXPORTFUNCTIONS;	// Export functions...
	Menu m17;	// Orchestra
	MenuItem ID_ORCHESTRA_EDITORCHESTRA;	// Edit orchestra...
	MenuItem ID_ORCHESTRA_DELETEORCHESTRA;	// Delete all instruments
	MenuItem m20;	// Separator
	MenuItem ID_ORCHESTRA_IMPORTORCHESTRA;	// Import orchestra...
	MenuItem ID_ORCHESTRA_EXPORTORCHESTRA;	// Export orchestra...
	Menu m23;	// Notes
	MenuItem ID_NOTES_EDITNOTES;	// Edit notes...
	MenuItem ID_NOTES_DELETEALLNOTES;	// Delete all notes
	MenuItem m26;	// Separator
	MenuItem ID_NOTES_SCALE;	// Scale...
	MenuItem ID_NOTES_RESCALEACTUALTOTARGET;	// Rescale actual to target
	MenuItem m29;	// Separator
	MenuItem ID_NOTES_IMPORTNOTES;	// Import notes...
	MenuItem ID_NOTES_EXPORTNOTES;	// Export notes...
	MenuItem m32;	// Separator
	MenuItem ID_NOTES_SCOREOPTIONS;	// Score options...
	Menu m40;   // Midifile
	MenuItem ID_MIDIFILE_PLAYMIDIFILE;      // Play midifile...
	MenuItem ID_MIDIFILE_EDITMIDIFILE;      // Edit midifile...
	MenuItem m41;   // Separator
	MenuItem ID_MIDIFILE_IMPORTMIDIFILE;    // Import midifile...
	MenuItem ID_MIDIFILE_EXPORTMIDIFILE;    // Export midifile...
	Menu m34;	// Soundfile
	MenuItem ID_SOUNDFILE_RENDERSOUNDFILE;	// Render soundfile...
	MenuItem ID_SOUNDFILE_STOPRENDERING;	// Stop rendering
	MenuItem m37;	// Separator
	MenuItem ID_SOUNDFILE_PLAYSOUNDFILE;	// Play soundfile...
	MenuItem ID_SOUNDFILE_EDITSOUNDFILE;	// Edit soundfile...
	MenuItem m39;	// Separator
	MenuItem ID_SOUNDFILE_SOUNDFILEOPTIONS;	// Soundfile options...

	// Constructor
	//--------------------------------------------------------------------------
	public IDR_MENU (Frame frame)
	{
		m_Frame = frame;
	}

	// Initialization.
	//--------------------------------------------------------------------------
	public boolean CreateMenu()
	{
		// Can only init controls once
		//----------------------------------------------------------------------
		if (m_fInitialized || m_Frame == null)
			return false;

		// Create menubar and attach to the frame
		//----------------------------------------------------------------------
		mb = new MenuBar();
		m_Frame.setMenuBar(mb);

		// Create menu and menu items and assign to menubar
		//----------------------------------------------------------------------
		m1 = new Menu("Score");
		mb.add(m1);
			ID_SCORE_NEWSCORE = new MenuItem("New score...");
			m1.add(ID_SCORE_NEWSCORE);
			ID_SCORE_OPENSCORE = new MenuItem("Open score...");
			m1.add(ID_SCORE_OPENSCORE);
			ID_SCORE_SAVESCORE = new MenuItem("Save score");
			m1.add(ID_SCORE_SAVESCORE);
			ID_SCORE_SAVESCOREAS = new MenuItem("Save score as...");
			m1.add(ID_SCORE_SAVESCOREAS);
			m6 = new MenuItem("-");
			m1.add(m6);
			ID_SCORE_IMPORTSCORE = new MenuItem("Import score...");
			m1.add(ID_SCORE_IMPORTSCORE);
			ID_SCORE_EXPORTSCORE = new MenuItem("Export score...");
			m1.add(ID_SCORE_EXPORTSCORE);
			m9 = new MenuItem("-");
			m1.add(m9);
			ID_SCORE_EXIT = new MenuItem("Exit...");
			m1.add(ID_SCORE_EXIT);
		m11 = new Menu("Functions");
		mb.add(m11);
			ID_FUNCTIONS_EDITFUNCTIONS = new MenuItem("Edit functions...");
			m11.add(ID_FUNCTIONS_EDITFUNCTIONS);
			ID_FUNCTIONS_DELETEALLFUNCTIONS = new MenuItem("Delete all functions");
			m11.add(ID_FUNCTIONS_DELETEALLFUNCTIONS);
			m14 = new MenuItem("-");
			m11.add(m14);
			ID_FUNCTIONS_IMPORTFUNCTIONS = new MenuItem("Import functions...");
			m11.add(ID_FUNCTIONS_IMPORTFUNCTIONS);
			ID_FUNCTIONS_EXPORTFUNCTIONS = new MenuItem("Export functions...");
			m11.add(ID_FUNCTIONS_EXPORTFUNCTIONS);
		m17 = new Menu("Orchestra");
		mb.add(m17);
			ID_ORCHESTRA_EDITORCHESTRA = new MenuItem("Edit orchestra...");
			m17.add(ID_ORCHESTRA_EDITORCHESTRA);
			ID_ORCHESTRA_DELETEORCHESTRA = new MenuItem("Delete all instruments");
			m17.add(ID_ORCHESTRA_DELETEORCHESTRA);
			m20 = new MenuItem("-");
			m17.add(m20);
			ID_ORCHESTRA_IMPORTORCHESTRA = new MenuItem("Import orchestra...");
			m17.add(ID_ORCHESTRA_IMPORTORCHESTRA);
			ID_ORCHESTRA_EXPORTORCHESTRA = new MenuItem("Export orchestra...");
			m17.add(ID_ORCHESTRA_EXPORTORCHESTRA);
		m23 = new Menu("Notes");
		mb.add(m23);
			ID_NOTES_EDITNOTES = new MenuItem("Edit notes...");
			m23.add(ID_NOTES_EDITNOTES);
			ID_NOTES_DELETEALLNOTES = new MenuItem("Delete all notes");
			m23.add(ID_NOTES_DELETEALLNOTES);
			m26 = new MenuItem("-");
			m23.add(m26);
			ID_NOTES_SCALE = new MenuItem("Scale...");
			m23.add(ID_NOTES_SCALE);
			ID_NOTES_RESCALEACTUALTOTARGET = new MenuItem("Rescale actual to target");
			m23.add(ID_NOTES_RESCALEACTUALTOTARGET);
			m29 = new MenuItem("-");
			m23.add(m29);
			ID_NOTES_IMPORTNOTES = new MenuItem("Import notes...");
			m23.add(ID_NOTES_IMPORTNOTES);
			ID_NOTES_EXPORTNOTES = new MenuItem("Export notes...");
			m23.add(ID_NOTES_EXPORTNOTES);
			m32 = new MenuItem("-");
			m23.add(m32);
			ID_NOTES_SCOREOPTIONS = new MenuItem("Score options...");
			m23.add(ID_NOTES_SCOREOPTIONS);
		m40 = new Menu("Midifile");
		mb.add(m40);
		    ID_MIDIFILE_PLAYMIDIFILE = new MenuItem("Play midifile...");
		    m40.add(ID_MIDIFILE_PLAYMIDIFILE);
		    ID_MIDIFILE_EDITMIDIFILE = new MenuItem("Edit midifile...");
			m40.add(ID_MIDIFILE_EDITMIDIFILE);
		    m41 = new MenuItem("-");
		    m40.add(m41);
		    ID_MIDIFILE_IMPORTMIDIFILE = new MenuItem("Import midifile...");
		    m40.add(ID_MIDIFILE_IMPORTMIDIFILE);
		    ID_MIDIFILE_EXPORTMIDIFILE = new MenuItem("Export midifile...");
		    m40.add(ID_MIDIFILE_EXPORTMIDIFILE);
		m34 = new Menu("Soundfile");
		mb.add(m34);
			ID_SOUNDFILE_RENDERSOUNDFILE = new MenuItem("Render soundfile...");
			m34.add(ID_SOUNDFILE_RENDERSOUNDFILE);
			ID_SOUNDFILE_STOPRENDERING = new MenuItem("Stop rendering");
			m34.add(ID_SOUNDFILE_STOPRENDERING);
			m37 = new MenuItem("-");
			m34.add(m37);
			ID_SOUNDFILE_PLAYSOUNDFILE = new MenuItem("Play soundfile...");
			m34.add(ID_SOUNDFILE_PLAYSOUNDFILE);
			ID_SOUNDFILE_EDITSOUNDFILE = new MenuItem("Edit soundfile...");
			m34.add(ID_SOUNDFILE_EDITSOUNDFILE);
			m39 = new MenuItem("-");
			m34.add(m39);
			ID_SOUNDFILE_SOUNDFILEOPTIONS = new MenuItem("Soundfile options...");
			m34.add(ID_SOUNDFILE_SOUNDFILEOPTIONS);
		m_fInitialized = true;
		return true;
	}
}
