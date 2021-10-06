package GoginsChapters.ScoreManager;
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1997 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	A platform-independent graphical user interface for Csound.

import java.awt.*;

class DialogSoundfileOptions extends Dialog
{
	ScoreManager scoreManager;
	ScoreManagerFrame scoreManagerFrame;
	IDD_DIALOG_SOUNDFILE_OPTIONS iddDialog;
	int NoteSubscript;

	DialogSoundfileOptions(ScoreManagerFrame frame)
	{
		super(frame, "Soundfile options", true);
		scoreManagerFrame = frame;
		scoreManager = frame.scoreManager;
		setBackground(Color.lightGray);
		iddDialog = new IDD_DIALOG_SOUNDFILE_OPTIONS(this);
		iddDialog.CreateControls();
		move(50, 50);
		setText();
	}

	void setText()
	{
		String buffer;
		iddDialog.IDC_COMBO_SR.addItem("22050");
		iddDialog.IDC_COMBO_SR.addItem("32000");
		iddDialog.IDC_COMBO_SR.addItem("44100");
		iddDialog.IDC_COMBO_SR.addItem("48000");
		iddDialog.IDC_COMBO_SR.addItem("56000");
		iddDialog.IDC_COMBO_SR.addItem("96000");
		iddDialog.IDC_COMBO_SR.select(scoreManager.soundfileOptions.getProperty("sr"));
		iddDialog.IDC_COMBO_KSMPS.addItem("1");
		iddDialog.IDC_COMBO_KSMPS.addItem("5");
		iddDialog.IDC_COMBO_KSMPS.addItem("10");
		iddDialog.IDC_COMBO_KSMPS.addItem("25");
		iddDialog.IDC_COMBO_KSMPS.addItem("50");
		iddDialog.IDC_COMBO_KSMPS.addItem("100");
		iddDialog.IDC_COMBO_SR.select(scoreManager.soundfileOptions.getProperty("ksmps"));
		iddDialog.IDC_COMBO_SOUNDFILE_FORMAT.addItem("A Macintosh/Unix AIFF");
		iddDialog.IDC_COMBO_SOUNDFILE_FORMAT.addItem("W Windows wav");
		iddDialog.IDC_COMBO_SOUNDFILE_FORMAT.addItem("h No header");
		buffer = scoreManager.soundfileOptions.getProperty("Format");
		if(buffer.startsWith("A"))
		{
			iddDialog.IDC_COMBO_SOUNDFILE_FORMAT.select(0);
		}
		else if(buffer.startsWith("W"))
		{
			iddDialog.IDC_COMBO_SOUNDFILE_FORMAT.select(1);
		}
		else if(buffer.startsWith("h"))
		{
			iddDialog.IDC_COMBO_SOUNDFILE_FORMAT.select(2);
		}
		iddDialog.IDC_COMBO_SAMPLE_FORMAT.addItem("c 8 bit signed");
		iddDialog.IDC_COMBO_SAMPLE_FORMAT.addItem("8 8 bit unsigned");
		iddDialog.IDC_COMBO_SAMPLE_FORMAT.addItem("s 16 bit signed");
		iddDialog.IDC_COMBO_SAMPLE_FORMAT.addItem("l 32 bit signed");
		iddDialog.IDC_COMBO_SAMPLE_FORMAT.addItem("f 32 bit floating point");
		buffer = scoreManager.soundfileOptions.getProperty("Sample");
		if(buffer.startsWith("c"))
		{
			iddDialog.IDC_COMBO_SAMPLE_FORMAT.select(0);
		}
		else if(buffer.startsWith("8"))
		{
			iddDialog.IDC_COMBO_SAMPLE_FORMAT.select(1);
		}
		else if(buffer.startsWith("s"))
		{
			iddDialog.IDC_COMBO_SAMPLE_FORMAT.select(2);
		}
		else if(buffer.startsWith("l"))
		{
			iddDialog.IDC_COMBO_SAMPLE_FORMAT.select(3);
		}
		else if(buffer.startsWith("f"))
		{
			iddDialog.IDC_COMBO_SAMPLE_FORMAT.select(4);
		}
		iddDialog.IDC_COMBO_CHANNEL_COUNT.addItem("1 Monophonic");
		iddDialog.IDC_COMBO_CHANNEL_COUNT.addItem("2 Sterephonic");
		iddDialog.IDC_COMBO_CHANNEL_COUNT.addItem("4 Quadrophonic");
		buffer = scoreManager.soundfileOptions.getProperty("nchnls");
		if(buffer.startsWith("1"))
		{
			iddDialog.IDC_COMBO_CHANNEL_COUNT.select(0);
		}
		else if(buffer.startsWith("2"))
		{
			iddDialog.IDC_COMBO_CHANNEL_COUNT.select(1);
		}
		else if(buffer.startsWith("4"))
		{
			iddDialog.IDC_COMBO_CHANNEL_COUNT.select(2);
		}
		iddDialog.IDC_EDIT_OPTIONS.setText(scoreManager.soundfileOptions.getProperty("Other"));
		iddDialog.IDC_EDIT_SOUND_PLAYER.setText(scoreManager.soundfileOptions.getProperty("SoundPlayer"));
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
						String buffer;

						scoreManager.soundfileOptions.put("sr", iddDialog.IDC_COMBO_SR.getSelectedItem());
						scoreManager.soundfileOptions.put("ksmps", iddDialog.IDC_COMBO_KSMPS.getSelectedItem());
						buffer = iddDialog.IDC_COMBO_SOUNDFILE_FORMAT.getSelectedItem();
						scoreManager.soundfileOptions.put("Format", buffer.substring(0, 1));
						buffer = iddDialog.IDC_COMBO_SAMPLE_FORMAT.getSelectedItem();
						scoreManager.soundfileOptions.put("Sample", buffer.substring(0, 1));
						buffer = iddDialog.IDC_COMBO_CHANNEL_COUNT.getSelectedItem();
						scoreManager.soundfileOptions.put("nchnls", buffer.substring(0, 1));
						scoreManager.soundfileOptions.put("Other", iddDialog.IDC_EDIT_OPTIONS.getText());
						scoreManager.soundfileOptions.put("SoundPlayer", iddDialog.IDC_EDIT_SOUND_PLAYER.getText());
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