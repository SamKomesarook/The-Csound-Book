sr             =         44100
kr             =         44100
ksmps          =         1
nchnls         =         1

instr 1 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ROLAND TB-303 BASSLINE EMULATOR
; CODED BY JOSEP Mª COMAJUNCOSAS , SEPT 1997 TO OCT 1998
; PLEASE SEND YOUR COMMENTS, SCORES (AND MONEY ;-)) TO
; TO GELIDA@INTERCOM.ES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; INITIAL SETTINGS; CONTROL THE OVERALL CHARACTER OF THE SOUND
imaxfreq       =         5000                                    ; max.filter cutoff freq. when ienvmod = 0
imaxsweep      =         sr/2                                    ; ... max.filter freq. at kenvmod & kaccent= 1
iratio         =         20                                      ; "compression" ratio for the distorter. Must be > 0

; INIT VARIABLES; DON´T TOUCH THIS!
itranspose     =         p15                                     ; 1 raise the whole seq. 1 octave, etc.
iseqfn         =         p16
iaccfn         =         p17
idurfn         =         p18
imaxamp        =         p19                                     ; maximum amplitude. Max 32768 for 16 bit output monophonic
ibpm           =         p14                                     ; 4/4 bars per minute (or beats?)
inotedur       =         15/ibpm   
icount         init      0                                       ; sequence counter (for notes)
icount2        init      0                                       ; id. for durations
ipcount2       init      0
idecaydur      =         inotedur
imindecay      =         (idecaydur<.2 ? .2 : idecaydur)         ; set minimum decay to .2 or inotedur
ipitch         table     0,iseqfn                                ; first note in the sequence
ipitch         =         cpspch(itranspose + 6 + ipitch/100)
kaccurve       init      0

; TWISTING THE KNOBS FROM THE SCORE (SIMPLE LINES TO TEST)
kfco           line      p4, p3, p5
kres           line      p6, p3, p7
kenvmod        line      p8, p3, p9
kdecay         line      p10, p3, p11
kaccent        line      p12, p3, p13

start:
; PITCH & PORTAMENTO FROM THE SEQUENCE
ippitch        =         ipitch
ipitch         table     ftlen(iseqfn)*frac(icount/ftlen(iseqfn)),iseqfn
ipitch         =         cpspch(itranspose + 6 + ipitch/100)

if ipcount2 !  =         icount2 goto noslide
kpitch         linseg    ippitch, .06, ipitch, inotedur-.06, ipitch
goto next

noslide:
     kpitch    =         ipitch

next:
ipcount2       =         icount2
               timout    0,inotedur,contin
icount         =         icount + 1
               reinit    start
rireturn

contin:
; ACCENT DETECTOR
iacc           table     ftlen(iaccfn)*frac((icount-1)/ftlen(iaccfn)), iaccfn
if iacc        ==        0 goto noaccent

ienvdecay      =         0                                                 ; accented notes are the shortest ones
iremacc        =         i(kaccurve)
kaccurve       oscil1i   0, 1, .4, 3
kaccurve       =         kaccurve+iremacc                                  ; successive accents cause hysterical raising cutoff

goto sequencer

noaccent:
kaccurve       =         0                                                 ; no accent & "discharges" accent curve
ienvdecay      =         i(kdecay)

sequencer:
aremovedc      init      0                                                 ; set feedback to 0 at every event
imult          table     ftlen(idurfn)*frac(icount2/ftlen(idurfn)),idurfn
if imult       !=        0 goto noproblemo                                 ; compensate for zero padding in the sequencer

icount2        =         icount2 + 1
goto sequencer

noproblemo:
ieventdur      =         inotedur*imult

; NOTE THAN THE ENVELOPE IS SENSITIVE TO NOTE DURATION
; IN FACT, TO THE DURATION OF A STREAM OF SLIDED NOTES
; THIS IS RICHER THAN SETTING A STATIC ENVELOPE TIME
; BUT IT WORKS DIFFERENT FROM A REAL TB-303

; TWO ENVELOPES
kmeg           expseg    1, imindecay+(3.4*ienvdecay), ienvdecay+.000001   ; <- fixed time
kmeg           expseg    1, imindecay+((ieventdur-imindecay)*ienvdecay), ienvdecay+.000001
kveg           linen     1, .004, ieventdur, .016

; AMPLITUDE ENVELOPE
kamp           =         kveg*((1-i(kenvmod)) + kmeg*i(kenvmod)*(.5+.5*iacc*kaccent))

; FILTER ENVELOPE: 2 OPTIONS
; 1:SOFT SUSTAINED (REQUIRES HIGHER KENVMOD)
; ksweep       =         imaxfreq + (.7*kmeg+.3*kaccurve*kaccent)*kenvmod*(imaxsweep-imaxfreq)
; kfco         =         50 + kfco * ksweep                                ; cutoff always greater than 50 Hz ...
; 2:EXTREME SWEEP (MORE "ACID")
kfco           =         50 + imaxfreq*kfco*(1-kenvmod)+imaxsweep*kenvmod*(.7*kmeg +.3*kaccurve*kaccent)

kfco           =         (kfco > sr/2 ? sr/2 : kfco)                       ; could be necessary

               timout    0, ieventdur, out
icount2        =         icount2 + 1
               reinit    contin

out:
; GENERATE BANDLIMITED SAWTOOTH WAVE
abuzz          buzz      kamp, kpitch, sr/(4*kpitch), 1 ,0                 ;bandlimited pulse
asawdc         filter2   abuzz, 1, 1, 1, -.99                              ; leaky integrator
asaw           =         asawdc                                            ; a leaky integrator "forgets" DC transients

; RESONANT 4-POLE LPF
ax             =         asaw
ay1            init      0
ay2            init      0
ay3            init      0
ay4            init      0

kfcon          =         kfco/(sr/2)                                       ; use freq normalized DC to Nyquist
kp             tablei    kfcon, 21, 1                                      ; (approximated) tuning table
kscale         tablei    (kp+1)/2, 20, 1                                   ; adjust feedback (approximation)
kk             =         kres*kscale

; INVERTED FEEDBACK FOR CORNER PEAKING
ax             =         ax - kk*ay4

; 4 CASCADED ONEPOLE FILTERS (BILINEAR TRANSFORM)
ax1            delay1    ax
ay1            =         ax * (kp+1)/2 + ax1 * (kp+1)/2 - kp*ay1
ay11           delay1    ay1
ay2            =         ay1 * (kp+1)/2 + ay11 * (kp+1)/2 - kp*ay2
ay21           delay1    ay2
ay3            =         ay2 * (kp+1)/2 + ay21 * (kp+1)/2 - kp*ay3
ay31           delay1    ay3
ay4            =         ay3 * (kp+1)/2 + ay31 * (kp+1)/2 - kp*ay4

; CLIPPER/DISTORTER VIA WAVESHAPING
; TO ALLOW AUTOOSCILLATION WITHOUT OVERDRIVING
; CERTAINLY MORE EFFICIENT WITH TABLE LOOK-UP,
; WAIT FOR NEXT RELEASE ;-)

;ay4           =         ay4-ay4*ay4*ay4/6                                 ; bandlimited sigmoid (Taylor expansion)
ay4            =         tanh(ay4)                                         ; ~ ay4 at small values, but limited to +-1
;ay4           =         ay4 - ay4*ay4*ay4

; RESONANCE CONTROLLED ARCTAN() OR TANH() DISTORTION
; NOTE THIS DISTORTION IS AFTER THE FILTER, NOT INSIDE THE LOOP

;ay5           =         (taninv(kres*ay4*iratio))/(taninv(kres*iratio))   ; distorter
ay5            =         (tanh(kres*ay4*iratio))/(tanh(kres*iratio))

; FINAL OUTPUT

               out       imaxamp*kamp*ay5
               endin

