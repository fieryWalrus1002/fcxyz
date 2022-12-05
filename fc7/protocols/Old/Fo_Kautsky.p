;protocol body - modified by ZB
;version May 23, 2008
TS=20ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=0
Sensitivity=40
Act1=100
Super=0
Act2=0

;*** Fo Measurement **************************************************
F0duration=5s;             ##
<0,1s..F0duration>=>mfmsub
<0s>=>checkPoint,"startFo"
<F0duration>=>checkPoint,"endFo"
;---------------------------------------------------
;
;******* Actinic light Exposure **************************************
ALPeriod=60s;            ##
c1=F0duration + 160ms
<c1>=>actinlightOn(ALPeriod)
<c1>=>actinic2(ALPeriod)
;
;******* Kautsky Effect Measurement **********************************
c2=1s; ## interval of fast measurement, period 80ms
c3=2s
;
<c1-80ms, c1 .. c1+c2>=>mfmsub
<c1+c2+80ms, c1+c2+2*80ms, c1+c2+4*80ms, c1+c2+8*80ms, c1+c2+16*80ms>=>mfmsub
<c1+c2+c3, c1+c2+2*c3..c1+ALPeriod>=>mfmsub
;
<c1>=>checkPoint,"startFp"
<c1+c2+c3>=>checkPoint,"endFp"
<c1+c2>=>checkPoint,"timeVisual"
;
f1=c1+ALPeriod-720ms
f11=<f1>#<80ms, 160ms .. 560ms>
f11=>mfmsub
<f1>=>checkPoint,"startFt_Lss"
<f1+800ms>=>checkPoint,"endFt_Lss"
; ---------------------------------------------------
;
;END ******************************************************************
