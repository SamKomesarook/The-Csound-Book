; stRINGPHASER.ORC
;
; BY SEAN COSTELLO, AUGUST 23-26, 1999
;
; THIS ORCHESTRA IS A DIGITAL RECREATION OF THE OLD ANALOG "STRING
; ENSEMBLE." A STRING ENSEMBLE WAS AN ATTEMPT TO CREATE A REASONABLY
; FULL STRING SECTION SOUND, WITH FULL POLYPHONY, USING THE LIMITED
; TECHNOLOGY AVAILABLE IN THE EARLY 1970'S. IN THIS ORCHESTRA,
; THE STRING ENSEMBLE SECTION IS FOLLOWED BY A 6-STAGE PHASE SHIFTER
; (A DIGITAL RECREATION OF A COMMON 1970'S ANALOG EFFECT), AND IS
; SENT INTO A FDN (FEEDBACK DELAY NETWORK) REVERB, BASED UPON THE
; WORK OF STAUTNER AND PUCKETTE.

sr             =         44100
kr             =         44100          ; KR MUST EQUAL SR FOR PHASE SHIFTING TO WORK IN THIS VERSION.
ksmps          =         1
nchnls         =         2

; GLOBAL VARIABLES INITIALIZATION

gasig2         init      0              ; GLOBAL VARIABLE TO SEND PULSE WAVES TO ENSEMBLE SECTION
ga2            init      0              ; GLOBAL VARIABLE TO SEND OUTPUT OF ENSEMBLE TO REVERB


instr          19                       ; USED TO GENERATE SIMPLE SAWTOOTH-LIKE WAVEFORMS, WITH
                                        ; AR-TYPE ENVELOPES. THESE ARE SENT TO THE ENSEMBLE
                                        ; SECTION TO PRODUCE THE STRING ANIMATION. AS THE
                                        ; ENSEMBLE/PHASER/REVERB SECTION HAS A FIXED LEVEL OF
                                        ; COMPUTATIONAL OVERHEAD (SINCE THESE ARE GLOBAL
                                        ; PROCESSORS), THE POLYPHONY CAN BE RAISED TO LARGE
                                        ; NUMBERS OF SIMULTANEOUS NOTES WITHOUT SIGNIFICANTLY
                                        ; INCREASING THE COMPUTATIONAL LOAD.

idur           =         p3
iamp           =         p4
ifreq          =         cpspch(p5)
iharms         =         (sr*.4) / ifreq     ; LIMITS NUMBER OF HARMONICS IN BANDLIMITED
                                             ; PULSE WAVEFORM

; ASIG IS A SIMPLE SAWTOOTH-LIKE WAVEFORM, SIMILAR TO THE WAVEFORMS
; THAT WOULD HAVE BEEN CREATED BY THE DIVIDE-DOWN CIRCUITRY &
; WAVESHAPERS IN THE OLD STRING ENSEMBLES.
asig           gbuzz     1, ifreq, iharms, 1, .9, 2

; THE AMPLITUDE ENVELOPE IS A SIMULATION OF A SIMPLE AR ENVELOPE, TO
; FADE THE NOTE IN AND OUT. NOT "REALISTIC" FROM THE STANDPOINT OF
; AN ACOUSTIC INSTRUMENT, BUT VERY CLOSE TO THE SIMPLE ENVELOPES
; OF THE SOLINA/ARP STRING ENSEMBLE/ETC.
kenv           linseg    0, 1, iamp, idur - 2, iamp, 1, 0

; THE OUTPUT IS SCALED SOMEWHAT. NOTE THAT MIXING MULTIPLE NOTES DOES
; NOT RESULT IN A LINEAR INCREASE OF AMPLITUDE. THE GBUZZ WAVEFORM
; MUST HAVE A VERY LARGE PEAK PER PERIOD, WITH THE MAJORITY OF
; THE PERIOD BEING FAIRLY LOW LEVEL.
aout           =         kenv * asig * .45

; THE OUTPUT OF INSTR 19 IS SENT TO THE "ENSEMBLE" CHORUSING
; SECTION. NONE OF THE DRY SIGNAL WILL BE HEARD IN THE OUTPUT.
gasig2         =         gasig2 + aout

; IF YOU WANT TO HEAR THE STRAIGHT WAVEFORM BEING USED, COMMENT 
; OUT THE LINE ABOVE FOR GASIG2, AND UNCOMMENT THE FOLLOWING LINE.
;outs          aout, aout

endin



instr          22        ; ENSEMBLE SECTION. TAKES STATIC SAWTOOTH WAVES,
                         ; AND PRODUCES AN ANIMATED FLANGED/CHORUSED/VIBRATOED
                         ; OUTPUT. THE PHASE SHIFTER FOLLOWS THE OUTPUT
                         ; OF THE ENSEMBLE.

; INITIALIZATION OF FEEDBACK VARIABLES FOR ALLPASS FILTERS.
ay1            init      0
ay2            init      0 
ay3            init      0
ay4            init      0
ay5            init      0
ay6            init      0

; INITIALIZATION OF VARIABLE FOR PHASER FEEDBACK.
afeed          init      0

idur           =         p3
ivib           =         p4 * .00025    ; DETERMINES AMOUNT OF PITCH CHANGE/VIBRATO/
                                        ; CHORUSING. A VALUE OF 1 GIVES MODERATELY THICK 
                                        ; CHORUSING, WITHOUT EXCESSIVE VIBRATO. VARY THIS 
                                        ; ACCORDING TO TASTE.


; SIMULATES THE FIRST OF TWO 3-PHASE LFOS THAT WERE USED
; IN THE ENSEMBLE SECTIONS. EACH LFO HAD THREE OUTPUTS,
; SEPERATED BY 120 DEGREES. THIS FIRST LFO PROVIDES A
; SLOW FLANGING COMPONENT TO THE SOUND, AND HELPS TO 
; PREVENT UNPLEASANT PHASE CANCELLATIONS OF THE FASTER VIBRATO
; COMPONENT PROVIDED BY THE SECOND LFO.
ktimea         oscili    4, 0.33, 1
ktimeb         oscili    4, 0.33, 1, .333
ktimec         oscili    4, 0.33, 1, .667

; SIMULATES THE SECOND 3-PHASE LFO. THIS LFO PROVIDES
; A VIBRATO COMPONENT TO THE SOUND. NOTE THAT THE AMPLITUDE
; OF THIS LFO IS 1/4TH THE AMPLITUDE OF THE SLOWER LFO.
ktimed         oscili    1, 5.5, 1
ktimee         oscili    1, 5.5, 1, .333
ktimef         oscili    1, 5.5, 1, .667

; THE OUTPUTS OF THE 2 LFOS ARE COMBINES, SO THAT THE 0
; DEGREE COMPONENT OF THE SLOW LFO IS COMBINED WITH THE 
; 0 DEGREE COMPONENT OF THE FAST LFO, THE 120 DEGREE 
; COMPONENT OF THE SLOW LFO IS COMBINED WITH THE 120
; DEGREE COMPONENT OF THE FAST LFO, AND THE 240 DEGREE
; COMPONENT OF THE SLOW LFO IS COMBINED WITH THE 240
; DEGREE COMPONENT OF THE FAST LFO. EACH OF THE SUMMED
; LFO SIGNALS IS SCALED BY IVIB.
ktime1         =         (ktimea + ktimed) * ivib
ktime2         =         (ktimeb + ktimee) * ivib
ktime3         =         (ktimec + ktimef) * ivib

; EACH OF THE SUMMED & SCALED LFO SIGNALS IS USED TO 
; MODULATE A DELTAPI DELAY LINE. THIS RESULTS IN 
; THREE PARALLEL SIGNALS, EACH WITH A SMALL AMOUNT OF
; VIBRATO AND PITCH WARBLE.
adummy         delayr    .030
asig1          deltapi   ktime1 + .012
asig2          deltapi   ktime2 + .012
asig3          deltapi   ktime3 + .012
               delayw    gasig2

; THE DELAY LINE OUTPUTS ARE MIXED TOGETHER, RESULTING
; IN A SIGNAL WITH COMPLEX PHASE, TIMBRAL AND PITCH 
; SHIFTS. UNLIKE MOST FLANGERS OR CHORUS GENERATORS, THE
; DRY INPUT SIGNAL IS NOT MIXED IN WITH THE OUTPUTS OF 
; THE DELAY LINES. THIS RESULTS IN A MORE ANIMATED SIGNAL,
; WITH MULTIPLE LAYERS OF "THROUGH-ZERO" FLANGING, AND
; LESS OF THE CHARACTERISTIC COMB-FILTER SOUND OF NORMAL
; FLANGERS AND CHORUSES.
aout           =         (asig1 + asig2 + asig3) * .33

; KPHS AND KCOEFF MAKE UP THE MODULATION SIGNAL FOR THE 
; PHASER. THE PHASER COEFFICIENT MUST BE IN THE RANGE OF
; -1 < KCOEFF < 1. FOR PHASE SHIFTING PURPOSES, THE MORE
; INTERESTING EFFECTS OCCUR IN THE RANGE -1 < KCOEFF < 0.
; THE MODULATING WAVEFORM USES AN INVERTED HALF-SINE
; (RANGING FROM -1 TO 0) AS A TABLE, WHICH RESULTS IN 
; A NICE PHASING SWEEP.
kphs           oscili    .69, .1, 3, .25
kcoeff         =         kphs - .3

; INPUT TO THE PHASER IS THE OUTPUT OF THE DELAY LINES,
; PLUS FEEDBACK FROM THE OUTPUT OF THE PHASER. FEEDBACK
; RESULTS IN INCREASED DEPTH OF THE NOTCH FREQUENCIES, 
; MAKING A MORE PRONOUNCED "SWEEPING" SOUND.
ain            =         aout + afeed

; EACH ALLPASS STAGE TAKES THE FORM
;
; Output       =         (coeff * Input) + PreviousInput - (coeff * PreviousOutput)
; 
; THE ALLPASS SECTION CONSISTS OF 6 OF THESE STAGES IN SERIES,
; WITH EACH STAGE SHARING THE SAME COEFFICIENT. YOU CAN EASILY
; EXTEND THESE BY CUTTING AND PASTING. IN MY ORIGINAL ORCHESTRA,
; I USED A UNIT GENERATOR OF MY OWN CONSTRUCTION, ALLPASSN, FOR 
; THE PHASE SHIFTING. ALLPASSN INCLUDES N STAGES OF ALLPASS FILTERS
; IN SERIES, ALL SHARING THE SAME COEFFICIENT, WITH FEEDBACK AMOUNT
; VARIABLE. I WILL SOON SEND THIS UGEN TO JOHN FFITCH, AS IT IS
; NICE TO HAVE THIS IN A UGEN SO THAT THE KR CAN BE AT A VALUE DIFFERENT
; FROM SR.
ax1            delay1    ain
ay1            =         kcoeff * ain + ax1 - kcoeff * ay1
ax2            delay1    ay1
ay2            =         kcoeff * ay1 + ax2 - kcoeff * ay2
ax3            delay1    ay2
ay3            =         kcoeff * ay2 + ax3 - kcoeff * ay3
ax4            delay1    ay3
ay4            =         kcoeff * ay3 + ax4 - kcoeff * ay4
ax5            delay1    ay4
ay5            =         kcoeff * ay4 + ax5 - kcoeff * ay5
ax6            delay1    ay5
ay6            =         kcoeff * ay5 + ax6 - kcoeff * ay6

; FEEDBACK TO PHASER. INCREASE THE CONSTANT FOR A MORE
; PRONOUNCED EFFECT. FEEDBACK GAIN VALUES OUTSIDE OF
; THE RANGE -1 < G < 1 MAY RESULT IN OSCILLATION, OVERFLOW,
; AND OTHER NASTY THINGS.
afeed          =         .5 * ay6

; THE OUTPUT OF THE ALLPASS FILTER SERIES IS SUMMED WITH
; THE INPUT TO THE ALLPASS FILTER SERIES, TO PRODUCE AN
; OUTPUT SIGNAL WITH 3 NOTCHES IN IT. AS KCOEFF IS SWEPT,
; THE NOTCHES MOVE IN FREQUENCY, PRODUCING THE CLASSIC 
; "PHASER" EFFECT. THE OUTPUT IS ALSO SCALED BY 1/2 TO
; KEEP THE OUTPUT LEVEL ROUGHLY THE SAME AS THE INPUT LEVEL.
aout2          =         (aout + ay6) * .5

; THE OUTPUT OF THE PHASE SHIFTING SECTION IS SENT VIA
; A GLOBAL VARIABLE TO INSTR 99 (REVERBERATION).
ga2            =         ga2 + .37 * aout2

; PHASER OUTPUT SENT TO MAIN OUTPUTS. IF YOU WANT TO 
; USE THE STRAIGHT ENSEMBLE OUTPUT (WITH NO ALLPASS
; PHASE SHIFTING), REPLACE AOUT2 WITH AOUT IN THE LINE
; BELOW, AS WELL AS IN THE GA2... LINE ABOVE.
               outs      aout2, aout2

gasig2         =         0

endin


instr          99        ; SIMPLE IMPLEMENTATION OF FEEDBACK DELAY NETWORK (FDN)
                         ; REVERB, AS DESCRIBED BY JOHN STAUTNER AND MILLER 
                         ; PUCKETTE, "DESIGNING MULTI-CHANNEL REVERBERATORS," 
                         ; COMPUTER MUSIC JOURNAL, VOL. 6, NO. 1, SPRING 1982,
                         ; P.52-65. THIS VERSION STICKS TO IMPLEMENTING THE 
                         ; BASIC FDN STRUCTURE, AND LEAVES OUT MOST OF THE
                         ; FIR MULTITAP DELAY LINES AND FILTERING USED FOR
                         ; THE EARLY REFLECTIONS. FOR SOUNDS WITH NON-PERCUSSIVE
                         ; ATTACKS, THIS SIMPLE IMPLEMENTATION WORKS GREAT.

afilt1         init      0
afilt2         init      0
afilt3         init      0
afilt4         init      0

igain          =         p4 * 0.70710678117       ; GAIN OF REVERB
ipitchmod      =         p5                       ; AMOUNT OF RANDOM PITCH MOD, BETWEEN 0 AND 1
idelaytime     =         p6                       ; CONTROLS OVERALL LENGTH OF DELAY LINES
ifilt          =         p7                       ; CONTROLS CUTOFF OF LOWPASS FILTERS AT 
                                                  ; OUTPUTS OF DELAY LINES
ifreq          =         p8                       ; CONTROLS FREQUENCY OF RANDOM NOISE

kgain          linseg    .94, 66, .94, 2, 1, p3 - 68, 1
k1             randi     .001, 3.1 * ifreq, .06
k2             randi     .0011, 3.5 * ifreq, .9
k3             randi     .0017, 1.11 * ifreq, .7
k4             randi     .0006, 3.973 * ifreq, .3

atap           multitap  ga2, 0.00043, 0.0215, 0.00268, 0.0298, 0.00485, 0.0572, 0.00595, 0.0708, 0.00741, 0.0797, 0.0142, 0.134, 0.0217, 0.181, 0.0272, 0.192, 0.0379, 0.346, 0.0841, 0.504

adum1          delayr    0.072 
adel1          deltapi   0.0663 * idelaytime + k1 * ipitchmod
               delayw    ga2 + afilt2 + afilt3

adum2          delayr    0.082 
adel2          deltapi   0.0753 * idelaytime + k2 * ipitchmod
               delayw    ga2 - afilt1 - afilt4

adum3          delayr    0.095
adel3          deltapi   0.0882 * idelaytime + k3 * ipitchmod
               delayw    ga2 + afilt1 - afilt4

adum4          delayr    0.11
adel4          deltapi   0.0971 * idelaytime + k4 * ipitchmod
               delayw    ga2 + afilt2 - afilt3

afilt1         tone      adel1 * igain, ifilt
afilt2         tone      adel2 * igain, ifilt
afilt3         tone      adel3 * igain, ifilt
afilt4         tone      adel4 * igain, ifilt

               outs      afilt1 + afilt2 + atap, afilt4 + afilt3 + atap

ga2            =         0

endin
