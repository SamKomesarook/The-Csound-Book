package GoginsChapters.ScoreManager;
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1997 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	A platform-independent graphical user interface for Csound.
import java.awt.*;

class DialogScoreOptions extends Dialog
{
	ScoreManager scoreManager;
	ScoreManagerFrame ScoreManagerFrame;
	IDD_DIALOG_SCORE_OPTIONS iddDialog;
	int NoteSubscript;

	DialogScoreOptions(ScoreManagerFrame frame)
	{
		super(frame, "Score options", true);
		ScoreManagerFrame = frame;
		scoreManager = frame.scoreManager;
		setBackground(Color.lightGray);
		iddDialog = new IDD_DIALOG_SCORE_OPTIONS(this);
		iddDialog.CreateControls();
		move(50, 50);
		setText();
	}

	void setText()
	{
		iddDialog.IDC_EDIT_DIVISIONS_PER_OCTAVE.setText(scoreManager.scoreOptions.getProperty("DivisionsPerOctave"));
		Boolean buffer = Boolean.valueOf(scoreManager.scoreOptions.getProperty("UseEqualTemperament"));
		iddDialog.IDC_CHECK_USE_EQUAL_TEMPERAMENT.setState(buffer.booleanValue());
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
						scoreManager.scoreOptions.put("DivisionsPerOctave", iddDialog.IDC_EDIT_DIVISIONS_PER_OCTAVE.getText());
						scoreManager.scoreOptions.put("UseEqualTemperament", String.valueOf(iddDialog.IDC_CHECK_USE_EQUAL_TEMPERAMENT.getState()));
						hide();
						return true;
					}
					else if(string.equals("Cancel"))
					{
						hide();
						return true;
					}
				}
			}
		return super.handleEvent(event);
	}
}