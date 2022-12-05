;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;----------------------------------------------------------------------------------------------
;
; FluorCam FilterWheel include file
; File Name  : FilterWheel.inc
; Version    : 1.00
; Last change: 20.7.2006
;
;----------------------------------------------------------------------------------------------

; FS
; 
; 
; 
; 
; 
CompAction __FWSPEED(B:Byte) begin
  0x54,0x46,0x53,B,0x00
end;

; FI
; 
; 
; 
; 
; 
CompAction __FWINICIALIZATION(B:Byte) begin
  0x54,0x46,0x49,B,0x00
end;

; FF
; 
; 
; 
; 
; 
CompAction __FWFILTER(B:Byte) begin
  0x54,0x46,0x46,B,0x00
end;

Action SET_SPEED(B) begin
  <0>=>__FWSPEED(B), extcomm
end;
Action SET_MAX_FILTER(B) begin
  <0>=>__FWINICIALIZATION(B), extcomm
end;
Action SET_FILTER(B) begin
  <0>=>__FWFILTER(B), extcomm
end;
