; Pagano 
sr = 22050
kr = 2205
ksmps = 10
nchnls = 2
zakinit 50, 50


		instr  	1
ioutch  =       2                                 ; Output channel
ipanl = sqrt (1)
ipanr = sqrt (0)
ifreq    cps2pch    p4-2.00,-45    ; refer to multiplier table #1
ifreq   =       128*ifreq/64
k1      linen   p5*5,.2,p3,.5
aamp    linseg  0, .002, 1, p3-.004, 1, .002, 0  ; Declick envelope
asound  oscili       k1,ifreq,2
aout    =       asound*aamp
outs    aout*ipanl,aout*ipanr             ; Output stereo
zawm    aout, ioutch                       ; Mix to the Zak channel

endin
		
	instr  	5
ioutch  =       1                                 ; Output channel
ipanl = sqrt (0)
ipanr = sqrt (1)
ifreq    cps2pch    p4/2,-45    ; refer to multiplier table #1
ifreq   =       256*ifreq/128
k1      linen   p5*5,.2,p3,.5
aamp    linseg  0, .002, 1, p3-.004, 1, .002, 0  ; Declick envelope
asound  oscili       k1,ifreq,2
aout    =       asound*aamp
outs    aout*ipanl,aout*ipanr             ; Output stereo
zawm    aout, ioutch                       ; Mix to the Zak channel

endin
	instr  	3
ioutch  =       1                                 ; Output channel
ipanl = sqrt (0)
ipanr = sqrt (1)
ifreq    cps2pch    p4,-45    ; refer to multiplier table #1
ifreq   =       256*ifreq/128
k1      linen   p5*5,.2,p3,.5
aamp    linseg  0, .002, 1, p3-.004, 1, .002, 0  ; Declick envelope
asound  oscili       k1,ifreq,7
aout    =       asound*aamp
outs    aout*ipanl,aout*ipanr             ; Output stereo
zawm    aout, ioutch                       ; Mix to the Zak channel

endin

	instr  	4
ioutch  =       1                                 ; Output channel
ipanl = sqrt (1)
ipanr = sqrt (0)
ifreq    cps2pch    p4,-45    ; refer to multiplier table #1
ifreq   =       128*ifreq/64
k1      linen   p5*5,.2,p3,.5
aamp    linseg  0, .002, 1, p3-.004, 1, .002, 0  ; Declick envelope
asound  oscili       k1,ifreq,7
aout    =       asound*aamp
outs    aout*ipanl,aout*ipanr             ; Output stereo
zawm    aout, ioutch                       ; Mix to the Zak channel

endin
		

			instr  	2
ioutch  =       1                                 ; Output channel

ifreq    cps2pch    p4/2,-45    ; refer to multiplier table #1
ifreq   =       64*ifreq/32
k1      linen   p5*3,.2,p3,.5
aamp    linseg  0, .002, 1, p3-.004, 1, .002, 0  ; Declick envelope
asound  oscili       k1,ifreq,2
aout    =       asound*aamp
outs    aout,aout             ; Output stereo
zawm    aout, ioutch                       ; Mix to the Zak channel

endin

		;------------------------------------------------------------------------------
; Stereo delay with feedback and cross-feedback
;------------------------------------------------------------------------------
        instr   15

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
itiml   =       p5                                 ; Left delay time
ifdbkl  =       p6                                 ; Left feedback
ixfbl   =       p7                                 ; Left cross feedback
itimr   =       p8                                 ; Right delay time
ifdbkr  =       p9                                 ; Right feedback
ixfbr   =       p10                                ; Right cross feedback 
inchl   =       p11                                ; Left input
inchr   =       p12                                ; Right input

adell   init    0                                  ; Initialize adel to zero
adelr   init    0                                  ; Initialize adel to zero

aamp    linseg  0, .002, iamp, idur-.004, iamp, .002, 0  ; Declick envelope

asigl   zar     inchl                              ; Read the left channel
asigr   zar     inchr                              ; Read the right channel

asavl   =       adell                              ; Save the left delay for cross feedback
adell   delay   asigl + adell*ifdbkl + adelr*ixfbl, itiml  ; Delay the signal
adelr   delay   asigr + adelr*ifdbkr + asavl*ixfbr, itimr  ; Delay the signal

        outs    adell*aamp, adelr*aamp             ; Output the delayed signal

        endin

;------------------------------------------------------------------------------
; Clear Zak
;------------------------------------------------------------------------------
         instr   99
         zacl    0, 50                             ; Clear the audio channels
         zkcl    0, 50                             ; Clear the control channels
         endin
