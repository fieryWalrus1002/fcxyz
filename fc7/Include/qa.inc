;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;----------------------------------------------------------------------------------------------
;
; Li-Cor include file
; File Name  : licor.inc
; Version    : 1.00
; Last change: 3.10.2005
;
;----------------------------------------------------------------------------------------------
; A = QA pulse duration [ us ], now fixed to 120 us
; B = position before measuring flash [ us ]
;
; <10s>=>QA(120us,200us)
;
Action QA(A,B) begin
  A = 1000000*A
  D = 255 - A - 1
  B = 1000000*B 
  C = 65535 - (23525-B)
  H = C/256
  L = C
  <0>=>__SI2C4(154,D,H,L), extcomm
end;
; -------------------------------------------------


