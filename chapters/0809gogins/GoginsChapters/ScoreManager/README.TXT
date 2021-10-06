Midi to Csound and Csound to Midi File Conversion Utilities

Two standard unix-compatible routines for converting file formats:

        writemid --  converts a Csound score into a midi file.
	readmidi -- converts a midi file into a csound score.

	The input Midi Files must be Midi File Format 0 or 1.
	They will always be written in file format 0.
	The CSound scores must have the following p-fields :
		p1 = Midi channel number (1-16).
		p2 = start time in beats (tempo = 120).
		p3 = duration.
		p4 = Midi amplitude (0 - 127).
		p5 = Midi note number (0 - 127).

	Notes :
                1 ) Only i-cards are processed in the the CSound files.
                    Hence, t-cards are ignored.
                2 ) Tempo changes are handled properly when converting
                    from format 0 Midi files to C Sound, but tempo changes
                    are ignored when converting format 1 midi files.


	Usage examples :
                writemid  oboe.sco   oboe.mid
                readmidi  jazz.mid   jazz.sco

		writemidi	long.sco    long.mid    10000
                        The 10000 tells the computer to allocate space for
                        10000 note on/off events instead of the default 3500
                        events. This might be necessary for long scores.


	Versions :
                Versions of these routines have been written for both the
                IBM PC and the NEXT. They have only minor differences that
                involve differences in include files and binary file types
                in the fopen subroutines.

                Written by Keith Lent, Electronic Music Studios, UT-Austin
