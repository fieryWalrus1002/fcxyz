;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;----------------------------------------------------------------------------------------------
;
; FluorCam Arc include file
; File Name  : axio.inc
; Version    : 1.00
; Last change: 3.10.2005
;
;----------------------------------------------------------------------------------------------

CompAction __MOT(V1:Byte, V2:Byte, V3:Int) begin	; Motor
  0x52,0x5,0x50,V1,V2,V3
end;

Action MOT(V1,V2,V3) begin				; Motor
  <0>=>__MOT(V1,V2,V3), extcomm
end;

Action Wheel_Home begin					; Vertical axis Sensor reset & Parking position
  <0>=>__MOT(65,97,0), extcomm
end;

Action Wheel_Pos(V3) begin				; Vertical axis position [degrees]
  <0>=>__MOT(65,98,V3), extcomm
end;

Action Arc_Home begin					; Horizontal axis Sensor reset & Parking position
  <0>=>__MOT(67,97,0), extcomm
end;

Action Arc_Pos(V3) begin				; Horizontal axis position [degrees]
  <0>=>__MOT(67,98,V3), extcomm
end;

;----------------------------------------------------------------------------------------------
