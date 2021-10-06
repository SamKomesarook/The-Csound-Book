;;;  CAVE MUSIC
;;;  © MICHAEL ALDERSON 1997


sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
          
ga1       init      0
ga2       init      0
gatap     init      0
gapan1    init      0
gapan2    init      0
gaamp     init      0

;**************************************************************************************
          instr 1
                    
idur      =         p3
iamp      =         p4
icps      =         p5
ifn       =         p6
ibw       =         p7
ipan      =         p8                       

k1        linenr    iamp*10,.05*idur,.95*idur,.02 ; ENVELOPE
asig      oscil     k1,icps,ifn

aftr1     butterbp  asig,icps,ibw            ; SERIES OF FILTERS IN PARALLEL
aftr2     butterbp  asig,icps*1.1,ibw
aftr3     butterbp  asig,icps*1.2,ibw
aftr35    butterbp  asig,icps*1.3,ibw
aftr4     butterbp  asig,icps*.9,ibw
aftr5     butterbp  asig,icps*.8,ibw
aftr6     butterbp  asig,icps*.7,ibw
aftrf     =         aftr1+aftr2+aftr3+aftr4+aftr5+aftr35+aftr6 ; ADD FILTERS TOGETHER

gapan1    =         ipan 
          
aout      =         aftrf 
ga1       =         ga1+aout
          
          endin



; ************************************************************************

          instr 2

idur      =         p3
iamp      =         p4
icps      =         p5
ifn       =         p6
icm       =         p7                       ; C/M RATIO
imod      =         p8                       ; MOD INDEX
ipan      =         p9
iampscale =         p10
ifm       =         icps *icm
idfm      =         imod * ifm               ; DEPTH
gapan2    =         ipan
ipldur    =         idur
gaamp     =         iamp

;;; FM SOUND

kenv      linen     iamp, .05 * idur, idur,.9 * idur   ; AMP ENV
kmodenv   linen     imod, .05 * idur, idur,.9 * idur   ; MOD ENV
amod      oscil     kmodenv*idfm, ifm, 1     ; MODULATOR
asig      oscil     kenv, p5 + amod, 1       ; CARRIER

asig1     oscil     kenv, (icps-1) + amod, 1 ; CHORUSED 
asig2     oscil     kenv, (icps-1) + amod, 1 ; CHORUSED
     
asig3     =         asig + asig1 + asig2     ; ALL THREE OSCILLATORS ADDED TOGETHER

;;;"PLUCKED" SOUND AT SAME PITCH

kpllin    line      icps, idur, icps-2       ; LINE TO CONTROL PITCH
kplenv    linen     iamp, .05 * ipldur, ipldur, .95 * ipldur
apl       pluck     kplenv, kpllin, icps, ifn, 1
     
gatap     =         gatap + asig3

asigl     =         ipan * apl               ; PLUCK SENT OUT LEFT, OR
asigr     =         (1-ipan) * apl           ; PLUCK SENT OUT RIGHT

          outs      asigl, asigr
ga2       =         ga2 + (asig3 * iampscale)                           

          endin



     ;*********************************************************************
     
     
     
          instr 3
          
idur      =         p3
iamp      =         p4
icps      =         p5
ifn       =         p6
icm       =          p7
imod      =         p8
ipan      =         p9                       
ifm       =         icps *icm
idfm      =         imod * ifm               ; DEPTH
          
     
     

kenv      linen     iamp, .05 * idur, idur,.9 * idur ; AMP ENV
kmodenv   linen     imod, .05, idur, .95     ; MOD ENV
ampmod    oscil     kenv, icps*1.2, 1
amod      oscil     kmodenv*ifm, ifm, 1      ; MODULATOR
amove     oscil     10, 10, 1
asig      oscil     ampmod, icps + amod + amove, 1  ; CARRIER


asigl     =         ipan * asig
asigr     =         (1-ipan) * asig

          outs      asigl, asigr
          endin

;**********************************************************************


          instr     98             ; REVERB FOR INSTRUMENT 2


arev      reverb    ga2, 5         ; REVERBERATE WHATEVER IS IN ga1
asigl     =         gapan2 * arev  ; REVERBERATED SOUND SENT OUT LEFT, OR
asigr     =         (1-gapan2) * arev ; RIGHT.(THE OPPOSITE CHANNEL OF THE PLUCK)

          outs      asigl, asigr   ; AND OUTPUT THE RESULT
ga2       =         0              ; EMPTY THE RECEIVER FOR THE NEXT PASS
          endin



;************************************************************************

          instr 99            ; REVERB FOR INSTRUMENT 1
areve     reverb    ga1, 6

asigl     =         (1-gapan1) * areve
asigr     =         gapan1 * areve

          outs      asigl, asigr
ga1       =         0
          endin



