package GoginsChapters.ScoreManager;
//------------------------------------------------------------------------------
// IDD_DIALOG_INSTRUMENT.java:
//		Implementation of "control creator" class IDD_DIALOG_INSTRUMENT
//------------------------------------------------------------------------------
import java.awt.*;

public class IDD_DIALOG_INSTRUMENT
{
	Container    m_Parent       = null;
	boolean      m_fInitialized = false;
	DialogLayout m_Layout;

	// Control definitions
	//--------------------------------------------------------------------------
	TextField     IDC_EDIT_INSTRUMENT_NAME;
	TextArea      IDC_EDIT_INSTRUMENT_DEFINITION;
	Button        IDTEST;
	Button        IDCANCEL;
	Button        IDOK;
	Label         IDC_STATIC1;
	Label         IDC_STATIC2;


	// Constructor
	//--------------------------------------------------------------------------
	public IDD_DIALOG_INSTRUMENT (Container parent)
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
		IDC_EDIT_INSTRUMENT_NAME = new TextField ("");
		m_Parent.add(IDC_EDIT_INSTRUMENT_NAME);
		m_Layout.setShape(IDC_EDIT_INSTRUMENT_NAME, 5, 15, 280, 15);

		IDC_EDIT_INSTRUMENT_DEFINITION = new TextArea ("");
		m_Parent.add(IDC_EDIT_INSTRUMENT_DEFINITION);
		m_Layout.setShape(IDC_EDIT_INSTRUMENT_DEFINITION, 5, 45, 280, 145);

		IDTEST = new Button ("Test");
		m_Parent.add(IDTEST);
		m_Layout.setShape(IDTEST, 5, 195, 50, 15);

		IDCANCEL = new Button ("Cancel");
		m_Parent.add(IDCANCEL);
		m_Layout.setShape(IDCANCEL, 180, 195, 50, 15);

		IDOK = new Button ("Ok");
		m_Parent.add(IDOK);
		m_Layout.setShape(IDOK, 235, 195, 50, 15);

		IDC_STATIC1 = new Label ("Name", Label.LEFT);
		m_Parent.add(IDC_STATIC1);
		m_Layout.setShape(IDC_STATIC1, 5, 5, 70, 10);

		IDC_STATIC2 = new Label ("Definition", Label.LEFT);
		m_Parent.add(IDC_STATIC2);
		m_Layout.setShape(IDC_STATIC2, 5, 35, 70, 10);

		m_fInitialized = true;
		return true;
	}
}
