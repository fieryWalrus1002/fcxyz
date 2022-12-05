;protocol body - modified by ZB
;version September 13, 2009

TS=100ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
include FilterWheel.inc  ;Includes standard options, do not remove it !
FAR=35
Act1=60
Shutter=2
Sensitivity=10
Super=20

;********************************************************************
NIR_period = 2s
RED_period = 2s
;
a = 10s
b = a + NIR_period + 2*TS
;*******************************************
<0s>=>SET_FILTER(2); B position of Filter Wheel
;
<a>=>FAR(NIR_period)
<a, a + 2*TS .. a + NIR_period>=>m
;
<b>=>act1(3s)
<b, b + 2*TS .. b + RED_period>=>m
;
;*******************************************
<a + 4*TS>=>checkPoint,"startR_NIR"
<a + NIR_period - 2*TS>=>checkPoint,"endR_NIR"

<b + 4*TS>=>checkPoint,"startR_RED"
<b + RED_period - 2*TS>=>checkPoint,"endR_RED"

<a + 2*TS>=>checkPoint,"timeVisual"

