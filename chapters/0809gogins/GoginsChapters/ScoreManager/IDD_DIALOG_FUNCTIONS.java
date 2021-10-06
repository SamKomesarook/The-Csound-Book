package GoginsChapters.ScoreManager;
//------------------------------------------------------------------------------
// IDD_DIALOG_FUNCTIONS.java:
//		Implementation of "control creator" class IDD_DIALOG_FUNCTIONS
//------------------------------------------------------------------------------
import java.awt.*;

public class IDD_DIALOG_FUNCTIONS
{
	Container    m_Parent       = null;
	boolean      m_fInitialized = false;
	DialogLayout m_Layout;

	// Control definitions
	//--------------------------------------------------------------------------
	TextArea      IDC_EDIT_FUNCTIONS;
	Button        IDCANCEL;
	Button        IDOK;


	// Constructor
	//--------------------------------------------------------------------------
	public IDD_DIALOG_FUNCTIONS (Container parent)
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
		m_Layout = new DialogLayout(m_Parent, 344, 225);
		m_Parent.setLayout(m_Layout);
		m_Parent.addNotify();

		Dimension size   = m_Layout.getDialogSize();
		Insets    insets = m_Parent.insets();
		
		m_Parent.resize(insets.left + size.width  + insets.right,
                        insets.top  + size.height + insets.bottom);

		// Control creation
		//----------------------------------------------------------------------
		IDC_EDIT_FUNCTIONS = new TextArea ("");
		m_Parent.add(IDC_EDIT_FUNCTIONS);
		m_Layout.setShape(IDC_EDIT_FUNCTIONS, 5, 5, 335, 195);

		IDCANCEL = new Button ("Cancel");
		m_Parent.add(IDCANCEL);
		m_Layout.setShape(IDCANCEL, 245, 205, 45, 14);

		IDOK = new Button ("Ok");
		m_Parent.add(IDOK);
		m_Layout.setShape(IDOK, 295, 205, 45, 14);

		m_fInitialized = true;
		return true;
	}
}
