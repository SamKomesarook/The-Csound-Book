sr        =         44100
kr        =         4410       
ksmps     =         10       
nchnls    =         1

gaux1     init      0

; MIDI EXAMPLE BY ELOY ANZOLA SUMMER 1997
; HANS MICKELSON REZZY SYNTH MODIFIED FOR MIDI BY ELOY ANZOLA

          instr     1         ; BY DEFAULT MIDI CHANNEL 1 IS PLAYED BY INSTR 1
idur      =         p3 
iamp      ampmidi   6500, 2                  ; SETS THE AMPLITUDE AND VELOCITY ENVELOPE
iptch     cpsmidi                            ; SETS PITCH
itabl1    =         3                        ; READS TABLE
kfco      midictrl  1                        ; CONTROLLER 1 CONTROLS CUTOFF FREQUENCY          
kfco      =         (kfco * 30) + 400        ; CHANGES MIDI CONTROLLER 1 VALUES FROM 0-127 TO 400-3810 TO USE AS CUTOFF FREQ.  
ablock2   init      0
ablock3   init      0
krez      midictrl  2                        ; CONTROLLER 2 CONTROLS RESONANCE                 
krez      =         ( krez+1 ) * .2          ; CHANGES MIDI CONTROLLER 2 VALUES FROM 0-127 TO 1-25 TO USE AS RESONANCE
kenv1     expon     iamp, 5, iamp/iptch      ; ENVELOPE FOR REZZY SYNTH   
axn2      oscil     kenv1, iptch, itabl1
        
; BLOCKING FILTER, AVOIDS DC OFFSET
          
ablock2   =         axn2-ablock3+.99*ablock2
ablock3   =         axn2
axn1      =         ablock2        
                  
; THIS RELATIONSHIP ATTEMPTS TO SEPARATE FREQ FROM RES.
ka1       =         100/krez/sqrt(kfco)-1
ka2       =         1000/kfco

; INITIALIZE YN-1 & YN-2 TO ZERO
aynm1     init      0
aynm2     init      0
          
; REPLACE THE DIFFERENTIAL EQ. WITH A DIFFERENCE EQ.
ayn       =         ((ka1+2*ka2)*aynm1-ka2*aynm2+axn1)/(1+ka1+ka2)
atemp     tone      axn1, kfco
aclip1    =         (ayn-atemp)/100000
aclip     tablei    aclip1, 4, 1, .5
aout      =         aclip * 20000 + atemp
aynm2     =         aynm1
aynm1     =         ayn

; AMP ENVELOPE AND OUTPUT 
aout      balance   aout, axn1
          
          out       aout                
          endin
                                             
          instr 2                            ; DRUM LOOP "NIGHTBEAT"
                                                                           
asig      loscil    1, 261.6, 5
     
          out       asig
          endin
     
          instr 100                          ; REVERB NOT BEING USED

igain     =         p4
irvt      =         p5
ifrq      =         p6
     
asig      =         gaux1
     
arvb      reverb2   asig, irvt, ifrq
arvb      =         arvb * igain
     
          out       arvb
          endin
          
