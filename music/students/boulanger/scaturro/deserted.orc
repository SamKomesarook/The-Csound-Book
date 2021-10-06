;************************************************
;*                                              *
;*             DESERTED by Jen Scaturro         *
;*                                              *
;************************************************
;*                  created 5/97                *
;*                  updated 9/97                *
;************************************************


sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


;========
; INITS
;========

gapansig1 init      0
gapansig2 init      0
                    

;==============
; CHOWDRUM 01
;==============
          instr 30
                                             
iamp      =         ampdb(p4)                ; p4=AMPDB
inote     =         cpspch(p5)               ; p5=OCT.PITCH
ionecycl  =         1/p3                     ; p6=MOD FREQ
iamp2     =         p6*p7                    ; p7=IMAX
ifunc1    =         p8                       ; p8=FUNC TABLES 31,32,33,34
ifunc2    =         p9                       ; p9=SAME AS p8

k1        oscil     iamp, ionecycl, ifunc1
k2        oscil     iamp2, ionecycl, ifunc2
a1        oscil     k1, p6, 1
a2        oscil     k2, inote+p6, 1

aleft     =         a1*.5
aright    =         a1*.5

          outs      aleft, aright


          endin


;====================
; DRUM 01 (J. Fitch)
;====================
; INSTRUMENT 4
; PITCHED DRUM
          instr 4
idur      =         p3                       ; p4=AMP
iamp7     =         p4                       ; p5=PITCH IN CPS
iamp2     =         p4 * .8                  ; p6=PITCH IN CPS
iamp4     =         p4 * .3

a5        randi     p4, 1500
a5        oscili    a5, 1/idur, 52
a5        oscili    a5, p5*1.006, 1

a3        oscili    iamp4, 1/idur, 52
a3        oscili    a3, 33.1, 11

a1        oscili    iamp2, 1/idur, 51
a1        oscili    a1,    p6*.998, 1
aright    =         (a1+a3+a5)*.5
aleft     =         (a1+a3+a5)*.5

          outs      aleft, aright

gapansig2 =         (a1+a3+a5)


          endin

;==========
; DRUM 02 
;==========
; (spinoff of drum01 with no panning feature)

; INSTRUMENT 44
; PITCHED DRUM
          instr 44

idur      =         p3                       ; p4=AMP
iamp7     =         p4                       ; p5=PITCH IN CPS
iamp2     =         p4 * .8                  ; p6=PITCH IN CPS
iamp4     =         p4 * .3
                                             
a5        randi     p4, 1500
a5        oscili    a5, 1/idur, 52
a5        oscili    a5, p5*1.006, 1

a3        oscili    iamp4, 1/idur, 52
a3        oscili    a3, 33.1, 11

a1        oscili    iamp2, 1/idur, 51
a1        oscili    a1,    p6*.998, 1
aright    =         ((a1+a3+a5)*.5)*p7
aleft     =         ((a1+a3+a5)*.5)*(1-p7)

          outs      aleft, aright
          endin




;==========
; NOIZ 02
;==========
          instr 2

iamp      =         ampdb(p4)                ; p4=AMPDB
inote     =         cpspch(p5)               ; p5=OCT.PITCH

k1        linseg    1, .05, 100, .2, 100, 2, 1, p3, 1 
k2        rand      500, 1
a1        buzz      iamp*.3, inote, k1, 1
a2        buzz      iamp, inote*.5, k1, 1
a3        buzz      iamp, inote*.501, k1, 1

a4        oscil     (a1+a2+a3)*.3, k2, 1


aleft     =         .5*(a4)
aright    =         .5*(a4)

          outs      aleft, aright

          endin


;==========
; BASS 01
;==========
          instr 50
                                             
iamp      =         ampdb(p4)                ; p4=AMBDB
inote     =         cpspch(p5)               ; p5=OCT.PITCH
ionecycl  =         1/p3

k1        oscil     iamp, ionecycl, 21
a1        oscil     k1, inote, 1

aleft     =         a1*.5
aright    =         a1*.5

          outs      aleft, aright
          endin



;==================
; RING MOD HI HAT
;==================
          instr 20
                                             
iamp      =         ampdb(p4)                ; p4=AMPDB
inote     =         cpspch(p5)               ; p5=OCT.PITCH
ifunc1    =         p6                       ; p6=f TABLE (1, 4, 5)

k1        linen     iamp, 0, p3, 0           ; AMP ENV
k2        randi     k1, 1000                 ; RANDOM NUMBER GENERATOR
a1        oscil     k2, inote, ifunc1

aleft     =         a1*.5
aright    =         a1*.5

          outs      aleft, aright

          endin


;=================
; PLUCK SYNTH 01
;=================

          instr 100

iamp      =         ampdb(p4)
inote     =         cpspch(p5)
inote2    =         cpspch(p6)
idur      =         1/p3

k1        oscil     iamp, idur, 22 
a1        pluck     k1, inote2, inote, 0, 3
aleft     =         a1*.5
aright    =         a1*.5

          outs      aleft, aright

          endin


;=======
; WIND 
;=======
; INSTRUMENT 2
; White noise at 333Hz with declicking

          instr 21

iamp      =         ampdb(p4)
iwinds    =         p10
iwinde    =         1-p10
ivalu1    =         100
ivalu2    =         50

kfreq     line      p7, p3, p8
kband     line      p5, p3, p6
kfreq2    line      p7-ivalu1, p3, p8+ivalu2
kband2    line      p5+ivalu1, p3, p6-ivalu2

aenv      linseg    0,p3*(iwinds),1,p3*(iwinde),0
a1        rand      iamp
a2        butterbp  a1, kfreq, kband
a3        butterbp  a2, kfreq2, kband2

aleft     =         (a2+a3)*aenv*p9
aright    =         (a2+a3)*aenv*(1-p9)
     
          outs      aleft, aright
     

          endin


;===================
; CHIMES (J. Fitch)
;===================

          instr 14            ; SIMPLE MARIMBA
                              			; p5=PCH p4=AMP p6=BIAS
iamp      =         ampdb (p4)
                    
i1        =         cpsoct(p5)*1.2
i2        =         log(i1)/10.0 - p6
k1        expseg    .0001,.03,iamp*.7,p3-.03,.001 ; ENV
k25       linseg    1,.03,1,p3-.03,3
k1        =         k25*k1
k10       linseg    2.25,.03,3,p3-.03,2  		; POWER TO PARTIALS
a1        gbuzz     k1,i1,k10,0,35,44
a2        reson     a1,500,50,1     ;filt
a3        reson     a2,1500,100,1   ;filt
a4        reson     a3,2500,150,1   ;filt
a5        reson     a4,3500,150,1   ;filt
a6        balance   a5,a1
i6        =         p6
a7        =         a6*i2
a8        =         a6*(1-i2)
        
          
          outs      a7*p7,a8*(1-p7)
     
    
          endin


; p1 = instr #
; p2 = start time
; p3 = duration
; p4 = amp
; p5 = pitch
; p6 = panning


;================
; PHASING SYNTH
;================
 
          instr 77

iamp      =         ampdb(p4)
inote     =         cpspch(p5)

k1        linen     iamp, p6, p3, p7 

a1        oscil     k1*.18, inote, 1
a2        oscil     k1*.18, inote*1.008, 3, .02
a3        oscil     k1*.18, inote *.992, 1, .04
a4        oscil     k1*.18, inote*2, 3, .06
a5        oscil     k1*.18, inote, 3, .08
a6        oscil     k1*.18, inote, 1, .1

kosc1     oscil     10000, 1/p3, 1
kosc2     oscil     10000, 1/p3, 1, .4
kosc3     oscil     20000, 1/p3, 1, .8

afilt     butterbp  (a1+a2+a3+a4+a5+a6), kosc1, 1000
afilt2    butterbp  (a1+a2+a3+a4+a5+a6), kosc2, 300    
afilt3    butterbp  (a1+a2+a3+a4+a5+a6), kosc3, 20     


aleft     =         ((afilt+afilt2+afilt3) + (a1+a2+a3+a4+a5+a6)*.5)*p8
aright    =         ((afilt+afilt2+afilt3)+ (a1+a2+a3+a4+a5+a6)*.5)*(1-p8)

          outs      aleft, aright


          endin


;==================
; PANNING MACHINE
;==================

          instr 40
               
ibeg      =         p4             
iend      =         p5
isus1     =         ((p3-iend)*(.5))-((ibeg)*(.5))
iplace    =         p11

                                        
kline     linseg    p6, ibeg, p7, isus1, p8, isus1, p9, iend, p10 ; PAN TRICK CONTROL
kpanb     oscil     1, kline, 1			; PAN OSCIL
							
aleft1    =    ((1-iplace)-kpanb)*gapansig1
aright1   =         (iplace+kpanb)*gapansig1


          outs      aleft1, aright1

gapansig1 =         0


          endin

;========================
; PANNING MACHINE CLONE
;========================
          instr 41

ibeg      =         p4             
iend      =         p5
isus1     =         ((p3-iend)*(.5))-((ibeg)*(.5))
iplace    =         p11

                                        
kline     linseg    p6, ibeg, p7, isus1, p8, isus1, p9, iend, p10 ;
kpanb     oscil     1, kline, 1              ; PAN OSCIL
                                             

aleft2    =         ((1-iplace)-kpanb)*gapansig2
aright2   =         (iplace+kpanb)*gapansig2


          outs      aleft2, aright2

gapansig2 =         0

          endin


;p1 = i#
;p2 = pan start
;p3 = pan dur
;p4 = sus time of note before pan trik
;p5 = sus time of note after pan trik
;p6 = starting panning freq
;p7 = mid 1 panning freq
;p8 = mid 2 panning freq
;p9 = mid 3 panning freq
;p10 = ending panning freq
;p11 = placement of pan start (0=L, .5=C, 1=R)


;************** END OF ORCHESTRA FILE ***************
