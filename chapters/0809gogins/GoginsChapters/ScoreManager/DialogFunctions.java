package GoginsChapters.ScoreManager;
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1997 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	A platform-independent graphical user interface for Csound.
import java.io.*;
import java.net.*;
import java.awt.*;

class DialogFunctions extends Dialog
{
	//	This is a reference to the ScoreManager 
	//	that has the data to be edited.
	ScoreManager scoreManager;
	//	This is a reference to the control layout class 
	//	generated by Visual J++ from the dialog resource.
	IDD_DIALOG_FUNCTIONS iddDialog;

	DialogFunctions(ScoreManagerFrame mainFrameWindow)
	{
		//	The Dialog constructor enables this dialog 
		//	to receive and handle events from the main frame window.
		super(mainFrameWindow, "Edit functions", true);
		//	Now we have a reference in this dialog to the data it edits.
		scoreManager = mainFrameWindow.scoreManager;
		//	Set the background color for the dialog layout to use.
		setBackground(Color.lightGray);
		//	This constructs the control layout object 
		//	and plugs the Dialog into it.
		iddDialog = new IDD_DIALOG_FUNCTIONS(this);
		//	This actually creates all the controls on the screen.
		iddDialog.CreateControls();
		//	Put the function definitions into the text box for editing them.
		iddDialog.IDC_EDIT_FUNCTIONS.setText(scoreManager.functions);
		//	Move away from the top corner.
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
						//	Put the edited data back into the ScoreManager.
						scoreManager.functions = iddDialog.IDC_EDIT_FUNCTIONS.getText();
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