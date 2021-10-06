package GoginsChapters.ScoreManager;
//------------------------------------------------------------------------------
// IDD_DIALOG_NOTE.java:
//		Implementation of "control creator" class IDD_DIALOG_NOTE
//------------------------------------------------------------------------------
import java.awt.*;

public class IDD_DIALOG_NOTE
{
	Container    m_Parent       = null;
	boolean      m_fInitialized = false;
	DialogLayout m_Layout;

	// Control definitions
	//--------------------------------------------------------------------------
	TextArea      IDC_EDIT_NOTE;
	Button        IDADD;
	Button        IDUPDATE;
	Button        IDFIRST;
	Button        IDPREVIOUS;
	Button        IDNEXT;
	Button        IDLAST;
	Button        IDDELETE;
	Button        IDGOTO;
	TextField     IDC_EDIT_NOTE_SUBSCRIPT;
	Label         IDC_STATIC1;
	TextField     IDC_EDIT_NOTE_COUNT;
	Button        IDOK;


	// Constructor
	//--------------------------------------------------------------------------
	public IDD_DIALOG_NOTE (Container parent)
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
		m_Layout = new DialogLayout(m_Parent, 284, 90);
		m_Parent.setLayout(m_Layout);
		m_Parent.addNotify();

		Dimension size   = m_Layout.getDialogSize();
		Insets    insets = m_Parent.insets();
		
		m_Parent.resize(insets.left + size.width  + insets.right,
                        insets.top  + size.height + insets.bottom);

		// Control creation
		//----------------------------------------------------------------------
		IDC_EDIT_NOTE = new TextArea ("");
		m_Parent.add(IDC_EDIT_NOTE);
		m_Layout.setShape(IDC_EDIT_NOTE, 5, 5, 275, 35);

		IDADD = new Button ("Add");
		m_Parent.add(IDADD);
		m_Layout.setShape(IDADD, 5, 45, 35, 15);

		IDUPDATE = new Button ("Update");
		m_Parent.add(IDUPDATE);
		m_Layout.setShape(IDUPDATE, 45, 45, 35, 15);

		IDFIRST = new Button ("First");
		m_Parent.add(IDFIRST);
		m_Layout.setShape(IDFIRST, 85, 45, 35, 15);

		IDPREVIOUS = new Button ("Previous");
		m_Parent.add(IDPREVIOUS);
		m_Layout.setShape(IDPREVIOUS, 125, 45, 35, 15);

		IDNEXT = new Button ("Next");
		m_Parent.add(IDNEXT);
		m_Layout.setShape(IDNEXT, 165, 45, 35, 15);

		IDLAST = new Button ("Last");
		m_Parent.add(IDLAST);
		m_Layout.setShape(IDLAST, 205, 45, 35, 15);

		IDDELETE = new Button ("Delete");
		m_Parent.add(IDDELETE);
		m_Layout.setShape(IDDELETE, 245, 45, 35, 15);

		IDGOTO = new Button ("Goto");
		m_Parent.add(IDGOTO);
		m_Layout.setShape(IDGOTO, 5, 70, 35, 15);

		IDC_EDIT_NOTE_SUBSCRIPT = new TextField ("");
		m_Parent.add(IDC_EDIT_NOTE_SUBSCRIPT);
		m_Layout.setShape(IDC_EDIT_NOTE_SUBSCRIPT, 45, 70, 45, 15);

		IDC_STATIC1 = new Label ("of", Label.CENTER);
		m_Parent.add(IDC_STATIC1);
		m_Layout.setShape(IDC_STATIC1, 95, 70, 10, 15);

		IDC_EDIT_NOTE_COUNT = new TextField ("");
		m_Parent.add(IDC_EDIT_NOTE_COUNT);
		m_Layout.setShape(IDC_EDIT_NOTE_COUNT, 110, 70, 45, 15);

		IDOK = new Button ("Close");
		m_Parent.add(IDOK);
		m_Layout.setShape(IDOK, 235, 70, 45, 15);

		m_fInitialized = true;
		return true;
	}
}
