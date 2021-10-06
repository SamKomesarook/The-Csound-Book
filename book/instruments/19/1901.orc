
; BASS PHYSICAL MODEL

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     1901

; INITIALIZATIONS
ifqc      =         cpspch(p5)
ipluck    =         1/ifqc*p6
kcount    init      0
adline    init      0
ablock2   init      0
ablock3   init      0

afiltr    init      0
afeedbk   init      0

koutenv   linseg    0,.01,1,p3-.11,1,.1,0 ; OUTPUT ENVELOPE
kfltenv   linseg    0, 1.5, 1, 1.5, 0 

; THIS ENVELOPE LOADS THE STRING WITH A TRIANGLE WAVE
kenvstr   linseg    0,ipluck/4,-p4/2,ipluck/2,p4/2,ipluck/4,0,p3-ipluck,0

aenvstr   =         kenvstr
ainput    tone      aenvstr,200

; DC BLOCKER
ablock2   =         afeedbk-ablock3+.99*ablock2
ablock3   =         afeedbk
ablock    =         ablock2

; DELAY LINE WITH FILTERED FEEDBACK
adline    delay     ablock+ainput,1/ifqc-15/sr
afiltr    tone      adline,400

; RESONANCE OF THE BODY 
abody1    reson     afiltr, 110, 40
abody1    =         abody1/5000
abody2    reson     afiltr, 70, 20
abody2    =         abody2/50000

afeedbk   =         afiltr

aout      =         afeedbk
          out       50*koutenv*(aout + kfltenv*(abody1 + abody2))

          endin
