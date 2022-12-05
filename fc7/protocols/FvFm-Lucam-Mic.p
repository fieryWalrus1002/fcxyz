;protocol body - modified by ZB
;version November 29, 2011
;high-resolution CCD
;
TS=40ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !

Flashes=30
Super=10
Shutter=3
Sensitivity=100


;-------------------------------------------------------------------------------------------------------------
;*** Fo Measurement ******************************************************************************************
;-------------------------------------------------------------------------------------------------------------
F0duration=10s;
F0period = 1s
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
<a1 + mfmsub_length>=>checkPoint,"startFm"
<a1 + PulseDuration - mfmsub_length>=>checkPoint,"endFm"
;
;Visual frame definition                                                - image shown in pre-processing window
<a1 + PulseDuration/2 + TS>=>checkPoint,"timeVisual"
