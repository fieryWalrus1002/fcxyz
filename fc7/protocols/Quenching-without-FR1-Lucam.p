; Quenching protocol with Actinic1 - protocol body - modified by ZB
;version November 18, 2010
;high-resolution CCD
;
TS=40ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=1
Sensitivity=46
Act3=0
Act1=56
Act2=20
Super=30

;-------------------------------------------------------------------------------------------------------------
;*** Fo Measurement ******************************************************************************************
;-------------------------------------------------------------------------------------------------------------
F0duration = 5s
F0period = 1s
<0,F0period..F0duration>=>mfmsub
;
;Fo definition
<0s>=>checkPoint,"startFo"
<F0duration - F0period>=>checkPoint,"endFo"
;
;-------------------------------------------------------------------------------------------------------------
;*** Saturating Pulse & Fm Measurement ***********************************************************************
;-------------------------------------------------------------------------------------------------------------
PulseDuration=800ms;#####
a1=F0duration + 2*mfmsub_length;#####
;
<a1>=>SatPulse(PulseDuration)
<a1>=>act1(PulseDuration)
;
<a1>=>mpulse
;
;Fm definition
<a1 + PulseDuration/2>=>checkPoint,"startFm"
<a1 + PulseDuration - mfmsub_length>=>checkPoint,"endFm"
;
;Visual frame definition                                               ## Image shown in pre-processing window
<a1 + PulseDuration/2 + TS>=>checkPoint,"timeVisual"
;
;-------------------------------------------------------------------------------------------------------------
;******* Dark Relaxation Measurement *************************************************************************
;-------------------------------------------------------------------------------------------------------------
DarkRelaxation1=17s;#####
b1= a1 + PulseDuration + 2*mfmsub_length;#####
b2=2s;#####
<b1, b1 + 200ms .. b1 + b2>=>mfmsub
<b1 + b2 + 200ms, b1 + 2*b2 .. b1+DarkRelaxation1>=>mfmsub
;
;-------------------------------------------------------------------------------------------------------------
;******* Kautsky Effect Measurement **************************************************************************
;-------------------------------------------------------------------------------------------------------------
;
;******* Actinic light Exposure **************************************
ALPeriod=70s;#####
c1= a1 + PulseDuration + DarkRelaxation1 + mfmsub_length;#####
<c1>=>act1(ALPeriod)
;
;*******Fast Kautsky kinetics****************************************
c2=2s;#####
;
<c1 + TS, c1 + TS + 2*TS.. c1+c2>=>mfmsub;
;
;*******Slow Kautsky kinetics****************************************
c3=2s;#####                                                                           period of slow measurement
;
<c1 + c2 + c3/10, c1 + c2+ c3/5, c1 + c2 + c3/2>=>mfmsub
;
<c1 + c2 + c3, c1 + c2 + 2*c3 .. c1 + ALPeriod>=>mfmsub;
;
;Fp definition
<c1>=>checkPoint,"startFp"
<c1 + c2 + c3>=>checkPoint,"endFp"
;
;-------------------------------------------------------------------------------------------------------------
;******* Saturating Pulses - Fm' Quenching Analysis **********************************************************
;-------------------------------------------------------------------------------------------------------------
;
;******* Saturating Pulses - Fm_L1 ***********************************
f1=c1+<8s>;#####
f11=f1#<mfmsub_length,2*mfmsub_length ..PulseDuration - mfmsub_length>;#####
f11=>mfmsub
f1 + mfmsub_length=>checkPoint,"startFt_L1"
f1 + PulseDuration - mfmsub_length=>checkPoint,"endFt_L1"
;
f2=f1 + PulseDuration;#####
f2=>SatPulse(PulseDuration);
f2=>mpulse
f2+PulseDuration/2=>checkPoint,"startFm_L1"
f2 + PulseDuration - mfmsub_length=>checkPoint,"endFm_L1"
;
;******* Saturating Pulses - Fm_L2 **********************************
f3=c1+<18s>;#####
f31=f3#<mfmsub_length,2*mfmsub_length ..PulseDuration - mfmsub_length>;#####
f31=>mfmsub
f3 + mfmsub_length=>checkPoint,"startFt_L2"
f3 + PulseDuration - mfmsub_length=>checkPoint,"endFt_L2"
;
f4=f3 + PulseDuration;#####
f4=>SatPulse(PulseDuration);
f4=>mpulse
f4 + PulseDuration/2=>checkPoint,"startFm_L2"
f4 + PulseDuration - mfmsub_length=>checkPoint,"endFm_L2"
;
;******* Saturating Pulses - Fm_L3 ***********************************
f5=c1+<28s>;#####
f51=f5#<mfmsub_length,2*mfmsub_length ..PulseDuration - mfmsub_length>;#####
f51=>mfmsub
f5 + mfmsub_length=>checkPoint,"startFt_L3"
f5 + PulseDuration - mfmsub_length=>checkPoint,"endFt_L3"
;
f6=f5 + PulseDuration;#####
f6=>SatPulse(PulseDuration);
f6=>mpulse
f6 + PulseDuration/2=>checkPoint,"startFm_L3"
f6 + PulseDuration - mfmsub_length=>checkPoint,"endFm_L3"
;******* Saturating Pulses - Fm_L4 ***********************************
f7=c1+<48s>;#####
f71=f7#<mfmsub_length,2*mfmsub_length ..PulseDuration - mfmsub_length>;#####
f71=>mfmsub
f7 + mfmsub_length=>checkPoint,"startFt_L4"
f7 + PulseDuration - mfmsub_length=>checkPoint,"endFt_L4"
;
f8=f7 + PulseDuration;#####
f8=>SatPulse(PulseDuration);
f8=>mpulse
f8 + PulseDuration/2=>checkPoint,"startFm_L4"
f8 + PulseDuration - mfmsub_length=>checkPoint,"endFm_L4"
;
;******* Saturating Pulses - Fm_Lss **********************************
f9=c1 + <68s>;#####
f91=f9#<mfmsub_length,2*mfmsub_length ..PulseDuration - mfmsub_length>;#####
f91=>mfmsub
f9 + mfmsub_length=>checkPoint,"startFt_Lss"
f9 + PulseDuration - mfmsub_length=>checkPoint,"endFt_Lss"
;
f10=f9 + PulseDuration;#####
f10=>SatPulse(PulseDuration);
f10=>mpulse
f10 + PulseDuration/2=>checkPoint,"startFm_Lss"
f10 + PulseDuration - mfmsub_length=>checkPoint,"endFm_Lss"
;
;-------------------------------------------------------------------------------------------------------------
;*** Dark relaxation after actinic light period **************************************************************
;-------------------------------------------------------------------------------------------------------------
DarkRelaxation2=100s;#####
h1=c1 + ALPeriod;#####
h2=2*TS;#####
h3=3s;#####
;
;******** Relaxation measurement**************************************
;
<h1+h2, h1+2*h2, h1+4*h2, h1+8*h2, h1+16*h2>=>mfmsub;
<h1+h3, h1+2*h3..h1+DarkRelaxation2>=>mfmsub
;
;******* Saturating Pulses - Fm_D1 ***********************************
g1=h1 + <28s>;#####
g11=g1#<mfmsub_length,2*mfmsub_length ..PulseDuration - mfmsub_length>;#####
g11=>mfmsub
g1 + mfmsub_length=>checkPoint,"startFt_D1"
g1 + PulseDuration - mfmsub_length=>checkPoint,"endFt_D1"
;
g2=g1 + PulseDuration;#####
g2=>SatPulse(PulseDuration)
g2=>act1(PulseDuration)
g2=>mpulse
g2 + PulseDuration/2=>checkPoint,"startFm_D1"
g2 + PulseDuration - mfmsub_length=>checkPoint,"endFm_D1"
;
;******* Saturating Pulses - Fm_D2 ***********************************
g3=h1 + <58s>;#####
g31=g3#<mfmsub_length,2*mfmsub_length ..PulseDuration - mfmsub_length>;#####
g31=>mfmsub
g3 + mfmsub_length=>checkPoint,"startFt_D2"
g3 + PulseDuration - mfmsub_length=>checkPoint, "endFt_D2"
;
g4=g3 + PulseDuration;#####
g4=>SatPulse(PulseDuration)
g4=>act1(PulseDuration)
g4=>mpulse
g4 + PulseDuration/2=>checkPoint,"startFm_D2"
g4 + PulseDuration - mfmsub_length=>checkPoint,"endFm_D2"
;
;******* Saturating Pulses - Fm_D3 ***********************************
g5=h1+<88s>;#####
g51=g5#<mfmsub_length,2*mfmsub_length ..PulseDuration - mfmsub_length>;#####
g51=>mfmsub
g5 + mfmsub_length=>checkPoint,"startFt_D3"
g5 + PulseDuration - mfmsub_length=>checkPoint,"endFt_D3"
;
g6=g5 + PulseDuration;#####
g6=>SatPulse(PulseDuration)
g6=>act1(PulseDuration)
g6=>mpulse
g6 + PulseDuration/2=>checkPoint,"startFm_D3"
g6 + PulseDuration - mfmsub_length=>checkPoint,"endFm_D3"
;
;END ******************************************************************