; 1115.ORC    FM SYNTHESIS INSTRUMENT USING FOSCIL
;                PRODUCES VARIOUS KINDS OF SOUNDS
;                (C) RAJMIL FISCHMAN, 1997
sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1


;----------------------------------------------------
        instr 1115  ; GENERAL FM INSTRUMENT, WITH ENVELOPE CHANGING
                    ; ACCORDING TO FUNCTION TABLE GIVEN BY P10 AND
                    ; INDEX CHANGING ACCORDING TO FUNCTION TABLE GIVEN
                    ; BY p11.
;---------------------------------------------------; PARAMETER LIST
;p4  : AMPLITUDE
;p5  : PITCH (TO BE CONVERTED TO FREQUENCY)
;p6  : CARRIER/FREQUENCY
;p7  : MODULATOR/FREQUENCY
;p8  : MAXIMUM INDEX
;p9  : MINIMUM INDEX
;p10 : OSCILLATOR FUNCTION (USUALLY A SINE WAVE)
;p11 : AMPLITUDE FUNCTION
;p12 : INDEX FUNCTION
;--------------------------------------------------
ifreq   =       cpspch(p5)                  ; PICH TO FREQUENCY CONVERSION
kenv    oscil1  0, p4, p3, p11              ; AMPLITUDE ENVELOPE
kidx    oscil1  0, p8-p9, p3, p12           ; TIME-VARYING INDEX
asig    foscili kenv, ifreq, p6, p7, p9+kidx, p10 ; FM OSCILLATOR
        out     asig                        ; OUTPUT
        endin
