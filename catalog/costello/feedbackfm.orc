
; AN UNSUCCESFUL ATTEMPT AT IMPLEMENTING FEEDBACK FM, BY SEAN COSTELLO.
; (UNSUCCESSFUL IN THE SENSE OF NOT DOING WHAT I INTENDED IT TO DO.  IT STILL SOUNDS PRETTY COOL TO ME.)

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     1

aosc1     init      0
idur1     =         p3                  ; OVERALL DURATION OF NOTE
ifreq1    =         p4                  ; MAIN FREQUENCY
iamp1     =         p5 * 4000           ; OVERALL AMPLITUDE OF NOTE
iattack1  =         p6        

; ATTACK OF AD-STYLE ENVELOPE FOR OVERALL AMPLITUDE.   

iamp2     =         p7                  ; FEEDBACK FM INDEX
iattack2  =         p8        

; ATTACK OF AD-STYLE ENVELOPE FOR FEEDBACK AMPLITUDE.

; KAMP1 CONTROLS OVERALL AMPLITUDE OF NOTE
kamp1     linseg    .0001, iattack1, iamp1, (idur1 - iattack1), .0001

; KAMP2 CONTROLS AMPLITUDE OF FEEDBACK
kamp2     linseg    .0001, iattack2, iamp2, (idur1 - iattack2), .0001

; I DIVIDED IAMP2 BY 10, JUST TO GET THE FEEDBACK IN A USEABLE RANGE.
aosc1     oscili    kamp1, ifreq1 + (aosc1 * iamp2/10), 1

          out       aosc1
          endin
