package GoginsChapters.ScoreManager;
//	S I L E N C E
//	A system for making music on computers by means of software alone.
//	Copyright (C) 1997 by Michael Gogins. All rights reserved.
//	P U R P O S E
//	A platform-independent graphical user interface for Csound.
import java.util.*;
import java.io.*;

//  Notes must be able to copy themselves in order to have 
//  value semantics instead of reference semantics.
//  Therefore, Note must implement the Cloneable interface.
public class Note implements Cloneable 
{
    private double pfields[];
    
    //  By default, a Note has 6 pfields, but this can be changed.
	public Note()
	{
	    pfields = new double[6];
	}
	
    //  A Note can create itself from a Csound note statement.
	public Note(String buffer)
	{
	    stringSet(buffer);
	}

    //  Copy the value of this.
	public Object clone()
	{
	    Note buffer = new Note();
	    buffer.pfields = new double[pfields.length];
	    System.arraycopy(pfields, 0, buffer.pfields, 0, pfields.length);
	    return buffer;
	}

    //  Translate this into a Csound note statement.
	public String stringGet()
	{
		String string = new String("i");
		for(int i = 0, n = pfields.length; i < n; ++i)
		{
		    //  Java calls an implicit string conversion here.
			string = string + " " + pfields[i];
		}
		return string;
	}

    //  Translate this into a Csound note statement,
    //  and round pitch off into equal temperament.
	public String stringGet(double temperament)
	{
		String buffer = new String("i");
		double pfield;
		double temperamentRound = (1.0 / temperament) / 2.0;
		for(int i = 0, n = pfields.length; i < n; ++i)
		{
		    pfield = pfields[i];
			if(temperament != 0 && i == 3)
			{
				pfield = ((int)((pfield + temperamentRound) * temperament)) / temperament;
			}
			buffer = buffer + " " + pfield;
		}
		return buffer;
	}
	
	//  Change the number of pfields 
	//  without destroying their values.
	public void resize(int newCount)
	{
	    if(newCount <= 0)
	    {
	        pfields = null;
	        return;
	    }
	    double buffer[] = new double[newCount];
	    int oldCount;
	    if(pfields == null)
        {
            oldCount = 0;
        }
        else
	    {
	        oldCount = pfields.length;
	        System.arraycopy(pfields, 0, buffer, 0, Math.min(oldCount, newCount));
        }
	    for(int i = oldCount; i < newCount; ++i)
	    {
	        buffer[i] = 0;
	    }
	    pfields = buffer;
	}
	
	//  Typical Java syntax for setting an element.
	public void setElementAt(double value, int i)
	{
	    if(pfields == null)
	    {
	        resize(i + 1);
	    }
	    else if (i >= pfields.length)
	    {
	        resize(i + 1);
	    }
	    pfields[i] = value;
	}
	
	//  Typical Java syntax for getting an element.
	public double elementAt(int i)
	{
	    return pfields[i];
	}
	
	public void append(double value)
	{
	    if(pfields == null)
	    {
	        setElementAt(value, 0);
	    }
	    else
	    {
	        setElementAt(value, pfields.length);
	    }
	}
	
	public int size()
	{
	    return pfields.length;
	}

    //  Set the value of this from a Csound note statement.
	public void stringSet(String newValue) 
	{
	    pfields = null;
		try
		{
			newValue = newValue.substring(newValue.indexOf("i") + 1);
			Double buffer;
			for(StringTokenizer tokenizer = new StringTokenizer(newValue);
			tokenizer.hasMoreTokens(); )
			{
				buffer = Double.valueOf(tokenizer.nextToken());
				append(buffer.doubleValue());
			}
		}
		catch(StringIndexOutOfBoundsException sioobException)
		{
		}
		catch(NumberFormatException e)
		{
		}
	}
    
    //  Functions for getting and setting individual pfields.
	public double instrumentGet()
	{
		return pfields[0];
	}

	public void instrumentSet(double newValue)
	{
		pfields[0] = newValue;
	}

	public double startGet()
	{
		return pfields[1];
	}

	public void startSet(double newValue)
	{
		pfields[1] = newValue;
	}

	public double lengthGet()
	{
		return pfields[2];
	}

	public void lengthSet(double newValue)
	{
		pfields[2] = newValue;
	}

	public double octaveGet()
	{
		return pfields[3];
	}

	public void octaveSet(double newValue)
	{
		pfields[3] = newValue;
	}

    //  Set and get pitch as a MIDI key number (middle C = 60).
	public void midiKeySet(double newValue)
	{
		pfields[3] = ((newValue - 60.0) / 12.0) + 8.0;
	}

	public double midiKeyGet()
	{
		return ((pfields[3] - 8.0) * 12.0) + 60.0;
	}

	public double decibelsGet()
	{
		return pfields[4];
	}

	public void decibelsSet(double newValue)
	{
		pfields[4] = newValue;
	}

	public double panGet()
	{
		return pfields[5];
	}

	public void panSet(double newValue)
	{
		pfields[5] = newValue;
	}

    //  Read the value of this from a Csound text stream.
	public void read(DataInputStream stream) throws IOException
	{
		String buffer = stream.readLine();
		stringSet(buffer);
	}

	//  Write the value of this to a Csound text stream.
	public void write(PrintStream stream) throws IOException
	{
		stream.println(stringGet());
	}

    //  This is the function that is normally used to write 
    //  Csound scores.
    //  Write the value of this to a Csound text stream
    //  and round pitch off into equal temperament.
	public void write(PrintStream stream, double temperament) throws IOException
	{
		stream.println(stringGet(temperament));
	}
}