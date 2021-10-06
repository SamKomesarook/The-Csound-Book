package GoginsChapters.ScoreManager;
//------------------------------------------------------------------------------
// IDD_DIALOG_NOTE_SCALE.java:
//		Implementation of "control creator" class IDD_DIALOG_NOTE_SCALE
//------------------------------------------------------------------------------
import java.awt.*;

public class IDD_DIALOG_NOTE_SCALE
{
	Container    m_Parent       = null;
	boolean      m_fInitialized = false;
	DialogLayout m_Layout;

	// Control definitions
	//--------------------------------------------------------------------------
	Label         IDC_STATIC1;
	Label         IDC_STATIC2;
	Label         IDC_STATIC3;
	Label         IDC_STATIC4;
	Label         IDC_STATIC5;
	Label         IDC_STATIC6;
	Label         IDC_STATIC7;
	Label         IDC_STATIC8;
	TextField     IDC_EDIT1;
	TextField     IDC_EDIT7;
	TextField     IDC_EDIT2;
	TextField     IDC_EDIT8;
	TextField     IDC_EDIT3;
	TextField     IDC_EDIT9;
	TextField     IDC_EDIT4;
	TextField     IDC_EDIT10;
	TextField     IDC_EDIT5;
	TextField     IDC_EDIT11;
	TextField     IDC_EDIT6;
	TextField     IDC_EDIT12;
	Button        IDSCALETARGETTOACTUAL;
	Label         IDC_STATIC9;
	Label         IDC_STATIC10;
	TextField     IDC_EDIT13;
	TextField     IDC_EDIT19;
	TextField     IDC_EDIT14;
	TextField     IDC_EDIT20;
	TextField     IDC_EDIT15;
	TextField     IDC_EDIT21;
	TextField     IDC_EDIT16;
	TextField     IDC_EDIT22;
	TextField     IDC_EDIT17;
	TextField     IDC_EDIT23;
	TextField     IDC_EDIT18;
	TextField     IDC_EDIT24;
	Button        IDSCALEACTUALTOTARGET;
	Button        IDCANCEL;
	Button        IDOK;
	Label         IDC_STATIC11;
	Label         IDC_STATIC12;


	// Constructor
	//--------------------------------------------------------------------------
	public IDD_DIALOG_NOTE_SCALE (Container parent)
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
		m_Layout = new DialogLayout(m_Parent, 299, 197);
		m_Parent.setLayout(m_Layout);
		m_Parent.addNotify();

		Dimension size   = m_Layout.getDialogSize();
		Insets    insets = m_Parent.insets();
		
		m_Parent.resize(insets.left + size.width  + insets.right,
                        insets.top  + size.height + insets.bottom);

		// Control creation
		//----------------------------------------------------------------------
		IDC_STATIC1 = new Label ("Instrument", Label.LEFT);
		m_Parent.add(IDC_STATIC1);
		m_Layout.setShape(IDC_STATIC1, 5, 30, 70, 10);

		IDC_STATIC2 = new Label ("Time (seconds)", Label.LEFT);
		m_Parent.add(IDC_STATIC2);
		m_Layout.setShape(IDC_STATIC2, 5, 50, 70, 10);

		IDC_STATIC3 = new Label ("Length (seconds)", Label.LEFT);
		m_Parent.add(IDC_STATIC3);
		m_Layout.setShape(IDC_STATIC3, 5, 70, 70, 10);

		IDC_STATIC4 = new Label ("Octave (middle C = 8.0)", Label.LEFT);
		m_Parent.add(IDC_STATIC4);
		m_Layout.setShape(IDC_STATIC4, 5, 90, 85, 10);

		IDC_STATIC5 = new Label ("Decibels (loudest = 96)", Label.LEFT);
		m_Parent.add(IDC_STATIC5);
		m_Layout.setShape(IDC_STATIC5, 5, 110, 85, 10);

		IDC_STATIC6 = new Label ("Pan (-1.0 to +1.0)", Label.LEFT);
		m_Parent.add(IDC_STATIC6);
		m_Layout.setShape(IDC_STATIC6, 5, 130, 70, 10);

		IDC_STATIC7 = new Label ("Minimum", Label.CENTER);
		m_Parent.add(IDC_STATIC7);
		m_Layout.setShape(IDC_STATIC7, 90, 20, 45, 10);

		IDC_STATIC8 = new Label ("Range", Label.CENTER);
		m_Parent.add(IDC_STATIC8);
		m_Layout.setShape(IDC_STATIC8, 140, 20, 45, 10);

		IDC_EDIT1 = new TextField ("");
		m_Parent.add(IDC_EDIT1);
		m_Layout.setShape(IDC_EDIT1, 90, 30, 45, 15);

		IDC_EDIT7 = new TextField ("");
		m_Parent.add(IDC_EDIT7);
		m_Layout.setShape(IDC_EDIT7, 140, 30, 45, 15);

		IDC_EDIT2 = new TextField ("");
		m_Parent.add(IDC_EDIT2);
		m_Layout.setShape(IDC_EDIT2, 90, 50, 45, 15);

		IDC_EDIT8 = new TextField ("");
		m_Parent.add(IDC_EDIT8);
		m_Layout.setShape(IDC_EDIT8, 140, 50, 45, 15);

		IDC_EDIT3 = new TextField ("");
		m_Parent.add(IDC_EDIT3);
		m_Layout.setShape(IDC_EDIT3, 90, 70, 45, 15);

		IDC_EDIT9 = new TextField ("");
		m_Parent.add(IDC_EDIT9);
		m_Layout.setShape(IDC_EDIT9, 140, 70, 45, 15);

		IDC_EDIT4 = new TextField ("");
		m_Parent.add(IDC_EDIT4);
		m_Layout.setShape(IDC_EDIT4, 90, 90, 45, 15);

		IDC_EDIT10 = new TextField ("");
		m_Parent.add(IDC_EDIT10);
		m_Layout.setShape(IDC_EDIT10, 140, 90, 45, 15);

		IDC_EDIT5 = new TextField ("");
		m_Parent.add(IDC_EDIT5);
		m_Layout.setShape(IDC_EDIT5, 90, 110, 45, 15);

		IDC_EDIT11 = new TextField ("");
		m_Parent.add(IDC_EDIT11);
		m_Layout.setShape(IDC_EDIT11, 140, 110, 45, 15);

		IDC_EDIT6 = new TextField ("");
		m_Parent.add(IDC_EDIT6);
		m_Layout.setShape(IDC_EDIT6, 90, 130, 45, 15);

		IDC_EDIT12 = new TextField ("");
		m_Parent.add(IDC_EDIT12);
		m_Layout.setShape(IDC_EDIT12, 140, 130, 45, 15);

		IDSCALETARGETTOACTUAL = new Button ("Scale target to actual");
		m_Parent.add(IDSCALETARGETTOACTUAL);
		m_Layout.setShape(IDSCALETARGETTOACTUAL, 90, 150, 95, 15);

		IDC_STATIC9 = new Label ("Minimum", Label.CENTER);
		m_Parent.add(IDC_STATIC9);
		m_Layout.setShape(IDC_STATIC9, 200, 20, 45, 10);

		IDC_STATIC10 = new Label ("Range", Label.CENTER);
		m_Parent.add(IDC_STATIC10);
		m_Layout.setShape(IDC_STATIC10, 250, 20, 45, 10);

		IDC_EDIT13 = new TextField ("");
		m_Parent.add(IDC_EDIT13);
		m_Layout.setShape(IDC_EDIT13, 200, 30, 45, 15);

		IDC_EDIT19 = new TextField ("");
		m_Parent.add(IDC_EDIT19);
		m_Layout.setShape(IDC_EDIT19, 250, 30, 45, 15);

		IDC_EDIT14 = new TextField ("");
		m_Parent.add(IDC_EDIT14);
		m_Layout.setShape(IDC_EDIT14, 200, 50, 45, 15);

		IDC_EDIT20 = new TextField ("");
		m_Parent.add(IDC_EDIT20);
		m_Layout.setShape(IDC_EDIT20, 250, 50, 45, 15);

		IDC_EDIT15 = new TextField ("");
		m_Parent.add(IDC_EDIT15);
		m_Layout.setShape(IDC_EDIT15, 200, 70, 45, 15);

		IDC_EDIT21 = new TextField ("");
		m_Parent.add(IDC_EDIT21);
		m_Layout.setShape(IDC_EDIT21, 250, 70, 45, 15);

		IDC_EDIT16 = new TextField ("");
		m_Parent.add(IDC_EDIT16);
		m_Layout.setShape(IDC_EDIT16, 200, 90, 45, 15);

		IDC_EDIT22 = new TextField ("");
		m_Parent.add(IDC_EDIT22);
		m_Layout.setShape(IDC_EDIT22, 250, 90, 45, 15);

		IDC_EDIT17 = new TextField ("");
		m_Parent.add(IDC_EDIT17);
		m_Layout.setShape(IDC_EDIT17, 200, 110, 45, 15);

		IDC_EDIT23 = new TextField ("");
		m_Parent.add(IDC_EDIT23);
		m_Layout.setShape(IDC_EDIT23, 250, 110, 45, 15);

		IDC_EDIT18 = new TextField ("");
		m_Parent.add(IDC_EDIT18);
		m_Layout.setShape(IDC_EDIT18, 200, 130, 45, 15);

		IDC_EDIT24 = new TextField ("");
		m_Parent.add(IDC_EDIT24);
		m_Layout.setShape(IDC_EDIT24, 250, 130, 45, 15);

		IDSCALEACTUALTOTARGET = new Button ("Scale actual to target");
		m_Parent.add(IDSCALEACTUALTOTARGET);
		m_Layout.setShape(IDSCALEACTUALTOTARGET, 200, 150, 95, 15);

		IDCANCEL = new Button ("Cancel");
		m_Parent.add(IDCANCEL);
		m_Layout.setShape(IDCANCEL, 200, 175, 45, 15);

		IDOK = new Button ("Ok");
		m_Parent.add(IDOK);
		m_Layout.setShape(IDOK, 250, 175, 45, 15);

		IDC_STATIC11 = new Label ("Target", Label.CENTER);
		m_Parent.add(IDC_STATIC11);
		m_Layout.setShape(IDC_STATIC11, 90, 5, 95, 10);

		IDC_STATIC12 = new Label ("Actual", Label.CENTER);
		m_Parent.add(IDC_STATIC12);
		m_Layout.setShape(IDC_STATIC12, 200, 5, 95, 10);

		m_fInitialized = true;
		return true;
	}
}
