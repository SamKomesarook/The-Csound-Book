sr        =         44100
kr        =         44100                                             ; use sr=kr please  
                                                                      ; I don´t suggest lower control rates !!!!
ksmps     =         1
nchnls    =         1
          zakinit   4,4

          instr 1                                                     ; instr 1 acts like "the player" and instr 2 like "the instrument"
                                                                      ; instr 2 must be active troughout the entire piece
                                                                      ; instr 1 is activated at each note event
ittime    =         .01                                               ; transition time between two different fingerings
irel      =         .01                                               ; release time - experiment!

          ; MIDI SETUP
ifrequency          pchmidi
print               ifrequency                                        ; displays current note being played
ifreq               cpsmidi

iamp      ampmidi   600                                               ; GREATER FOR BEATING CLARINET!!!!!!
iamp      =         500+iamp
icontrol  zir       0                                                 ; = 0 at compilation start time
icontrol  =         (icontrol == 0 ? 1:0)                             ; this swaps bores at each new event
          ziw       icontrol,0
          ziw       ifreq, icontrol+1                                 ; writes fre. at zk location 1 or 2. First is 2 <-- !

; TO DO: PRESSURE EQUALISATION. MAKE THE CLARINET SENSITIVE TO AMPMIDI UP TO THE BEATING REGISTER
; TO DO: ADD SOME VIBRATO TO THE AIR FLOW:STRAIGHTFORWARD
; POSSIBLE:FLUTTERTONGUE CLARINET

kdepth    linseg    5,.5,25,100,20
kspeed    linseg    3,.2,3,.5,6.5,100,6
kvibr     oscil     kdepth,kspeed,1
kp0       expsegr   10,irel,iamp,100-2*irel,iamp,irel,10              ; pressure envelope
knoize    gauss     .0015*kp0                                         ; add some pressure-dependent breath noise
kp0       =         (kp0 + knoize+kvibr)

          zkwm      kp0,3                                             ; writes flow at zk location 3

                                                                      ; weighting factor for bore swap
                                                                      ; activated at each new event

istart    =         icontrol
iend      =         1-istart
transition:
kweight   linseg    istart,ittime,iend,p3,iend
          zkw       kweight,4

output:
          endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 2
; MIDIFIED CLARINET MODEL
; VARIABLE EMBOCHURE MODEL FOR WAVEGUIDE WOODWINDS
; BASED ON A JNMR ARTICLE (VOL.24 PP.148-163)
; WRITTEN BY GIJS DE BRUIN & MAARTEN VAN WALSTIJM
; CODED TO CSOUND BY JOSEP M COMAJUNCOSAS / DEC´98-FEB´99
; THANKS TO MARTEEN FOR HIS VALUABLE HELP
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; ATTACHED TO A CILYNDRICAL WAVEGUIDE
; FOR CLARINET MODELLING

ipi        =        3.14159265359
ixtiny     =        0.000000004                                       ; small value
inumb_iter =        3                                                 ; number of iterations, suggested 1 to 3
; USED IN THE NEWTON-RHAPSON METHOD.

; DEFAULT CLARINET VALUES
ifr       =         2500                                              ; reed resonance frequency
iwr       =         2*ipi*ifr                                         ; normalized in radiants/cycle
ier       =         44.4 
ihr       =         0.0004                                            ; aperture of the reed in equilibrium
iir       =         731                                               ; inertance of the air above the reed
iq        =         1.5                                               ; set q=2 for lip & double reed????
ist       =         0.000177  
isr       =         0.000146
iqr       =         5.0
igr       =         iwr/iqr
iur       =         0.0231

ic        =         343                                               ; sound velocity
irho      =         1.21                                              ; air density
iz0       =         (irho*ic)/ist

; INITIALISE VARIABLES
kuf1      init      0                                                 ; normal volume flow
apm1      init      0                                                 ; mouthpiece pressure at t=0 is 0
apr2      init      0                                                 ; reflected pressure wave from the tube
kx1       init      ihr                                               ; previous reed aperture (at t=-1)
kx2       init      ihr                                               ; initial reed aperture (at t=0)


; THE CONSTANTS ARE COMPUTED AS:
iv        =         1                                                 ; iv = -1 (lip) or 1 (cane). Here "cane"
it        =1        /sr                                               ; sampling period

ic1       =         2-iwr*iwr*it*it - igr*it
ic2       =         igr*it - 1
ic3       =         -it*it*iv/iur       
ic4       =         it*it*iwr*iwr
ic6       =         isr/it
ic7       =         -(iz0*it/iir + 1)
ic8       =         -it*ier/iir
ic9       =         it/iir

kp0       zkr       3                                                 ; get flow value fron zk location 3

adp1      =         kp0 - apm1
kdp1      downsamp  adp1                                              ; necessary to compute a k-rate variable
kpr2      downsamp  apr2                                              ; idem

kx0       =         kx1  
kx1       =         kx2       
kx2       =         ic1*kx1 + ic2*kx0 + ic3*kdp1 + ic4*ihr


; SOME CLIPPING for x
kx2       =         (kx2<ixtiny?ixtiny:kx2)                           ; by now...cheap but works

kur2      =         ic6*(kx2 - kx1)     

id1       =         ic7  
kd2       =         ic8/(kx2 * kx2)     
kd3       =         ic9*(kp0 - 2*kpr2 + iz0*kur2) + kuf1    
     
; NEWTON-RHAPSON iteration.

; Uf(n) is used as initial value.

 kd4      =         kd2*iq;
 kd5      =         kd4-kd2;
 kxo      =         kuf1;

kcounter  =         inumb_iter                                        ; reinitialise counter
iter:

kbsaxo    =         abs(kxo)
ksign     =         kbsaxo                                            ; temp. variable
ksign_axo =         (ksign<0?-1:1)                                    ; can be pulled out of the loop?
kbsaxoq1  pow       kbsaxo,(iq-1);abs(x0)^(q-1)
kbsaxoq   =         kbsaxo*kbsaxoq1

kxo       =         (kd5*ksign_axo*kbsaxoq-kd3)/(id1+kd4*kbsaxoq1)

kcounter  =         kcounter - 1
if kcounter > 0 goto iter                                             ; iterate inumb_iter times

kuf2      =         kxo;get value
     
kub2      =         kuf2 - kur2                                       ; total volume flow for next pass  
api2      =         iz0*kub2 + apr2                                   ; ingoing pressure wave into the tube
apm2      =         api2 + apr2                                       ; mouthpiece pressure         

;CILYNDRICAL WAVEGUIDE (LOWPASS INVERTING)
;BORE LOGIC : SWAP IF A NEW NOTE HAS STARTED
;THIS FEATURE ALLOWS PLAYING LEGATO NOTES

kbore1    zkr       1
kbore2    zkr       2
; THIS CONDITIONAL IS NORMALLY SKIPPED EXCEPT AT INIT TIME
; WHEN BORE1 CAN HAVE ITS LENGHT UNDEFINED
kbore1    =         (kbore1==0?kbore2:kbore1)
kweight   zkr       4

; TABLE LOOKUP FOR FINE TUNING UP TO .08*SR (ABOUT 3500HZ AT SR = 44100)

kbore1n   =         kbore1/sr
kfreqncorr tablei   kbore1n/.08,2,1,0,0
kbore1    =         kbore1*kfreqncorr

kbore2n   =         kbore2/sr
kfreqncorr tablei   kbore2n/.08,2,1,0,0
kbore2    =         kbore2*kfreqncorr

kdlt1     =         1/kbore1
kdlt2     =         1/kbore2

; CALCULATIONS FOR FRACTIONAL DELAY INTERPOLATION FILTER
kdltn1    =         int(sr*kdlt1)
kdltn2    =         int(sr*kdlt2)
kdltf1    =         frac(sr*kdlt1)                                    ; note than time=int(time)+frac(time) ;-)
kdltf2    =         frac(sr*kdlt2)

; PRESSURE SENT TO TWO BORES IN PARALLEL
bore1:
atemp11   delayr    1/20
api31     deltapn   kdltn1/4
afdf11    biquad    api31, 1-kdltf1, kdltf1,0,1,0,0
delayw    api2
atemp12   delayr    1/20
apr31     deltapn   kdltn1/4
aprf1     butterlp  -apr31,p4
afdf12    biquad    aprf1, 1-kdltf1, kdltf1,0,1,0,0
delayw    afdf11

bore2:
atemp21   delayr    1/20
api32     deltapn   kdltn2/4
afdf21    biquad    api32, 1-kdltf2, kdltf2,0,1,0,0
delayw    api2
atemp22   delayr    1/20
apr32     deltapn   kdltn2/4
aprf2     butterlp  -apr32,p4
afdf22    biquad    aprf2, 1-kdltf2, kdltf2,0,1,0,0
delayw    afdf21

; SIGNAL BACK INTO THE BORE
apr3      =         kweight*afdf12 + (1-kweight)*afdf22
; OUTPUT SIGNAL
api3      =         kweight*afdf11 + (1-kweight)*afdf21

; SOUND OUTPUT

          aout      butterhp api3,p4*1.1
          out       aout*100;crude scaling


; update variables for next pass
kuf1      =         kuf2
apm1      =         apm2
apr2      =         apr3


; <SOME CLIPPING FOR X> INDICATES THAT X MUST BE RESTRICTED TO BE POSITIVE.
; IN REAL CLARINETS , THERE IS NO RIGID CLIPPING, 
; BUT RATHER A SMOOTHENED CLIPPING CURVE.
; THIS WILL IMPROVE THE SOUND A LOT FOR "BEATING READ".

          zkcl      3,3                                          ; clean mixer
          endin
