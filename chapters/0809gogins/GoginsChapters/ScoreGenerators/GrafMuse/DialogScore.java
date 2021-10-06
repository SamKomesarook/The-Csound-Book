package GoginsChapters.ScoreGenerators.GrafMuse;
import GoginsChapters.ScoreManager.*;
import java.awt.*;

public class DialogScore extends Dialog
{
	GrafMuse grafMuse = null;
	IDD_DIALOG_SCORE iddDialog = null;

	public DialogScore(GrafMuse parent)
	{
		super(parent.frame, "Render as Csound score", true);
		grafMuse = parent;
		setBackground(Color.lightGray);
		iddDialog = new IDD_DIALOG_SCORE(this);
		iddDialog.CreateControls();
		setText();
		move(50, 50);
	}

	void getText()
	{
		Double buffer = null;
		buffer = Double.valueOf(iddDialog.IDC_EDIT_VOICES.getText());
		grafMuse.voiceCount = buffer.intValue();
		buffer = Double.valueOf(iddDialog.IDC_EDIT_INSTRUMENTS.getText());
		grafMuse.instrumentCount = buffer.intValue();
		buffer = Double.valueOf(iddDialog.IDC_EDIT_DURATION.getText());
		grafMuse.durationSeconds = buffer.doubleValue();
		buffer = Double.valueOf(iddDialog.IDC_EDIT_DIVISIONSPEROCTAVE.getText());
		grafMuse.divisionsPerOctave = buffer.doubleValue();
	}

	void setText()
	{
		iddDialog.IDC_EDIT_VOICES.setText(String.valueOf(grafMuse.voiceCount));
		iddDialog.IDC_EDIT_INSTRUMENTS.setText(String.valueOf(grafMuse.instrumentCount));
		iddDialog.IDC_EDIT_DURATION.setText(String.valueOf(grafMuse.durationSeconds));
		iddDialog.IDC_EDIT_DIVISIONSPEROCTAVE.setText(String.valueOf(grafMuse.divisionsPerOctave));
	}

	public boolean handleEvent(Event evt)
	{
		switch (evt.id)
		{
		case Event.WINDOW_DESTROY:
			System.exit(0);
			return true;
		case Event.ACTION_EVENT:
			if(evt.target instanceof Button)
			{
				String string = ((Button)evt.target).getLabel();
				if(string.equals("Render score"))
				{
					getText();
					grafMuse.imageToSco();
					hide();
					grafMuse.scoreManager.openWindow();
				}
				else if(string.equals("Cancel"))
				{
					hide();
				}
				else if(string.equals("OK"))
				{
					getText();
					hide();
				}
			}
			default:
				return super.handleEvent(evt);
		}
	}
}

