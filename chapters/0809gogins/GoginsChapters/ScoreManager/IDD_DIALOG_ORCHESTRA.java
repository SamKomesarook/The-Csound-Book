package GoginsChapters.ScoreManager;
//------------------------------------------------------------------------------
// IDD_DIALOG_ORCHESTRA.java:
//		Implementation of "control creator" class IDD_DIALOG_ORCHESTRA
//------------------------------------------------------------------------------
import java.awt.*;

public class IDD_DIALOG_ORCHESTRA
{
	Container    m_Parent       = null;
	boolean      m_fInitialized = false;
	DialogLayout m_Layout;

	// Control definitions
	//--------------------------------------------------------------------------
	List          IDC_LIST_INSTRUMENT_NAMES;
	Button        IDC_BUTTON_INSTRUMENT_NEW;
	Button        IDC_BUTTON_INSTRUMENT_DELETE;
	Button        IDC_BUTTON_INSTRUMENT_EDIT;
	List          IDC_LIST_ARRANGEMENT_INSTRUMENT_NUMBERS;
	List          IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES;
	Button        IDC_BUTTON_ARRANGEMENT_ADD;
	Button        IDC_BUTTON_ARRANGEMENT_REMOVE;
	Button        IDC_BUTTON_ARRANGEMENT_UP;
	Button        IDC_BUTTON_ARRANGEMENT_DOWN;
	Button        IDOK;
	Label         IDC_STATIC1;
	Label         IDC_STATIC2;


	// Constructor
	//--------------------------------------------------------------------------
	public IDD_DIALOG_ORCHESTRA (Container parent)
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
		IDC_LIST_INSTRUMENT_NAMES = new List (1, false);
		m_Parent.add(IDC_LIST_INSTRUMENT_NAMES);
		m_Layout.setShape(IDC_LIST_INSTRUMENT_NAMES, 5, 15, 115, 150);

		IDC_BUTTON_INSTRUMENT_NEW = new Button ("New");
		m_Parent.add(IDC_BUTTON_INSTRUMENT_NEW);
		m_Layout.setShape(IDC_BUTTON_INSTRUMENT_NEW, 5, 170, 35, 15);

		IDC_BUTTON_INSTRUMENT_DELETE = new Button ("Delete");
		m_Parent.add(IDC_BUTTON_INSTRUMENT_DELETE);
		m_Layout.setShape(IDC_BUTTON_INSTRUMENT_DELETE, 45, 170, 35, 15);

		IDC_BUTTON_INSTRUMENT_EDIT = new Button ("Edit");
		m_Parent.add(IDC_BUTTON_INSTRUMENT_EDIT);
		m_Layout.setShape(IDC_BUTTON_INSTRUMENT_EDIT, 85, 170, 35, 15);

		IDC_LIST_ARRANGEMENT_INSTRUMENT_NUMBERS = new List (1, false);
		m_Parent.add(IDC_LIST_ARRANGEMENT_INSTRUMENT_NUMBERS);
		m_Layout.setShape(IDC_LIST_ARRANGEMENT_INSTRUMENT_NUMBERS, 130, 15, 20, 150);

		IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES = new List (1, false);
		m_Parent.add(IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES);
		m_Layout.setShape(IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES, 155, 15, 130, 150);

		IDC_BUTTON_ARRANGEMENT_ADD = new Button ("Add");
		m_Parent.add(IDC_BUTTON_ARRANGEMENT_ADD);
		m_Layout.setShape(IDC_BUTTON_ARRANGEMENT_ADD, 130, 170, 35, 15);

		IDC_BUTTON_ARRANGEMENT_REMOVE = new Button ("Remove");
		m_Parent.add(IDC_BUTTON_ARRANGEMENT_REMOVE);
		m_Layout.setShape(IDC_BUTTON_ARRANGEMENT_REMOVE, 170, 170, 35, 15);

		IDC_BUTTON_ARRANGEMENT_UP = new Button ("Up");
		m_Parent.add(IDC_BUTTON_ARRANGEMENT_UP);
		m_Layout.setShape(IDC_BUTTON_ARRANGEMENT_UP, 210, 170, 35, 15);

		IDC_BUTTON_ARRANGEMENT_DOWN = new Button ("Down");
		m_Parent.add(IDC_BUTTON_ARRANGEMENT_DOWN);
		m_Layout.setShape(IDC_BUTTON_ARRANGEMENT_DOWN, 250, 170, 35, 15);

		IDOK = new Button ("Close");
		m_Parent.add(IDOK);
		m_Layout.setShape(IDOK, 235, 195, 50, 15);

		IDC_STATIC1 = new Label ("Instruments", Label.CENTER);
		m_Parent.add(IDC_STATIC1);
		m_Layout.setShape(IDC_STATIC1, 5, 5, 115, 10);

		IDC_STATIC2 = new Label ("Arrangement", Label.CENTER);
		m_Parent.add(IDC_STATIC2);
		m_Layout.setShape(IDC_STATIC2, 130, 5, 155, 10);

		m_fInitialized = true;
		return true;
	}
}
