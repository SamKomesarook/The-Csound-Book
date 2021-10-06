;Reteplas.orc /Second Movement  

;=======================================================================;
;Reteplas Microtonality composition by Sal Sofia (c)1997.               ;           
;=======================================================================;

;=======================================================================;
;FM Instrument by John M. Chowning                                      ;
;=======================================================================;
;Orchestra Coded and Compiled by Dr. Richard Boulanger                  ;
;=======================================================================; 

   sr = 44100         
   kr = 441           
   ksmps = 100        
   nchnls = 2


;=============================< Instr 4 >================================;
 instr 4
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function
   ;p10 = modulator envelope function
   ;p11 = attack
   ;p12 = ibalance 

i1 = 1/p3	                       ;one cycle per duration of note
i2 = p7 * p6 		           ;calculates deviation for index 1
i3 = (p8-p7) * p6	                 ;calculates deviation for index 2

ibalance = p12                     ;panning:1=Left,0.5=Center,0=Right
attack   linen 1,p11,p3,0

ampcar   oscil p4,i1,p9	           ;amplitude envelope for the carrier
ampmod   oscil i3,i1,p10 	     ;amplitude envelope for the modulator

amod     oscili  ampmod+i2,p6,1    ;modulating oscillator
asig     oscili  ampcar,p5+amod,1  ;carrier oscillator
    
   outs  asig*attack*ibalance,asig*attack*(1-ibalance)
 

endin

;=============================< Instr 5 >================================;
 instr 5  
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function
   ;p10 = modulator envelope function
   ;p11 = attack
   ;p12 = ibalance

i1 = 1/p3		               ;one cycle per duration of note
i2 = p7 * p6 		         ;calculates deviation for index 1
i3 = (p8-p7) * p6	               ;calculates deviation for index 2 
  
ibalance = p12                   ;panning:1=Left,0.5=Center,0=Right
adetun     oscil 1,p5*1.0068,1   ;detuned freq. in cents (3Hz)  
aprime     oscil 1,p5,1   
    
ampcar     oscil  p4/2.5,i1,p9   ;amplitude envelope for the carrier
ampmod     oscil i3,i1,p10       ;amplitude envelope for the modulator

amod    oscili  ampmod+i2,p6,1   ;modulating oscillator
asig    oscili  ampcar,p5+amod,1 ;carrier oscillator

attack     linen 1,p11,p3,0
aout    =  adetun+aprime
     outs  attack*asig*aout*ibalance, attack*asig*aout*(1-ibalance)
  
endin

;=============================< Instr 6 >================================;
 instr 6  
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function
   ;p10 = modulator envelope function
   ;p11 = attack
   ;p12 = ibalance


i1 = 1/p3		               ;one cycle per duration of note
i2 = p7 * p6 		         ;calculates deviation for index 1
i3 = (p8-p7) * p6	               ;calculates deviation for index 2
 
ibalance = p12                   ;panning:1=Left,0.5=Center,0=Right
adetun     oscil 1,p5*1.0068,1   ;detuned freq. in cents (3Hz)  
aprime     oscil 1,p5,1   
     
ampcar     oscil  p4/2.5,i1,p9   ;amplitude envelope for the carrier
ampmod     oscil i3,i1,p10  	   ;amplitude envelope for the modulator

amod   oscili  ampmod+i2,p6,1    ;modulating oscillator
asig   oscili  ampcar,p5+amod,1  ;carrier oscillator

attack     linen 1,p11,p3,0
anoclick   linseg 1,p3-.05,1,.05,0,.01,0
aout     = adetun+aprime
    outs  aout*asig*attack*anoclick*ibalance,aout*asig*attack*anoclick*(1-ibalance)
    
endin

;=============================< Instr 7 >================================;
 instr 7  
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function 
   ;p10 = modulator envelope function
   ;p11 = attack
   ;p12 = ibalance

i1 = 1/p3		               ;one cycle per duration of note
i2 = p7 * p6 		         ;calculates deviation for index 1
i3 = (p8-p7) * p6	               ;calculates deviation for index 2
  
ibalance = p12                   ;panning:1=Left,0.5=Center,0=Right
adetun     oscil 1,p5*1.0068,1   ;detuned freq. in cents (3Hz)  

ahum1      oscil 1,.34*p5,1      ;anoctav&perfect 5th. below p5.
ahum2      oscil 1,p5/1.34,1     ;perfect 5th. below p5
aprime     oscil 1,p5,1   
apart1     oscil 1,p5*2.7,1   
apart2     oscil 1,p5*5.2,1   
apart3     oscil 1,p5*8.4,1   
apart4     oscil 1,p5*12.2,1  

ampcar     oscil  p4/2.5,i1,p9   ;amplitude envelope for the carrier
ampmod     oscil i3,i1,p10 	   ;amplitude envelope for the modulator

amod     oscili  ampmod+i2,p6,1  ;modulating oscillator
asig     oscili ampcar,p5+amod,1 ;carrier oscillator

attack   linen 1,p11,p3,0
anoclick linseg 1,p3-.05,1,.05,0,.01,0

aout =   adetun+aprime+ahum1+ahum2+apart1+apart2+apart3+apart4
     outs  attack*asig*anoclick*aout*ibalance, attack*asig*anoclick*aout*(1-ibalance)
    
endin

;===============================< II >============================;
