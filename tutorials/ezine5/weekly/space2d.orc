;----------------------------------------------------------------------------------
; Spatial Audio
; Coded by Hans Mikelson October 1998 Updated April 2000
; This spatial audio system included the following features:
;
;  1. Moving sound source with table supplied moving X and Y coordinates
;  2. Volume decreases as 1/r^2
;  3. Filtering of sound due to air absorption
;  4. Doppler effect due to moving sound
;  5. Simplified HRTF for head shadow filtering
;  6. Inter ear time delay
;  7. Speaker cross-talk cancellation based on both inter ear time delay & head shadowing
;----------------------------------------------------------------------------------

sr=44100
kr=4410
ksmps=10
nchnls=2
zakinit 50,50

;----------------------------------------------------------------------------------
; Envelope
;----------------------------------------------------------------------------------
       instr    2

idur   =        p3
iamp   =        p4
irate  =        p5
itab1  =        p6
ioutch =        p7

kenv1  oscili   iamp, irate/idur, itab1
       zkw      kenv1, ioutch
       endin

;----------------------------------------------------------------------------------
; Disk Input Mono
;----------------------------------------------------------------------------------
        instr  3

iamp    =      p4                   ; Amplitude
irate   =      p5                   ; Read rate
isndin  =      p6                   ; Sound input file
ioutch  =      p7                   ; Output channel

ain     diskin isndin, irate, 0, 1  ; Read stereo input with wrap around

        zawm   ain, ioutch          ; Output to audio channel

        endin

;----------------------------------------------------------------------------------
; Spatial Audio
;----------------------------------------------------------------------------------
        instr     20

idur    =         p3            ; Duration
iamp    =         p4            ; Amplitude
iexl    =         p5            ; Fixed left ear location X coordinate
iexr    =         iexl+.23      ; Fixed right ear location X coordinate
iey     =         p6            ; Fixed ear location Y coordinate (facing +Y axis)
isxchn  =         p7            ; Moving source table for X coordinate in m
isychn  =         p8            ; Moving source table for Y coordinate in m
iinch   =         p9            ; Audio input channel
ihrtabl =         p10           ; Head shadowing filter for left ear
ihrtabr =         p11           ; Head shadowing filter for right ear
irvchl  =         p12           ; Reverb channel left
irvchr  =         p13           ; Reverb channel right
imax    =         500           ; Maximum delay time in ms
ipi     =         3.14159265    ; Pi
ics     =         .333          ; Approx. speed of sound in m/ms

kamp    linseg    0, .002, iamp, idur-.004, iamp, .002, 0 ; Declick Enevelope

ksx     zkr       isxchn                                  ; Moving Source X
ksy     zkr       isychn                                  ; Moving Source Y

ksmexl  =         ksx-iexl                                ; Delta X left
ksmexr  =         ksx-iexr                                ; Delta X right
ksmey   =         ksy-iey                                 ; Delta Y
kdistl  =         sqrt(ksmexl*ksmexl+ksmey*ksmey)         ; Distance from left ear to source
kdistr  =         sqrt(ksmexr*ksmexr+ksmey*ksmey)         ; Distance from right ear to source
kdistlnz=         (kdistl==0 ? 1 : kdistl)                ; Avoid divide by zero problem
kdistrnz=         (kdistr==0 ? 1 : kdistr)                ; Avoid divide by zero problem

kangl   =         cosinv(ksmexl/kdistlnz)                 ; Get the magnitude of the angle (0 to Pi)
kangr   =         cosinv(ksmexr/kdistrnz)                 ; Get the magnitude of the angle (0 to Pi)
ksmeynz =         (ksmey==0 ? 1 : ksmey)                  ; Make sure it is not zero
ksign   =         ksmeynz/abs(ksmeynz)/2/ipi              ; Get the sign
kanglel =         kangl*ksign                             ; Get the true angle -Pi to Pi
kangler =         kangr*ksign                             ; Get the true angle -Pi to Pi
kdd4l   =         kdistl/4                                ; Factor for distance and air absorption
kdd4r   =         kdistr/4                                ; Factor for distance and air absorption

ain     zar       iinch                                   ; Input audio

adoppl  vdelay3   ain/(1+kdistl*kdistl), kdistl/ics, imax ; Volume decreases as distance^2.
adoppr  vdelay3   ain/(1+kdistr*kdistr), kdistr/ics, imax ; Volume decreases as distance^2.
                                                          ; arrival time is delayed by speed of sound, doppler effect 
adplrvb vdelay3   ain/(1+sqrt(abs(kdistl))), kdistl/ics, imax ; Reverb decreases as distance.
adprrvb vdelay3   ain/(1+sqrt(abs(kdistr))), kdistr/ics, imax ; Reverb decreases as distance.

        zawm      adplrvb, irvchl                         ; Output to left reverb channel
        zawm      adprrvb, irvchr                         ; Output to right reverb channel

afltail pareq     adoppl, 20000/(1+kdd4l), 1/(1+kdd4l), .707, 2 ; Air absorption of distant sound
afltair pareq     adoppr, 20000/(1+kdd4r), 1/(1+kdd4r), .707, 2 ; Air absorption of distant sound

khrtfl  tablei    kanglel, ihrtabl, 1, .5                 ; Get the "poor man's" HRTF for left ear
khrtfr  tablei    kangler, ihrtabr, 1, .5                 ; Get the "poor man's" HRTF for right ear

ahrtfl  butterlp  afltail, khrtfl                         ; Apply the filter for head shadowing left ear
ahrtfr  butterlp  afltair, khrtfr                         ; Apply the filter for head shadowing right ear

asctcl  butterlp  ahrtfl, 8000                            ; Simplified head shadowing for speaker cross-talk
asctcr  butterlp  ahrtfr, 8000                            ; Simplified head shadowing for speaker cross-talk

asctcdl delay     asctcl, .0003                           ; Speaker cross-talk cancellation delay left
asctcdr delay     asctcr, .0003                           ; Speaker cross-talk cancellation delay right

        outs      (ahrtfl-asctcdr*.4)*kamp, (ahrtfr-asctcdl*.4)*kamp ; Cancel speaker cross-talk and ouput

        endin

;----------------------------------------------------------------------------------
; 3 Delay Multiple Feedback Reverb
;----------------------------------------------------------------------------------
        instr    37

idur    =        p3
iamp    =        p4
iinch   =        p5
ifdbk   =        p6/3
ifco1   =        p7
ifco2   =        p7*p9/(p9+p10*(1-p8))
ifco3   =        p7*p9/(p9+p11*(1-p8))
itim1   =        p9/1000
itim2   =        p10/1000
itim3   =        p11/1000
ioutch  =        p12

aflt1   init     0
aflt2   init     0
aflt3   init     0

asig    zar      iinch

adel1   delay    asig+( aflt1-aflt2-aflt3)*ifdbk, itim1 ; Loop 1
adel2   delay    asig+(-aflt1+aflt2-aflt3)*ifdbk, itim2 ; Loop 2
adel3   delay    asig+(-aflt1-aflt2+aflt3)*ifdbk, itim3 ; Loop 3

aflt1   pareq      adel1, ifco1, .5, .4, 2
aflt2   pareq      adel2, ifco2, .5, .4, 2
aflt3   pareq      adel3, ifco3, .5, .4, 2

aout    butterhp aflt1+aflt2+aflt3, 140 ; Combine outputs
        zaw      aout, ioutch

        endin

;----------------------------------------------------------------------------------
; Output For Stereo Reverb
;----------------------------------------------------------------------------------
       instr  91

idur   =      p3
igain  =      p4
iinch1 =      p5
iinch2 =      p6

kdclik linseg 0, .002, igain, idur-.004, igain, .002, 0

ain1   zar    iinch1
ain2   zar    iinch2
       outs   ain1*kdclik, ain2*kdclik

       endin

;----------------------------------------------------------------------------------
; Clear Zak
;----------------------------------------------------------------------------------
       instr   99
       zacl    0,50
       zkcl    0,50
       endin

