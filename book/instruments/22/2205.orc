sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2                        
                                
          instr     2205                    
imain     =         p4                       ; MAIN AMP FACTOR                    
isend     =         p5                       ; SEND AMP FACTOR                    
gasend    init      0                             
asig      soundin   "speech1.aif"            ; THE SOURCE SOUND                   
amain     =         asig*imain               ; ATTEN MAIN SIG                     
          outs      amain, amain                         
gasend    =         gasend+asig*isend        ; ADD TO EFFECTS SEND                    
          endin                              
                                
          instr     2206                    
ifeed     =         p4                       ; FEEDBACK FACTOR                    
ilfohz1   =         p5                       ; 1ST LFO SPEED                  
ilfohz2   =         p6                       ; 2ND LFO SPEED                  
imaxdel   =         p7                       ; MAX DELAY TIME                     
ivdel1    =         p8*imaxdel               ; TAP1 VARY AMOUNT                   
ivdel2    =         p9*imaxdel               ; TAP2 VARY AMOUNT                   
avary1    oscili    ivdel1, ilfohz1, 1       ; HAMMING WINDOW FN             
avary2    oscili    ivdel2, ilfohz2, 1, .5   ; START OUT OF PHASE                    
afixed    delayr    imaxdel                  ; IMAXDEL SEC BUFFER                     
aout1     deltapi   .001+avary1              ; TWO VARYING TAPS                   
aout2     deltapi   .0005+avary2             ; STAGGER A LITTLE                   
afeed     =         (aout1+aout2)*ifeed      ; FEEDBACK BOTH                  
ainput    balance   gasend+afeed, gasend     ; BALANCE WITH ORIG                 
          delayw    ainput                   ; DELAY W/FEEDBK                     
          outs      aout1, aout2             ; SPLIT OUTPUTS                  
gasend    =         0                        ; ZERO SEND VAR                  
          endin
