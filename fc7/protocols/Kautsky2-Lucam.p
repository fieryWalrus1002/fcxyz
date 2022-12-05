;Kautsky effect with F0 measurement in Actinic2 - protocol body - modified by ZB
;version November 18, 2010
;high-resolution CCD
;
TS=20ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=1
Sensitivity=61
FAR=0
Super=20
Act2=20
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
ALPeriod=60s;            ##
c1=F0duration + mfmsub_length;    ##
;
<c1>=>act2(ALPeriod)
;
;*******Fast Kautsky kinetics*****************************************
c2=2s;                   ##                                      Interval of fast measurement with period 2*TS
;
<c1 + TS, c1+ TS + mfmsub_length .. c1+c2>=>mfmsub
;
;*******Slow Kautsky kinetics*****************************************
c3=2s;                   ##                                                         Period of slow measurement
;
<c1 + c2 + c3/10, c1 + c2+ c3/5, c1 + c2 + c3/2>=>mfmsub
;
<c1 + c2 + c3, c1 + c2 + 2*c3..c1 + ALPeriod - 800ms>=>mfmsub
;
;Fp definition
<c1>=>checkPoint,"startFp"
<c1 + c2 + c3>=>checkPoint,"endFp"
;
;Visual frame definition                                                  Image shown in pre-processing window
<c1 + c2>=>checkPoint,"timeVisual"
;
;Ft_Lss definition
f1=c1 + ALPeriod - 800ms
f11=<f1>#<0s, mfmsub_length.. 800ms>
f11=>mfmsub
;
<c1 + ALPeriod - 800ms>=>checkPoint,"startFt_Lss"
<c1 + ALPeriod - 2*mfmsub_length>=>checkPoint,"endFt_Lss"
;
;END *********************************************************************************************************
