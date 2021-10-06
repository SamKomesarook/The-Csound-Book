sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     1603 
ifenv     =         2                        ; BELL SETTINGS: AMP AND INDEX...
ifdyn     =         3                        ; ...ENVELOPES ARE EXPONENTIAL
ifq1      =         cpspch(p5)*5             ; DECREASING, N1:N2 IS 5:7,
if1       =         1                        ; DURATION = 15 sec
ifq2      =         cpspch(p5)*7   
if2       =         1    
imax      =         10   
aenv      oscili    p4, 1/p3, ifenv          ; ENVELOPE
adyn      oscili    ifq2*imax, 1/p3, ifdyn   ; DYNAMIC
amod      oscili    adyn, ifq2, if2          ; MODULATOR
acar      oscili    aenv, ifq1+amod, if1     ; CARRIER
          out       acar 
          endin

