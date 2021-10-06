package GoginsChapters.ScoreManager;
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1997 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	A platform-independent graphical user interface for Csound.
import java.awt.*;

class DialogNoteScale extends Dialog
{
	ScoreManager scoreManager;
	IDD_DIALOG_NOTE_SCALE iddDialog;
	int NoteSubscript;

	DialogNoteScale(ScoreManagerFrame frame)
	{
		super(frame, "Note scale", true);
		scoreManager = frame.scoreManager;
		setBackground(Color.lightGray);
		iddDialog = new IDD_DIALOG_NOTE_SCALE(this);
		iddDialog.CreateControls();
		move(50, 50);
		iddDialog.IDC_EDIT13.setEditable(false);
		iddDialog.IDC_EDIT14.setEditable(false);
		iddDialog.IDC_EDIT15.setEditable(false);
		iddDialog.IDC_EDIT16.setEditable(false);
		iddDialog.IDC_EDIT17.setEditable(false);
		iddDialog.IDC_EDIT18.setEditable(false);
		iddDialog.IDC_EDIT19.setEditable(false);
		iddDialog.IDC_EDIT20.setEditable(false);
		iddDialog.IDC_EDIT21.setEditable(false);
		iddDialog.IDC_EDIT22.setEditable(false);
		iddDialog.IDC_EDIT23.setEditable(false);
		iddDialog.IDC_EDIT24.setEditable(false);
		scoreManager.scaleActualFind();
		setText();
	}

	void setText()
	{
		iddDialog.IDC_EDIT1.setText(String.valueOf(scoreManager.scaleTargetMinima.elementAt(0)));
		iddDialog.IDC_EDIT2.setText(String.valueOf(scoreManager.scaleTargetMinima.elementAt(1)));
		iddDialog.IDC_EDIT3.setText(String.valueOf(scoreManager.scaleTargetMinima.elementAt(2)));
		iddDialog.IDC_EDIT4.setText(String.valueOf(scoreManager.scaleTargetMinima.elementAt(3)));
		iddDialog.IDC_EDIT5.setText(String.valueOf(scoreManager.scaleTargetMinima.elementAt(4)));
		iddDialog.IDC_EDIT6.setText(String.valueOf(scoreManager.scaleTargetMinima.elementAt(5)));
		iddDialog.IDC_EDIT7.setText(String.valueOf(scoreManager.scaleTargetRanges.elementAt(0)));
		iddDialog.IDC_EDIT8.setText(String.valueOf(scoreManager.scaleTargetRanges.elementAt(1)));
		iddDialog.IDC_EDIT9.setText(String.valueOf(scoreManager.scaleTargetRanges.elementAt(2)));
		iddDialog.IDC_EDIT10.setText(String.valueOf(scoreManager.scaleTargetRanges.elementAt(3)));
		iddDialog.IDC_EDIT11.setText(String.valueOf(scoreManager.scaleTargetRanges.elementAt(4)));
		iddDialog.IDC_EDIT12.setText(String.valueOf(scoreManager.scaleTargetRanges.elementAt(5)));
		iddDialog.IDC_EDIT13.setText(String.valueOf(scoreManager.scaleActualMinima.elementAt(0)));
		iddDialog.IDC_EDIT14.setText(String.valueOf(scoreManager.scaleActualMinima.elementAt(1)));
		iddDialog.IDC_EDIT15.setText(String.valueOf(scoreManager.scaleActualMinima.elementAt(2)));
		iddDialog.IDC_EDIT16.setText(String.valueOf(scoreManager.scaleActualMinima.elementAt(3)));
		iddDialog.IDC_EDIT17.setText(String.valueOf(scoreManager.scaleActualMinima.elementAt(4)));
		iddDialog.IDC_EDIT18.setText(String.valueOf(scoreManager.scaleActualMinima.elementAt(5)));
		iddDialog.IDC_EDIT19.setText(String.valueOf(scoreManager.scaleActualRanges.elementAt(0)));
		iddDialog.IDC_EDIT20.setText(String.valueOf(scoreManager.scaleActualRanges.elementAt(1)));
		iddDialog.IDC_EDIT21.setText(String.valueOf(scoreManager.scaleActualRanges.elementAt(2)));
		iddDialog.IDC_EDIT22.setText(String.valueOf(scoreManager.scaleActualRanges.elementAt(3)));
		iddDialog.IDC_EDIT23.setText(String.valueOf(scoreManager.scaleActualRanges.elementAt(4)));
		iddDialog.IDC_EDIT24.setText(String.valueOf(scoreManager.scaleActualRanges.elementAt(5)));
	}

	void getText()
	{
		scoreManager.scaleTargetMinima.setElementAt(Double.valueOf(iddDialog.IDC_EDIT1.getText()).doubleValue(), 0);
		scoreManager.scaleTargetMinima.setElementAt(Double.valueOf(iddDialog.IDC_EDIT2.getText()).doubleValue(), 1);
		scoreManager.scaleTargetMinima.setElementAt(Double.valueOf(iddDialog.IDC_EDIT3.getText()).doubleValue(), 2);
		scoreManager.scaleTargetMinima.setElementAt(Double.valueOf(iddDialog.IDC_EDIT4.getText()).doubleValue(), 3);
		scoreManager.scaleTargetMinima.setElementAt(Double.valueOf(iddDialog.IDC_EDIT5.getText()).doubleValue(), 4);
		scoreManager.scaleTargetMinima.setElementAt(Double.valueOf(iddDialog.IDC_EDIT6.getText()).doubleValue(), 5);
		scoreManager.scaleTargetRanges.setElementAt(Double.valueOf(iddDialog.IDC_EDIT7.getText()).doubleValue(), 0);
		scoreManager.scaleTargetRanges.setElementAt(Double.valueOf(iddDialog.IDC_EDIT8.getText()).doubleValue(), 1);
		scoreManager.scaleTargetRanges.setElementAt(Double.valueOf(iddDialog.IDC_EDIT9.getText()).doubleValue(), 2);
		scoreManager.scaleTargetRanges.setElementAt(Double.valueOf(iddDialog.IDC_EDIT10.getText()).doubleValue(), 3);
		scoreManager.scaleTargetRanges.setElementAt(Double.valueOf(iddDialog.IDC_EDIT11.getText()).doubleValue(), 4);
		scoreManager.scaleTargetRanges.setElementAt(Double.valueOf(iddDialog.IDC_EDIT12.getText()).doubleValue(), 5);
	}

	public boolean handleEvent(Event event)
	{
		switch(event.id)
		{
			case Event.WINDOW_DESTROY:
				hide();
				return true;
			case Event.ACTION_EVENT:
				if(event.target instanceof Button)
				{
					String string = ((Button)event.target).getLabel();
					if(string.equals("Ok"))
					{
						getText();
						hide();
						return true;
					}
					else if(string.equals("Cancel"))
					{
						hide();
						return true;
					}
					else if(string.equals("Scale target to actual"))
					{
						scoreManager.scaleTargetToActualSet();
						setText();
						repaint();
						return true;
					}
					else if(string.equals("Scale actual to target"))
					{
						getText();
						scoreManager.scaleActualToTargetSet();
						setText();
						return true;
					}
				}
			}
		return super.handleEvent(event);
	}
}