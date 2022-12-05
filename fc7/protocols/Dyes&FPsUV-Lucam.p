;protocol body - modified by ZB
;version November 29, 2011
;high-resolution CCD
;
TS=20ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=2
Sensitivity=80


;***************************************
duration = 10s;    # Experiment duration
step=1s;           # Time between acquisition of 2 image
;                  # Video Mode: minimum 2xTS
;                  # Snapshot Mode: minimum 500ms
;                  # Number of averaged images = duration / step
;
;;***Illumination************************
<0s, step .. duration>=>UV(TS)
;
;***Data acquisition & Averaging********
<0s, step .. duration>=>m 
;
<0s>=>checkPoint,"startFt_Lss"
<duration/2>=>checkPoint,"timeVisual"
<duration>=>checkPoint,"endFt_Lss"

