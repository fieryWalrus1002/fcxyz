;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;----------------------------------------------------------------------------------------------
;
; FluorCam Microscope Zeiss Axio Imager include file
; File Name  : axio.inc
; Version    : 1.00
; Last change: 3.10.2005
;
;----------------------------------------------------------------------------------------------

; Microscope Axes, target = V1 * 10000 + V2
CompAction __AXIS1(V1:Int, V2:Word) begin
  0x52,0x7,0x41,0x41,0x31,V1,V2
end;

CompAction __AXIS2(V1:Int, V2:Word) begin
  0x52,0x7,0x41,0x41,0x32,V1,V2
end;

CompAction __AXIS3(V1:Int, V2:Word) begin
  0x52,0x7,0x41,0x41,0x33,V1,V2
end;

; Misc servos.
CompAction __REFLECTORTURRET(V1:Word) begin
  0x52,0x7,0x41,0x52,0x54,0x00,0x00,V1
end;

CompAction __LAMPINTENSITY(V1:Word) begin
  0x52,0x7,0x41,0x4c,0x49,0x00,0x00,V1
end;

CompAction __TRANSFIELDDIAPH(V1:Word) begin
  0x52,0x7,0x41,0x54,0x44,0x00,0x00,V1
end;

CompAction __REFLFIELDDIAPH(V1:Word) begin
  0x52,0x7,0x41,0x52,0x44,0x00,0x00,V1
end;

CompAction __REFLECTORSHUTTER(V1:Word) begin
  0x52,0x7,0x41,0x52,0x53,0x00,0x00,V1
end;

Action AXIS1(V1,V2) begin
  <0>=>__AXIS1(V1,V2), extcomm
end;

Action AXIS2(V1,V2) begin
  <0>=>__AXIS2(V1,V2), extcomm
end;

Action AXIS3(V1,V2) begin
  <0>=>__AXIS3(V1,V2), extcomm
end;

Action REFLECTORTURRET(V1) begin
  <0>=>__REFLECTORTURRET(V1), extcomm
end;

Action LAMPINTENSITY(V1) begin
  <0>=>__LAMPINTENSITY(V1), extcomm
end;

Action TRANSFIELDDIAPH(V1) begin
  <0>=>__TRANSFIELDDIAPH(V1), extcomm
end;

Action REFLFIELDDIAPH(V1) begin
  <0>=>__REFLFIELDDIAPH(V1), extcomm
end;

Action REFLECTORSHUTTER(V1) begin
  <0>=>__REFLECTORSHUTTER(V1), extcomm
end;

;----------------------------------------------------------------------------------------------
