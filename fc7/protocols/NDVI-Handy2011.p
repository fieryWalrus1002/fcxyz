;protocol body - modified by ZB
;version May 23, 2008
TS=20ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=4
Sensitivity=20
UV=100
Super=20
FAR=21
Act1=20

<0s>=>FAR(3s)
<0s, 80ms .. 3s>=>m
;
<3s+2*TS>=>UV(3s)
<3s+2*TS, 3s+2*TS + 80ms .. 3s+2*TS + 3s>=>m

<0s>=>checkPoint,"startR_NIR"
<2s-200ms>=>checkPoint,"endR_NIR"

<3s+2*TS+200ms>=>checkPoint,"startR_RED"
<3s+2*TS + 2s-200ms>=>checkPoint,"endR_RED"

<200ms>=>checkPoint,"timeVisual"
