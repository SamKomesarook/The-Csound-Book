; slowBURN.orc
; SEK 11/97
; slowBurn

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

garvbsig  init      0

     
          instr 99                                               ; GLOBAL REVERB 2

k1        linen     4,1,.01,2
a1        reverb2   garvbsig,k1,p5
          outs      a1+k1,a1+k1

garvbsig  =         0

          endin

          instr 5                                                ; BASED ON CASCONE'S FM W/REVERSE ENVELOPE FROM BLUECUBE()
                                                                 ; w/ afm3 PLUCK, PHASOR, OSCILLI OPCODES AND ifn as p FIELD
kcps      =         p4
kcar      =         p5
kmod      =         p6
kpan      =         p7                                           ; SCORE DETERMINES PAN POSITION
kndx      =         p8                      
kamp      =         p9
krvb      =         p10
iphs      =         p11
ifn       =         p12
icps      =         p13
imeth     =         p14


afm       phasor    kcps,iphs
afm1      oscili    afm,1/p3,ifn
afm2      pluck     kamp,kcps,icps,ifn,imeth
                    
afm3      =         (afm1*40)+(afm2*80)              

krtl      =         sqrt(2)/2*cos(kpan)+sin(kpan)                ; CONSTANT POWER PANNING
krtr      =         sqrt(2)/2*cos(kpan)-sin(kpan)                ; FROM C.ROADS "CM TUTORIAL" pp460

al        =         afm3*krtl
ar        =         afm3*krtr

          outs      al,ar

garvbsig  =         garvbsig+(afm3*krvb)               

          endin


          instr 6                                                ; BASED ON CASCONE'S FM W/REVERSE ENVELOPE FROM BLUECUBE()
                                                                 ; FTABLES IN PFIELDS, FOSCILI
kcps      =         P4        
kcar      =         p5
kmod      =         p6
kpan      =         p7                                           ; SCORE DETERMINES PAN POSITION
kndx      =         p8                      
kamp      =         p9
krvb      =         p10
ifn       =         p11
                                             
afm       foscili   kamp,kcps,kcar,kmod,kndx,ifn
afm1      oscil     afm,1/p3,18

afm2      =         afm1*100                     

krtl      =         sqrt(2)/2*cos(kpan)-sin(kpan)                ; CONSTANT POWER PANNING
krtr      =         sqrt(2)/2*cos(kpan)+sin(kpan)                ; FROM C.ROADS "CM TUTORIAL" pp460

al        =         afm2*krtl
ar        =         afm2*krtr
     
          outs      al,ar

garvbsig  =         garvbsig+(afm2*krvb)               

          endin



