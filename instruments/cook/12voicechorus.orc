sr     = 44100
kr     = 4410
ksmps  = 10
nchnls = 2

instr    1 ; 12 Voice Chorus with random LFO rates and spread pan

ilevl    = p4*.3   ; Output level
idelay   = p5/1000 ; Delay in ms
idpth    = p6/1000 ; Depth in ms
imax     = p7 - p8 ; Maximum LFO rate
imin     = p8      ; Minimum LFO rate
iwave    = p9      ; LFO waveform

ain      soundin  "Marimba.aif"

ain      = ain*ilevl
i01      = rnd(imax)
i02      = rnd(imax)
i03      = rnd(imax)
i04      = rnd(imax)
i05      = rnd(imax)
i06      = rnd(imax)
i07      = rnd(imax)
i08      = rnd(imax)
i09      = rnd(imax)
i10      = rnd(imax)
i11      = rnd(imax)
i12      = rnd(imax)
alfo01   oscil  idpth, i01 + imin, iwave
alfo02   oscil  idpth, i02 + imin, iwave, .08
alfo03   oscil  idpth, i03 + imin, iwave, .17
alfo04   oscil  idpth, i04 + imin, iwave, .25
alfo05   oscil  idpth, i05 + imin, iwave, .33
alfo06   oscil  idpth, i06 + imin, iwave, .42
alfo07   oscil  idpth, i07 + imin, iwave, .50
alfo08   oscil  idpth, i08 + imin, iwave, .58
alfo09   oscil  idpth, i09 + imin, iwave, .67
alfo10   oscil  idpth, i10 + imin, iwave, .75
alfo11   oscil  idpth, i11 + imin, iwave, .83
alfo12   oscil  idpth, i12 + imin, iwave, .92
atemp    delayr  idelay + idpth +.1
a01      deltapi  idelay + alfo01
a02      deltapi  idelay + alfo02
a03      deltapi  idelay + alfo03
a04      deltapi  idelay + alfo04
a05      deltapi  idelay + alfo05
a06      deltapi  idelay + alfo06
a07      deltapi  idelay + alfo07
a08      deltapi  idelay + alfo08
a09      deltapi  idelay + alfo09
a10      deltapi  idelay + alfo10
a11      deltapi  idelay + alfo11
a12      deltapi  idelay + alfo12
         delayw  ain
outs1    a01+a02*.95+a03*.9+a04*.85+a05*.79+a06*.74+a07*.67+a08*.6+a09*.52+a10*.42+a11*.3
outs2    a02*.3+a03*.42+a04*.52+a05*.6+a06*.67+a07*.74+a08*.79+a09*.85+a10*.9+a11*.95+a12

endin
