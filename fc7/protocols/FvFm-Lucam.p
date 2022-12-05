;protocol body - modified by ZB
;version November 18, 2010
;high-resolution CCD
;
TS=20ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=1
Sensitivity=52
FAR=0
Act3=0
Act2=20
Act1=100
Super=20

;-------------------------------------------------------------------------------------------------------------
;*** Fo Measurement ******************************************************************************************
;-------------------------------------------------------------------------------------------------------------
F0duration=2s;
F0period = 200ms
<0,F0period..F0duration>=>mfmsub
;
;Fo definition
<TS>=>checkPoint,"startFo"
<F0duration - F0period>=>checkPoint,"endFo"
;
;-------------------------------------------------------------------------------------------------------------
;*** Saturating Pulse & Fm Measurement ***********************************************************************
;-------------------------------------------------------------------------------------------------------------
PulseDuration=800ms;    ##   
a1=F0duration + 2*mfmsub_length;   ##
;
<a1>=>SatPulse(PulseDuration)
;
<a1>=>mpulse
;
;Fm definition
<a1 + PulseDuration/2>=>checkPoint,"startFm"
<a1 + PulseDuration - mfmsub_length>=>checkPoint,"endFm"
;
;Visual frame definition                                                - image shown in pre-processing window
<a1 + PulseDuration/2 + TS>=>checkPoint,"timeVisual"
