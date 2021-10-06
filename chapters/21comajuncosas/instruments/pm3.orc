sr = 44100
kr = 44100
ksmps = 1

;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
instr 1; Two masses, both ends. Scheme : (grnd)<-->m2<-->m3<-->(grnd)
;coded by Josep M Comajuncosas / gelida@intercom.es
;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

;set initial position and velocity of the mass
iv0 = 0
ix0 = 10000

;set k, z and m
ik = p4
iz = p5
im2 = 30
im3 = 30

;normalize (don't touch this!)
ik = ik/(sr*sr)
iz = iz/(1000000000*sr); z given in N*s/(kg*10e-9)
im2 = im2/1000000000; mass given in kg*10e-9
im3 = im3/1000000000; mass given in kg*10e-9

ax2 init ix0
axprev2 init ix0-1000*iv0/sr

ax3 init 0
axprev3 init 0

af1 = ik*(ax2) + iz*((ax2-axprev2))
af2 = -af1 + ik*(ax3-ax2) + iz*((ax3-axprev3)-(ax2-axprev2))
af3 = -af2 + ik*(-ax3) + iz*(-(ax3-axprev3))

anext2 = af2/im2 + 2*ax2-axprev2
anext3 = af3/im3 + 2*ax3-axprev3

	out ax3

axprev2 = ax2
axprev3 = ax3
ax2 = anext2
ax3 = anext3
endin

