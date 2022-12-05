;Static detection of fluorescence dyes or fluorescent proteins excited with Actinic2 - protocol body - modified by ZB
;version February 8, 2011
;high-resolution CCD
;
TS=50ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=12
Sensitivity=0
Act2=20
;
;-------------------------------------------------------------------------------------------------------------
;*** Illumination ********************************************************************************************
;-------------------------------------------------------------------------------------------------------------
LightPeriod = 2s;
<0s>=>act2(LightPeriod)
;
;-------------------------------------------------------------------------------------------------------------
;*** Data acquisition & Averaging ****************************************************************************
;-------------------------------------------------------------------------------------------------------------
<0s, 1s .. LightPeriod>=>m
;
<0s>=>checkPoint,"startFt_Lss"
<LightPeriod/2>=>checkPoint,"timeVisual"
<LightPeriod>=>checkPoint,"endFt_Lss"
