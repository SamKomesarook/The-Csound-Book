;;; SUFFER THE CHILDREN
;;; COPYRIGHT 1997 WILLIAM PRICE

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


ga1       init      0

          instr 1

; FREQ MODULATION WITH ENV.

icm       =         p13                                     ; C:M 
imod      =         p14                                     ; MOD INDEX
ifm       =         p5*icm                                  ; FREQ OF MOD.
idfm      =         imod*ifm                                ; DEPTH OF MOD.
                                                                                                                   
; BASIC FM INSTR
kamp      linen     p4/p12,p15*p3,p3,p16*p3                 ; AMP ENV W/ p12 AMP DIVSOR AND p15 & p16 (ATTACK/DECAY PARAMETERS)
kmodenv   linen     imod,p15*p3,p3,p16*p3                   ; MOD. ENV W/ p15 & p16 (ATTACK/DECAY. PARAMETERS)
amod      oscil     kmodenv*ifm,ifm,1                       ; MODULATOR oscil W/ FIXED FXNTABLE 1
asig      oscil     kamp,p11+amod,1                         ; CARRIER oscil W/ FREQ p11 + MOD OSCIL, FIXED FXNTABLE 1
                                             
; CHANT INSTR
k1        linen     p4/p10,.08*p3,p3,.15*p3                 ; AMP ENV W/ AMP DIVSOR p10 PARAMETER
krand     randi     7,4                                     ; randi FUNCTION
a1        oscil     p9,p8,p7                                ; oscil MOD. Oscil W/ PARAMETERS p9, p8, p7
a2        oscil     k1,p5+a1+krand,p6                       ; oscil W/ FREQ + MOD oscil + randi FUNCTION

; STEREO PAN UNIT
     
aout      =         asig+a2
aftr1     butterlp  aout,22000
aleft,aright,adum1,adum2 pan aftr1,p17,1,10,1,0             ; PAN UNIT
     
          outs      aleft,aright

; GLOBAL REVERB
ga1       =         (ga1+aleft+aright)/15
     
          endin




          instr 2
     
; FILTER PARALLEL UNIT
k1        linen     p4/p13,.1*p3, p3,.9*p3                  ; AMP ENV W/ AMP DIVSOR p13 PARAMETER
a1        rand      k1                                      ; rand WHITE NOISE  
aftr1     tone      a1,4000                                 ; LOW PASS 4000 FREQ
aftr3     reson     aftr1,p7,p7/p8                          ; BAND PASS1  Q = p7/p8
aftr4     reson     aftr1,p9,p9/p10                         ; BAND PASS2  Q = p9/p10
aftr5     reson     aftr1,p11,p11/p12                       ; BAND PASS3  Q = p10/p11
aftr6     =         aftr3+aftr4+aftr5             
     
; OSCIL UNIT
k11       linen     p4/p16,.1*p3,p3,.9*p3                   ; AMP ENV W/ DIVSOR p16 PARAMETER
k12       linseg    p5,.1*p3,p5-p14,.2*p3,p5+p15,.7*p3,p5   ; LINSEG FREQ-p14 AND FREQ+p15
asig      oscil     k11,p5+k12,p6                           ; oscil+linseg
     
; MULTITAP UNIT     
atap      multitap  aftr6,.3,3/p4,.5,5/p4,.7,8/p4           ;MULTITAP DELAY W/ 3 POINTS

aout      =         atap+asig

; FILTER LOW PASS   
aftr7     butterlp  aout, 22000

; STEREO PAN UNIT   
aleft,aright,adum1,adum2 pan aftr7,p17,1,10,1,0             ; PAN UNIT
     
          outs      aright,aleft
          
; GLOBAL REVERB     
ga1       =         (ga1+aright+aleft)/15

          endin 
                                                  
          

          instr 3
     
; ADDITIVE WITH RAND FREQ PARAMETERS
krand     randi     p7,p8                                   ; RANDI W/ PARAMETERS p7 p8
     
kamp      linen     p4,.35*p3,p3,.65*p3                     ; AMP ENV1
a1        oscil     kamp,p5+krand,p6                        ; OSCIL1 W/ FREQ+RANDI
     
     
kamp1     linen     p4,.25*p3,p3,.75*p3                     ; AMP ENV2
a2        oscil     kamp1,p5+krand,2                        ; OSCIL2 W/ FREQ+RANDI 
                                                            ; AND FIXED FXNTBLE 2
     
     
kamp2     linen     p4,.15*p3,p3,.8*p3                      ; AMP ENV3
a3        oscil     kamp2,p5+krand,3                        ; OSCIL3 W/ FREQ+RANDI
                                                            ; AND FIXED FXNTBLE 3
               
kamp3     linen     p4,.05*p3,p3,.8*p3                      ; AMP ENV4
a4        oscil     kamp3,p5+krand,4                        ; OSCIL3 W/ FREQ+RANDI
                                                            ; AND FIXED FXNTBLE 4
                                                                           
asig      =         a1+a2+a3+a4

; FILTER UNIT
afiltr    butterlp  asig,22000                              ; BUTTER LOW PASS FILTER 22000 HZ 

; LINSEG ON PAN     
kpan      linseg    p9,p10*p3,abs(1-p9),p11*p3,p9           ; LINSEG PAN W/ p10 & p11 PARAMETERS

; STEREO PAN UNIT   
aleft,aright,adum1,adum2 pan afiltr,kpan,1,10,1,0           ; PAN UNIT
     
     
          outs      aleft,aright

; GLOBAL REVERB UNIT
ga1       =         (ga1+aleft+aright)/15                                                 

          endin

    
    
    
       
          instr 99

; GLOBAL REVERB INSTRUMENT    
aout      reverb    ga1,p4
          outs      aout,aout
ga1       =         0

          endin
