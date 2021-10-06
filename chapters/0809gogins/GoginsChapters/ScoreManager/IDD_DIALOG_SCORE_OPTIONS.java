package GoginsChapters.ScoreManager;
//------------------------------------------------------------------------------
// IDD_DIALOG_SCORE_OPTIONS.java:
//		Implementation of "control creator" class IDD_DIALOG_SCORE_OPTIONS
//------------------------------------------------------------------------------
import java.awt.*;

public class IDD_DIALOG_SCORE_OPTIONS
{
	Container    m_Parent       = null;
	boolean      m_fInitialized = false;
	DialogLayout m_Layout;

	// Control definitions
	//--------------------------------------------------------------------------
	Label         IDC_STATIC1;
	TextField     IDC_EDIT_DIVISIONS_PER_OCTAVE;
	Checkbox      IDC_CHECK_USE_EQUAL_TEMPERAMENT;
	Button        IDCANCEL;
	Button        IDOK;


	// Constructor
	//--------------------------------------------------------------------------
	public IDD_DIALOG_SCORE_OPTIONS (Container parent)
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
		m_Layout = new DialogLayout(m_Parent, 114, 66);
		m_Parent.setLayout(m_Layout);
		m_Parent.addNotify();

		Dimension size   = m_Layout.getDialogSize();
		Insets    insets = m_Parent.insets();
		
		m_Parent.resize(insets.left + size.width  + insets.right,
                        insets.top  + size.height + insets.bottom);

		// Control creation
		//----------------------------------------------------------------------
		IDC_STATIC1 = new Label ("Divisions per octave", Label.LEFT);
		m_Parent.add(IDC_STATIC1);
		m_Layout.setShape(IDC_STATIC1, 5, 5, 75, 10);

		IDC_EDIT_DIVISIONS_PER_OCTAVE = new TextField ("");
		m_Parent.add(IDC_EDIT_DIVISIONS_PER_OCTAVE);
		m_Layout.setShape(IDC_EDIT_DIVISIONS_PER_OCTAVE, 85, 5, 25, 15);

		IDC_CHECK_USE_EQUAL_TEMPERAMENT = new Checkbox ("Use equal temperament");
		m_Parent.add(IDC_CHECK_USE_EQUAL_TEMPERAMENT);
		m_Layout.setShape(IDC_CHECK_USE_EQUAL_TEMPERAMENT, 5, 25, 105, 10);

		IDCANCEL = new Button ("Cancel");
		m_Parent.add(IDCANCEL);
		m_Layout.setShape(IDCANCEL, 5, 45, 50, 15);

		IDOK = new Button ("Ok");
		m_Parent.add(IDOK);
		m_Layout.setShape(IDOK, 60, 45, 50, 15);

		m_fInitialized = true;
		return true;
	}
}
