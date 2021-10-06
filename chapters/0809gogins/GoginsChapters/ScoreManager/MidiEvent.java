package GoginsChapters.ScoreManager;

import java.io.*;

class MidiEvent
{
    public static void writeVarLen(RandomAccessFile fp, int value) throws java.io.IOException
    {
	    int buffer;
    	buffer = value & 0x7f;
	    while((value >>= 7) > 0)
	    {
		    buffer <<= 8;
    		buffer |= 0x80;
    		buffer |= (value & 0x7f);
	    }
	    for(;;)
	    {
    		fp.writeByte(buffer);
    		if((buffer & 0x80) == 0x80)
    		{
    		    buffer	>>= 8;
    		}
    		else
    		{
    		    break;
    		}
    	}
	}
    public static int readVarLen(RandomAccessFile fp) throws java.io.IOException
    {
	    int value;
    	byte c;
    	if(((value = fp.readByte()) & 0x80) == 0x80)
	    {
		    value &= 0x7f;
		    do
		    {
			    value = (value << 7) + ((c = fp.readByte()) & 0x7f);
		    } while ((c & 0x80) == 0x80);
    	}
	    return value;
    }
    public boolean isNoteOn()
    {
        return ((status & 0x90) == 0x90);
    }
    public boolean isNoteOff()
    {
        if((status & 0x80) == 0x80)
        {
            return true;
        }
        if(isNoteOn() && data[1] == 0)
        {
            return true;
        }
        return false;
    }
    public byte getChannel()
    {
        return (byte)(status & 0xf);
    }
    public byte getKey()
    {
        return data[0];
    }
    public byte getVelocity()
    {
        return data[1];
    }
    public boolean isMatchingNoteOff(MidiEvent Event)
    {
        //  To have a matching note off, one must be a note on.
        if(!isNoteOn())
        {
            return false;
        }
        //  
        if(!Event.isNoteOff())
        {
            return false;
        }
        if(getChannel() != Event.getChannel())
        {
            return false;
        }
        if(getKey() != Event.getKey())
        {
            return false;
        }
        return true;
    }
    public double time;
	public byte status;
	public byte[] data = new byte[2];
};

