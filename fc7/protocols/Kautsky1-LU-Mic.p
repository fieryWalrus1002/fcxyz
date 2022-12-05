;Kautsky effect with F0 measurement in Actinic1 - protocol body - modified by ZB
;version November 18, 2010
;high-resolution CCD
;
TS=50ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Trans=8
UV=10
Flashes=50
Shutter=2
Sensitivity=58
Act2=22
FAR=0
Super=10
Act1=20
;
;-------------------------------------------------------------------------------------------------------------
;*** Fo Measurement ******************************************************************************************
;-------------------------------------------------------------------------------------------------------------
F0duration = 5s;
F0period = 1s
<0,F0period..F0duration>=>mfmsub
;
;Fo definition
<TS>=>checkPoint,"startFo"
<F0duration - F0period>=>checkPoint,"endFo"
;
;-------------------------------------------------------------------------------------------------------------
;******* Kautsky Effect Measurement **************************************************************************
;-------------------------------------------------------------------------------------------------------------
;
;******* Actinic light Exposure **************************************
ALPeriod=20s;            ##
c1=F0duration + mfmsub_length;    ##
;
<c1-TS>=>act1(ALPeriod)
;
;******* Kautsky kinetics*****************************************
;
c2=2s
;
<c1, c1 + mfmsub_length .. c1+c2>=>mfmsub
<c1+c2, c1+c2 + mfmsub_length*5 .. c1+ALPeriod-1000ms>=>mfmsub
;
;Fp definition
<c1>=>checkPoint,"startFp"
<(c1 + ALPeriod)/2>=>checkPoint,"endFp"
;
;Visual frame definition                                                  Image shown in pre-processing window
<(c1 + ALPeriod)/4>=>checkPoint,"timeVisual"
;
;Ft_Lss definition
f1=c1 + ALPeriod - 1000ms
f11=<f1>#<mfmsub_length, 2*mfmsub_length.. 800ms>
f11=>mfmsub
;
<f1 + mfmsub_length>=>checkPoint,"startFt_Lss"
<c1 + ALPeriod>=>checkPoint,"endFt_Lss"
;
;END *********************************************************************************************************
