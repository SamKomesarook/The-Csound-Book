sr=44100
kr=44100
ksmps=1
nchnls=2
garvbsig init  0                      ; make zero at orch init time
                       


;"DWA" by Pawel Sek  www.pawelsek.com                                
                                                   
         
         
          instr   110
klinen    linen     p4    ,p9  ,p3  ,  p3        
a1        pluck     klinen, cpspch(p5), p6, p7, p8
		  out		(a1/2), (a1/2)
		  garvbsig = garvbsig+(a1*.07)
          endin



instr 11 ; Simple chaos 5. These are all from Sprott's Fractal Gallery Simple Chaotic Flow GIF Animations

  kampenv linseg 0, .01, p4, p3-.02, p4, .01, 0
  ax init .5
  ay init .3
  az init .6
  ah init cpspch(p5)/6550
  kloops init p6

  klfsinth oscil 1,1,1
  klfsinph oscil 1,.5,1
  klfcosth oscil 1,1,1,.25
  klfcosph oscil 1,.5,1,.25

kcount = 0
loop:

  adx=-ay+az*az
  ady=ax+.5*ay
  adz=ax-az

  ax=ax+ah*adx
  ay=ay+ah*ady
  az=az+ah*adz

kcount = kcount + 1
if (kcount<kloops) goto loop

  aox=-ax*klfsinth+ay*klfcosth
  aoy=-ax*klfsinth*klfcosph-ay*klfsinth*klfcosph+az*klfsinph

  outs aox*kampenv, aoy*kampenv
  garvbsig =    garvbsig+(aox*(kampenv/5))
                            
endin


;bass
       
         instr   210  

;kr      linen      kamp, irise, idur, idec
 klinen  linen      p4   , .05 , p3  , p3*.95

;ar      buzz       xamp,   xcps      , knh, ifn
 abuzz   buzz       klinen, cpspch(p5), 1  , 3

;kr      oscil      kamp,   kcps      , ifn
 koscil  oscil      klinen, cpspch(p5), 3

         outs     (abuzz*.5+koscil)*.6,(abuzz+koscil)*.6
         endin
         
instr 004

ipanfrq   =   p6
kfreq     =         p5
irandfrq =       p7
irandamp =      p8                                        
kramp     linseg    0,p3*.8,p4,p3*.2,0       ; THIS CONTROLS THE AMP OF RANDI
kenv1     linen     p4,0, p3,10              ; THIS CONTROLS THE FRQ OF RANDI
krndmod   randh     irandamp,irandfrq
an        randi     kramp,kenv1
ao        oscil     an,kfreq,11          ; ANOISE IS FED TO THE A INPUT OF AOSC
kpan      oscil     7,.09*ipanfrq,7
aosc2     reson     ao,kpan+100+krndmod,100,2      ; KPAN+100 IS OFFSET FOR FILTER SWEEP INPUT
          outs      aosc2*kpan,aosc2*(1-kpan)  ;garvbsig  =         garvbsig+(aosc2*.2)
          endin         

 





instr 99   ; global reverb          
              
              
              irvbtime    =            p4
              asig        reverb       garvbsig, irvbtime   ; put global signal into reverb
              outs        asig, asig
              garvbsig     =   0                            ; then clear it
              
 endin                                                                      

