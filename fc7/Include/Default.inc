;
; PSI (Photon Systems Instruments), Ltd.
; Hogrova 20
; 612 00 Brno - Czech Republic
; www.psi.cz
;
;----------------------------------------------------------------------------------------------
;
; Default include file
; File Name  : default.inc
; Version    : 1.04
; Last change: 18.11.2008
;
;----------------------------------------------------------------------------------------------
;
; upravene primitivni akce - implicitni doba trvani 1ms
; mozno pouzit take ve tvaru napr.  <1s>=>m(5s)
;
;    Event High       Event Low
; 7,6,5,4,3,2,1,0   7,6,5,4,3,2,1,0
; | | | | | | | |   | | | | | | | |
; | | | | | | | |   | | | | | | | |.. measuring flash on/off   (1)
; | | | | | | | |   | | | | | | |.... actinic light 1 on/off   (2)
; | | | | | | | |   | | | | | |...... actinic light 2 on/off   (4)
; | | | | | | | |   | | | | |........ superlight on/off        (8)
; | | | | | | | |   | | | |.......... Far led                  (1)
; | | | | | | | |   | | | ...........                          (2)
; | | | | | | | |   | |.............. measuring frame          (4) 
; | | | | | | | |   | ...............                          (8)
; | | | | | | | |
; | | | | | | | |.................... mechanical shutter on/off                             (1)
; | | | | | | |...................... external mechanical shutter on/off (TTL2); active low (2)
; | | | | | | ....................... external superlight on/off (TTL1); active high        (4)
; | | | | | .........................                                                       (8)
; | | | | ...........................                                                       (1)
; | | | .............................                                                       (2)
; | | ...............................                                                       (4)
; | .................................                                                       (8)
;
;----------------------------------------------------------------------------------------------
;
; primary actions
;
PrimAction   m(0x10040,0x10010040,1ms)	                ; Bit 0 a ;bit 6 v eventech(0..7)
PrimAction   avgstart(0x20000,0x10020000,1ms)		; Bit 1
PrimAction   avgstop(0x200000,0x10200000,1ms)		; Bit 1
PrimAction   sub(0x40000,0x10040000,1ms)		; Bit 0 and sub from next
PrimAction   lightOff_t(0x10000001,0x0001,1ms)          ; Switch on light in this frame
PrimAction   lightOn_t(0x0001,0x10000001,1ms)           ; measuring flash_on  
PrimAction   visual(0x80000,0x10080000,1ms)             ; use this frame as analysis image
PrimAction   mech_shutter_On(0x0100,0x10000100,1ms)     ; Switch on light in this frame_old
PrimAction   superlightOn(0x0008,0x10000008,1ms)        ; Switch on light in this frame_old
PrimAction   light2Off(0x0010,0x10000010,1ms)           ; Switch off light in this frame
PrimAction   checkPoint(0x100000,0x10100000,1ms)        ; arithmetic selectable frame
PrimAction   extcomm(0x0080,0x10000080,1ms)		; external command
PrimAction   actinlightOn(0x0002,0x10000002,1ms)        ; switch on actinic light 1
;----------------------------------------------------------------------------------------
;
;----------------------------------------------------------------------------------------
; primary actions for TTL outputs control
; date 10.03.2004
; Ladislav Hronek
PrimAction TTL1H(0x0400,0x10000400,1ms)  ;TTL 1 output (active high)
PrimAction TTL2L(0x0200,0x10000200,1ms)  ;TTL 2 output (active low)
;----------------------------------------------------------------------------------------
;
;----------------------------------------------------------------------------------------
; event bits (low)
PrimAction bit0L(0x0001,0x10000001,1ms)  ;low event bit 0
PrimAction bit1L(0x0002,0x10000002,1ms)  ;low event bit 1   
PrimAction bit2L(0x0004,0x10000004,1ms)  ;low event bit 2
PrimAction bit3L(0x0008,0x10000008,1ms)  ;low event bit 3   
PrimAction bit4L(0x0010,0x10000010,1ms)  ;low event bit 4
PrimAction bit5L(0x0020,0x10000020,1ms)  ;low event bit 5   
PrimAction bit6L(0x0040,0x10000040,1ms)  ;low event bit 6
PrimAction bit7L(0x0080,0x10000080,1ms)  ;low event bit 7

; event bits (high)
PrimAction bit0H(0x0100,0x10000100,1ms)  ;high event bit 0
PrimAction bit1H(0x0200,0x10000200,1ms)  ;high event bit 1
PrimAction bit2H(0x0400,0x10000400,1ms)  ;high event bit 2
PrimAction bit3H(0x0800,0x10000800,1ms)  ;high event bit 3
PrimAction bit4H(0x1000,0x10001000,1ms)  ;high event bit 4
PrimAction bit5H(0x2000,0x10002000,1ms)  ;high event bit 5
PrimAction bit6H(0x4000,0x10004000,1ms)  ;high event bit 6
PrimAction bit7H(0x8000,0x10008000,1ms)  ;high event bit 7
;----------------------------------------------------------------------------------------

Action f begin
  <0ms>=>lightOn_t
end

Action lightOff begin
  <0ms>=>lightOff_t
end

Action fm begin
  <0>=>f,m
end

Action SatPulse(Value) begin
  <0,TS .. Value>=>mech_shutter_On
  <0,TS .. Value>=>superlightOn
end

;obsolote not recomended to use
Action mfmsub begin
  <0>=>m,sub
  <2*TS>=>f,m
end

Action mfmsub2 begin
  <0>=>m,sub
  <20ms>=>f,m
end

Action mfm begin
  <0>=>m
  <TS>=>f,m
end

mfmsub_length = 4*TS
fm_length = 2*TS

Action F begin
  <-1s>=>superlightOn
end

Action Sh begin
  <0ms>=>mech_shutter_On
end

Action mpulse begin
  <-mfmsub_length>=>mfmsub ;before pulse
  <TS,TS + mfmsub_length .. 800ms-TS>=>mfmsub
  <800ms + mfmsub_length>=>mfmsub
end

CompAction   repeat(Count:word, Delay:word) begin
  0xFE, Count, Delay
end

CompAction   call(Start:word, Length:word) begin
  0xFF, Start, Length
end

;---------------------------------------------------------------------------------------------
MaxSensitivity = 1000
MaxIntensity   = 1000
MaxShutter     = 12
MaxSLight      = 1000
;---------------------------------------------------------------------------------------------

CompAction   __SS(Value:word) begin
  0x20, Value
end

CompAction   __SI(Value:word) begin
  0x21, Value
end

CompAction   __SZ(Value:byte) begin
  0x30, Value
end

CompAction   __SA(Value:word) begin
  0x22, Value
end

CompAction   __S2(Value:byte) begin
  0x40, Value
end

CompAction   __FlashDelay(Value:word) begin
  0x41, Value
end

CompAction   __Empty begin       ;test command
  0x50
end

CompAction __SAD(Adr:byte, Value:Word) begin
  0x51, Adr, Value
end;

;0x52 ..preposilej na seriak
;0x5  ..kolik hodnot ma poslat
CompAction __SER(V1:Byte, V2:Byte, V3:Byte, V4:Byte, V5:Byte) begin
  0x52,0x5, V1,V2,V3,V4,V5
end;

;0x53 ..preposilej na I2C
;0x4  ..kolik hodnot ma poslat
CompAction __SI2C4(V1:Byte, V2:Byte, V3:Byte, V4:Byte) begin
  0x53,0x4, V1,V2,V3,V4
end;

;0x55 ..preposilej na SPI
;0x7  ..kolik hodnot ma poslat
CompAction __SSPI7(V1:Byte, V2:Byte, V3:Byte, V4:Byte, V5:Byte, V6:Byte, V7:Byte) begin
  0x55,0x7, V1,V2,V3,V4,V5,V6,V7
end;

;0x55 ..preposilej na SPI
;0x5  ..kolik hodnot ma poslat
CompAction __SSPI5(V1:Byte, V2:Byte, V3:Byte, V4:Byte, V5:Byte) begin
  0x55,0x5, V1,V2,V3,V4,V5
end;

;0x55 ..preposilej na SPI
;0x3  ..kolik hodnot ma poslat
CompAction __SSPI3(V1:Byte, V2:Byte, V3:Byte) begin
  0x55,0x3, V1,V2,V3
end;

Action SS(Value) begin
  <0>=>__SS(Fit(0, MaxSensitivity, 10*Value)), extcomm
end

Action SI(Value) begin
  <0>=>__SI(Fit(0, MaxIntensity, 10*Value)), extcomm
end

Action SZ(Value) begin
  <0>=>__SZ(Fit(0, MaxShutter, Value)), extcomm
end

Action SA(Value) begin
  <0>=>__SA(Fit(0, MaxSLight, 10*Value)), extcomm
end

Action S2(Value) begin
  <0>=>__S2(Fit(0, MaxIntensity, 10*Value)), extcomm
end

Action FlashDelay(Value) begin
  <0>=>__FlashDelay(Fit(0, 511, Value)), extcomm
end

Action Empty begin
  <0>=>__Empty, extcomm
end

;nastaveni prevodniku 5311 adresovaneho adr na hodnotu value
Action SAD(Adr,Value) begin
  <0>=>__SAD(Adr,Value), extcomm
end

;posle 5 bytu
Action SER(V1,V2,V3,V4,V5) begin
  <0>=>__SER(V1,V2,V3,V4,V5), extcomm
end;


Action SI2C4(V1,V2,V3,V4) begin
  <0>=>__SI2C4(V1,V2,V3,V4), extcomm
end; 
;---------------------------------------------------------------------------------------------
; End of file
;---------------------------------------------------------------------------------------------
