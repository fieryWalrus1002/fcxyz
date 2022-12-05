TS=100ms
;protocol body - modified by ZB
;version November 29, 2011
;high-resolution CCD
;
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Act1=30
Shutter=200.00ms
Sensitivity=0


;***************************************
light_pulse=Shutter;# Illumination pulse, minimum 1ms
step=1000ms;        # Time between acquisition of 2 image
;                   # minimum 500ms
Average = 10;       # Number of averaged frames
;
;;***Illumination************************
<0s, light_pulse+step .. (light_pulse+step)*(Average)>=>act1(light_pulse)
;
;***Data acquisition & Averaging********
<0s, light_pulse+step .. (light_pulse+step)*(Average)>=>m 
;
<0s>=>checkPoint,"startFt_Lss"
<light_pulse+step>=>checkPoint,"timeVisual"
<(light_pulse+step)*(Average)>=>checkPoint,"endFt_Lss"

