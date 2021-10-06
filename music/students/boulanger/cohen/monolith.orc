;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;                                                        THE MONOLYTH
;                                                             BY
;                                                      JEAN-LUC COHEN
;                                                 BERKLEE COLLEGE OF MUSIC
;                                                    BRACES@XENSEI.COM
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2



          instr 1

; p3       =        duration of note
; p4       =        amplitude of carrier
; p5       =        freq of carrier
; p6       =        start freq of modulator
; p7       =        endin freq of modulator
; p8       =        start amp of carrier
; p9       =        endin amp of modulator
; p10      =        time 2 for carrier env



k1        expseg    p6,p3,p7                                ; ENVELLOPE FOR MODULATOR FREQ
k2        linseg    p8,p3,p9                                ; ENVELLOPE FOR MODULATOR AMP
k3        linseg    0,p10,p4,p11,0                          ; ENVELLOPE FOR CARRIER AMP
                                             
alfo      oscil     1000,5,3                                ; LFO
a2        oscil     k1,k2,2                                 ; MODULATING OSCILATOR
a1        oscil     (k3+alfo),p5+a2,1                       ; CARRIER OSCILATOR

adel      delay     a1,.5

          outs      a1*.5,adel*.5

          endin


          instr 2                                           ; BELL LIKE SOUND
                         



a8        oscil     80,(p5*.52),3
k2        expon     p4,p3,.001                              ; CARRIER ENV
a1        oscil     k2,p5*a8/8,3                            ; CARRIER OSCIL
                    

k3        expon     6000,p3,.01                             ; MOD ENV
a2        oscil     k3,p5+1.17,3                            ; MOD OSCIL

k9        expon     6000,p3,.001
a3        oscil     k9,p5+2.75,3

k9        expon     3000,p3,.001
a4        oscil     k9,p5+111,3

k9        expon     5000,p3,.001
a5        oscil     k9,p5+.56,3

k9        expon     p4,p3,.1
a6        oscil     k9,(p5/2),3                             ; SINE WAVE
     

a5        =         a1+a2+a3+a4+a5+a6                       ; DEFINING OUTPUT
ga5       =         a5

          outs      a5*.25,a5*.25                           ; MIX OUT DRY+VERB
          endin

                         
          instr 3             ; PLUCKED INSTRUMENT



k1        expon     15000,p3/2,10                           ; ENVELLOPE 4 LP FILTER LEFT
k2        expon     1000,p3,2775                            ; ENVELLOPE 4 LFO AMP
k3        expon     1,p3,8                                  ; ENVELLOPE 4 LFO FREQ
k4        expon     20000,p3,3                              ; ENVELLOPE 4 LP FILTER RIGHT
                                             
a4        oscil     300,15000,4                             ; OSCIL 4 RINGMOD

alfo      oscil     k2,k3,3                                 ;  LFO

a1        pluck     10000,32,128,0,3,1

a3        =         (a1*a4)+alfo                            ; RINGMOD+LFO

al        butterlp  a3,k1                                   ; LP FILTER LEFT

a5        vdelay    a3,200,10000                            ; DELAY RIGHT

ar        butterlp  a5,k4                                   ; LP FILTER RIGHT

          outs      al/60,ar/60

          endin


                    

          instr 14                                          ; RANDOM MIDROTONAL INSTRUMENT
                              

iseed     =         p6
idur      =         p3
klforate  linseg    5,p3,25
kindex    randh     int(15),klforate,iseed
k1        oscil     2,4,1                                   ; VIB
kpitch    table     abs(kindex),25
                                             

k1        oscil     2,4,1                                   ; VIB

a1        fof       p4,cpspch(kpitch)+k1,150,1,60,.01,.1,.05,20000,1,19,100
a2        fof       p4,cpspch(kpitch)+k1,50,1,60,.001,.1,.05,20000,1,19,100

a5        =         (a1/2)+(a2/2)
     
;         display   a5,.1

kpan      linseg    1,p3,0
kmp       linseg    0.5,5*(p3/6),1,p3/6,0
          outs      (a5*kmp)/10,a5*kmp


          endin

          instr 15                                          ; YET ANOTHER RANDOM MICROTONAL INSTRUMENT


iseed     =         p5
idur      =         p3
klforate  linseg    5,p3,15
kindex    randh     int(15),klforate,iseed
k1        oscil     2,4,1                                   ; VIB
kpitch    table     abs(kindex),26
     


k1        oscil     2,4,1                                   ; VIB
     
a1        fof       5000,cpspch(kpitch)+k1,500,2,120,.01,.05,.5,20000,3,19,100
a2        fof       5000,cpspch(kpitch)+k1,1500,2,120,.001,.05,.5,20000,3,19,100

a5        =         (a1+a2)
     
kmp       linseg    0.2,5*(p3/6),1,p3/6,0
     

kpan      linseg    1,p3,0

          outs      (a5/2)*kmp,(a5*kmp)/10


          endin


          instr 10                                          ; GRANULAR SYNTHESIS
     
     
kamp      linseg    1500,p3,3000
kpcs      linseg    660,p3,520
kdens     linseg    1,p3,400
kenv      linseg    .001,p3*.5,.9
kvar1     linseg    50,p3/2,10
kvar2     linseg    60,p3/2,10
     
a1        grain     kamp,kpcs,kdens,50,kvar1,kenv,1,2,.9
a2        grain     kamp,kpcs*.87,kdens,60,kvar2,kenv,1,2,.9
     
     
     
     
          outs      a1/2,a2/2

          endin

          instr 20
     
     
kamp      linseg    1000,p3,2000
kpcs      linseg    1220,p3,745
kdens     linseg    5,p3,250
kenv      linseg    .001,p3*.5,.9
     
a1        grain     kamp,kpcs,kdens,50,20,kenv,3,2,.9
a2        grain     kamp,kpcs*.87,kdens,60,20,kenv,1,2,.9
     
     
     
     
          outs      a1/2,a2/2
                    
          endin


          instr 30
     
     
kamp      linseg    1000,p3,1500
kpcs      linseg    2390,p3,2390
kdens     linseg    10,p3,10
kenv      linseg    .001,p3*.5,.9
     
a1        grain     kamp,kpcs,kdens,50,20,kenv,1,2,.9
a2        grain     kamp,kpcs*.87,kdens,60,20,kenv,2,2,.9
     
     
; a3       grain     kamp,1600*kp,500,0,10,.05,1,2,.1
     
          outs      a1/2,a2/2
                    
          endin
