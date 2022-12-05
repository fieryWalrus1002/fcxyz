; FluorScan & FluorCam Include file for PSI device "XY"
; Ing.Pavel Korabecny, 2007
;-------------------------------------------------------------------------

CompAction __MOVE(V1:Word, V2:Word) begin		; Motor
  0x53,0x6,0x80,0x50,V1,V2
end;

CompAction __MOVE_SIMPLE(V1:Byte, V2:Word) begin	; Motor
  0x53,0x4,0x80,V1,V2
end;

Action MOVE(V1,V2) begin				; Position [mm]
  <0>=>__MOVE(V1,V2), extcomm
end;

Action MOVE_X(V1) begin					; Position [mm]
  <0>=>__MOVE_SIMPLE(88,V1), extcomm
end;

Action MOVE_Y(V1) begin					; Position [mm]
  <0>=>__MOVE_SIMPLE(89,V1), extcomm
end;

Action Home begin					; Position -> 0 mm
  <0>=>__MOVE(0,0), extcomm
end;
