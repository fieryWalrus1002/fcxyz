;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;----------------------------------------------------------------------------------------------
;
; File Name  : elight.inc
; Version    : 1.00
; Last change: 15.12.2010
;
;----------------------------------------------------------------------------------------------
;
; SUPER ON
;
a1_intensity = 0;
a2_intensity = 1;
a3_intensity = 2;
a4_intensity = 3;
a5_intensity = 4;
f1_intensity = 0;
f2_intensity = 1;
f3_intensity = 2;
f4_intensity = 3;
f5_intensity = 4;

CompAction __SUPERON begin
  0x52,0x2,0x45,0x4f
end;

; SUPER OFF
;
CompAction __SUPEROFF begin
  0x52,0x2,0x45,0x46
end;

CompAction  __SETAD(i:Byte,l:Byte,h:Byte) begin
  0x52,0x5,0x45,0x4c,i,l,h
end

CompAction __SETLIGHT(a:Byte,f:Byte) begin
  0x52,0x4,0x43,0x45,a,f
end

Action SUPER_ON begin
  <0s>=>__SUPERON,extcomm
end  

Action SUPER_OFF begin
  <0s>=>__SUPEROFF,extcomm
end  

Action SETFLASH(i,v) begin
  p = v * 10.23
  h = p / 256
  l = p
  <0s>=>__SETAD(i,l,h),extcomm
end;

Action SETACTINIC(i,v) begin
  p = v * 5.11
  h = p / 256
  l = p
  <0s>=>__SETAD(i+5,l,h),extcomm
end;

Action SETSUPER(v) begin
  p = v * 5.11
  h = p / 256
  l = p
  <0s>=>__SETAD(11,l,h),extcomm
end;

Action SETACTINIC_GLOBAL(v) begin
  p = v * 10.23
  h = p / 256
  l = p
  <0s>=>__SETAD(12,l,h),extcomm
end;

;Setting the color mask of Actinic/Superpulse and Flashes
;set bit value (a1..a5 for actinic,f1..f5 for flashes) to =1 for enable the light 
Action SETLIGHT(a1,a2,a3,a4,a5,f1,f2,f3,f4,f5) begin
  a = a1 + 2*a2 + 4*a3 + 8*a4 + 16*a5
  f = f1 + 2*f2 + 4*f4 + 8*f3 + 16*f5  
  <0s>=>__SETLIGHT(a,f),extcomm
end;

PrimAction   actinic_on(0x0002,0x10000002,1ms)   	; switch on actinic light 




