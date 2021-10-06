;--------------------------------------
; Granular Synthesis Instruments
; Coded by Hans Mikelson February 2000
;--------------------------------------
sr      =     44100      ; Sample rate
kr      =     44100      ; Control rate
ksmps   =     1          ; Samples per control rate
nchnls  =     2          ; Number of channels

;--------------------------------------
; Simple Granular Synthesis Instrument
;--------------------------------------
        instr  1

idur    =      p3         ; Duration
iamp    =      p4         ; Amplitude
ifqc    =      cpspch(p5) ; Pitch to frequency
iaoff   =      p6         ; Amplitude offset
ipoff   =      p7         ; Pitch offset
idens   =      p8         ; Density
ifn     =      p9         ; Function
iri     =      p10        ; Fade in time
iro     =      p11        ; Fade out time
igdtab  =      p12        ; Grain duration table
iwnd    =      2          ; Window function
imxgdur =      1          ; Maximum grain duration

; Amplitude envelope for fading in and out
kamp    linseg 0, iri*idur, 1, (1-iri-iro)*idur, 1, iro*idur, 0

; Grain envelope
kgrn    oscil  1, 1/idur, igdtab    ; Grain density envelope
kpoff   oscil  ifqc, 1/idur, ipoff  ; Pitch variation envelope

;               Amp, Pitch, Density, AmpOff, PitchOff, GrainDur,  Fn, Window, ImgDur, [Grnd]
agrnl   grain  iamp, ifqc,  idens,   iaoff,  kpoff,    kgrn,      ifn, iwnd, imxgdur      
agrnr   grain  iamp, ifqc,  idens,   iaoff,  kpoff,    kgrn,      ifn, iwnd, imxgdur      

aoutl   =      agrnl*kamp           ; Scale and output the left
aoutr   =      agrnr*kamp           ; and right signals
        outs   aoutl, aoutr         ; Output the result

        endin

;--------------------------------------
; Granular Synthesis Instrument 2
;--------------------------------------
        instr  2

idur    =      p3   ; Duration
iamp    =      p4   ; Amplitude
iptch   =      p5   ; Pitch
iaoff   =      p6   ; Amplitude offset
ipoff   =      p7   ; Pitch offset
idens   =      p8   ; Density
ifn     =      p9   ; Waveform
iri     =      p10  ; Fade in time
iro     =      p11  ; Fade out time
igdtab  =      p12  ; Grain duration table
iwnd    =      2    ; Grain window function
imxgdur =      1    ; Maximum grain duration

; Amplitude envelope to fade in and out
kamp    linseg 0, iri*idur, 1, (1-iri-iro)*idur, 1, iro*idur, 0

kgrn    oscil  1, 1/idur, igdtab      ; Grain duration envelope
kpoff   oscil  iptch, 1/idur, ipoff   ; Pitch offset envelope
i1	=  sr/ftlen(ifn)              ;scaling to reflect sample rate and table length


;               Amp, Pitch,     Density, AmpOff, PitchOff, GrainDur, Fn,  Window, ImgDur, [Grnd]
agrnl   grain  iamp, iptch*i1,  idens,   iaoff,  kpoff,    kgrn,     ifn, iwnd, imxgdur      
agrnr   grain  iamp, iptch*i1,  idens,   iaoff,  kpoff,    kgrn,     ifn, iwnd, imxgdur      

aoutl   =      agrnl*kamp    ; Scale left and right channels and output.
aoutr   =      agrnr*kamp
        outs   aoutl, aoutr

        endin

