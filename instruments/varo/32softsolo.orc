sr             =              44100
kr             =              4410
ksmps          =              10
nchnls         =              1
;========================================================================;
;                 Yamaha DX7 Algorithm 05                                ;
;========================================================================;
               instr          1
ihold                          
idur           =              abs(p3)
ibase          =              (exp((p4/12) * log(2))/log(2.71828183)) * 8.175
iroct          =              octcps(p4)
irbase         =              octpch(4.09)          
irrange        =              octpch(13.06)-irbase
iveloc         =              p5                    
iop1fn         =              p10                   
iop2fn         =              p11
iop3fn         =              p12
iop4fn         =              p13
iop5fn         =              p14
iop6fn         =              p15
iampfn         =              p16                   
ipkamp         =              p17                   
irsfn          =              p18                   
idevfn         =              p19                   
irisefn        =              p20                   
idecfn         =              p21                   
ivsfn          =              p22                   
ivelfn         =              p23                   
iveloc         table          iveloc,ivelfn         
iveloc         =              iveloc * 1.10         
ifeedfn        =              p24
ifeed          table          p25,ifeedfn                
ifeed          =              ifeed/(2 * 3.14159)   
idetfac        =              4                          
imap128        =              127/99                     
irscl          table          (iroct-irbase)/irrange*127,irsfn
irscl          =              irscl*6
iop            =              1                          
iopfn          =              iop1fn
loop:
;---------------------------------READ OPERATOR PARAMETERS
ilvl           table          0,iopfn
ivel           table          1,iopfn
iegr1          table          2,iopfn
iegr2          table          3,iopfn
iegr3          table          4,iopfn
iegr4          table          5,iopfn
iegl1          table          6,iopfn
iegl2          table          7,iopfn
iegl3          table          8,iopfn
iegl4          table          9,iopfn
iams           table          10,iopfn
imode          table          11,iopfn
ifreq          table          12,iopfn
idet           table          13,iopfn
irss           table          14,iopfn
;----------------------------------INITIALIZE OPERATOR
ihz            =              (imode > 0 ? ifreq : ibase * ifreq) + idet/idetfac
iamp           =              ilvl/99       
ivfac          table          ivel,ivsfn
          
iegl1          =              iamp*iegl1
iegl2          =              iamp*iegl2
iegl3          =              iamp*iegl3
iegl4          =              iamp*iegl4
  
iegl1          =              iegl1*(1-ivfac)+iegl1*ivfac*iveloc
iegl2          =              iegl2*(1-ivfac)+iegl2*ivfac*iveloc
iegl3          =              iegl3*(1-ivfac)+iegl3*ivfac*iveloc
iegl4          =              iegl4*(1-ivfac)+iegl4*ivfac*iveloc

irs            =              irscl*irss
iegr1          =              (iegr1+irs > 99 ? 99 : iegr1+irs)
iegr2          =              (iegr2+irs > 99 ? 99 : iegr2+irs)
iegr3          =              (iegr3+irs > 99 ? 99 : iegr3+irs)
iegr4          =              (iegr4+irs > 99 ? 99 : iegr4+irs)
     
irfn           =              (iegl1 > iegl4 ? irisefn : idecfn)
iegd1          table          iegr1,irfn                                   ;CONVERT RATE->DUR
ipct1          table          iegl4,irfn+1                                 ;PCT FN IS NEXT ONE
ipct2          table          iegl1,irfn+1
iegd1          =              abs(iegd1*ipct1-iegd1*ipct2)
iegd1          =              (iegd1 == 0 ? .001 : iegd1)

irfn           =              (iegl2 > iegl1 ? irisefn : idecfn)
iegd2          table          iegr2,irfn
ipct1          table          iegl1,irfn+1
ipct2          table          iegl2,irfn+1
iegd2          =              abs(iegd2*ipct1-iegd2*ipct2)
iegd2          =              (iegd2 == 0 ? .001 : iegd2)

irfn           =              (iegl3 > iegl2 ? irisefn : idecfn)
iegd3          table          iegr3,irfn
ipct1          table          iegl2,irfn+1
ipct2          table          iegl3,irfn+1
iegd3          =              abs(iegd3*ipct1-iegd3*ipct2)
iegd3          =              (iegd3 == 0 ? .001 : iegd3)

iegd4          table          iegr4,idecfn
if      (iegl3 <= iegl4)      igoto continue
ipct1          table          iegl3,irfn+1
ipct2          table          iegl4,irfn+1
iegd4          =              abs(iegd4*ipct1-iegd4*ipct2)
iegd4          =              (iegd4 == 0 ? .001 : iegd4)

continue:
         if       (iop > 1)   igoto op2
op1:   
i1egd1         =              iegd1
i1egd2         =              iegd2
i1egd3         =              iegd3
i1egd4         =              iegd4
i1egl1         =              iegl1
i1egl2         =              iegl2
i1egl3         =              iegl3
i1egl4         =              iegl4
i1ams          =              iams
i1hz           =              ihz
iop            =              iop + 1
iopfn          =              iop2fn
igoto          loop

op2:     if       (iop > 2)   igoto op3
i2egd1         =              iegd1
i2egd2         =              iegd2
i2egd3         =              iegd3
i2egd4         =              iegd4
i2egl1         =              iegl1
i2egl2         =              iegl2
i2egl3         =              iegl3
i2egl4         =              iegl4
i2ams          =              iams
i2hz           =              ihz
iop            =              iop + 1
iopfn          =              iop3fn
igoto          loop

op3:     if       (iop > 3) igoto op4
i3egd1         =              iegd1
i3egd2         =              iegd2
i3egd3         =              iegd3
i3egd4         =              iegd4
i3egl1         =              iegl1
i3egl2         =              iegl2
i3egl3         =              iegl3
i3egl4         =              iegl4
i3ams          =              iams
i3hz           =              ihz
iop            =              iop + 1
iopfn          =              iop4fn
igoto          loop

op4:     if       (iop > 4)   igoto op5
i4egd1         =              iegd1
i4egd2         =              iegd2
i4egd3         =              iegd3
i4egd4         =              iegd4
i4egl1         =              iegl1
i4egl2         =              iegl2
i4egl3         =              iegl3
i4egl4         =              iegl4
i4ams          =              iams
i4hz           =              ihz
iop            =              iop + 1
iopfn          =              iop5fn
igoto          loop

op5:     if       (iop > 5) igoto op6
i5egd1         =              iegd1
i5egd2         =              iegd2
i5egd3         =              iegd3
i5egd4         =              iegd4
i5egl1         =              iegl1
i5egl2         =              iegl2
i5egl3         =              iegl3
i5egl4         =              iegl4
i5ams          =              iams
i5hz           =              ihz
iop            =              iop + 1
iopfn          =              iop6fn
igoto          loop

op6:
i6egd1         =              iegd1
i6egd2         =              iegd2
i6egd3         =              iegd3
i6egd4         =              iegd4
i6egl1         =              iegl1
i6egl2         =              iegl2
i6egl3         =              iegl3
i6egl4         =              iegl4
i6ams          =              iams
i6hz           =              ihz
;============================================================
                
timout         idur,999,final                                    ;SKIP DURING FINAL DECAY
k1sus          linseg         i1egl4,i1egd1,i1egl1,i1egd2,i1egl2,i1egd3,i1egl3,1,i1egl3
k2sus          linseg         i2egl4,i2egd1,i2egl1,i2egd2,i2egl2,i2egd3,i2egl3,1,i2egl3
k3sus          linseg         i3egl4,i3egd1,i3egl1,i3egd2,i3egl2,i3egd3,i3egl3,1,i3egl3
k4sus          linseg         i4egl4,i4egd1,i4egl1,i4egd2,i4egl2,i4egd3,i4egl3,1,i4egl3
k5sus          linseg         i5egl4,i5egd1,i5egl1,i5egd2,i5egl2,i5egd3,i5egl3,1,i5egl3
k6sus          linseg         i6egl4,i6egd1,i6egl1,i6egd2,i6egl2,i6egd3,i6egl3,1,i6egl3
k1phs          =              k1sus
k2phs          =              k2sus
k3phs          =              k3sus
k4phs          =              k4sus
k5phs          =              k5sus
k6phs          =              k6sus
kgoto          structure

final:   
k1fin          linseg         1,i1egd4,0,1,0
k1phs          =              i1egl4+(k1sus-i1egl4)*k1fin
k2fin          linseg         1,i2egd4,0,1,0
k2phs          =              i2egl4+(k2sus-i2egl4)*k2fin
k3fin          linseg         1,i3egd4,0,1,0
k3phs          =              i3egl4+(k3sus-i3egl4)*k3fin
k4fin          linseg         1,i4egd4,0,1,0
k4phs          =              i4egl4+(k4sus-i4egl4)*k4fin
k5fin          linseg         1,i5egd4,0,1,0
k5phs          =              i5egl4+(k5sus-i5egl4)*k5fin
k6fin          linseg         1,i6egd4,0,1,0
k6phs          =              i6egl4+(k6sus-i6egl4)*k6fin
kgoto          carrier       
;====================================================================
;DETERMINE ALGORITHM PATHWAY!!!!!!!!!!!!!!!!!!!!!!!!
;====================================================================
carrier: if       (k1fin + k3fin + k5fin) > 0 kgoto   structure 
               turnoff

;=========================================================================
;STRUCTURE SECTION - TELLS OPS WHETHER THEY ARE CARRIERS OR MODULATORS.
;=========================================================================
structure:
k1gate         tablei         k1phs,iampfn          
k2gate         tablei         k2phs,idevfn          
k3gate         tablei         k3phs,iampfn
k4gate         tablei         k4phs,idevfn
k5gate         tablei         k5phs,iampfn
k6gate         tablei         k6phs,idevfn

a6sig          init           0               
a6phs          phasor         i6hz       
a6sig          tablei         a6phs+a6sig*ifeed,1,1,0,1 
a6sig          =              a6sig*k6gate
      
a5phs          phasor         i5hz
a5sig          tablei         a5phs+a6sig,1,1,0,1
a5sig          =              a5sig*k5gate
      
a4sig          oscili         k4gate,i4hz,1   
      
a3phs          phasor         i3hz
a3sig          tablei         a3phs+a4sig,1,1,0,1
a3sig          =              a3sig*k3gate
      
a2sig          oscili         k2gate,i2hz,1
      
a1phs          phasor         i1hz    
a1sig          tablei         a1phs+a2sig,1,1,0,1
a1sig          =              a1sig*k1gate
      
out            (a1sig + a3sig + a5sig) * ipkamp
endin 
