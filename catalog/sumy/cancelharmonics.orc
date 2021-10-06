
;************************************   CANCELLED HARMONICS   ***************************************

; THIS DEMONSTRATION ILLUSTRATES FOURIER ANALYSIS OF A COMPLEX TONE CONSISTING OF 20 HARMONICS OF A
; 200HZ FUNDAMENTAL. IT ALSO ILLUSTRATES HOW OUR AUDITORY SYSTEM, LIKE OUR OTHER SENSES, HAS THE ABI-
; LITY TO LISTEN TO COMPLEX SOUNDS IN DIFFERENT MODES. WHEN WE LISTEN "ANALYTICALLY OR IN AN ISOLATIVE
; WAY", WE HEAR THE DIFFERENT COMPONENTS SEPARATELY; WHEN WE LISTEN "HOLISTICALLY",WE FOCUS ON THE 
; WHOLE SOUND AND PAY LITTLE ATTENTION TO THE COMPONENTS. 
; A COMPEX TONE IS PRESENTED TO THE LISTENER(S), FOLLOWED BY SEVERAL CANCELLATIONS AND RESTORATIONS OF
; A PARTICULAR HARMONIC. THIS IS DONE FOR HARMONICS 1 THROUGH 10.

;***************************************   HEADER   **************************************************



sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2

 instr         1

 iamp          =         ampdb(p4)               
 ifunc         =         p5
        

 a1            oscili    iamp,200,ifunc         
               outs      a1,a1
 endin  
