;protocol body - modified by ZB
;version November 18, 2010
;high-resolution CCD
TS=50ms
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
Shutter=3
Sensitivity=52
FAR=75
;----actinic light set to 160uE, combination of red and blue. Both at 45%
Act1=60
Act2=70
Super=90;************************************************************************************************************
Action SATPULSE(end_time) begin
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
;
;light teatment
;-------------------------------------------------------------------------------------------------------------
;*** pre-illumination *****************************************************************************************
;-------------------------------------------------------------------------------------------------------------

<0.0s>=>act1(29s);
<0.0s>=>act2(29s);
<0.0s>=>MEASURE(29s);


;Fmprime
;-------------------------------------------------------------------------------------------------------------
;*** Fmprime **************************************************************************************************
;-------------------------------------------------------------------------------------------------------------

<30.0s>=>act1(29s);
<30.0s>=>act2(29s);
<30.0s>=>MEASURE(29s);

<60.0s>=>SATPULSE(0.8s);

<30.27s>=>checkPoint,"startFo_L1"
<59.07s>=>checkPoint,"endFo_L1"
<60.0s>=>checkPoint,"startFm_L1"
<60.8s>=>checkPoint,"endFm_L1"
;Fmprime
;-------------------------------------------------------------------------------------------------------------
;*** Fmprime **************************************************************************************************
;-------------------------------------------------------------------------------------------------------------

<60.8s>=>act1(29s);
<60.8s>=>act2(29s);
<60.8s>=>MEASURE(29s);

<90.8s>=>SATPULSE(0.8s);

<60.93s>=>checkPoint,"startFo_Lss"
<90.75s>=>checkPoint,"endFo_Lss"
<90.8s>=>checkPoint,"startFm_Lss"
<91.6s>=>checkPoint,"endFm_Lss"
;light after pulse
;-------------------------------------------------------------------------------------------------------------
;*** light after pulse ****************************************************************************************
;-------------------------------------------------------------------------------------------------------------


<91.6s>=>MEASURE(9s);


;foprime
;-------------------------------------------------------------------------------------------------------------
;***  *********************************************************************************************************
;-------------------------------------------------------------------------------------------------------------


<101.6>=>FARREDILL(9s)
<101.6s>=>MEASURE(9s);


<101.86999999999999s>=>checkPoint,"startFoprime"
<111.16999999999999s>=>checkPoint,"endFoprime"
;recovery
;-------------------------------------------------------------------------------------------------------------
;***  *********************************************************************************************************
;-------------------------------------------------------------------------------------------------------------


<111.6s>=>MEASURE(29s);

<141.6s>=>SATPULSE(0.8s);

<112.52s>=>checkPoint,"startFt_D1"
<140.85999999999999s>=>checkPoint,"endFt_D1"
<141.6s>=>checkPoint,"startFm_D1"
<142.4s>=>checkPoint,"endFm_D1"
;recovery
;-------------------------------------------------------------------------------------------------------------
;***  *********************************************************************************************************
;-------------------------------------------------------------------------------------------------------------


<142.4s>=>MEASURE(29s);

<172.4s>=>SATPULSE(0.8s);

<142.97s>=>checkPoint,"startFt_D2"
<172.21s>=>checkPoint,"endFt_D2"
<172.4s>=>checkPoint,"startFm_D2"
<173.20000000000002s>=>checkPoint,"endFm_D2"
;recovery
;-------------------------------------------------------------------------------------------------------------
;***  *********************************************************************************************************
;-------------------------------------------------------------------------------------------------------------


<173.20000000000002s>=>MEASURE(29s);

<203.20000000000002s>=>SATPULSE(0.8s);

<174.08s>=>checkPoint,"startFt_D3"
<203.13000000000002s>=>checkPoint,"endFt_D3"
<203.20000000000002s>=>checkPoint,"startFm_D3"
<204.00000000000003s>=>checkPoint,"endFm_D3"
;recovery
;-------------------------------------------------------------------------------------------------------------
;***  *********************************************************************************************************
;-------------------------------------------------------------------------------------------------------------


<204.00000000000003s>=>MEASURE(59s);

<264.0s>=>SATPULSE(0.8s);

<204.96000000000004s>=>checkPoint,"startFt_D4"
<263.43s>=>checkPoint,"endFt_D4"
<264.0s>=>checkPoint,"startFm_D4"
<264.8s>=>checkPoint,"endFm_D4"
;recovery
;-------------------------------------------------------------------------------------------------------------
;***  *********************************************************************************************************
;-------------------------------------------------------------------------------------------------------------


<264.8s>=>MEASURE(59s);

<324.8s>=>SATPULSE(0.8s);

<265.32s>=>checkPoint,"startFt_D5"
<324.52000000000004s>=>checkPoint,"endFt_D5"
<324.8s>=>checkPoint,"startFm_D5"
<325.6s>=>checkPoint,"endFm_D5"
;dark
;-------------------------------------------------------------------------------------------------------------
;*** dark *****************************************************************************************************
;-------------------------------------------------------------------------------------------------------------


<325.6s>=>MEASURE(9s);


;end