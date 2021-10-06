'       L O G M U S E
'       A simple algorithmic score generator for Csound in QuickBASIC.
'       Michael Gogins
'       21 January 1997

'       Variables for the generator.
DIM c AS DOUBLE
DIM y AS DOUBLE
DIM y1 AS DOUBLE
DIM i AS INTEGER
DIM n AS INTEGER
'       Variables for music.
'       The dimensions that are not generated have default values.
DIM instrument AS DOUBLE
instrument = 1#
DIM start AS DOUBLE
DIM length AS DOUBLE
length = 2#
DIM octave AS DOUBLE
DIM decibels AS DOUBLE
decibels = 70#
DIM pan AS DOUBLE
pan = 0#
'       Mapping coefficients.
DIM pulse AS DOUBLE
pulse = .25#
DIM bass AS DOUBLE
bass = 6#
DIM range AS DOUBLE
range = 4#
'       Variables for rendering the score.
DIM file AS INTEGER
'       You can paste a Csound instrument definition right into BASIC code like this.
DIM orchestra AS STRING
orchestra = "sr =    44100" + CHR$(10)
orchestra = orchestra + "kr =    44100" + CHR$(10)
orchestra = orchestra + "ksmps =     1" + CHR$(10)
orchestra = orchestra + "nchnls =    2" + CHR$(10)
orchestra = orchestra + "" + CHR$(10)
orchestra = orchestra + "; Frequency modulation instrument." + CHR$(10)
orchestra = orchestra + "instr 1" + CHR$(10)
orchestra = orchestra + "; LOGGING" + CHR$(10)
orchestra = orchestra + "; p1 = Instrument" + CHR$(10)
orchestra = orchestra + "; p2 = Start" + CHR$(10)
orchestra = orchestra + "; p3 = Length" + CHR$(10)
orchestra = orchestra + "; p4 = Octave" + CHR$(10)
orchestra = orchestra + "; p5 = Decibels" + CHR$(10)
orchestra = orchestra + "; p6 = Pan" + CHR$(10)
orchestra = orchestra + "print p2, p3, p4, p5, p6" + CHR$(10)
orchestra = orchestra + "" + CHR$(10)
orchestra = orchestra + "; INITIALIZATION" + CHR$(10)
orchestra = orchestra + "iwavetable = 1" + CHR$(10)
orchestra = orchestra + "imodulator = .5" + CHR$(10)
orchestra = orchestra + "ifmamplitude = 1" + CHR$(10)
orchestra = orchestra + "index = 1.375" + CHR$(10)
orchestra = orchestra + "iattack = .025" + CHR$(10)
orchestra = orchestra + "irelease = .125" + CHR$(10)
orchestra = orchestra + "isustain = p3  - (iattack + irelease)" + CHR$(10)
orchestra = orchestra + "if isustain > 0 goto longenvelope" + CHR$(10)
orchestra = orchestra + "isustain = 0.03" + CHR$(10)
orchestra = orchestra + "p3 = iattack + isustain + irelease" + CHR$(10)
orchestra = orchestra + "longenvelope:" + CHR$(10)
orchestra = orchestra + "ifrequency = cpsoct(p4)" + CHR$(10)
orchestra = orchestra + "icarrier =  .998" + CHR$(10)
orchestra = orchestra + "icarrierb =  1.002" + CHR$(10)
orchestra = orchestra + "; Normalize to 80 dB = ampdb(80)." + CHR$(10)
orchestra = orchestra + "iamplitude = ampdb(p5) * 15848.926 / 12729.0" + CHR$(10)
orchestra = orchestra + "ileftpan = (0.5 - p6) / 2.0" + CHR$(10)
orchestra = orchestra + "irightpan = (0.5 + p6) / 2.0" + CHR$(10)
orchestra = orchestra + "" + CHR$(10)
orchestra = orchestra + "; KONTROL" + CHR$(10)
orchestra = orchestra + "kindenv expseg .00001, iattack, 1, isustain, .1, irelease, .00001" + CHR$(10)
orchestra = orchestra + "kindex = kindenv * index * ifmamplitude" + CHR$(10)
orchestra = orchestra + "" + CHR$(10)
orchestra = orchestra + "; AUDIO" + CHR$(10)
orchestra = orchestra + "aouta foscili iamplitude, ifrequency, icarrier, imodulator, kindex, iwavetable" + CHR$(10)
orchestra = orchestra + "aoutb foscili iamplitude, ifrequency, icarrierb, imodulator, kindex, iwavetable" + CHR$(10)
orchestra = orchestra + "afmout = (aouta + aoutb) * kindenv * 2.556" + CHR$(10)
orchestra = orchestra + "outs ileftpan * afmout, irightpan * afmout" + CHR$(10)
orchestra = orchestra + "endin" + CHR$(10)
'       Buffer for writing note statements.
DIM buffer AS STRING
c = .75#
n = 100
'       Create a score file.
file = FREEFILE
OPEN "test.sco" FOR OUTPUT AS file
'       Initial value of y.
y = .5#
'       Write the initial state of the system as a Csound comment.
PRINT #file, "; Hello Csound!"
PRINT #file, "; c = " + STR$(c)
PRINT #file, "; y = " + STR$(y)
PRINT #file, "; n = " + STR$(n)
'       GENERATE THE SCORE
'       Write the function table for the instrument.
PRINT #file, "f 1 0 16384 10 1 ; High-fidelity sine wave."
'       Iterate to write the notes.
FOR i = 1 TO n
	' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' '
	'       GENERATION
	y1 = y * c * 4# * (1# - y)
	'       MAPPING
	start = i * pulse
	octave = bass + y1 * range
	'       Round off to 12 tone equal temperament.
	octave = INT(octave * 12# + 0.5#) / 12#
	'       RENDERING
	'       Write a note into the Csound score.
	PRINT #file, USING "i #####.###### #####.###### #####.###### #####.###### ####.###### #####.######"; instrument; start; length; octave; decibels; pan
	'       Iterate.
	y = y1
	' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' ' '
NEXT
CLOSE #file
'       RENDER THE SOUNDFILE
'       Write the orchestra file.
file = FREEFILE
OPEN "test.orc" FOR OUTPUT AS file
PRINT #file, orchestra
CLOSE #file
'       Render the generated files using Csound.
SHELL "winsound -RWso test.wav test.orc test.sco"
'       PLAY THE SOUNDFILE
SHELL "MPLAYER test.wav"

