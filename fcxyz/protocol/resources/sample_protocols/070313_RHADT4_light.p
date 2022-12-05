TS=50ms
;protocol body - generated by wizard
;version ZB February 11, 2010
include default.inc  ;Includes standard options, do not remove it !
include light.inc    ;Includes standard options, do not remove it !

;--- settings for survey of Mike Neff's mutants, first stage of protocol
Shutter=3
Sensitivity=18
FAR=85
;----actinic light set to 200uE, combination of red and blue. Both at 45%
Act2=55
Act1=55
Super=90
;
;------------------------------------------------------------------------------------------------------------
;************************************************************************************************************
Action SATPULSE begin
  <-mfmsub_length>=>mfmsub ;before pulse
  <0s>=>SatPulse(800ms)
  <TS,TS + 2 * mfmsub_length .. 800ms/2 - mfmsub_length>=>mfmsub
  <800ms/2,800ms/2 + mfmsub_length .. 800ms>=>mfmsub
  <800ms + mfmsub_length>=>mfmsub
end
;
Action MEASURE(end_time) begin
  <800ms + 2*mfmsub_length,800ms + 2*mfmsub_length + 40 * mfmsub_length ..end_time - mfmsub_length>=>mfmsub
end
;
Action FARREDILL(end_time) begin
  <800ms + 4*mfmsub_length,800ms + 4*mfmsub_length + 40 * mfmsub_length ..end_time - 2 * mfmsub_length>=>FAR(38*mfmsub_length)
end
;-------------------------------------------------------------------------------------------------------------
;*** Fo Measurement ******************************************************************************************
;-------------------------------------------------------------------------------------------------------------
F0duration=5s
F0period = mfmsub_length * 5
;
<0, F0period  .. F0duration>=>mfmsub
<0s>=>act2(F0duration)
<0s>=>act1(F0duration)
;
;-------------------------------------------------------------------------------------------------------------
;*** Saturating Pulse & Fm Measurement ***********************************************************************
;-------------------------------------------------------------------------------------------------------------
PulseDuration = 800ms;      ##
PulseStart = F0duration + 2*mfmsub_length;      ##
;
<PulseStart>=>SATPULSE
<PulseStart>=>act1(PulseDuration)
<PulseStart>=>act2(PulseDuration)
;
<PulseStart + PulseDuration/2>=>checkPoint,"startFm"
<PulseStart + PulseDuration - mfmsub_length>=>checkPoint,"endFm"
;
;Visual frame definition                                                  Image shown in pre-processing window
<PulseStart + PulseDuration - 3*mfmsub_length>=>checkPoint,"timeVisual"
;
;-------------------------------------------------------------------------------------------------------------
;******* Dark Relaxation Measurement *************************************************************************
;-------------------------------------------------------------------------------------------------------------
DarkRelaxation1 = 10s;         ##

DarkStart= PulseStart + PulseDuration + 2*mfmsub_length; ##
<DarkStart>=>act1(9s)
<DarkStart>=>act2(9s)
;
<DarkStart, DarkStart + mfmsub_length *10..DarkStart + DarkRelaxation1 - 2*mfmsub_length>=>mfmsub
;
;-------------------------------------------------------------------------------------------------------------
;******* Kautsky Effect Measurement **************************************************************************
;-------------------------------------------------------------------------------------------------------------
;
;******* Actinic light Exposure **************************************
ALPeriod = 120s + TS;            ##
ALStart = 15.8s;##
EndFp = 20.3s
;
<ALStart - TS>=>act1(ALPeriod)
<ALStart - TS>=>act2(ALPeriod)
;
;*******Fast Kautsky kinetics*****************************************
<ALStart - 2*mfmsub_length>=>mfmsub
<ALStart, ALStart + mfmsub_length .. EndFp - 2*mfmsub_length>=>mfmsub
;
;Fp definition
<ALStart>=>checkPoint,"startFp"
<EndFp>=>checkPoint,"endFp"
;
;*******Slow Kautsky kinetics*********************************************
;
; measure to pulse 1
<EndFp,EndFp + 40 * mfmsub_length..24.8s - 2*mfmsub_length>=>mfmsub
; measure from last pulse
<133.8 + PulseDuration + 2*mfmsub_length,133.8s + PulseDuration + 2*mfmsub_length + 40 * mfmsub_length .. ALStart + ALPeriod - mfmsub_length>=>mfmsub
<ALStart + ALPeriod - mfmsub_length>=>mfmsub
;
;-------------------------------------------------------------------------------------------------------------
;******* Saturating Pulses - Fm' Quenching Analysis **********************************************************
;-------------------------------------------------------------------------------------------------------------
;
;******* Saturating Pulses in Light- Fm_L'********************************************************************
;
;pulse 1
<24.8s>=>SATPULSE
<24.8s - mfmsub_length>=>checkPoint,"startFt_L1"
<24.8s + PulseDuration/2>=>checkPoint,"startFm_L1"
<24.8s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_L1"
;
;1 to 2 pulses
<24.8s>=>MEASURE(61.1 - 24.8s)
;2 pulses
<61.1s>=>SATPULSE
<61.1s - mfmsub_length>=>checkPoint,"startFt_L2"
<61.1s + PulseDuration/2>=>checkPoint,"startFm_L2"
<61.1s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_L2"
;
;2 to 3 pulses
<61.1s>=>MEASURE(97.5 - 61.1)
;3
<97.5s>=>SATPULSE
<97.5s - mfmsub_length>=>checkPoint,"startFt_L3"
<97.5s + PulseDuration/2>=>checkPoint,"startFm_L3"
<97.5s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_L3"
;
;from 3 to 4
<97.5s>=>MEASURE(133.8 - 97.5)
;4
<133.8s>=>SATPULSE
<133.8s - mfmsub_length>=>checkPoint,"startFt_Lss"
<133.8s + PulseDuration/2>=>checkPoint,"startFm_Lss"
<133.8s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_Lss"
;
;
;
;
;
;
;
;-------------------------------------------------------------------------------------------------------------
;******* Dark relaxation after actinic light period **********************************************************
;-------------------------------------------------------------------------------------------------------------
DarkRelaxation2 = 120s
;
; measure to pulse 1
<ALStart + ALPeriod, ALStart + ALPeriod + 40 * mfmsub_length..144.8s - 2*mfmsub_length>=>mfmsub
; measure from last pulse
<253.8 + PulseDuration + 2*mfmsub_length, 253.8s + PulseDuration + 2*mfmsub_length + 40 * mfmsub_length..ALStart + ALPeriod + DarkRelaxation2 - mfmsub_length>=>mfmsub
;<ALStart + ALPeriod + DarkRelaxation2>=>mfmsub
;
;******* Saturating Pulses in Dark- Fm_D'********************************************************************
;
;pulse 1
<144.8s>=>SATPULSE
<144.8s>=>act1(PulseDuration)
<144.8s>=>act2(PulseDuration)
<144.8s - mfmsub_length>=>checkPoint,"startFt_D1"
<144.8s + PulseDuration/2>=>checkPoint,"startFm_D1"
<144.8s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_D1"
;from 1 to 2
<144.8s>=>MEASURE(181.1 - 144.8s)
;2
<181.1s>=>SATPULSE
<181.1s>=>act1(PulseDuration)
<181.1s>=>act2(PulseDuration)
<181.1s - mfmsub_length>=>checkPoint,"startFt_D2"
<181.1s + PulseDuration/2>=>checkPoint,"startFm_D2"
<181.1s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_D2"
;from 2 to 3
<181.1s>=>MEASURE(217.5 - 181.1s)
;3
<217.5s>=>SATPULSE
<217.5s>=>act1(PulseDuration)
<217.5s>=>act2(PulseDuration)
<217.5s - mfmsub_length>=>checkPoint,"startFt_D3"
<217.5s + PulseDuration/2>=>checkPoint,"startFm_D3"
<217.5s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_D3"
;from 3 to 4
<217.5s>=>MEASURE(253.8 - 217.5s)
;4
<253.8s>=>SATPULSE
<253.8s>=>act1(PulseDuration)
<253.8s>=>act2(PulseDuration)
<253.8s - mfmsub_length>=>checkPoint,"startFt_D4"
<253.8s + PulseDuration/2>=>checkPoint,"startFm_D4"
<253.8s + PulseDuration - mfmsub_length>=>checkPoint,"endFm_D4"

FoMeasureStart=253.8s + PulseDuration + 2*mfmsub_length
FoPeriod=60s
<FoMeasureStart>=>MEASURE(FoPeriod)
<FoMeasureStart>=>FARREDILL(FoPeriod)
FoPrimeStart=FoMeasureStart+FoPeriod
<FoPrimeStart - 2*TS>=>checkPoint,"startFoPrime"
<FoPrimeStart>=>checkPoint,"endFoPrime"
;;;;;;