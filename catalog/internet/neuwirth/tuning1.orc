; tuning.orc  
; instrument used in 
; Erich Neuwirth 
; Musical Temperaments                                 
; Springer Verlag
; ISBN 3-211-83040-5
; the instrument has the wave shape sin(x)/(const-cos(x))
; the constant is frequency dependent

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

gilowavf  init      100
gihiwavf  init      1000
giloenvf  init      100
gihienvf  init      1000
gilowavv  init      1.03
gihiwavv  init      1.5
giloenvv  init      1.75
gihienvv  init      1
giattime  init      65/1024
gireltime init      68/1024
giattend  init      0.868
girelstart init     0.921
gidecup   init      girelstart-giattend
gidechump init      0.102

          instr 1             ; sin(t)/(a-cos(t))
   
iwavlin   =         p5
iwavlin   =         (iwavlin < gilowavf ? gilowavf : iwavlin)
iwavlin   =         (iwavlin > gihiwavf ? gihiwavf : iwavlin)
iwavlin   =         (iwavlin-gilowavf)/(gihiwavf-gilowavf)
iwavlin   =         gilowavv + iwavlin*(gihiwavv-gilowavv)
      
ienvlin   =         p5
ienvlin   =         (ienvlin < giloenvf ? giloenvf : ienvlin)
ienvlin   =         (ienvlin > gihienvf ? gihienvf : ienvlin)
ienvlin   =         (ienvlin-giloenvf)/(gihienvf-giloenvf)
ienvlin   =         giloenvv + ienvlin*(gihienvv-giloenvv)
      

iwav      =         iwavlin
ienv      =         ienvlin
   
iwavconst =         exp(log(iwav*iwav-1)/2)
   
ax        phasor    p5                       ; PHASE FOR WAVE FREQUENCY
ay        phasor    p5,0.25 shifted phase for wave frequency to get cosine
a1        table     ax,1,1                   ; SINE 
a2        table     ay,1,1                   ; COSINE
awav      =         p4*iwavconst*a1/(iwav-a2) ; WAVEFORM STANDARDIZED FOR VOLUME p4 
                                             
 
kdur      =         p3
kx        phasor    1/kdur                   ; ONE CYCLE PER NOTE 
kenvshort table     kx,8,1

kt        =         kdur*kx                  ; TIME FOR WHOLE NOTE

ktatt     =         kt/ienv                  ; SLOWER PHASE FOR ATTACK 
kdectime  =         kdur-giattime*ienv-gireltime
ktdec     =         (kt-ienv*giattime)/kdectime
ktdec     =         ( ktdec < 0 ? 0 : ktdec )
ktdec     =         ( ktdec > 1 ? 1 : ktdec )
ktrel     =         kt-kdur+gireltime
   

katt      table     ktatt,5,1

kdecfact  =         kdectime/(1-giattime*ienv-gireltime)  
kdecfact  =         (kdecfact > 1 ? 1 : kdecfact)
kdec1     table     ktdec,6,1  
kdec2     =         (kdecfact*ktdec*gidecup)+giattend
kdec      =         kdec2+kdec1*kdecfact*gidechump
   
krel      table     ktrel,7,1 
krel      =         krel*(giattend+gidecup*kdecfact)

kenvlong  =         katt
kenvlong  =         (kt > ienv*giattime ? kdec : kenvlong)
kenvlong  =         (kt > kdur - gireltime ? krel : kenvlong)
   
kenv      =         (kdectime > 0 ? kenvlong : kenvshort)

          out       kenv*awav
   
          endin
