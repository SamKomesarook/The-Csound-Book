package GoginsChapters.ScoreManager;
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1997 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	A platform-independent graphical user interface for Csound.

import java.io.*;
import java.awt.*;

class DialogNote extends Dialog
{
	ScoreManager scoreManager;
	ScoreManagerFrame ScoreManagerFrame;
	IDD_DIALOG_NOTE iddDialog;
	int noteSubscript;

	DialogNote(ScoreManagerFrame frame)
	{
		super(frame, "Edit note definition", true);
		ScoreManagerFrame = frame;
		scoreManager = frame.scoreManager;
		setBackground(Color.lightGray);
		iddDialog = new IDD_DIALOG_NOTE(this);
		iddDialog.CreateControls();
		move(50, 50);
		setText();
	}

	void setText()
	{
		if(noteSubscript >= scoreManager.notes.size())
		{
			noteSubscript--;
		}
		if(noteSubscript < 0)
		{
			noteSubscript = 0;
		}
		try
		{
			iddDialog.IDC_EDIT_NOTE.setText(((Note)scoreManager.notes.elementAt(noteSubscript)).stringGet());
			iddDialog.IDC_EDIT_NOTE_SUBSCRIPT.setText(String.valueOf(noteSubscript + 1));
			iddDialog.IDC_EDIT_NOTE_COUNT.setText(String.valueOf(scoreManager.notes.size()));
		}
		catch(ArrayIndexOutOfBoundsException e)
		{

		}
	}

	public boolean handleEvent(Event event)
	{
		try
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
					if(string.equals("Close"))
					{
						hide();
						return true;
					}
					else if(string.equals("Add"))
					{
						scoreManager.notes.addElement(new Note());
						noteSubscript = scoreManager.notes.size() - 1;
						setText();
						return true;
					}
					else if(string.equals("Update"))
					{
						((Note)scoreManager.notes.elementAt(noteSubscript)).stringSet(iddDialog.IDC_EDIT_NOTE.getText());
						setText();
						return true;
					}
					else if(string.equals("First"))
					{
						noteSubscript = 0;
						setText();
						return true;
					}
					else if(string.equals("Next"))
					{
						noteSubscript++;
						if(noteSubscript >= scoreManager.notes.size())
						{
							noteSubscript--;
						}
						setText();
						return true;
					}
					else if(string.equals("Previous"))
					{
						noteSubscript--;
						if(noteSubscript < 0)
						{
							noteSubscript = 0;
						}
						setText();
						return true;
					}
					else if(string.equals("Last"))
					{
						noteSubscript = scoreManager.notes.size() - 1;
						if(noteSubscript < 0)
						{
							noteSubscript = 0;
						}
						setText();
						return true;
					}
					else if(string.equals("Delete"))
					{
						scoreManager.notes.removeElementAt(noteSubscript);
						setText();
						return true;
					}
					else if(string.equals("Goto"))
					{
						Integer buffer = Integer.valueOf(iddDialog.IDC_EDIT_NOTE_SUBSCRIPT.getText());
						setText();
						noteSubscript = buffer.intValue() - 1;
						setText();
					}
				}
			}
		}
		catch(Exception e)
		{

		}
		return super.handleEvent(event);
	}
}