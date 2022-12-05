;protocol body - modified by ZB
;version May 23, 2008
TS=20ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=0
Sensitivity=50
Act2=50
Super=100
FAR=100

;*** Fo Measurement **************************************************
F0duration=2s;             ##
<0,200ms..F0duration>=>mfmsub
<0s>=>checkPoint,"startFo"
<F0duration>=>checkPoint,"endFo"
;
;*** Saturating Pulse & Fm Measurement *******************************
PulseDuration=960ms;      ##
a1=F0duration+40ms
a2=a1+160ms
<a1>=>SatPulse(PulseDuration)
;
<a2, a2 + 160ms..a1+PulseDuration>=>mfmsub
<a2>=>checkPoint,"startFm"
<a1+PulseDuration>=>checkPoint,"endFm"
<a1 + PulseDuration - 160ms>=>checkPoint,"timeVisual"
;
;******* Dark Relaxation Measurement *********************************
DarkRelaxation1=27s;  ##
b1=F0duration+40ms+PulseDuration
b2=80ms
b3=2s
<b1+b2, b1+2*b2, b1+4*b2, b1+8*b2, b1+16*b2>=>mfmsub
<b1+b3, b1+2*b3..b1+DarkRelaxation1-b3>=>mfmsub
<b1+DarkRelaxation1-80ms>=>mfmsub
;
;******* Actinic light Exposure **************************************
ALPeriod=71s;            ##
c1=F0duration+40ms+PulseDuration+DarkRelaxation1
<c1>=>act2(ALPeriod)
;
;******* Kautsky Effect Measurement **********************************
c2=2s
c3=2s
<c1, c1+80ms .. c1+c2>=>mfmsub
<c1+c2+80ms, c1+c2+2*80ms, c1+c2+4*80ms, c1+c2+8*80ms, c1+c2+16*80ms>=>mfmsub
<c1+c2+c3, c1+c2+2*c3..c1+ALPeriod>=>mfmsub

<c1>=>checkPoint,"startFp"
<c1+c2+c3>=>checkPoint,"endFp"
; 
;******* Saturating Pulses - Fm' Quenching Analysis 
f1=c1+<9s>;            ##
f11=f1#<160ms,320ms..960ms>
f11=>mfmsub
f1+480ms=>checkPoint,"startFt_L1"
f1+960ms=>checkPoint,"endFt_L1"
;--------------------------------------------------
f2=f1+1s
f2+40ms=>SatPulse(PulseDuration)
f21=f2#<160ms,320ms..PulseDuration>
f21=>mfmsub
f2+480ms=>checkPoint,"startFm_L1"
f2+PulseDuration=>checkPoint,"endFm_L1"
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
f3=c1+<19s>;            ##
f31=f3#<160ms,320ms..960ms>
f31=>mfmsub
f3+480ms=>checkPoint,"startFt_L2"
f3+960ms=>checkPoint,"endFt_L2"
;--------------------------------------------------
f4=f3+1s
f4+40ms=>SatPulse(PulseDuration)
f41=f4#<160ms,320ms..PulseDuration>
f41=>mfmsub
f4+480ms=>checkPoint,"startFm_L2"
f4+PulseDuration=>checkPoint,"endFm_L2"
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
f5=c1+<29s>;            ##
f51=f5#<160ms,320ms..960ms>
f51=>mfmsub
f5+480ms=>checkPoint,"startFt_L3"
f5+960ms=>checkPoint,"endFt_L3"
;--------------------------------------------------
f6=f5+1s
f6+40ms=>SatPulse(PulseDuration)
f61=f6#<160ms,320ms..PulseDuration>
f61=>mfmsub
f6+480ms=>checkPoint,"startFm_L3"
f6+PulseDuration=>checkPoint,"endFm_L3"
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
f7=c1+<49s>;            ##
f71=f7#<160ms,320ms..960ms>
f71=>mfmsub
f7+480ms=>checkPoint,"startFt_L4"
f7+960ms=>checkPoint,"endFt_L4"
;--------------------------------------------------
f8=f7+1s
f8+40ms=>SatPulse(PulseDuration)
f81=f8#<160ms,320ms..PulseDuration>
f81=>mfmsub
f8+480ms=>checkPoint,"startFm_L4"
f8+PulseDuration=>checkPoint,"endFm_L4"
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
f9=c1+<69s>;            ##
f91=f9#<160ms,320ms..960ms>
f91=>mfmsub
f9+480ms=>checkPoint,"startFt_Lss"
f9+960ms=>checkPoint,"endFt_Lss"
;--------------------------------------------------
f10=f9+1s
f10+40ms=>SatPulse(PulseDuration)
f101=f10#<160ms,320ms..PulseDuration>
f101=>mfmsub
f10+480ms=>checkPoint,"startFm_Lss"
f10+PulseDuration=>checkPoint,"endFm_Lss"
; 
;******* Far-Red Exposure
FRPeriod=2s;            ##
d1=F0duration+40ms+PulseDuration+DarkRelaxation1+ALPeriod; # = 101
<d1>=>FAR(520ms)
<d1+640ms>=>FAR(120ms)
<d1+840ms>=>FAR(120ms)
<d1+1040ms>=>FAR(120ms)
<d1+1240ms>=>FAR(120ms)
<d1+1440ms>=>FAR(120ms)
<d1+1640ms>=>FAR(120ms)
<d1+1840ms>=>FAR(120ms)
<d1+600ms,d1+800ms..d1+FRPeriod>=>mfmsub
<d1+1200ms>=>checkPoint,"startFo_Lss"
<d1+FRPeriod>=>checkPoint,"endFo_Lss"
; 
;******* Dark relaxation after actinic light period
DarkRelaxation2=100s;  ##
h1=F0duration+40ms+PulseDuration+DarkRelaxation1+ALPeriod+FRPeriod; # = 103s
;
; ******* Relaxation measurement
h2=80ms
h3=3s
<h1+h2, h1+2*h2, h1+4*h2, h1+8*h2, h1+16*h2>=>mfmsub;
<h1+h3, h1+2*h3..h1+DarkRelaxation2-80ms>=>mfmsub
;
;******* Saturating Pulses - Fm_D1 Quenching Analysis 
g1=h1+<28s>;      ## = 131s
g11=g1#<160ms,320ms..960ms>
g11=>mfmsub
g1+480ms=>checkPoint,"startFt_D1"
g1+960ms=>checkPoint,"endFt_D1"
;-------------------------------------------------------------
g2=g1+1s
g2+40ms=>SatPulse(PulseDuration)
g21=g2#<160ms,320ms..PulseDuration>
g21=>mfmsub
g2+480ms=>checkPoint,"startFm_D1"
g2+PulseDuration=>checkPoint,"endFm_D1"
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;******Far-Red Exposure D1
gg1=g2+40ms+PulseDuration
gg1=>FAR(520ms)
gg2=gg1#<600ms,800ms,1000ms,1200ms,1400ms,1600ms,1800ms>
gg2=>mfmsub
gg3=gg1#<640ms,840ms..FRPeriod>
gg3=>FAR(120ms)
gg1+1200ms=>checkPoint,"startFo_D1"
gg1+FRPeriod=>checkPoint,"endFo_D1"
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;******* Saturating Pulses - Fm_D2 Quenching Analysis 
g3=h1+<58s>;      ## = 161s
g31=g3#<160ms,320ms..960ms>
g31=>mfmsub
g3+480ms=>checkPoint,"startFt_D2"
g3+960ms=>checkPoint, "endFt_D2"
;-------------------------------------------------------------
g4=g3+1s
g4+40ms=>SatPulse(PulseDuration)
g41=g4#<160ms,320ms..PulseDuration>
g41=>mfmsub
g4+480ms=>checkPoint,"startFm_D2"
g4+PulseDuration=>checkPoint,"endFm_D2"
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;******Far-Red Exposure D2
gg4=g4+40ms+PulseDuration
gg4=>FAR(520ms)
gg5=gg4#<600ms,800ms,1000ms,1200ms,1400ms,1600ms,1800ms>
gg5=>mfmsub
gg6=gg4#<640ms,840ms..FRPeriod>
gg6=>FAR(120ms)
gg4+1200ms=>checkPoint,"startFo_D2"
gg4+FRPeriod=>checkPoint,"endFo_D2"
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;******* Saturating Pulses - Fm_D3 Quenching Analysis 
g5=h1+<88s>;      ##
g51=g5#<160ms,320ms..960ms>
g51=>mfmsub
g5+480ms=>checkPoint,"startFt_D3"
g5+960ms=>checkPoint,"endFt_D3"
;-------------------------------------------------------------
g6=g5+1s
g6+40ms=>SatPulse(PulseDuration)
g61=g6#<160ms,320ms..PulseDuration>
g61=>mfmsub
g6+480ms=>checkPoint,"startFm_D3"
g6+PulseDuration=>checkPoint,"endFm_D3"
;^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
;******Far-Red Exposure D3
gg7=g6+40ms+PulseDuration
gg7=>FAR(520ms)
gg8=gg7#<600ms,800ms,1200ms,1400ms,1600ms,1800ms>
gg8=>mfmsub
gg9=gg7#<640ms,840ms..FRPeriod>
gg9=>FAR(120ms)
gg7+1200ms=>checkPoint,"startFo_D3"
gg7+FRPeriod=>checkPoint,"endFo_D3"
;
;END ******************************************************************

