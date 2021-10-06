;Reteplas.orc /First Movement  

;=======================================================================;
;Reteplas Microtonality composition by Sal Sofia (c.) 1997.             ;           
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


;=============================< Instr 1 >===============================;
 instr 1
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function
   ;p10 = modulator envelope function
   ;p11 = attack
   ;p12 = ibalance

i1 = 1/p3		                ;one cycle per duration of note
i2 = p7 * p6 		          ;calculates deviation for index 1
i3 = (p8-p7) * p6	                ;calculates deviation for index 2 
   
ibalance = p12                    ;panning:1=Left,0.5=Center,0=Right.        
adetun    oscil 1,p5*1.0068,6,1   ;detuned freq. in cents (3Hz) 

ampcar  oscil p4/2.5,i1,p9	    ;amplitude envelope for the carrier
ampmod  oscil i3,i1,p10	          ;amplitude envelope for the modulator

amod    oscili  ampmod+i2,p6,1    ;modulating oscillator
asig    oscili  ampcar,p5+amod,1  ;carrier oscillator
   
attack  linen 1,p11,p3,0
anoclick linseg 1,p3-.05,1,.05,0,.01,0

aout = adetun
  outs  aout*asig*attack*anoclick*ibalance,aout*asig*attack*anoclick*(1-ibalance)
	
 
endin

;=============================< Instr 2 >===============================;

instr 2
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function
   ;p10 = modulator envelope function
   ;p11 = attack
   ;p12 = ibalance 

i1 = 1/p3	                      ;one cycle per duration of note
i2 = p7 * p6 	    	          ;calculates deviation for index 1
i3 = (p8-p7) * p6	                ;calculates deviation for index 2

ibalance = p12                    ;panning:1=Left,0.5=Center,0=Right.
ahum    oscil 1,.34*p5,1          ;one octave and perfect 5th below p5.
aprime  oscil 1,p5,1   
aperf5  oscil 1,p5*1.49,1         ;perfect 5th. up from p5 (in microt.)
   
ampcar  oscil p4,i1,p9            ;amplitude envelope for the carrier
ampmod  oscil i3,i1,p10           ;amplitude envelope for the modulator

amod    oscili  ampmod+i2,p6,1    ; modulating oscillator
asig    oscili  ampcar,p5+amod,1  ; carrier oscillator

attack   linen 1,p11,p3,0
anoclick linseg 1,p3-.05,1,.05,0,.01,0

 aout =   ahum+aprime+aperf5
   outs  aout*asig*attack*anoclick*ibalance,aout*asig*attack*anoclick*(1-ibalance)
  		
endin

;=============================< Instr 3 >===============================;
 
instr 3
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function
   ;p10 = modulator envelope function
   ;p11 = attack
   ;p12 = ibalance

i1 = 1/p3	                    ;one cycle per duration of note
i2 = p7 * p6                    ;calculates deviation for index 1
i3 = (p8-p7) * p6               ;calculates deviation for index 2
 
ibalance = p12                  ;panning: 1=Left,0.5=Center,0=Right.
adetun   oscil 1,p5*1.0068,1    ;detuned freq. in cents (3Hz)
aprime   oscil 1,p5,1  
     
ampcar  oscil  p4*1,i1,p9       ;amplitude envelope for the carrier
ampmod  oscil i3,i1,p10         ;amplitude envelope for the modulator

amod   oscili  ampmod+i2,p6,1   ;modulating oscillator
asig   oscili  ampcar,p5+amod,1 ;carrier oscillator

attack   linen 1,p11,p3,0
anoclick linseg 1,p3-.05,1,.05,0,.01,0

aout =   aprime+adetun
 outs  aout*asig*attack*anoclick*ibalance,aout*asig*attack*anoclick*(1-ibalance)
    
endin
;==============================< I >=================================;
