sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

     
          zakinit 30,30

;----------------------------------------------------------------------------------
; DISK INPUT MONO
;----------------------------------------------------------------------------------
          instr     2401

iamp      =         p4
irate     =         p5
isndin    =         p6
ioutch    =         p7

ain       diskin    isndin, irate
          zaw       ain, ioutch
          outs      ain*iamp, ain*iamp
     
          endin
       
;----------------------------------------------------------------------------------
; SMALL ROOM REVERB
;----------------------------------------------------------------------------------
          instr     2402

idur      =         p3
iamp      =         p4
iinch     =         p5

aout41    init      0
adel01    init      0
adel11    init      0
adel21    init      0
adel22    init      0
adel23    init      0
adel41    init      0
adel42    init      0

kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0

; INITIALIZE
asig0     zar       iinch
aflt01    butterlp  asig0, 6000             ; PRE-FILTER
aflt02    butterbp  .5*aout41, 1600, 800   ; FEED-BACK FILTER
asum01    =         aflt01+.5*aflt02        ; INITIAL MIX

; DELAY 1
adel11    delay     asum01, .024

; DOUBLE NESTED ALL-PASS
asum21    =         adel22-.25*adel21         ; FIRST INNER FEEDFORWARD
asum22    =         adel23-.30*asum21         ; SECOND INNER FEEDFORWARD
aout21    =         asum22-.15*adel11         ; OUTER FEEDFORWARD
adel21    delay     adel11+.15*aout21, .0047 ; OUTER FEEDBACK
adel22    delay     adel21+.25*asum21, .022   ; FIRST INNER FEEDBACK
adel23    delay     asum21+.30*asum22, .0083 ; SECOND INNER FEEDBACK

; SINGLE NESTED ALL-PASS
asum41    =         adel42-.3*adel41          ; INNER FEEDFORWARD
aout41    =         asum41-.08*aout21         ; OUTER FEEDFORWARD
adel41    delay     aout21+.08*aout41, .036   ; OUTER FEEDBACK
adel42    delay     adel41+.3*asum41,   .030  ; INNER FEEDBACK

; OUTPUT
aout      =         .6*aout41+.5*aout21

          outs      aout*kdclick, -aout*kdclick
     
          endin
        
;----------------------------------------------------------------------------------
; CLEAR Zac
          instr     2499
          zacl      0,30
          endin

