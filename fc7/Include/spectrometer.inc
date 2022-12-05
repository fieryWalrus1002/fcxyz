;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;----------------------------------------------------------------------------------------------
;
; File Name  : spectrometer.inc
; Version    : 1.00
; Last change: 16.9.2008
;
;----------------------------------------------------------------------------------------------


PrimAction  sync_spec_on(0x0010,0x10000010,1ms)   ;prepare spectrometer to take spectrum

PrimAction  take_spec(0x0100,0x10000100,1ms)      ;spectrometer take spectrum


Action take_spectrum begin
  <-20ms>=>sync_spec_on
  <0ms>=>take_spec
end