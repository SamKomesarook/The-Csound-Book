sr = 44100
kr = 44100
ksmps = 1



 instr 2
asig oscil 10000, 440, 3
out asig
endin

;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
instr 1; Mass linked to ground (damped sine wave)
;coded by Josep M Comajuncosas / gelida@intercom.es
;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

i2pi2 =   39.47841760436; (2pi)^2

;set initial position and velocity of the mass
iv0 = 0
ix0 = 10000

;set frequency, z and m
ifreq = cpspch(p4)
iz = p5
im1 = 30

;normalize (don´t touch this!)
iz = iz/(1000000000*sr); z given in N*s/(kg*10e-9)
im1 = im1/1000000000; mass given in kg*10e-9

;calculate k according to given freq
ik = i2pi2*ifreq*ifreq*im1
ik = ik/(sr*sr)

ax1 init ix0
axprev1 init ix0-1000*iv0/sr

;calculate actual force and then next position
af1 = ik*(-ax1) + iz*(-(ax1-axprev1))
anext1 = af1/im1 + 2*ax1-axprev1

	out anext1

;prepare for next pass
axprev1 = ax1
ax1 = anext1

endin
