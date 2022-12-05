;protocol body - modified by ZB
;version May 23, 2008
TS=20ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=4
Sensitivity=50
Super=100
Act1=100

;***************************************
IP = 1s;   # Illumination period - the time when light illuminates a sample
step= TS; # Time between acquisition of 2 images, minimum 40ms for PSI CCD 
;          # Number of averaged images = IP / step
;
;
;***Illumination************************
<0s>=>act1(IP)
<0s>=>SatPulse(IP)
;
;
;***Data acquisition & Averaging********
<0s, step .. IP>=>m 
;
<0s>=>checkPoint,"startFt_Lss"
<IP/2>=>checkPoint,"timeVisual"
<IP>=>checkPoint,"endFt_Lss"
