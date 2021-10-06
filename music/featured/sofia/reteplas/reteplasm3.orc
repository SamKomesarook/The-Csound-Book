;Reteplas.orc /Third Movement  

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
   nchnls = 1


;=============================< Instr 8 >===============================;
 instr 8
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function
   ;p10 = modulator envelope function
   ;p11 = attack
    

i1 = 1/p3	                       ;one cycle per duration of note
i2 = p7 * p6 		           ;calculates deviation for index 1
i3 = (p8-p7) * p6	                 ;calculates deviation for index 2
i4 = p5*2

attack   linen 1,p11,p3,0
ahum     oscil 1,i4/1.34,1         ;perfect 5th. below p5
adetun   oscil 1,i4*1.0068,1       ;detune  

ampcar   oscil p4/1,i1,p9	     ;amplitude envelope for the carrier
ampmod   oscil i3,i1,p10 	     ;amplitude envelope for the modulator

amod     oscili  ampmod+i2,p6,1    ;modulating oscillator
asig     oscili  ampcar,i4+amod,1  ;carrier oscillator
 aout = ahum+adetun   
   
 out  asig*attack*aout

endin

;=============================< Instr 9 >================================;
 instr 9  
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function
   ;p10 = modulator envelope function
   ;p11 = attack

i1 = 1/p3		               ;one cycle per duration of note
i2 = p7 * p6 		         ;calculates deviation for index 1
i3 = (p8-p7) * p6	               ;calculates deviation for index 2 

 
adetun     oscil 1,p5*1.0068,1   ;detune
aprime     oscil 1,p5,1   
    
ampcar     oscil  p4/2.5,i1,p9   ;amplitude envelope for the carrier
ampmod     oscil i3,i1,p10       ;amplitude envelope for the modulator

amod    oscili  ampmod+i2,p6,1   ;modulating oscillator
asig    oscili  ampcar,p5+amod,1 ;carrier oscillator

attack     linen 1,p11,p3,0
anoclick   linseg 1,p3-.06,1,.06,0,.02,0
aout    =  adetun+aprime
     
  out  asig*attack*anoclick*aout
endin

;=============================< Instr 10 >================================;
 instr 10
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function 
   ;p10 = modulator envelope function
   ;p11 = attack

i1 = 1/p3		               ;one cycle per duration of note
i2 = p7 * p6 		         ;calculates deviation for index 1
i3 = (p8-p7) * p6	               ;calculates deviation for index 2
i4 = p5*3

adetun     oscil 1,p5*1.0068,1   ;detune 
ahum2      oscil 1,p5/1.34,1     ;perfect 5th. below p5
aprime     oscil 1,p5,1   
apart1     oscil 1,p5*2.7,1   
apart2     oscil 1,p5*5.2,1   
apart3     oscil 1,p5*8.4,1   

ampcar     oscil  p4/2,i1,p9     ;amplitude envelope for the carrier
ampmod     oscil i3,i1,p10 	   ;amplitude envelope for the modulator

amod    oscili  ampmod+i2,p6,1   ;modulating oscillator
asig    oscili ampcar,i4+amod,1  ;carrier oscillator

attack   linen 1,p11,p3,0
anoclick linseg 1,p3-.06,1,.06,0,.02,0
aout =   adetun+aprime+ahum2+apart1+apart2+apart3
     
    out  attack*anoclick*asig*aout
endin


;=============================< INSTR 11 >============================;
 instr 11  
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function
   ;p10 = modulator envelope function
   ;p11 = attack

   i1 = 1/p3		; one cycle per duration of note
   i2 = p7 * p6 		; calculates deviation for index 1
   i3 = (p8-p7) * p6	; calculates deviation for index 2
  
 
adetun    oscil 1,p5*1.0068,1    ;detune
aprime    oscil 1,p5,1   
   
ampcar    oscil  p4/2,i1,p9      ;amplitude envelope for the carrier
ampmod    oscil i3,i1,p10        ;amplitude envelope for the modulator

amod    oscili  ampmod+i2,p6,1   ;modulating oscillator
asig    oscili  ampcar,p5+amod,1 ;carrier oscillator

attack   linen 1,p11,p3,0   
anoclick linseg 1,p3-.07,1,.07,0,.03,0

 aout =   adetun+aprime
   out    asig*attack*anoclick*aout
endin


;=============================< INSTR 12 >===========================;

instr 12
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function
   ;p10 = modulator envelope function
   ;p11 = attack

   i1 = 1/p3		; one cycle per duration of note
   i2 = p7 * p6 		; calculates deviation for index 1
   i3 = (p8-p7) * p6	; calculates deviation for index 2
 
adetun   oscil 1,p5*1.0068,1    ;detune(~11.7641 cents)
ahum2    oscil 1,p5/1.34,1      ;perfect 5th. below p5
aprime   oscil 1,p5,1   
   
ampcar  oscil  p4/1.5,i1,p9     ;amplitude envelope for the carrier
ampmod  oscil i3,i1,p10 	  ;amplitude envelope for the modulator

amod  oscili  ampmod+i2,p6,1    ;modulating oscillator
asig  oscili  ampcar,p5+amod,1  ;carrier oscillator

attack   linen 1,p11,p3,0
anoclick linseg 1,p3-.07,1,.07,0,.03,0
  aout =   adetun+ahum2+aprime
    
out    asig*attack*anoclick*aout 
endin

;=============================< INSTR 13 >===========================;
instr 13
   ;p4  = amplitude of output wave
   ;p5  = carrier frequency in Hz
   ;p6  = modulating frequency in Hz
   ;p7  = modulation index 1
   ;p8  = modulation index 2
   ;p9  = carrier envelope function   l
   ;p10 = modulator envelope function
   ;p11 = attack
   
i1 = 1/p3		      ; one cycle per duration of note
i2 = p7 * p6 		; calculates deviation for index 1
i3 = (p8-p7) * p6	      ; calculates deviation for index 2
  
adetun    oscil 1,p5*1.0068,1   ;detune  
ahum2     oscil 1,p5/1.34,1     ;perfect 5th. below p5
aprime    oscil 1,p5,1   
apart1    oscil 1,p5*2.7,1   
apart2    oscil 1,p5*5.2,1   
apart3    oscil 1,p5*8.4,1  
apart4    oscil 1,p5*12.2,1 

ampcar  oscil  p4/2.5,i1,p9	  ;amplitude envelope for the carrier
ampmod  oscil i3,i1,p10 	  ;amplitude envelope for the modulator

amod oscili  ampmod+i2,p6,1     ;modulating oscillator
asig oscili ampcar,p5+amod,1    ;carrier oscillator

attack   linen 1,p11,p3,0
anoclick linseg 1,p3-.06,1,.06,0,.02,0
  aout =   adetun+ahum2+aprime+apart1+apart2+apart3+apart4
   
    out    asig*attack*anoclick*aout
endin


;===============================< III >================================;
