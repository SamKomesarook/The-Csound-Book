package GoginsChapters.ScoreManager;
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1997 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	A platform-independent graphical user interface for Csound.

import java.util.*;
import java.awt.*;

class DialogOrchestra extends Dialog
{
	ScoreManagerFrame scoreManagerFrame;
	IDD_DIALOG_ORCHESTRA iddDialog;
	int instrumentSubscript;
	int arrangementSubscript;
	Properties instruments = null;
	Vector arrangement = null;

	DialogOrchestra(ScoreManagerFrame frame)
	{
		super(frame, "Orchestra", true);
		scoreManagerFrame = frame;
		setBackground(Color.lightGray);
		iddDialog = new IDD_DIALOG_ORCHESTRA(this);
		iddDialog.CreateControls();
		instruments = scoreManagerFrame.scoreManager.instruments;
		arrangement = scoreManagerFrame.scoreManager.arrangement;
		move(50, 50);
		setText();
	}

	void setText()
	{
		instrumentSubscript = iddDialog.IDC_LIST_INSTRUMENT_NAMES.getSelectedIndex();
		if(instrumentSubscript >= instruments.size())
		{
			instrumentSubscript--;
		}
		if(instrumentSubscript < 0)
		{
			instrumentSubscript = 0;
		}
		arrangementSubscript = iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES.getSelectedIndex();
		if(arrangementSubscript >= arrangement.size())
		{
			arrangementSubscript--;
		}
		if(arrangementSubscript < 0)
		{
			arrangementSubscript = 0;
		}
		iddDialog.IDC_LIST_INSTRUMENT_NAMES.clear();
		Vector v = new Vector();
		for(Enumeration e = instruments.keys(); e.hasMoreElements(); )
		{
			String Name = (String) e.nextElement();
			v.add(Name);
		}
		Collections.sort(v);
		for(int i = 0, n = v.size(); i < n; i++)
		{
			iddDialog.IDC_LIST_INSTRUMENT_NAMES.addItem((String) v.get(i));
		}
		int i;
		int n;
		iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NUMBERS.clear();
		iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES.clear();
		Enumeration e;
		for(e = arrangement.elements(), i = 0; e.hasMoreElements(); ++i)
		{
			String Name = (String) e.nextElement();
			iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NUMBERS.addItem(String.valueOf(i + 1));
			iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES.addItem(Name);
		}
		iddDialog.IDC_LIST_INSTRUMENT_NAMES.select(instrumentSubscript);
		iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NUMBERS.select(arrangementSubscript);
		iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES.select(arrangementSubscript);
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
					else if(string.equals("New"))
					{
						setText();
						DialogInstrument dialogInstrument = new DialogInstrument(scoreManagerFrame, "New instrument");
						dialogInstrument.show();
						iddDialog.IDC_LIST_INSTRUMENT_NAMES.invalidate();
						setText();
						return true;
					}
					else if(string.equals("Delete"))
					{
						setText();
						String instrumentName = iddDialog.IDC_LIST_INSTRUMENT_NAMES.getItem(instrumentSubscript);
						instruments.remove(instrumentName);
						setText();
						return true;
					}
					else if(string.equals("Edit"))
					{
						setText();
						String instrumentName = iddDialog.IDC_LIST_INSTRUMENT_NAMES.getItem(instrumentSubscript);
						DialogInstrument dialogInstrument = new DialogInstrument(scoreManagerFrame, instrumentName);
						dialogInstrument.show();
						setText();
						return true;
					}
					else if(string.equals("Add"))
					{
						int arrangementSubscript = iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES.getSelectedIndex();
						if(arrangementSubscript > 0 && arrangementSubscript <= arrangement.size())
						{
							arrangement.insertElementAt(iddDialog.IDC_LIST_INSTRUMENT_NAMES.getSelectedItem(), arrangementSubscript);
						}
						else
						{
							arrangement.addElement(iddDialog.IDC_LIST_INSTRUMENT_NAMES.getSelectedItem());
						}
						setText();
						return true;
					}
					else if(string.equals("Remove"))
					{
						arrangement.removeElementAt(iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES.getSelectedIndex());
						setText();
						return true;
					}
					else if(string.equals("Down"))
					{
						arrangementSubscript = iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES.getSelectedIndex();
						if(arrangementSubscript < arrangement.size() - 1)
						{
							Object instrument = arrangement.elementAt(arrangementSubscript);
							arrangement.setElementAt(arrangement.elementAt(arrangementSubscript + 1), arrangementSubscript);
							arrangement.setElementAt(instrument, arrangementSubscript + 1);
							iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES.select(arrangementSubscript + 1);
							setText();
						}					
						return true;
					}
					else if(string.equals("Up"))
					{
						int arrangementSubscript = iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES.getSelectedIndex();
						if(arrangementSubscript > 0)
						{
							Object instrument = arrangement.elementAt(arrangementSubscript);
							arrangement.setElementAt(arrangement.elementAt(arrangementSubscript - 1), arrangementSubscript);
							arrangement.setElementAt(instrument, arrangementSubscript - 1);
							iddDialog.IDC_LIST_ARRANGEMENT_INSTRUMENT_NAMES.select(arrangementSubscript - 1);
							setText();
						}					
						return true;
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