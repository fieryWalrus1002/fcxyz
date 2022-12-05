;protocol body - modified by ZB
;version February 3, 2011

TS=50ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
include FilterWheel.inc  ;Includes standard options, do not remove it !

FAR=100
Act1=49
Shutter=1
Sensitivity=18

;********************************************************************
NIR_period = 10*mfmsub_length
RED_period = 10*mfmsub_length
;
a = 0s
<a>=>FAR(NIR_period)
;
b = a + NIR_period
<b>=>act1(RED_period)
;
<a + TS, a + TS + mfmsub_length .. b + RED_period>=>m
;*******************************************
<a + mfmsub_length>=>checkPoint,"startR_NIR"
<a + NIR_period - mfmsub_length>=>checkPoint,"endR_NIR"

<b + mfmsub_length>=>checkPoint,"startR_RED"
<b + RED_period - mfmsub_length>=>checkPoint,"endR_RED"

<a + 2*mfmsub_length>=>checkPoint,"timeVisual"

