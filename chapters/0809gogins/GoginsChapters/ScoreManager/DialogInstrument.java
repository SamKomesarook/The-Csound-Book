package GoginsChapters.ScoreManager;
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1997 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	A platform-independent graphical user interface for Csound.
import java.awt.*;
import java.net.*;
import java.io.*;

class DialogInstrument extends Dialog
{
	ScoreManagerFrame scoreManagerFrame;
	IDD_DIALOG_INSTRUMENT iddDialog;

	DialogInstrument(ScoreManagerFrame frame, String InstrumentName)
	{
		super(frame, "Edit instrument definition", true);
		scoreManagerFrame = frame;
		setBackground(Color.lightGray);
		iddDialog = new IDD_DIALOG_INSTRUMENT(this);
		iddDialog.CreateControls();
		iddDialog.IDC_EDIT_INSTRUMENT_NAME.setText(InstrumentName);
		String instrumentText = scoreManagerFrame.scoreManager.instruments.getProperty(InstrumentName);
		if(instrumentText == null)
		{
			instrumentText = "";
		}
		iddDialog.IDC_EDIT_INSTRUMENT_DEFINITION.setText(instrumentText);
		move(50, 50);
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
						scoreManagerFrame.scoreManager.instruments.put(iddDialog.IDC_EDIT_INSTRUMENT_NAME.getText(),
							iddDialog.IDC_EDIT_INSTRUMENT_DEFINITION.getText());
						hide();
						return true;
					}
					else if(string.equals("Test"))
					{
						DialogInstrumentTest dialogInstrumentTest = new DialogInstrumentTest(scoreManagerFrame, iddDialog.IDC_EDIT_INSTRUMENT_NAME.getText());
						dialogInstrumentTest.show();
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