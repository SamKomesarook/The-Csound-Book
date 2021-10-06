sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
garvbsig  init      0
          

;-------------------------------------------------
; ********** THE ELECTRIC PRIEST ***" Talking "***
;-------------------------------------------------
          instr 1
          
inote     =         cpspch(p5)
irvbgain  =         p8   
                    
k2        linseg    0,p3*.9,0,p3*.1,1                       ; OCTAVIATION COEFFICIENT
a1        oscil     7,.15,1                                 ; RUBATO FOR VIBRATO
a3        linen     a1,(p3-p3*.05),p3,.2                    ; DELAY FOR VIBRATO
a2        oscil     a3,5,1                                  ; VIBRATO
a5        linen     1250,p7,p3,(p3*.1)                      ; AMP ENVELOPE

a21       line      456,p6,1030                             ; p6: MORPH-TIME,0=INSTANT AAH                         
a5        linen     10000,p7,p3,(p3*.1)                     ; AMP ENVELOPE
a11       fof       a5,inote+a2,a21*(p4/100),k2,200,.003,.017,.005,10,1,2,inote,0,1

a31       line      4000,p6,6845
a32       line      2471,p6,1370                                                
a6        linen     a31,p7,p3,(p3*.1)                       ; AMP ENVELOPE
a12       fof       a6,inote+a2,a32*(p4/100),k2,200,.003,.017,.005,20,1,2,inote,0,1

a41       line      2813,p6,3170
a42       line      1650,p6,1845                                                
a7        linen     a42,p7,p3,(p3*.1)                       ; AMP ENVELOPE
a13       fof       a7,inote+a2,a41*(p4/100),k2,200,.003,.017,.005,20,1,2,inote,0,1

a71       line      1347,p6,1726                            ; AMP LINE
a72       line      3839,p6,3797                            ; FORM LINE                                                 
a8        linen     a71,p7,p3,(p3*.1)                       ; AMP ENVELOPE
a14       fof       a8,inote+a2,a72*(p4/100),k2,200,.003,.017,.005,30,1,2,inote,0,1

a51       line      1,p6,1250                                              
a9        linen     a51,p7,p3,(p3*.1)                       ; AMP ENVELOPE
a15       fof       a5,inote+a2,4177*(p4/100),k2,200,.003,.017,.005,30,1,2,inote,0,1

a61       line      1,p6,5833
a10       linen     a51,p7,p3,(p3*.1)                       ; AMP ENVELOPE
a16       fof        a10,inote+a2,428*(p4/100),k2,200,.003,.017,.005,10,1,2,inote,0,1
a7        =         (a11+a12+a13+a14+a15+a16)*p9/10

          outs      a7*.9,a7*.6

garvbsig  =         garvbsig+(a7)*irvbgain
          endin

;------------------------------------------
; ********** THE ELECTRIC PRIEST ***Aaah**
;------------------------------------------
          instr 2
          
inote     =         cpspch(p5)
irvbgain  =         p8

k2        linseg    0,p3*.9,0,p3*.1,1                  ; OCTAVIATION COEFFICIENT
a1        oscil     5,.12,1                            ; RUBATO FOR VIBRATO
a3        linen     a1,(p3-p3*.02),p3,.2               ; DELAY FOR VIBRATO
a2        oscil     a3,4,1                             ; VIBRATO
a4        linen     (p4*.4),p6,p3,(p3*.05)             ; FORMAT ENV SHAPE
a5        linen     1250,p7,p3,(p3*.15)                ; AMP ENVELOPE

a21       oscil     2,10,1                        
a5        linen     9998+a21,p7,p3,(p3*.1)             ; AMP ENVELOPE
a11       fof       a5,inote+a2*.5,a4+1030*(p4/100),k2,200,.003,.017,.005,10,1,2,inote,0,1

a22       oscil     2, 2,1
a6        linen     6843+a22,p7,p3,(p3*.1)             ; AMP ENVELOPE
a12       fof       a6,inote+a2*.5,a4+1370*(p4/100),k2,200,.003,.017,.005,20,1,2,inote,0,1

a23       oscil     1,12,1
a7        linen     1845,p7,p3,(p3*.1)                 ; AMP ENVELOPE
a13       fof       a7,inote+a2*.5,a4+3170*(p4/100),k2,200,.003,.017,.005,20,1,2,inote,0,1

a24       oscil     2,5,1
a8        linen     1726+a24,p7,p3,(p3*.1)             ; AMP ENVELOPE
a14       fof       a8,inote+a2*.5,a4+3797*(p4/100),k2,200,.003,.017,.005,30,1,2,inote,0,1

a25       oscil     3,4,1
a9        linen     1250+a25,p7,p3,(p3*.1)             ; AMP ENVELOPE
a15       fof       a5,inote+a2*.5,a4+4177*(p4/100),k2,200,.003,.017,.005,30,1,2,inote,0,1


a26       oscil     3,6,1
a10       linen     5833+a26,p7,p3,(p3*.1)             ; AMP ENVELOPE
a16       fof       a10,inote+a2*.5,a4+428*(p4/100),k2,200,.003,.017,.005,10,1,2,inote,0,1
a7        =         (a11+a12+a13+a14+a15+a16)*p9/10
          
          outs      a7*p6,a7*(1-p6)

garvbsig  =         garvbsig+(a7)*irvbgain
          endin


;-------------------------------------------------
; ********** THE ELECTRIC PRIEST ***" gliss "***
;-------------------------------------------------
          instr 4
          
inote     =         cpspch(p5)
irvbgain  =         p8

k2        linseg    0,p3*.9,0,p3*.1,1                  ; OCTAVIATION COEFFICIENT
a1        oscil     7,.15,1                            ; RUBATO FOR VIBRATO
a3        linen     a1,(p3-p3*.05),p3,.2               ; DELAY FOR VIBRATO
a2        oscil     a3,5,1                             ; VIBRATO
a5        linen     1250,p7,p3,(p3*.1)                 ; AMP ENVELOPE
a90       oscil     30,.15625,1                        ; GLISS: 1 CYCLE PER 4 BARS IF 0.4SEC =1 QUARTERNOTE

a21       line      456,p6,1030                        ; p6: MORPH-TIME,0=INSTANT AAH                         
a5        linen     10000,p7,p3,(p3*.1)                ; AMP ENVELOPE
a11       fof       a5,inote+a2+a90,a21*(p4/100),k2,200,.003,.017,.005,10,1,2,inote,0,1

a31       line      4000,p6,6845
a32       line      2471,p6,1370                                                
a6        linen     a31,p7,p3,(p3*.1)                  ; AMP ENVELOPE
a12       fof       a6,inote+a2+a90,a32*(p4/100),k2,200,.003,.017,.005,20,1,2,inote,0,1

a41       line      2813,p6,3170
a42       line      1650,p6,1845                                                
a7        linen     a42,p7,p3,(p3*.1)                  ; AMP ENVELOPE
a13       fof       a7,inote+a2+a90,a41*(p4/100),k2,200,.003,.017,.005,20,1,2,inote,0,1

a71       line      1347,p6,1726                       ; AMP LINE
a72       line      3839,p6,3797                       ; FORM LINE                                                 
a8        linen     a71,p7,p3,(p3*.1)                  ; AMP ENVELOPE
a14       fof       a8,inote+a2+a90,a72*(p4/100),k2,200,.003,.017,.005,30,1,2,inote,0,1

a51       line      1,p6,1250                                              
a9        linen     a51,p7,p3,(p3*.1)                  ; AMP ENVELOPE
a15       fof       a5,inote+a2+a90,4177*(p4/100),k2,200,.003,.017,.005,30,1,2,inote,0,1

a61       line      1,p6,5833
a10       linen     a51,p7,p3,(p3*.1)                  ; AMP ENVELOPE
a16       fof       a10,inote+a2+a90,428*(p4/100),k2,200,.003,.017,.005,10,1,2,inote,0,1
a7        =         (a11+a12+a13+a14+a15+a16)*p9/10

          outs      a7*.9,a7*.6

garvbsig  =         garvbsig+(a7)*irvbgain
          endin



;*******************************************************************************************

;|||||||||||||||||
;||-SONAR NOISE-||
;|||||||||||||||||
          
          instr 5
          
irvbgain  =         p7
i1        =         cpspch(p4)

k1        expseg    .0001,.01,p5,p3-.01,.0001
a1        rand      k1
a2        reson     a1,i1,i1/25,1
a3        balance   a2,a1
a1        =         a3*p6
a2        =         a3*(1-p6)
          
          outs      a1,a2
          
garvbsig  =         garvbsig+(a1+a2)*irvbgain
          endin


     
; SOFT OSCIL/FOF INSTRUMENT, p3:dur p4:amp p5:pitch p6:reverb p7:att p8:rel p9:bal
          
          instr 3
          
irvbgain  =         p6
inote     =         cpspch(p5)
ibalance  =         p9   

k1        oscil     300,.2,1                 
k2        oscil     200,.5,1
k3        oscil     400,.05,1                          ; RES SWEEP
                                             
a1        oscil     p4*0.30,inote*0.998,4
a2        oscil     p4*0.30,inote*1.002,4
a3        oscil     p4*0.20,inote*1.000,5
a4        fof       p4*0.20+k2,inote,600,0,40,.003,.02,.007,10,1,2,p3

amix      =         a1+a2+a3+a4
a6        butterlp  amix,k1+1000,50                    ; INPUT, FREQ, Q
a7        butterlp  a6,k1+1000,50
a8        butterhp  a7,600    
a9        reson     a8,k3+2000,50
a10       butterhp  a9*.2+a8*1,150 
a11       butterlp  a10,9000
aenv      linen     a11,p7,p3,p8

          outs      aenv*ibalance,aenv*(1-ibalance)
garvbsig  =         garvbsig+(aenv)*irvbgain
          endin
                                             
; BASS OSCIL/FM INSTRUMENT, p3:dur p4:amp p5:pitch p6:reverb p7:att p8:rel p9:bal
          
          instr 10
          
irvbgain  =         p6
inote     =         cpspch(p5)
ibalance  =         p9   

k1        line      2500,p3*.8,1500                    
k3        line      6000,p3*.5,500                     ; RES SWEEP
k2        linen     k3,.08,p3*.5,.5

a1        oscil     p4*0.40,inote*0.998-.12,06
a2        oscil     p4*0.40,inote*1.002-.12,03
a3        oscil     p4*0.40,inote*1.002-.12,06
a4        oscil     p4*0.70,inote-.24,03

amix      =         a1+a2+a3+a4
a6        butterlp  amix,k2,20                         ; INPUT, FREQ, Q
a8        butterlp  (a6),k2,20
a9        butterhp  a8,65     
a10       butterhp  a9,65     
a11       butterlp  a10,1000
aenv      linen     a11,p7,p3,p8
          
          outs      aenv*ibalance,aenv*(1-ibalance)

garvbsig  =         garvbsig+(aenv)*irvbgain
          endin


;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
; PAN NOISE
;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
          
          instr 21
                                        
irvbgain  =         p6
i1        =         octpch(p5)
                         ; CENTER PITCH, TO BE MODIFIED
k1        randh     10,10,.5                           ; 10 TIME/SEC BY RANDOM DISPLACEMENTS UP TO 1 OCTAVE
a1        oscil     p7,cpsoct(i1+k1),10
a2        reson     a1,1000,50
a3        butterlp  a2*.4+a1,2500
a4        butterlp  a3,2500
a5        butterhp  a4,950
a6        butterhp  a5,950
aenv      linen     a6,p3*.2,p3,p3*2
a7        oscil     1,.4,03
          
          outs      aenv*a7,aenv*(1-a7)

garvbsig  =         garvbsig+a1*irvbgain
          endin

;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
; HI-HAT NOISE 
;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
          
          instr 22
irvbgain  =         p6
ibalance  =         p4

k1        expon     10000,.1,2500
a0        expon     p7+150,.1,10
a1        rand      a0
a3        butterlp  a1,k1
a4        butterlp  a3,k1
a5        butterhp  a4,3500
a6        butterhp  a5,3500
a8        linen     (a6+a1),0,p3,.05  

          outs      a8*ibalance,a8*(1-ibalance)
          
garvbsig  =         garvbsig+a1*irvbgain
          endin
;'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

;------
;METAL
;------
          
          instr 23
          
irvbgain  =         p6
ibalance  =         p4
i1        =         octpch(p5)                         ; CENTER PITCH, TO BE MODIFIED
                                             
a1        fmmetal   31129.60*p7,p5,1,1.2,0.2,5.5,1,5,5,1,1
a8        linen     a1,.01,p3,p3*.3  

          outs      a8*ibalance,a8*(1-ibalance)
          
garvbsig  =         garvbsig+a1*irvbgain
          endin

;-----------
; KICK DRUM 
;-----------

          instr 25
          
irvbgain  =         p4

k1        expon     120,.2,50      
k2        expon     500,.4,200
a1        oscil     p5,k1,03                           ; SINE WAVE
a2        reson     a1,k2,50
a3        butterlp  a2+a1,k1,20
a4        butterlp  a3,k1,20
a5        butterlp  a4,2500,50
a6        butterhp  a5,50
a7        butterhp  a6,50
a8        linen     a7,0.01,p3,.2  

          outs      a8,a8
          
garvbsig  =         garvbsig+a1*irvbgain
          endin


;---------------
; GLOBAL REVERB
;---------------
          
          instr     99
          
irvbtime  =         p4

asig      reverb    garvbsig,irvbtime
          outs      asig,asig
          
garvbsig  =         0
          endin
