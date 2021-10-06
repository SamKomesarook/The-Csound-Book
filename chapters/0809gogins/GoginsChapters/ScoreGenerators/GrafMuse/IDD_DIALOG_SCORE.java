package GoginsChapters.ScoreGenerators.GrafMuse;
import GoginsChapters.ScoreManager.*;
//------------------------------------------------------------------------------
// IDD_DIALOG_SCORE.java:
//		Implementation of "control creator" class IDD_DIALOG_SCORE
//------------------------------------------------------------------------------
import java.awt.*;

public class IDD_DIALOG_SCORE
{
	Container    m_Parent       = null;
	boolean      m_fInitialized = false;
	DialogLayout m_Layout;

	// Control definitions
	//--------------------------------------------------------------------------
	Label         IDC_STATIC1;
	TextField     IDC_EDIT_VOICES;
	Label         IDC_STATIC2;
	TextField     IDC_EDIT_INSTRUMENTS;
	Label         IDC_STATIC3;
	TextField     IDC_EDIT_DURATION;
	Label         IDC_STATIC4;
	TextField     IDC_EDIT_DIVISIONSPEROCTAVE;
	Button        ID_TRANSLATE;
	Button        IDCANCEL;
	Button        IDOK;
	Label         IDC_STATIC5;
	TextField     IDC_EDIT_COLUMNSRENDERED;


	// Constructor
	//--------------------------------------------------------------------------
	public IDD_DIALOG_SCORE (Container parent)
	{
		m_Parent = parent;
	}

	// Initialization.
	//--------------------------------------------------------------------------
	public boolean CreateControls()
	{
		// CreateControls should be called only once
		//----------------------------------------------------------------------
		if (m_fInitialized || m_Parent == null)
			return false;

		// m_Parent must be extended from the Container class
		//----------------------------------------------------------------------
		if (!(m_Parent instanceof Container))
			return false;

		// Since a given font may not be supported across all platforms, it
		// is safe to modify only the size of the font, not the typeface.
		//----------------------------------------------------------------------
	    Font OldFnt = m_Parent.getFont();
	    if (OldFnt != null)
	    {
			Font NewFnt = new Font(OldFnt.getName(), OldFnt.getStyle(), 8);

    		m_Parent.setFont(NewFnt);
	    }

		// All position and sizes are in dialog logical units, so we use a
		// DialogLayout as our layout manager.
		//----------------------------------------------------------------------
		m_Layout = new DialogLayout(m_Parent, 184, 131);
		m_Parent.setLayout(m_Layout);
		m_Parent.addNotify();

		Dimension size   = m_Layout.getDialogSize();
		Insets    insets = m_Parent.insets();
		
		m_Parent.resize(insets.left + size.width  + insets.right,
                        insets.top  + size.height + insets.bottom);

		// Control creation
		//----------------------------------------------------------------------
		IDC_STATIC1 = new Label ("Voices", Label.LEFT);
		m_Parent.add(IDC_STATIC1);
		m_Layout.setShape(IDC_STATIC1, 5, 5, 45, 15);

		IDC_EDIT_VOICES = new TextField ("");
		m_Parent.add(IDC_EDIT_VOICES);
		m_Layout.setShape(IDC_EDIT_VOICES, 125, 5, 55, 15);

		IDC_STATIC2 = new Label ("Instruments", Label.LEFT);
		m_Parent.add(IDC_STATIC2);
		m_Layout.setShape(IDC_STATIC2, 5, 25, 45, 15);

		IDC_EDIT_INSTRUMENTS = new TextField ("");
		m_Parent.add(IDC_EDIT_INSTRUMENTS);
		m_Layout.setShape(IDC_EDIT_INSTRUMENTS, 125, 25, 55, 15);

		IDC_STATIC3 = new Label ("Duration (seconds)", Label.LEFT);
		m_Parent.add(IDC_STATIC3);
		m_Layout.setShape(IDC_STATIC3, 5, 45, 90, 15);

		IDC_EDIT_DURATION = new TextField ("");
		m_Parent.add(IDC_EDIT_DURATION);
		m_Layout.setShape(IDC_EDIT_DURATION, 125, 45, 55, 15);

		IDC_STATIC4 = new Label ("Divisions per octave", Label.LEFT);
		m_Parent.add(IDC_STATIC4);
		m_Layout.setShape(IDC_STATIC4, 5, 65, 90, 15);

		IDC_EDIT_DIVISIONSPEROCTAVE = new TextField ("");
		m_Parent.add(IDC_EDIT_DIVISIONSPEROCTAVE);
		m_Layout.setShape(IDC_EDIT_DIVISIONSPEROCTAVE, 125, 65, 55, 15);

		ID_TRANSLATE = new Button ("Render score");
		m_Parent.add(ID_TRANSLATE);
		m_Layout.setShape(ID_TRANSLATE, 5, 110, 55, 14);

		IDCANCEL = new Button ("Cancel");
		m_Parent.add(IDCANCEL);
		m_Layout.setShape(IDCANCEL, 65, 110, 55, 14);

		IDOK = new Button ("OK");
		m_Parent.add(IDOK);
		m_Layout.setShape(IDOK, 125, 110, 55, 14);

		IDC_STATIC5 = new Label ("Columns rendered", Label.LEFT);
		m_Parent.add(IDC_STATIC5);
		m_Layout.setShape(IDC_STATIC5, 5, 85, 90, 15);

		IDC_EDIT_COLUMNSRENDERED = new TextField ("");
		m_Parent.add(IDC_EDIT_COLUMNSRENDERED);
		m_Layout.setShape(IDC_EDIT_COLUMNSRENDERED, 125, 85, 55, 15);

		m_fInitialized = true;
		return true;
	}
}
