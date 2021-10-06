#!/usr/bin/env python

from pmask import Range, UniformRandom
from pmask import PowerSegment, LinearSegment
from pmask import Mask, Quantizer, List
from pmask import FStatement, ScoreSection
from pmask import Lorenz, CircleSqr, Bifurcation, Hopalong, Mandelbrot, Julia, Henon

fs1  = FStatement(1, 0, 65536, 10, 1)

sf = open('rock1.sco','w')
sf.write(str(fs1)+'\n')

cdur	= 32
csta	= 0.0
ngen = """
i1 0 %f .5 1
i1 0 %f .1 2
""" % (cdur, cdur)
sf.write(ngen)

sf.write('t0 80\n')

# Kick drum part
kicki	= 11
kickr   = List([1, .75, .25, 1, 1, 1, 1, .25, .75, 1],'cycle')
kicka   = List([30000, 25000, 33000, 20000],'cycle')
kickhf  = List([200, 170, 150, 230, 260],'cycle')
# 						     Amp    HiF  LoF Pan Dec  Tens Hit PBendQ OD   OC  OF Sus  QFmF LPAmpF
kickss = ScoreSection(csta, cdur, kicki, kickr, .25, kicka, kickhf, 90, .5, .03, .2,  .5, 4,     .02, .1, 1, .01, 20,  8)
sf.write(str(kickss)+'\n')

# HiHat part
hihati	= 24
hihatd  = List([.25, .23, .2, .26, .28, .3],'cycle')
hhpan   = List([.25, .73, .2, .46, .28, .7],'cycle')
hhmix   = List([.15, .23, .2, .26, .31, .12, .3, .3],'cycle')
#						        Amp    Pitch Pan    Fc    Q     OTAmp OTFqc OTQ  Mix
hihatss = ScoreSection(csta, cdur, hihati, .25, hihatd, 30000, 8.00, hhpan, 5333, 40.0, 0.5,  1.5,  0.2, hhmix)
sf.write(str(hihatss)+'\n')

# Snare drum part
snarei	= 34
snares  = csta+.5
snarer = List([1, 1, 1, 1,  1, 1, .25, .75, 1],'cycle')
snsdec = List([.2, .3, .5, 1,  1.3, 1],'cycle')
snton  = List([.5, 1, .3, 1.3, 2],'cycle')
# 						          Amp    Fqc   Pan Q   SprDec SprTone SprMix SprQ PBend PBTime
snaress = ScoreSection(snares, cdur, snarei, snarer, .25, 30000, 7.00, .3, .7, snsdec,snton,      1,     1,   1.5,  .1)
sf.write(str(snaress)+'\n')

