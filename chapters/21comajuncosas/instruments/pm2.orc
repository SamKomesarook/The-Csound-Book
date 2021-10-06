sr = 44100
kr = 44100
ksmps = 1

;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
instr 1; Two masses, 1 end. Scheme : m1<-->m2<-->(grnd)
;coded by Josep M Comajuncosas / gelida@intercom.es
;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

i2pi2 =   39.47841760436; (2pi)^2

;set initial position and velocity of the mass
iv0 = 0
ix0 = 10000

;set frequency, z and m
;ifreq = cpspch(p4)
ifreq = 500
iz = p5
im1 = 30
im2 = 30

;normalize (don't touch this!)
iz = iz/(1000000000*sr); z given in N*s/(kg*10e-9)
im1 = im1/1000000000; mass given in kg*10e-9
im2 = im2/1000000000; mass given in kg*10e-9

;calculate k according to given freq
ik = i2pi2*ifreq*ifreq*im1
ik = ik/(sr*sr)

ax1 init ix0
axprev1 init ix0-1000*iv0/sr

ax2 init 0
axprev2 init 0

af1 = ik*(ax2-ax1) + iz*((ax2-axprev2)-(ax1-axprev1))
af2 = -af1 + ik*(-ax2) + iz*(-(ax2-axprev2))

anext1 = af1/im1 + 2*ax1-axprev1
anext2 = af2/im2 + 2*ax2-axprev2

	out anext2

axprev1 = ax1
axprev2 = ax2
ax1 = anext1
ax2 = anext2
endin

