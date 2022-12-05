;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;----------------------------------------------------------------------------------------------
;
; FluorCam Microscope include file
; File Name  : microscope.inc
; Version    : 1.00
; Last change: 3.10.2005
;
;----------------------------------------------------------------------------------------------

; Microscope, left-right, AXIS1(20,3456) => "go to 20.3456"
CompAction __AXIS1(V1:Word, V2:Word) begin
  0x52,0x7,0x5A,0x41,0x31,V1,V2
end;

; Microscope, back-front, AXIS2(30,12) => "go to 30.0012"
CompAction __AXIS2(V1:Word, V2:Word) begin
  0x52,0x7,0x5A,0x41,0x32,V1,V2
end;

; Microscope, up-down, AXIS3(100,234) => "go to 100234"
CompAction __AXIS3(V1:Word, V2:Word) begin
  0x52,0x7,0x5A,0x41,0x33,V1,V2
end;

; External filter wheel
CompAction __EXTFILTER(V1:Word) begin
  0x52,0x7,0x5A,0x45,0x46,0x00,0x00,V1
end;

; Reflector wheel
CompAction __REFLECTOR(V1:Word) begin
  0x52,0x7,0x5A,0x52,0x45,0x00,0x00,V1
end;

; Lamp intensity, 0-255 (255 is maximum intensity)
CompAction __LAMPINTENSITY(V1:Word) begin
  0x52,0x7,0x5A,0x4c,0x49,0x00,0x00,V1
end;

; Lamp power, 1 - on, 0 - off
CompAction __LAMPPOWER(V1:Word) begin
  0x52,0x7,0x5A,0x4c,0x50,0x00,0x00,V1
end;

; Lamp 3200K mode, 1 - on, 0 - off
CompAction __LAMP3200K(V1:Word) begin
  0x52,0x7,0x5A,0x4c,0x33,0x00,0x00,V1
end;

; Lamp FL mode, 1 - on, 0 - off
CompAction __LAMPFLMODE(V1:Word) begin
  0x52,0x7,0x5A,0x4c,0x46,0x00,0x00,V1
end;

; Added Pavel 24.08.2005
; Tube mirror
; send to serial 7 byte "ZTM",value(word),value(word)
;
CompAction __TUBE_MIRROR(V1:Word) begin
  0x52,0x7,0x5A,0x54,0x4D,0x00,0x00,V1
end;

; Added Pavel 24.08.2005
; Tube prism
; send to serial 7 byte "ZTP",value(word),value(word)
;
CompAction __TUBE_PRISM(V1:Word) begin
  0x52,0x7,0x5A,0x54,0x50,0x00,0x00,V1
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

Action EXTFILTER(V1) begin
  <0>=>__EXTFILTER(V1), extcomm
end;

Action REFLECTOR(V1) begin
  <0>=>__REFLECTOR(V1), extcomm
end;

Action LAMPINTENSITY(V1) begin
  <0>=>__LAMPINTENSITY(V1*2.5), extcomm
end;

Action LAMPPOWER(V1) begin
  <0>=>__LAMPPOWER(V1), extcomm
end;

Action LAMP3200K(V1) begin
  <0>=>__LAMP3200K(V1), extcomm
end;

Action LAMPFLMODE(V1) begin
  <0>=>__LAMPFLMODE(V1), extcomm
end;

; Added Pavel 24.08.2005
; Tube mirror
;
Action TUBEMIRROR(V1) begin
  <0>=>__TUBE_MIRROR(V1), extcomm
end;

;TUBEMIRROR(1)  ----  top port exit
;TUBEMIRROR(2)  ----  variable beam splitter

; Added Pavel 24.08.2005
; Tube prism
;
Action TUBEPRISM(V1) begin
  <0>=>__TUBE_PRISM(V1), extcomm
end;

;TUBEPRISM(1)   100% binocular exit
;TUBEPRISM(2)    50% binocular 50% upper slider
;TUBEPRISM(3)   100% upper slider
