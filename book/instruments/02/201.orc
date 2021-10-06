sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr 201               
iskip   =       int(p5*sr)          ; STARTING SAMPLE IN SECONDS
ilast   =       int(sr*p3*p6)+iskip ; ENDING SAMPLE IN SECONDS
kenv    linseg  0, .05, p4, p3-.05, p4, .02, 0  ; ENV FUNCTION
aread   line    iskip, p3, ilast    ; a-rate TABLE INDEX
; aread line    ilast, p3, iskip    ; OPTIONAL: ilast TO iskip READS BACKWARD
asnd    tablei  aread, 1            ; SCANS FTABLE 1
asig    =       asnd*kenv           ; IMPOSES ENVELOPE
        out     asig
        endin

