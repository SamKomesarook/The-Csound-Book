;;;   AXIOMATIC.ORC
;;;   COPYRIGHT © 1997 AARON JOHNSON


sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
                                             

          instr 1
idur      =         p3
iamp      =         p4
icps      =         p5
ifn       =         p6
icm       =         p7                                      ; C:M RATIO
indx      =         p8                                      ; INDEX MOD
iris      =         p9                                      ; RISE/DECAY TIME
iq        =         p12
ivib      =         p10
inois     =         iamp*p11                                ; RATIO OF FILTERED NOISE
igliss    =         p13                                     ; 1=NO GLISS
kpan      =         p14
ifm       =         p5*icm
idfm      =         indx*ifm
agls      line      icps,idur,igliss*icps                   ; LINE GLISS
k1        linen     1,iris*idur,idur,(1-iris)*idur          ; ENV WITH VARIABLE RISE/DECAY
amod      oscil     k1*idfm,ifm,ifn                         ; ENVELOPED MOD OSCIL
kvibenv   linen     10,.95*idur,idur,.05*idur               ; VIBRATO ENVELOPE
avib      oscil     kvibenv,ivib,ifn                        ; VIBRATO OSCIL
asig      oscil     k1*iamp,agls+amod+avib,ifn

k2        expseg    20,iris*idur,inois,(1-iris)*idur,20     ; VARIABLE EXPONENTIAL ENVELOPE
arand     rand      k2                       
a22       reson     arand,icps,icps/iq                      ; FILTER #1
a23       reson     arand,icps*2,(icps*2)/iq                ; FILTER #2
a24       reson     arand,(2*icps)/3,(2*icps/3)/iq          ; FILTER #3
asig2     =         a22+a23+a24
abal      balance   asig2,arand
aout      =         asig+abal
a1,a2,a3,a4 pan     aout,kpan,1,4,1,0
          
          outs      a1,a2
gareverb  =         aout*.3                                 ; 30% OF SIG GOING TO GA REVERB
          endin

          instr 2
idur      =         p3
iamp      =         p4
icps      =         p5
ifn       =         p6
icm       =         p7                                      ; C:M RATIO
indx      =         p8                                      ; INDEX MOD
ivib      =         p9
kpan      =         p10
ifm       =         p5*icm
idfm      =         indx*ifm
k1        expon     1,idur,.001                             ; HARD ATTACK, EXPON DECAY
amod      oscil     k1*idfm,ifm,ifn                         ; MOD OSCIL WITH ENVELOPE
kvibenv   linen     10,.95*idur,idur,.05*idur               ; VIBRATO ENVELOPE
avib      oscil      kvibenv,ivib,ifn
asig      oscil      k1*iamp,icps+amod+avib,ifn             
atap      multitap  asig,.01,1,.35,.4,.5,.25,.6,.25,.75,.25
a1,a2,a3,a4    pan  atap,kpan,1,4,1,0
          outs      a1,a2
gareverb  =         atap*.2                                 ; 20% OF SIG GOING TO GA REVERB
          endin

          instr 3
idur      =         p3
iamp      =         p4
icps      =         p5
ifn       =         p6
icm       =         p7                                      ; C:M RATIO
indx      =         p8                                      ; INDEX MOD
iris      =         p9                                      ; RISE/DECAY TIME
iq        =         p12
ivib      =         p10                                     ; RATE OF VIBRATO
idrum     =         p11                                     ; RATION OF PERCUSSION SIGNAL TO SUS TONE SIGNAL, 0 < P11 ² 1
kpan      =         p13
iverb     =         p14                                     ; AMOUNT OF REVERB BEING SENT TO GA REVERB
ifm       =         p5*icm
idfm      =         indx*ifm
k1        linen     1,iris*idur,idur,(1-iris)*idur          ; ENVELOPE WITH VARIABLE RISE/DECAY
amod      oscil     k1*idfm,ifm,ifn                         ; MOD OSCIL
kvibenv   linen     30,.95*idur,idur,.05*idur               ; VIBRATO ENV
avib      oscil     kvibenv,ivib,ifn
asig      oscil     (k1*iamp)/15,amod+avib,ifn              
     
k2        expon     idrum,idur,.01                          ; EXPONENTIAL ENV OF DRUM SOUND
arand     rand      k2*iamp                  
a22       reson     arand,icps*3,icps/iq                    ; FILTER#1
a23       reson     arand,icps*3.3,icps/iq                  ; FILTER#2
a24       reson     arand,220,icps/iq                       ; FILTER#3 WITH CONSTANT FORMANT
asig2     =         a22+a23+a24
abal      balance   asig2,arand
aout      =         asig+abal
atap      multitap  aout,.01,1,.5,.4,.6,.3,.7,.2
a1,a2,a3,a4 pan  atap,kpan,1,4,1,0
          outs      a1,a2
gareverb  =         atap*iverb
          endin

          instr 99
a1        reverb    gareverb, p4
          outs      a1,a1
gareverb  =         0
          endin
