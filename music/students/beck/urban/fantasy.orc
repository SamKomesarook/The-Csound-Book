
;;;;;  FANTASY BY CHARLES URBAN

;;;;;  © CHARLES URBAN 1997


sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
gaverb    init      0
gatap     init      0
gapan     init      0

          instr 1                                           ;;; CELLO (TRY THIS INSTR WITHOUT CHORUSING)
                                                                 
iindfac   =         7.5/log(p5)
iindfac2  =         (8.5-log(p5))/(3+(p5/1000))
iindfac3  =         1.25/sqrt(p5)

;;; PARALLEL MODULATORS
kenv1     linseg    iindfac+1,.2,iindfac,p3,iindfac
amod1     oscil     kenv1*p5,p5,2
kenv2     linseg    iindfac2+1,.2,iindfac2,p3,iindfac2
amod2     oscil     kenv2*3*p5,3*p5,2
kenv3     linseg    iindfac3+1,.2,iindfac3,p3,iindfac3
amod3     oscil     kenv3*4*p5,4*p5,2
kenv4     linseg    (10*iindfac2/p5),.2,10*iindfac2/p5,p3,10*iindfac2/p5
amod4     oscil     kenv4*3*p5,3*p5,2
amodsig   =         amod1+amod2+amod3+amod4

;;; INTIAL TRANSIENT     
ktransenv linen     50,.0001,.2,.001
atrans    rand      ktransenv
kbwenv    line      .2*p5,.2,0
aflt1     butterbp  atrans,2000,kbwenv

;;; NATURAL VIBRATO
kvibenv   linen     3,.5*p3,p3,.2
avib1     randi     kvibenv,5
avib2     oscil     kvibenv,4+avib1,1

;;; USER CONTROLLABALE VIBRATO
kvibenv2  linen     p10,p9*p3,p3,(1-p9)*p3
avibr     randh     3,1/5
avib3     oscil     kvibenv2,5+avibr,1
     
;;; CARRIER
kenvc     linen     p4,p12,p3,p13
acar      oscil     kenvc,p5+amodsig+aflt1+avib2+avib3,1

;;; CHOURSING
aph       phasor    p11
atap      vdelay    acar*.8,aph*100,100
aph2      phasor    p6
atap2     vdelay    acar*.8,aph2*100,100
     
achor     =         acar+atap+atap2

;;; FORMANT
af1       butterbp  achor,166.6,200
af2       butterbp  achor,650,100 
af3       butterbp  achor,1000,400
af4       butterbp  achor,2500,400
aform     =         af1+af2+af3+af4

;;; SYSTEM OUTPUT
abal      balance   aform,acar
aout1     butterhp  abal,30
gapan2    =         aout1*(1-p7)             ;; TO PANNER
gaverb    =         gaverb+aout1*p8          ;; TO REVERB
aout2     =         aout1*p7
          outs      aout2,aout2

          endin


          instr 2 ;;; BELL
     
;;; INITIAL TRANSIENT
ktransenv linen     3,.0001,.01,.001
atrans    randi     ktransenv,4
kbwenv    linseg    .2*p5,.01*p3,3,.99*p3,0 
aflt1     butterbp  atrans,p6,kbwenv

;;; CASCADE FM SYNTHESIS - 2ND ORDER
kifm      =         p5*.7809                                ;;; INDEX VALUE 1
kiifm     =         p5*1.31                                 ;;; INDEX VALUE 2
     
kenv      linen     .4,.1*p3,p3,.5*p3
krand     randi     kenv,5
     
kvalue    =         (p4> = 10000 && p5 < = 100 ? p5 * (1.31+krand) : kiifm)
     
karenv    linen     p4,.001*p3,p3,.999*p3                   ;;; CARRIER ENV
kmodenv   linen     p4/(p5*10),.01*p3,p3,.99*p3             ;;; MODULATOR ENV 
amod1     oscil     kifm*kmodenv,kifm,1                     ;;; MODULATOR1
amod2     oscil     kvalue*kmodenv+amod1,kvalue,1           ;;; MODULATOR2
acar      oscil     karenv,amod2+aflt1,1                    ;;; CARRIER

;;; SYSTEM OUTPUTS
gatap     =         gatap+acar*(1-p7)                       ;;; TO MULTITAP DELAY
gaverb    =         gaverb+acar*p8                          ;;; TO REVERB
aout      =         acar*p7
          outs      aout,aout
          endin

          instr 3
     
idummy    =         p6
     
;;; RAND CONTROL OF CARRIER FREQ
krenv     linen     10,.7*p3,p3,.3*p3
krand     randi     krenv,15  
     
;;; MODULATOR
amod      oscil     .25*p5,p5,1
     
;;; VIBRATO
kvibenv   linen     p10,p9*p3,p3,(1-p9)*p3
avib      oscil     kvibenv,4,1
     
;;; CARRIERS
kenv1     linen     p4*.97,.1*p3,p3,.8*p3
acar1     oscil     kenv1,amod+p5+krand+avib,1
kenv2     linseg    0,.02*p3,p4*.1,.08*p3,p4,.82*p3,p4,.064*p3,.1*p4,.016*p3,0
acar2     oscil     kenv2,amod*20+(2800/p5+.5)+krand+avib,1
asig      =         acar1+acar2
     
;;; CENTER FREQ ENV AND DYNAMIC FILTER
kfenv     oscil1    0,1000,p3,p11
afltr     reson     asig,kfenv,70
     
;;; FORMANT
af1       butterbp  afltr,350,200
af2       butterbp  afltr,700,200
af3       butterbp  afltr,2700,200     
asig2     =         af1+af2+af3
     
;;; SYSTEM OUTPUT
afltr2    tone      asig2,50+sqrt(p4)
abal      balance   afltr2,asig
gaverb    =         gaverb+abal*p8                 ;; TO REVERB
aout      =         abal*p7
gapan     =         abal*(1-p7)                   ;;; TO PANNER
          outs      aout,aout
          endin

          instr 96                                ;;; PANNER FOR CELLO
kpan      oscil1    0,1,p3,p4
a1,a2,a3,a4  pan    gapan2,kpan,1,10,1,0
          outs      a1,a2
gapan2    =         0
          endin


          instr 97                                ;;; MULTITAP DELAY FOR BELL
it        table     .3,9
atap      multitap  gatap,.1+it,.1,.3,.2,.5+it,.3,.7,.2,.9+it,.1,1.1,.09,1.3+it,.07,1.5,.05,1.7+it,.03,1.9,.01
kpan      randi     1,1/5
a1,a2,a3,a4    pan  atap,abs(kpan),1,10,1,0
          outs      a1,a2
gatap     =         0
          endin

          instr 98                                ;;; REVERB FOR ALL INSTR
averb     reverb2   gaverb,p4,.7
          outs      averb,averb
gaverb    =         0
          endin

          instr 99                                ;;; PANNING UNIT FOR VOICE
kpan      oscil1    p4,1,p3,p5
a1,a2,a3,a4    pan  gapan,kpan,1,10,1,0
          outs      a1,a2
gapan     =         0
          endin
