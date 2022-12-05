;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;----------------------------------------------------------------------------------------------
;
; FluorCam Craine include file
; File Name  : crane.inc
; Version    : 1.00
; Last change: 3.10.2005
;
;----------------------------------------------------------------------------------------------

CompAction __MOT(V1:Byte, V2:Byte, V3:Word) begin   ; Motor
  0x52,0x5,0x50,V1,V2,V3
end;

Action MOT(V1,V2,V3) begin                          ; Motor
  <0>=>__MOT(V1,V2,V3), extcomm
end;

Action Position(V3) begin                           ; Position [mm]
  <0>=>__MOT(66,98,V3), extcomm
end;

Action Home begin                                   ; Position -> 0 mm
  <0>=>__MOT(66,97,0), extcomm
end;

;----------------------------------------------------------------------------------------------
