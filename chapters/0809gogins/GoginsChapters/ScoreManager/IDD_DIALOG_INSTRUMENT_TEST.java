package GoginsChapters.ScoreManager;
//------------------------------------------------------------------------------
// IDD_DIALOG_INSTRUMENT_TEST.java:
//		Implementation of "control creator" class IDD_DIALOG_INSTRUMENT_TEST
//------------------------------------------------------------------------------
import java.awt.*;

public class IDD_DIALOG_INSTRUMENT_TEST
{
	Container    m_Parent       = null;
	boolean      m_fInitialized = false;
	DialogLayout m_Layout;

	// Control definitions
	//--------------------------------------------------------------------------
	TextArea      IDC_EDIT_INSTRUMENT_TEST_SCORE;
	Button        IDRENDER;
	Button        IDPLAY;
	Button        IDCANCEL;
	Button        IDOK;
	Label         IDC_STATIC1;


	// Constructor
	//--------------------------------------------------------------------------
	public IDD_DIALOG_INSTRUMENT_TEST (Container parent)
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
		m_Layout = new DialogLayout(m_Parent, 289, 215);
		m_Parent.setLayout(m_Layout);
		m_Parent.addNotify();

		Dimension size   = m_Layout.getDialogSize();
		Insets    insets = m_Parent.insets();
		
		m_Parent.resize(insets.left + size.width  + insets.right,
                        insets.top  + size.height + insets.bottom);

		// Control creation
		//----------------------------------------------------------------------
		IDC_EDIT_INSTRUMENT_TEST_SCORE = new TextArea ("");
		m_Parent.add(IDC_EDIT_INSTRUMENT_TEST_SCORE);
		m_Layout.setShape(IDC_EDIT_INSTRUMENT_TEST_SCORE, 5, 15, 280, 175);

		IDRENDER = new Button ("Render");
		m_Parent.add(IDRENDER);
		m_Layout.setShape(IDRENDER, 5, 195, 45, 15);

		IDPLAY = new Button ("Play");
		m_Parent.add(IDPLAY);
		m_Layout.setShape(IDPLAY, 55, 195, 45, 15);

		IDCANCEL = new Button ("Cancel");
		m_Parent.add(IDCANCEL);
		m_Layout.setShape(IDCANCEL, 190, 195, 45, 15);

		IDOK = new Button ("OK");
		m_Parent.add(IDOK);
		m_Layout.setShape(IDOK, 240, 195, 45, 15);

		IDC_STATIC1 = new Label ("Test score", Label.LEFT);
		m_Parent.add(IDC_STATIC1);
		m_Layout.setShape(IDC_STATIC1, 5, 5, 280, 10);

		m_fInitialized = true;
		return true;
	}
}
