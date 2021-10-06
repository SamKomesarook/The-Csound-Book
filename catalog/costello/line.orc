sr             =         44100
kr             =         2205
ksmps          =         20
nchnls         =         2


instr          3                             ; THIS INSTRUMENT USES OSCILI TO READ A SAMPLE THAT HAS
                                             ; BEEN STORED IN A FUNCTION TABLE USING GEN01.

ifn            =         p6
ilength        =         ftlen(ifn)
isampfreq      =         p4 * (sr/ilength)   ; CALCULATES THE FREQUENCY (THE SPEED OR RATE)
                                             ; FOR THE OSCILI SO THAT
                                             ; P4 IS A SCALAR ON THE FREQUENCY
                                             ; OF THE SAMPLE. WHEN P4 IS 1
                                             ; THERE WILL BE NO CHANGE FROM THE
                                             ; SAMPLES ORIGINAL FREQUENCY.
                                             ; P4=.5 WILL CAUSE IT TO SOUND ONE OCTAVE
                                             ; LOWER, P4=2 WILL BE AN OCTAVCE HIGHER, ETC...
                               
iamp           =         p5 * 32000

; AMPLITUDE ENVELOPE FOR SAMPLE PLAYBACK OSCILLATOR
kenv           linseg    0, .01, 1, p3 - .11, 1, .1, 0
asig           oscili    kenv, isampfreq, ifn

; ENVELOPE CONTROLLING BANDWIDTH OF RESON FILTERS. AT THE BEGINNING OF THE
; COMPOSITION, THE BANDWIDTH IS NARROW, AND THE OUTPUT OF THE RESON FILTER 
; STRONGLY EMPHASIZES A FEW HARMONICS OF THE SAMPLE, WHILE ATTENUATING ALL 
; OTHERS.  THE BANDWIDTH GRADUALLY WIDENS THROUGHOUT THE PIECE, UNTIL THE 
; 40 SECOND MARK, AT WHICH POINT THE BANDWIDTH IS 100 TIMES WIDER THAN AT
; THE BEGINNING OF THE PIECE. FROM 40 SECONDS UNTIL THE END OF THE PIECE,
; THE BANDWIDTH NARROWS TO THE ORIGINAL STARTING WIDTH.
kq1            expseg    .01, 40, 1, p3, .01 
kq             =         kq1 * 500

; ENVELOPE CONTROLLING CENTER FREQUENCY OF AFILT.  
kfreq          linseg    0, 40, 2000 * p4, p3 - 2, 300, p3, 0

; ASIG IS FILTERED BY A RESON FILTER, WITH CHANGING
; BANDWIDTH AND CENTER FREQUENCY.
afilt          reson     asig, kfreq, kq, 1

; DELAYED OUTPUT OF AFILT
adelay1        delay     afilt, .6

; ENVELOPE CONTROLLING CENTER FREQUENCY OF AFILT2. THE DIRECTION
; OF FREQUENCY CHANGE IS ROUGHLY OPPOSITE TO AFILT.
kfreq2         linseg    3000 * p4, 40, 0, p3 - 2, 2500 * p4, p3, 0

; AGAIN, ASIG IS FILTERED BY A RESON FILTER, WITH CHANGING
; BANDWIDTH AND CENTER FREQUENCY (IN THIS CASE, THE FREQUENCY
; IS MOVING IN OPPOSITE DIRECTIONS.
afilt2         reson     asig, kfreq2, kq, 1

; DELAYED OUTPUT OF AFILT2.
adelay2        delay     afilt2, .6

; EACH OUTPUT CHANNEL CONSISTS OF THE OUTPUT OF ONE RESON
; FILTER, AND THE DELAYED OUTPUT OF THE OTHER RESON FILTER.
aleft          =         (afilt + adelay2) * 2
aright         =         (afilt2 + adelay1) * 2

               outs      aleft, aright

endin
