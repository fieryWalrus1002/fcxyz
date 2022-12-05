;Static detection of fluorescence dyes or fluorescent proteins excited with Actinic3 - protocol body - modified by ZB
;version October 5, 2009
;high-resolution CCD
;
TS=50ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=2
Sensitivity=50
Act2=100
;
;-------------------------------------------------------------------------------------------------------------
;*** Illumination ********************************************************************************************
;-------------------------------------------------------------------------------------------------------------
LightPeriod = 2s;  ##
<0s>=>act3(LightPeriod)
;
;-------------------------------------------------------------------------------------------------------------
;*** Data acquisition & Averaging ****************************************************************************
;-------------------------------------------------------------------------------------------------------------
<TS, 2*TS .. LightPeriod - TS>=>m
;
<2*TS>=>checkPoint,"startFt_Lss"
<LightPeriod/2>=>checkPoint,"timeVisual"
<LightPeriod-2*TS>=>checkPoint,"endFt_Lss"
