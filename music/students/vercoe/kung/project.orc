sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         1

               instr     1                                       ;NEW FM USING J(X) AND R PARAMETER
ipch           =         cpspch(p5)                              ;CONVERT PARAMETER 5 TO CPS.
im             =         ipch
ic             =         ipch
kadsr          linseg    0,p3/6,1.0,p3/6,0.75,p3/2,0.70,p3/6,0   ;ADSR ENVELOPE 
kmodi          linseg    0,p3/6,5,p3/6,4,p3/2,3,p3/6,0           ;ADSR ENVELOPE FOR I
kmodr          linseg    1,p3/10,0.3,p3*0.8,1.7,p3/10,1
a1             =         kmodi*(kmodr - 1/kmodr)/2
a1ndx          =         abs(a1*2/20)                            ;A1*2 IS ARGUMENT NORMALIZED FROM 0-1.
a2             =         kmodi*(kmodr + 1/kmodr)/2     
a3             tablei    a1ndx,3,1                               ;LOOK UP TABLE IS IN F3, NORMALIZED INDEX.
ao1            oscil     a1,im,2                                 ;COSINE
a4             =         exp(-0.5*a3+ao1)
;
ao2            oscil     a2*im,im,2                              ;COSINE
aout           oscil     10000*kadsr*a4,ao2+ic,1                 ;FINAL OUTPUT
               out       aout
               endin

     instr     2                                                 ;NEW FM USING I(X) INSTEAD OF J(X)
ipch           =         cpspch(p5)                              ;CONVERT PARAMETER 5 TO CPS.
im             =         ipch
ic             =         ipch
kadsr          linseg    0,p3/6,1.0,p3/6,0.75,p3/2,0.70,p3/6,0   ;ADSR ENVELOPE 
kmodi          linseg    0,p3/6,5,p3/6,4,p3/2,3,p3/6,0           ;ADSR ENVELOPE FOR I
kmodr          linseg    1,p3/10,.3,p3*0.8,1.7,p3/10,1
a1             =         kmodi*(kmodr + 1/kmodr)/2
a1ndx          =         abs(a1*2/20)                            ;A1*2 IS ARGUMENT NORMALIZED FROM 0-1.
a2             =         kmodi*(kmodr - 1/kmodr)/2     
a3             tablei    a1ndx,3,1                               ;LOOK UP TABLE IS IN F3, NORMALIZED INDEX.
ao1            oscil     a1,im,2                                 ;COSINE
a4             =         exp(-0.5*a3+ao1)
;
ao2            oscil     a2*im,im,2                              ;COSINE
aout           oscil     10000*kadsr*a4,ao2+ic,1                 ;FINAL OUTPUT
               out       aout
               endin


     instr     3                                                 ;CHOWNING FM
ipch           =         cpspch(p5)
kadsr          linseg    0,p3/6,1.0,p3/6,0.75,p3/2,0.70,p3/6,0   ;ADSR envelope 
kmodi          linseg    0,p3/6,5,p3/6,4,p3/2,3,p3/6,0      

aout           foscil    10000*kadsr,ipch,1,1,kmodi,1
               out       aout
               endin

     instr     4                                                 ;VARIANT OF CHOWNING FM
ipch           =         cpspch(p5)
im             =         ipch
ic             =         ipch
kadsr          linseg    0,p3/6,1.0,p3/6,0.75,p3/2,0.70,p3/6,0   ;ADSR envelope 
kmodi          linseg    0,p3/6,5,p3/6,4,p3/2,3,p3/6,0 ;ADSR envelope for I
am             oscili    kmodi,im,2
aout           oscili    10000*kadsr,am+ic,1
               out       aout
               endin

