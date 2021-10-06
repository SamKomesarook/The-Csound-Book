<CsoundSynthesizer>
<CsOptions>
;csound -RWdm7o ./Xanadu.wav ./Temp.orc ./Temp.sco
</CsOptions>
<CsInstruments>
sr          =           44100
kr          =           4410
ksmps       =           10
nchnls      =           2
;--------------------------------------------------------
;INSTRUMENT 1 : PLUCKED STRINGS CHORUSED LEFT/RIGHT AND
;       PITCH-SHIFTED AND DELAYED TAPS THRU EXPONENTIAL
;       FUNCTIONS, AND DELAYED.
;--------------------------------------------------------

            instr       1
ishift      =           .00666667               ;shift it 8/1200.
ipch        =           cpspch(p5)              ;convert parameter 5 to cps.
ioct        =           octpch(p5)              ;convert parameter 5 to oct.
kvib        oscil       1/120, ipch/50, 1       ;vibrato
ag          pluck       2000, cpsoct(ioct+kvib), 1000, 1, 1
agleft      pluck       2000, cpsoct(ioct+ishift), 1000, 1, 1
agright     pluck       2000, cpsoct(ioct-ishift), 1000, 1, 1
kf1         expon       .1, p3, 1.0             ;exponential from 0.1 to 1.0
kf2         expon       1.0, p3, .1             ;exponential from 1.0 to 0.1
adump       delayr      2.0                     ;set delay line of 2.0 sec
            delayw      ag                      ;put ag signal into delay line.
atap1       deltapi     kf1                     ;tap delay line with kf1 func.
atap2       deltapi     kf2                     ;tap delay line with kf2 func.
ad1         deltap      2.0                     ;delay 2 sec.
ad2         deltap      1.1                     ;delay 1.1 sec.
            outs        agleft+atap1+ad1, agright+atap2+ad2
            endin       
;-------------------------------------------------------------
;INSTRUMENT 2 : PLUCKED STRINGS CHORUSED LEFT/RIGHT AND
;       PITCH-SHIFTED WITH FIXED DELAYED TAPS.
;------------------------------------------------------------

            instr       2
ishift      =           .00666667               ;shift it 8/1200.
ipch        =           cpspch(p5)              ;convert parameter 5 to cps.
ioct        =           octpch(p5)              ;convert parameter 5 to oct.
kvib        oscil       1/120, ipch/50, 1       ;vibrato
ag          pluck       1000, cpsoct(ioct+kvib), 1000, 1, 1
agleft      pluck       1000, cpsoct(ioct+ishift), 1000, 1, 1
agright     pluck       1000, cpsoct(ioct-ishift), 1000, 1, 1
adump       delayr      0.3                     ;set delay line of 0.3 sec
            delayw      ag                      ;put ag sign into del line.
ad1         deltap      0.1                     ;delay 100 msec.
ad2         deltap      0.2                     ;delay 200 msec.
            outs        agleft+ad1, agright+ad2
            endin       
;-----------------------------------------------------------
;INSTRUMENT 3 : NEW FM ALGORITHM, MODIFIED TO PRODUCE LARGE TIMBRE
;               SHIFTS USING MODULATION OF I AND R. DETUNED CHORUSING EMPLOYED. 
;-----------------------------------------------------------
            instr       3
ishift      =           .00666667               ;shift it 8/1200.
ipch        =           cpspch(p5)              ;convert parameter 5 to cps.
ioct        =           octpch(p5)              ;convert parameter 5 to oct.
kadsr       linseg      0, p3/3, 1.0, p3/3, 1.0, p3/3, 0 ;ADSR envelope 
kmodi       linseg      0, p3/3, 5, p3/3, 3, p3/3, 0 ;ADSR envelope for I
kmodr       linseg      p6, p3, p7              ;r moves from p6->p7 in p3 sec.
a1          =           kmodi*(kmodr-1/kmodr)/2
a1ndx       =           abs(a1*2/20)            ;a1*2 is normalized from 0-1.
a2          =           kmodi*(kmodr+1/kmodr)/2
a3          tablei      a1ndx, 3, 1             ;lookup tbl in f3, normal index
ao1         oscil       a1, ipch, 2             ;cosine
a4          =           exp(-0.5*a3+ao1)
ao2         oscil       a2*ipch, ipch, 2        ;cosine
aoutl       oscil       1000*kadsr*a4, ao2+cpsoct(ioct+ishift), 1 ;fnl outleft
aoutr       oscil       1000*kadsr*a4, ao2+cpsoct(ioct-ishift), 1 ;fnl outright
            outs        aoutl, aoutr
            endin       
</CsInstruments>
<CsScore>
;       SCORE FOR FINAL PROJECT IN DIGITAL AUDIO PROCESSING
;       ---------------------------------------------------

;           Piece entitled :  X A N A D U (short version)
;                           Joseph T. Kung, 12/12/88

;           THE FIRST PART OF THE SCORE WILL SPECIFY ALL FUNCTION
;       TABLES USED IN THE PIECE. THE SECOND PART SPECIFIES
;       THE INSTRUMENTS AND NOTES. THE LATTER IS DIVIDED INTO
;       7 SECTIONS, EACH PLAYING A CHORD ON A DIFFERENT 
;                 INSTRUMENT.
;       THE CHORDS ARE UNCOMMON GUITAR CHORDS THAT USE THE OPEN
;       B AND E STRINGS OFTEN. THESE WILL BE TRANSPOSED BY
;       OCTAVES ON SOME CHORDS.

;       EACH INSTRUMENT WILL PLAY A CHORD FOR 15 SECONDS. THE 
;                 TIMBRE
;       OF THE INSTRUMENT WILL CHANGE IN THAT INTERVAL AND JOIN
;       WITH THE NEXT INSTRUMENT/CHORD SEQUENCE. INSTRUMENT 3
;       USES A MODIFIED FM SYNTHESIS TECHNIQUE. THIS IS JOINED
;       BY AN ADDITIONAL PLUCKED-STRING INSTRUMENT
;       (INSTRUMENTS 1 AND 2).

;   The Function Tables
;   -------------------
;All functions are post-normalized (max value is 1) if p4 is 
;POSITIVE.

f1 0 8192 10 1      ;sine wave
f2 0 8192 11 1      ;cosine wave
f3 0 8192 -12 20.0  ;unscaled ln(I(x)) from 0 to 20.0

;-----------------------------------------------------------

;----- THIS SECTION COMPRISES ALL THE NEW FM SOUNDS -----------

;F#7addB chord on a guitar
i3 0 15 0 7.06 2.0 0.2  ;F#
i3 . . . 8.01 . .   ;C# above
i3 . . . 8.06 . .   ;F# octave above 1st one
i3 . . . 8.10 . .   ;Bb next one up
i3 . . . 8.11 . .   ;B
i3 . . . 9.04 . .   ;E

;D6add9 chord on a guitar
i3 7.5 15 0 6.02 1.7 0.5    ;D
i3 . . . 6.09 . .   ;A above
i3 . . . 7.02 . .   ;D octave above 1st one
i3 . . . 7.06 . .   ;F# next one up
i3 . . . 6.11 . .   ;B
i3 . . . 7.04 . .   ;E

;Bmajadd11 chord on a guitar
i3 15 15 0 7.11 1.4 0.8 ;B
i3 . . . 8.06 . .   ;F# above
i3 . . . 8.11 . .   ;B octave above 1st one
i3 . . . 9.03 . .   ;D# next one up
i3 . . . 8.11 . .   ;B
i3 . . . 9.04 . .   ;E;

;Amajadd9 chord on a guitar
i3 22.5 15 0 6.09 1.1 1.1   ;A
i3 . . . 7.04 . .   ;E above
i3 . . . 8.09 . .   ;A octave above 1st one
i3 . . . 8.01 . .   ;C# next one up
i3 . . . 7.11 . .   ;B
i3 . . . 8.04 . .   ;E

;Bmajadd11 chord on a guitar
i3 30 15 0 6.11 0.8 1.4 ;B
i3 . . . 7.06 . .   ;F# above
i3 . . . 7.11 . .   ;B octave above 1st one
i3 . . . 8.03 . .   ;D# next one up
i3 . . . 7.11 . .   ;B
i3 . . . 8.04 . .   ;E;

;Gmaj6 chord on a guitar
i3 37.5 15 0 5.07 0.5 1.7   ;G
i3 . . . 6.02 . .   ;D above
i3 . . . 6.07 . .   ;G octave above 1st one
i3 . . . 6.11 . .   ;B on G string
i3 . . . 6.11 . .   ;B
i3 . . . 7.04 . .   ;E

;F#7addB chord on a guitar
i3 45 15 0 7.06 0.2 2.0 ;F#
i3 . . . 8.01 . .   ;C# above
i3 . . . 8.06 . .   ;F# octave above 1st one
i3 . . . 8.10 . .   ;Bb next one up
i3 . . . 8.11 . .   ;B
i3 . . . 9.04 . .   ;E

; THIS SECTION ADDS THE PLUCKED CHORDS TO THE BEGINNING OF EACH 
; SECTION.

;F#7addB chord on a guitar
i1 0 10 0 8.06  ;F#
i1 0.1 . . 9.01 ;C# above
i1 0.2 . . 9.06 ;F# octave above 1st one
i1 0.3 . . 9.10 ;Bb next one up
i1 0.4 . . 9.11 ;B
i1 0.5 . . 10.04    ;E

;D6add9 chord on a guitar
i2 7.5 10 0 8.02    ;D
i2 7.6 . . 8.09     ;A above
i2 7.7 . . 9.02     ;D octave above 1st one
i2 7.8 . . 9.06     ;F# next one up
i2 7.9 . . 9.11     ;B
i2 8.0 . . 10.04    ;E

;Bmajadd11 chord on a guitar
i2 15 10 0 8.11     ;B
i2 15.1 . . 9.06    ;F# above
i2 15.2 . . 9.11    ;B octave above 1st one
i2 15.3 . . 10.03   ;D# next one up
i2 15.4 . . 9.11    ;B
i2 15.5 . . 10.04   ;E;

;Amajadd9 chord on a guitar
i2 22.5 10 0 8.09   ;A
i2 22.6 . . 9.04    ;E above
i2 22.7 . . 10.09   ;A octave above 1st one
i2 22.8 . . 10.01   ;C# next one up
i2 22.9 . . 9.11    ;B
i2 23.0 . . 10.04   ;E

;Bmajadd11 chord on a guitar
i2 30 10 0 8.11     ;B
i2 30.1 . . 9.06    ;F# above
i2 30.2 . . 9.11    ;B octave above 1st one
i2 30.3 . . 10.03   ;D# next one up
i2 30.4 . . 9.11    ;B
i2 30.5 . . 10.04   ;E;

;Gmaj6 chord on a guitar
i2 37.5 10 0 8.07   ;G
i2 37.6 . . 9.02    ;D above
i2 37.7 . . 9.07    ;G octave above 1st one
i2 37.8 . . 9.11    ;B on G string
i2 37.9 . . 9.11    ;B
i2 38.0 . . 10.04   ;E

;F#7addB chord on a guitar
i1 45 10 0 9.06     ;F#
i1 45.1 . . 10.01   ;C# above
i1 45.2 . . 10.06   ;F# octave above 1st one
i1 45.3 . . 10.10   ;Bb next one up
i1 45.4 . . 10.11   ;B
i1 45.5 . . 11.04   ;E
e
</CsScore>
</CsoundSynthesizer>

