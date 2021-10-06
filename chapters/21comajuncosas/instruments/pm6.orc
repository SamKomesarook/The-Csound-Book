sr = 44100
kr = 44100
ksmps = 1

;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
instr 1; square (4 masses) plate, all masses grounded
;coded by Josep M Comajuncosas / gelida@intercom.es
;""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

;set initial position and velocity of the mass
iv0 = 0
ix0 = 10000

;set k, z and m
ik = p4
iz = p5
im2 = 25
im3 = 31
im4 = 27
im5 = 29

;normalize (don't touch this!)
ik = ik/(sr*sr)
iz = iz/(1000000000*sr); z given in N*s/(kg*10e-9)
im2 = im2/1000000000; mass given in kg*10e-9
im3 = im3/1000000000
im4 = im4/1000000000
im5 = im5/1000000000

ax2 init ix0
axprev2 init ix0-1000*iv0/sr


ax3 init 0
ax4 init 0
ax5 init 0
axprev3 init 0
axprev4 init 0
axprev5 init 0

af1 = ik*(ax2) + iz*((ax2-axprev2))+ ik*(ax3) + iz*((ax3-axprev3)) + ik*(ax4) + iz*((ax4-axprev4)) + ik*(ax5) + iz*((ax5-axprev5))
af2 = -af1 + ik*(ax3-ax2) + iz*((ax3-axprev3)-(ax2-axprev2)) + ik*(ax5-ax2) + iz*((ax5-axprev5)-(ax2-axprev2))
af3 = -af1 - af2 + ik*(ax4-ax3) + iz*((ax4-axprev4)-(ax3-axprev3))
af4 = -af1 - af3 + ik*(ax5-ax4) + iz*((ax5-axprev5)-(ax4-axprev4))
af5 = -af1 - af4 - af2


anext2 = af2/im2 + 2*ax2-axprev2
anext3 = af3/im3 + 2*ax3-axprev3
anext4 = af4/im4 + 2*ax4-axprev4
anext5 = af5/im5 + 2*ax5-axprev5

	out ax3

axprev2 = ax2
axprev3 = ax3
axprev4 = ax4
axprev5 = ax5

ax2 = anext2
ax3 = anext3
ax4 = anext4
ax5 = anext5

endin
