;protocol body - modified by ZB
;version May 23, 2008
TS=20ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=0
Sensitivity=20
Act2=100
Act1=100
Super=70

;*** Fo Measurement **************************************************
F0duration=2s;
F0period = 200ms
;
<0,F0period..F0duration>=>mfmsub
<0s>=>checkPoint,"startFo"
<F0duration - F0period>=>checkPoint,"endFo"
;
;
;*** Saturating Pulse & Fm Measurement *******************************
PulseDuration=960ms;      ##
a1=F0duration + 40ms
a2 = a1 + 480ms
;
<a1>=>SatPulse(PulseDuration)
;
<a1 + 80ms, a1 + 160ms..a1 + PulseDuration>=>mfmsub
<a1 + PulseDuration + 80ms>=>mfmsub
;
<a2>=>checkPoint,"startFm"
<a1 + PulseDuration - 80ms>=>checkPoint,"endFm"
<a2 + 80ms>=>checkPoint,"timeVisual"
;

