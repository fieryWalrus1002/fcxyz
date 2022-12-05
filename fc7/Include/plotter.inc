;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;----------------------------------------------------------------------------------------------
;
; FluorCam Microscope include file
; File Name  : plotter.inc
; Version    : 1.00
; Last change: 6.1.2006
;
;----------------------------------------------------------------------------------------------

CompAction __MOVEA(S1:String) begin
  0x54,0x50,0x41,0x20,S1,0x3B,0x00
end;

CompAction __MOVER(S1:String) begin
  0x54,0x50,0x52,0x20,S1,0x3B,0x00
end;


Action MOVEA(S1:String) begin
  <0>=>__MOVEA(S1), extcomm
end;

Action MOVER(S1:String) begin
  <0>=>__MOVER(S1), extcomm
end;

