;;; THIRD PERSONATION
;;; © MICHAEL BLANDINO 1997


sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2
          
          instr 1
               
ifm       =         p5*p7
indx      =         p8
idelf     =         indx*ifm       
kenv      linen     p4,.2*p3,p3,.5*p3
am        oscil     kenv,p5,p6
k1        oscil1    0,kenv/40,p3*.1,p6
a1        oscil     idelf,ifm,p6
a2        oscil     kenv,p5+a1+k1,p6
afil      butterbp  a2,p5,p5/40 
a3        delay a2, p9,0
a4        delay a3, p9,0
a5        delay a4, p9,0
a6        delay a5, p9,0
aout      =         a2+a3+a4/2+a5/2+a6/3
p3        =         p3+p9*4 
a3,a4,a5,a6 pan a2,p10,1,3,1,0
          outs      a3,a4 
p3        =         p3
          endin

          
          instr 2
     
ifm       =         p5*p7
indx      =         p8
idelf     =         indx*ifm
kenv      expseg    1,p3*.2,p4*.8,p3*.1,p4,p3*.8,1
a1        oscil     idelf,ifm,p6
a2        oscil     idelf,ifm/2.1,p6
a3        oscil     8,4,p6
a4        oscil     kenv,a1+a2+a3+p5,p6
a5        delay     a4,p9,0
a6        delay     a5,p9,0
a7        delay     a6,p9,0
a8        delay     a7,p9,0
a9        delay     a8,p9,0
a10       delay     a9,p9,0
aout      =         a4+a5+a6+a7+a8+a9+a10
p3        =         p3+p9*6 
          outs      aout,aout
p3        =         p3
          endin        
       
          
          instr 3 
          
k1        linen     p4,.1*p3,p3,.9*p3
a1        foscil    k1,p5,p6,1.5,1.414,1
alookup   =         a1*((.5*ftlen(p7))/32768)
a2        tablei    alookup,p7
a3        =         a2*(32768/(.5*ftlen(p7)))
adel      reverb    a3,p8/5,0
adel1     reverb    adel,p8/5,0  
adel2     reverb    adel1,p8/5,0 
adel3     reverb    adel2,p8/5,0 
a4        balance   a3,a1
p3        =         p3+p8*4/5
a5        =         adel+adel1+adel2+adel3+a4
a6, a7, a8, a9 pan a5, p9, 1, 3, 1, 0
outs      a6,a7
p3        =         p3   
          endin     
