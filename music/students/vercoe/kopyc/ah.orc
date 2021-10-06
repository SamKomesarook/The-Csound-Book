;******************************************************************************
; A SINGING VOICE INSTRUMENT
;******************************************************************************

sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2
gimaxamp       =         25000

;******************************************************************************
; AH

               instr     1

iristim        =         0.2                           ;ENVLELOPE RISE TIME IN SECS.
idectim        =         1.5                           ;ENVELOPE DECAY TIME IN SECS.
ivibst         =         0.4                           ;SECONDS OF WAIT BEFORE VIBRATO STARTS IN
ivibpnt        =         2                             ;PERCENT VIBRATO (OF FUNDAMENTAL FREQ.)

isteady        =         p3 - iristim - idectim        ;SECONDS OF ENVELOPE PSEUDO-STEADY STATE
ivibris        =         p3 - ivibst - idectim         ;SECONDS FOR TOTAL VIBRATO RISE

kamp           envlpx    p4, iristim, p3, idectim, 2, 1.1, 0.0001

ie0            =         0.0001
kvibamt        expseg    ie0, ivibst, ie0, ivibris/3, 1, ivibris*2/3 + idectim, 0.5
kvib           oscili    kvibamt, 4 + (kvibamt * 2), 1

kf0            =         p5 + (kvib * ivibpnt / 100 * p5)
knharm         =         sr/2/kf0                      ;NUMBER OF HARMONICS FOR DRIVING F0

abuz           buzz      kamp, kf0, knharm, 1
avoc           tone      abuz, kf0 * 1.5               ;ROLLOFF FILTER 12DB/OCTAVE

kbandw         =         200 + (kamp * 200)            ;OPEN UP BANDWIDTH ALONG WITH AMP

aform1         reson     avoc, 609, kbandw, 1
aform2         reson     avoc, 1000, 300, 1
aform3         reson     avoc, 2450, 300, 1
aform4         reson     avoc, 2700, 250, 1
aform5         reson     avoc, 3240, 250, 1

afout          =         aform1 + (aform2 / 2) + (aform3 / 4) + (aform4 / 3.5) + (aform5 / 16)
afil           =         afout / 5                     ; FIVE FILTERS, SO AVERAGE
abal           balance   afil, abuz                    ; THEN BALANCE WITH ORIGINAL DRIVE

arevb          reverb    abal, .5
arev           =         arevb / 2.3

aout           =         (abal + arev) /2 * gimaxamp
               outs      aout, aout
               endin


;******************************************************************************
; OO

               instr     2

iristim        =         0.2                           ;ENVLELOPE RISE TIME IN SECS.
idectim        =         0.7                           ;ENVELOPE DECAY TIME IN SECS.
ivibst         =         0.4                           ;SECONDS OF WAIT BEFORE VIBRATO STARTS IN
ivibpnt        =         3                             ;PERCENT VIBRATO (OF FUNDAMENTAL FREQ.)

isteady        =         p3 - iristim - idectim        ;SECONDS OF ENVELOPE PSEUDO-STEADY STATE
ivibris        =         p3 - ivibst - idectim         ;SECONDS FOR TOTAL VIBRATO RISE

kamp           envlpx    p4, iristim, p3, idectim, 2, 1.1, 0.0001

kvibamt        linseg    0, ivibst, 0, ivibris/3, 0.7, ivibris*2/3, 1, idectim, 0
kvib           oscili    kvibamt, 5, 1

kf0            =         p5 + (kvib * ivibpnt / 100 * p5)
knharm         =         sr/2/kf0                      ;NUMBER OF HARMONICS FOR DRIVING F0

aimp           buzz      1, kf0, knharm, 1
aroll          tone      aimp, kf0 * 1.5               ;ROLLOFF FILTER 12DB/OCTAVE
avoc           =         aroll * kamp

kbandw         =         100 + (kvibamt * 100)         ;OPEN UP BANDWIDTH ALONG WITH VIBRATO

aform1         reson     avoc, 360, kbandw, 1
aform2         reson     avoc, 750, 100, 1
aform3         reson     avoc, 2400, 200, 1
aform4         reson     avoc, 2675, 250, 1
aform5         reson     avoc, 2950, 250, 1

afout          =         aform1 + (aform2 / 4) + (aform3 / 28) +(aform4 / 25) + (aform5 / 60)
afil           =         afout / 5                     ; FIVE FILTERS, SO AVERAGE
asig           balance   afil, avoc                    ; THEN BALANCE WITH ORIGINAL DRIVE

arevb          reverb    asig, 1
arev           =         arevb / 2.3

aout           =         (asig + arev) /2 * gimaxamp
               outs      aout, aout
               endin
