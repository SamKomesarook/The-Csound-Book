sr        =         44100
kr        =         44100
ksmps     =         1
nchnls    =         1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 1; PEAKING 12DB/OCT. LPF (ANALOG LOWPASS)
; BASED ON JON DATTORIO / JAES VOL.45 N.9 SEPT 1997
; PORTED TO CSOUND BY JOSEP M COMAJUNCOSAS / OCT.«98
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; NOTE : APPARENTLY THE CUTOFF AND THE RESONANCE
; ARE NOT DECOUPLED (NOR TUNED IN FACT) AT ALL...
; USE THEM *EMPYRICALLY*

ibound    =         10000
imaxamp   =         10000
kfreq     init      150
kamp      linen     1,.01,p3,.1
apulse1   buzz      kamp, kfreq, ibound/kfreq, 1
asaw      filter2   apulse1, 1, 1, 1, -.99

; THE FILTER ITSELF
i2pidsr   =         2*3.14159265359 / sr

; FREQ. CUTOFF
kfco      expseg    20, .2, 8000, p3-.2, 20
kfcon     =         kfco*i2pidsr
kfc       =         2*sin(kfcon/2)

; Q (RESONANCE) : STABILITY GUARANTEED FOR KQC IN [0,1]
; THOUGH YOU CAN TRY TO GO FURTHER (>1) AT YOUR OWN RISK
kqc       =         p4

ay4       init      0
ay5       init      0
ay7       init      0
ay8       init      0

ax        =         asaw/2
ay1       =         ax - ay5 - ay7
ay2       =         kfc*ay1
ay3       =         ay2+ay4
ay4       delay1    ay3
ay5       =         ay4*kqc
ay6       =         ay5*kfc
ay7       =         ay6+ay8
ay8       delay1    ay7
ay9       =         ay8*2

; COMPRESSION TO ALLOW A WIDER RANGE FOR Q
; BE CAREFUL, IT ACTS ALSO AS A DISTORTER! ;-)
;         out       tanh(ay9)*imaxamp
          out       ay9*imaxamp                        ; skip compression
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 2; PEAKING 24DB/OCT. LPF (ANALOG LOWPASS)
; LIKE INSTR 1, BUT 2 CASCADED FILTER UNITS HERE
; BASED ON JON DATTORIO / JAES VOL.45 N.9 SEPT 1997
; PORTED TO CSOUND BY JOSEP M COMAJUNCOSAS / OCT.«98
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; NOTE : APPARENTLY THE CUTOFF AND THE RESONANCE
; ARE NOT DECOUPLED (NOR TUNED IN FACT) AT ALL...
; USE THEM *EMPYRICALLY*

ibound    =         10000
imaxamp   =         10000
kfreq     init      150

kamp      linen     1,.01,p3,.1
apulse1   buzz      kamp, kfreq, ibound/kfreq, 1
asaw      filter2   apulse1, 1, 1, 1, -.99

; THE FILTER ITSELF
i2pidsr   =         2*3.14159265359 / sr

; FREQ. CUTOFF
kfco      expseg    20, .2, 8000, p3-.2, 20
kfcon     =         kfco*i2pidsr
kfc       =         2*sin(kfcon/2)

; Q (RESONANCE) : STABILITY GUARANTEED FOR KQC IN [0,1]
; THOUGH YOU CAN TRY TO GO FURTHER (>1) AT YOUR OWN RISK
kqc       =         p4

ay4       init      0
ay5       init      0
ay7       init      0
ay8       init      0

ax        =         asaw/2
ay1       =         ax - ay5 - ay7
ay2       =         kfc*ay1
ay3       =         ay2+ay4
ay4       delay1    ay3
ay5       =         ay4*kqc
ay6       =         ay5*kfc
ay7       =         ay6+ay8
ay8       delay1    ay7


ay14      init      0
ay15      init      0
ay17      init      0
ay18      init      0

ax2       =         ay8
ay11      =         ax2 - ay15 - ay17
ay12      =         kfc*ay11
ay13      =         ay2+ay14
ay14      delay1    ay13
ay15      =         ay14*kqc
ay16      =         ay15*kfc
ay17      =         ay16+ay18
ay18      delay1    ay17
ay19      =         ay18*2

; COMPRESSION TO ALLOW A WIDER RANGE FOR Q
; BE CAREFUL, IT ACTS ALSO AS A DISTORTER! ;-)
;         out       tanh(ay19)*imaxamp
          out       ay19*imaxamp                                      ; skip compression
          endin
