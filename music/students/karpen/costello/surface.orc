; surface.orc
;
; SEAN COSTELLO
; MUSIC 402
; MARCH 11, 1999
; 
; A MEDITATION UPON THE SURFACE OF A SOUND.
; THE SOUND IS FROZEN IN TIME, AND THE SINGULARITIES THAT MAKE UP THE SOUND
; ARE EXPLORED.
; GABOR WOULD BE PROUD.
; UNFORTUNATELY, THE SOUND UNEXPECTEDLY FALLS (OR IS PULLED?) BENEATH
; THE SURFACE, TO A WATERY GRAVE.
; WAS IT AN ACCIDENT?
; OR WAS IT THE TREACHEROUS GRIP OF ARCHITEUTHIS THAT INTERRUPTED 
; OUR STUDY OF THE QUANTUM NATURE OF SOUND?
;
; OK, I AM ON SORT OF A GIANT SQUID KICK LATELY.
;
; I ENDED UP CHANGING IT SO THAT THE SOUND EMERGES FROM THE WATER.  
; "SURFACES" FROM THE WATER, IF I MAY BE SO BOLD.
; DOES ANYONE ACTUALLY READ THIS?

sr             =         44100
kr             =         2205
ksmps          =         20
nchnls         =         2

ga1            init      0              ; SENDS OUTPUT OF TIME STRETCHING INSTRUMENT TO REVERB
ga2            init      0              ; DITTO

instr          1

iwindfun       =         1              ; HALF-COSINE
isampfun       =         2              ; apocalypse.aiff
ibeg           =         0              ; JUST COPIED FROM MANUAL
iwindsize      =         2000           ; WORKS WELL WITH SOUND IN QUESTION
iwindrand      =         1500           ; GIVES SWIRLY EFFECT, LESS COMB FILTERING
ioverlap       =         83             ; I LIKE LOTS OF OVERLAPS, FOR A NICE REVERBERANT SOUND.
idur           =         p3             ; OVERALL DURATION OF NOTE
ibegtime       =         p4             ; WHERE IN SOUNDFILE SNDWARP STARTS READING
iendtime       =         p5             ; WHERE IN SOUNDFILE SNDWARP STOPS READING
iattack        =         p6             ; ATTACK OF AMPLITUDE ENVELOPE, AS PERCENTAGE OF TOTAL DUR
iamp           =         p7             ; OVERALL AMPLITUDE OF NOTE, WITH 1 BEING THE BASELINE
irelease       =         p8             ; DECAY OF AMP ENV, AS % OF TOTAL DUR.  THE % OF SUSTAIN OF THE NOTE
                                        ; IS DETERMINED BY 1 - (IATTACK + IDECAY).  ASR ENVELOPE, SIMPLE BUT USEFUL.
ibegpitch      =         p9             ; BEGINNING PITCH OF NOTE, WITH 1 BEING PITCH OF ORIGINAL SAMPLE
iendpitch      =         p10            ; ENDING PITCH OF NOTE, WITH 1 BEING PITCH OF ORIGNAL SAMPLE
iwetbeg        =         sqrt(p11)      ; INITIAL RATIO OF DRY (STRAIGHT SNDWARP OUTPUT) TO WET (SNDWARP OUTPUT 
                                        ; THROUGH MY "MOISTURIZER")
idrybeg        =         sqrt(1-p11)    
iwetattack     =         p12            ; DETERMINES ATTACK OF WET/DRY ENVELOPE, AS PER AMPLITUDE ENVELOPE ABOVE
iwetsus1       =         sqrt(p13)      ; AMOUNT OF WETNESS DURING INITIAL PART OF SUSTAIN OF ASR ENVELOPE.
idrysus1       =         sqrt(1-p13)    
iwetsus2       =         sqrt(p14)      ; ALLOWS FOR DIFFERENT WET/DRY RATIO AT END OF "SUSTAIN" PHASE. NOT REALLY
idrysus2       =         sqrt(1-p14)    ; AN ASR ENVELOPE AT ALL, SO MUCH AS AN ENVELOPE THAT TRAVERSES
                                        ; BETWEEN FOUR SPECIFIED POINTS, WITH THE RATE OF TRAVEL BETWEEN
                                        ; EACH POINT CONTROLLED.
iwetrelease    =         p15            ; DETERMINES RELEASE OF WET/DRY ENVELOPE.  AS IN THE AMPLITUDE ENVELOPE,
                                        ; THE LENGTH OF THE SUSTAIN SEGMENT IS DETERMINED BY 
                                        ; 1 - (iwetattack + iwetdecay)
iwetend        =         sqrt(p16)      ; AMOUNT OF WETNESS AT END OF SOUND.
idryend        =         sqrt(1-p16)    
ichan1         =         sqrt(p17)      ; DETERMINES THE PLACEMENT IN THE STEREO FIELD OF THE DRY SOUND.
ichan2         =         sqrt(1-p17)
ispeed         =         p18            ; DETERMINES SPEED OF WATER NOISE
ireverb        =         p19            ; CONTROLS AMOUNT OF REVERB PER NOTE

; DETERMINES WHERE IN THE SOUND TO BEGIN AND END READING, AND HOW LONG IT TAKES
; TO TRAVERSE THE TWO POINTS
ktimpnt        linseg    ibegtime, idur, iendtime

; DETERMINES BEGINNING AND ENDING PITCHES FOR SOUND.
aresamp        linseg    ibegpitch, idur, iendpitch

; SNDWARP SECTION THAT GENERATES ACTUAL NOTES.  BEAUTIFUL VOICES FROM A CREAKY OLD JUNKIE GEEZER.
asig           sndwarp   .1, ktimpnt, aresamp, isampfun, ibeg, iwindsize, iwindrand, ioverlap, iwindfun, 1

; OVERALL AMPLITUDE ENVELOPE FOR SOUND
kenv           linseg    0, idur * iattack, iamp, idur - (idur * (iattack + irelease)), iamp, idur * irelease, 0

; SNDWARP OUTPUT MULTIPLIED BY AMPLITUDE ENVELOPE
asigb          =         asig * kenv

; AMPLITUDE BASED FILTERING - OPENS AND CLOSES BANDWIDTH OF RESON FILTER
avoc1          reson     asigb, 0, kenv * 15000 + 500, 1

; OK, THE SOUND IS A LITTLE TOO DULL, SO I AM INCLUDING A SECOND RESON FILTER
; TO TRY AND BRIGHTEN THINGS UP.  
avoc2          reson     asigb, 5200, kenv * 500 + 100, 1
avoc3          reson     asigb, 7500, kenv * 500 + 200, 1

avoc           =         (avoc1 + avoc2 + avoc3) * .333

; FOR DRY SOUND, AVOC IS MULTIPLIED BY DRY RATIO ENVELOPE.
kdry           linseg    idrybeg, idur *iwetattack, idrysus1, idur - (idur * (iwetattack + iwetrelease)), idrysus2, idur * iwetrelease, idryend
adryout        =         avoc * kdry

achan1         =         ichan1 * adryout
achan2         =         ichan2 * adryout


; CREATES PITCH VIBRATO FOR "MOISTURIZER"
kvib           linseg    1.5, idur, 3             ; CONTROLS AMOUNT OF PITCH VIBRATO DURING UNDERWATER SECTION
ktime1         oscili    .0012 * kvib, 4, 1       ; USED TO CREATE PITCH VIBRATO
ktime2         oscili    .0009 * kvib, 5, 1       ; DIFFERENT VIBRATO RATE
ktime3         oscili    .00087 * kvib, 6.3, 1    ; DIFFERENT VIBRATO RATE
ktime4         oscili    .0011 * kvib, 4.4, 1     ; DITTO

; FOUR INTERPOLATING DELAY TAPS, EACH MODULATED BY DIFFERENT OSCILLATOR
adummy         delayr    .030
asig1          deltapi   ktime1 + .015
asig2          deltapi   ktime2 + .015
asig3          deltapi   ktime3 + .015
asig4          deltapi   ktime4 + .015
               delayw    avoc

; THE OUTPUTS OF THE FOUR DELAY TAPS ARE SUMMED TOGETHER.  THE ORIGINAL SIGNAL IS NOT
; ADDED IN WITH THE MODULATED DELAY OUTPUTS.  I PREFER THIS SOUND - MORE THROUGH-ZERO
; FLANGING, LESS OBVIOUS METALLIC RESONANCES.  COPPED THE IDEA FROM THE OLD ARP STRING
; ENSEMBLE CHORUS UNITS (THINK "DREAM WEAVER" BY GARY WRIGHT)
avib           =         (asig1 + asig2 + asig3 + asig4)

kfenv1         linseg    300, idur * .5, 500, idur * .5, 100
;kfenv1        =         500
;kq1           linseg    100, idur * .5, 10, idur * .5, 30
kq1            =         15 + (200 * kdry)
krandamp1      linseg    300, idur, 200
kspeed         linseg    1, p3 * .4, 3, p3 * .6, 7
krand1         randi     krandamp1, kspeed * 7.31 * ispeed
krand2         randi     krandamp1, kspeed * 3.2 * ispeed
krand3         randi     krandamp1, kspeed * 4.7 * ispeed
krand4         randi     krandamp1, kspeed * 9 * ispeed


; SUM OF FILTER ENVELOPE OUTPUT AND OUTPUTS OF LOW FREQUENCY NOISE GENERATORS.
kfiltfreq1     =         kfenv1 + krand1
kfiltfreq2     =         kfenv1 + krand2
kfiltfreq3     =         kfenv1 + krand3
kfiltfreq4     =         kfenv1 + krand4

; FOUR RESON FILTERS, WITH CUTOFF FREQ MODULATED BY ENVELOVE GENERATORS AND
; LOWPASS NOISE.  SOUNDS NICE AND WATERY, IF DONE PROPERLY.
afilt1         reson     avib, kfiltfreq1, kq1, 1
afilt2         reson     avib, kfiltfreq2, kq1, 1
afilt3         reson     avib, kfiltfreq3, kq1, 1
afilt4         reson     avib, kfiltfreq4, kq1, 1

; OUTPUTS OF FILTERS ARE SUMMED TOGETHER.  EACH FILTER IS PANNED ACROSS STEREO 
; FIELD BY A DIFFERENT AMOUNT, WHICH VASTLY IMPROVES THE SOUND.
aout1          =         (.9 * afilt1) + (.67 * afilt2) + (.33 * afilt3) + (.1 * afilt4)
aout2          =         (.1 * afilt1) + (.33 * afilt2) + (.67 * afilt3) + (.9 * afilt4)

; FILTER SUMS ARE MULTIPLIED BY DRY RATIO ENVELOPE.
kwet           linseg    iwetbeg, idur * iwetattack, iwetsus1, idur - (idur * (iwetattack + iwetrelease)), iwetsus2, idur * iwetrelease, iwetend
awet1          =         aout1 * kwet
awet2          =         aout2 * kwet

; AMOUNT OF SOUND SENT TO GLOBAL REVERB.  HAVE MADE THIS CONSTANT.  TOO MANY DAMN 
; PARAMETERS TO WORRY ABOUT AT THIS POINT.
; OK, MADE IT PER NOTE.  ADD ANOTHER 1/2 HOUR ONTO MY MORNING
ga1            =         ga1 + .1 * (achan1 + awet1) * ireverb
ga2            =         ga2 + .11 *(achan2 + awet2) * ireverb

; OUTPUTS CONSIST OF WET AND DRY OUTPUTS SUMMED TOGETHER.
               outs      awet1 + achan1, awet2 + achan2


endin




instr          99                       ; REVERB INSTRUMENT.      PRETTY STANDARD.

idur           =         p3

a1             reverb2   ga1, 3.2, .5
a2             reverb2   ga2, 3.33, .5
     
               outs      a1, a2

ga1            =         0
ga2            =         0

endin


