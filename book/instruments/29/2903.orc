; MY SHOT AT A SIMULATED ANALOG SYNTH, LARGELY BASED ON MY JUNO 
; BUT WITH MORE QUANTITATIVE EDITING OF PARAMETERS (AND MORE FLEXIBLE 
; ONES IN SOME CASES).

; THE ENVELOPE IS SORT OF CHEESY, AND THE RESONANCE SEEMS A LITTLE WEIRD 
; BUT OTHER THAN THAT I THINK IT'S PRETTY COOL. 

; IDETUNE REALLY HELPED FATTEN IT UP, BUT I MIGHT WANT TO SLAP SOME CHORUS 
; ON THE END TOO. AND IDETUNE ONLY WORKS IF YOU'RE USING THE SUB OSCILLATOR. 

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr 2903

ilforate  =         5.1                      ; LFO SPEED IN Hz
ilfodelay =         0                        ; TIME BEFORE LFO STARTS, IN SECONDS
ilfopitch =         0                        ; EFFECT LFO HAS ON PITCH (FROM 0 TO 1)
isawlvl   =         0.75                     ; LEVEL OF SAWTOOTH WAVEFORM 
isublvl   =         0.5                      ; LEVEL OF SUB WAVEFORM
idetune   =         0.005                    ; HOW MUCH TO DETUNE SUB FROM SAWTOOTH 
inoislvl  =         0                        ; LEVEL OF RANDOM NOISE GENERATOR
ihpffrq   =         0                        ; CUTOFF OF GLOBAL HIGH PASS FILTER
ivcffrq   =         600                      ; CUTOFF OF GLOBAL LOW PASS FILTER 
ires      =         0                        ; RESONANCE LEVEL (NEEDS TO BE REALLY LOW LIKE 0.001)
ienvflt   =         100                      ; MAX CHANGE IN LPF CUTOFF BY ENVELOPE 
ilfoflt   =         50                       ; MAX CHANGE IN LPF CUTOFF BY LFO 
ikbdflt   =         0.1                      ; RELATIVE CHANGE IN LPF CUTOFF TO PITCH 
iattack   =         0.2                      ; ATTACK LENGTH COMPARED TO NOTE DURATION 
idecay    =         0.1                      ; DECAY LENGTH COMPARED TO NOTE DURATION 
isustain  =         0.8                      ; SUSTAIN LEVEL (1 IS FULL STRENGTH) 
irelease  =         0.2                      ; RELEASE LENGTH COMPARED TO NOTE DURATION 
isteady   =         1 - (iattack + idecay + irelease)   ; LENGTH OF SUSTAIN LEVEL

; THE OSCILLATORS

klfoenv   linseg    0, ilfodelay/2, 0, ilfodelay/2, 1, 1, 1 
klfo      oscil     1, ilforate, 1
asaw      oscili    isawlvl, p5 * (1+ klfo*ilfopitch), 3 
asub      oscil     isublvl, p5/2 * (1 + idetune) * (1 + klfo*ilfopitch), 4 
anoise    rand      inoislvl

awaves    =         asaw+asub+anoise

; THE ENVELOPE

kenv      linseg    0, p3*iattack, 1, p3*idecay, isustain, p3*isteady, isustain, p3*irelease, 0 

; THE FILTERS

ahpfed    atone     awaves, ihpffrq

klpfcut   =         ivcffrq + p5 * ikbdflt + ienvflt * kenv + ilfoflt * klfo

alpfed    tone      ahpfed, klpfcut
aresond   reson     ahpfed*ires, klpfcut, klpfcut/10 

aflted    =         alpfed + aresond

aout      =         p4*kenv*aflted

          out       aout

          endin
