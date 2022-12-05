;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;-------------------------------------------------------------------
;
; Oscillation include file
; File Name  : oscillation.inc
; Version    : 2.00
; Last change: 6.8.2008
;
;-------------------------------------------------------------------
;
; Parameters description
; 0x4F = 'O'
; 0x46 = 'F'
; V1   = Level [ % ]; 0 - 100
; V2   = Offset [ % ]; 0 - 100
; V3   = Frequency in [ mHz ] or [ uHz ]; 35 - 10000
; V4   = Frequency Range; 0 = [ mHz ]; 1 = [ uHz ]
;
;-------------------------------------------------------------------

CompAction __OSC(V1:Byte, V2:Byte, V3:Word, V4:Byte) begin
  0x52,0x7,0x4F,0x46,V1,V2,V3,V4
end;

CompAction __OSC_OFF begin
  0x52,0x2,0x4F,0x50
end;

; Oscillation frequency in [ mHz ]
Action OSC(V1,V2,V3) begin
  <0>=>__OSC(Fit(0,100,V1),Fit(0,100,V2),Fit(0,10000,V3),0), extcomm
end;

; Oscillation frequency in [ uHz ]
Action OSC_uH(V1,V2,V3) begin
  <0>=>__OSC(Fit(0,100,V1),Fit(0,100,V2),Fit(0,10000,V3/10),1), extcomm
end;

; Turn off osciallation
Action OSC_OFF begin
  <0>=>__OSC_OFF, extcomm
end;
