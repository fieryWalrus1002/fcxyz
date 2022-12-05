TS=20ms
;version ZB 10.03.25
include default.inc  ;Includes standard options, do not remove it !
include light.inc  ;Includes standard options, do not remove it !
include qa.inc;    ;Include qa command,do not remove it !
;
Shutter=0
Sensitivity=10
Super=40
;
;*******************************************************************
f0measurement = 0s
pause = 1s
;
;******************************
Action OJIP_measure begin
  <TS>=>bit0H        ;povoleni QA
  <TS>=>bit1H(2*TS)  ; povoleni OJIP - kdyz je povoleno zakaze se QA
  <2*TS>=>m     
end
;
Action OJIP begin
  <0>=>bit0H
  <0>=>bit1H(TS)  
end
;
;***************OJIP****************************************************************************************
TimeAxis = <10us,20us,40us,60us,80us,100us,140us,180us,220us,260us,300us,340us,380us,420us,460us,500us,600us,700us,800us,900us,1000us,1200us,1400us,1600us,1800us,2000us,2200us,2400us,2600us,2800us,3ms,4ms,5ms,6ms,7ms,8ms,9ms,10ms,11ms,12ms,13ms,14ms,15ms,16ms,17ms,18ms,19ms,20ms,60ms,120ms,180ms,240ms,300ms,360ms,420ms,480ms,540ms,600ms,660ms,720ms,780ms,840ms,900ms,960ms,1020ms,1080ms,1140ms,1200ms,1260ms,1320ms,1380ms,1440ms,1500ms,1560ms,1620ms,1680ms,1740ms,1800ms,1860ms,1920ms,1980ms>
<10us>=>checkPoint,"startFo"
<300us>=>checkPoint,"startF300"
<2ms>=>checkPoint,"startFj"
<20ms>=>checkPoint,"startFi"
<1000ms>=>checkPoint,"startFm"
<1980ms>=>checkPoint,"startFLast"
<1000ms>=>checkPoint,"timeVisual"
;*********Fo measurement***************
<f0measurement>=>QA(5us,10us), OJIP_measure
;
;*********Phase1 20us - 100us**********
period1 = 20us
<f0measurement+1*pause>=>QA(5us,1*period1), OJIP_measure; 20us
<f0measurement+2*pause>=>QA(5us,2*period1), OJIP_measure; 40us
<f0measurement+3*pause>=>QA(5us,3*period1), OJIP_measure; 60us
<f0measurement+4*pause>=>QA(5us,4*period1), OJIP_measure; 80us
<f0measurement+5*pause>=>QA(5us,5*period1), OJIP_measure; 100us
;
;*********Phase2 100us - 500us*********
period2 = 40us
delay2 = 5*period1
<f0measurement+6*pause>=>QA(5us,delay2 + 1*period2), OJIP_measure
<f0measurement+7*pause>=>QA(5us,delay2 + 2*period2), OJIP_measure
<f0measurement+8*pause>=>QA(5us,delay2 + 3*period2), OJIP_measure
<f0measurement+9*pause>=>QA(5us,delay2 + 4*period2), OJIP_measure
<f0measurement+10*pause>=>QA(5us,delay2 + 5*period2), OJIP_measure
<f0measurement+11*pause>=>QA(5us,delay2 + 6*period2), OJIP_measure
<f0measurement+12*pause>=>QA(5us,delay2 + 7*period2), OJIP_measure
<f0measurement+13*pause>=>QA(5us,delay2 + 8*period2), OJIP_measure
<f0measurement+14*pause>=>QA(5us,delay2 + 9*period2), OJIP_measure
<f0measurement+15*pause>=>QA(5us,delay2 + 10*period2), OJIP_measure
;
;*********Phase3 500us - 1000us*********
period3 = 100us
delay3 = delay2 + 10*period2
<f0measurement+16*pause>=>QA(5us,delay3 + 1*period3), OJIP_measure
<f0measurement+17*pause>=>QA(5us,delay3 + 2*period3), OJIP_measure
<f0measurement+18*pause>=>QA(5us,delay3 + 3*period3), OJIP_measure
<f0measurement+19*pause>=>QA(5us,delay3 + 4*period3), OJIP_measure
<f0measurement+20*pause>=>QA(5us,delay3 + 5*period3), OJIP_measure
;
;*********Phase4 1ms - 3ms**************
period4 = 200us
delay4 = delay3 + 5*period3
<f0measurement+21*pause>=>QA(5us,delay4 + 1*period4), OJIP_measure
<f0measurement+22*pause>=>QA(5us,delay4 + 2*period4), OJIP_measure
<f0measurement+23*pause>=>QA(5us,delay4 + 3*period4), OJIP_measure
<f0measurement+24*pause>=>QA(5us,delay4 + 4*period4), OJIP_measure
<f0measurement+25*pause>=>QA(5us,delay4 + 5*period4), OJIP_measure
<f0measurement+26*pause>=>QA(5us,delay4 + 6*period4), OJIP_measure
<f0measurement+27*pause>=>QA(5us,delay4 + 7*period4), OJIP_measure
<f0measurement+28*pause>=>QA(5us,delay4 + 8*period4), OJIP_measure
<f0measurement+29*pause>=>QA(5us,delay4 + 9*period4), OJIP_measure
<f0measurement+30*pause>=>QA(5us,delay4 + 10*period4), OJIP_measure
;
;*********Phase5 3ms - 20ms*************
period5 = 1ms
delay5 = delay4 + 10*period4
<f0measurement+31*pause>=>QA(5us,delay5 + 1*period5), OJIP_measure
<f0measurement+32*pause>=>QA(5us,delay5 + 2*period5), OJIP_measure
<f0measurement+33*pause>=>QA(5us,delay5 + 3*period5), OJIP_measure
<f0measurement+34*pause>=>QA(5us,delay5 + 4*period5), OJIP_measure
<f0measurement+35*pause>=>QA(5us,delay5 + 5*period5), OJIP_measure
<f0measurement+36*pause>=>QA(5us,delay5 + 6*period5), OJIP_measure
<f0measurement+37*pause>=>QA(5us,delay5 + 7*period5), OJIP_measure
<f0measurement+38*pause>=>QA(5us,delay5 + 8*period5), OJIP_measure
<f0measurement+39*pause>=>QA(5us,delay5 + 9*period5), OJIP_measure
<f0measurement+40*pause>=>QA(5us,delay5 + 10*period5), OJIP_measure
<f0measurement+41*pause>=>QA(5us,delay5 + 11*period5), OJIP_measure
<f0measurement+42*pause>=>QA(5us,delay5 + 12*period5), OJIP_measure
<f0measurement+43*pause>=>QA(5us,delay5 + 13*period5), OJIP_measure
<f0measurement+44*pause>=>QA(5us,delay5 + 14*period5), OJIP_measure
<f0measurement+45*pause>=>QA(5us,delay5 + 15*period5), OJIP_measure
<f0measurement+46*pause>=>QA(5us,delay5 + 16*period5), OJIP_measure
<f0measurement+47*pause>=>QA(5us,delay5 + 17*period5), OJIP_measure
;
;*********SLOW PHASES*************************************
;
fm_measurement = f0measurement + 48*pause
<fm_measurement + 20ms, fm_measurement + 80ms .. fm_measurement + 2s>=>superlightOn(20ms)
<fm_measurement + 60ms, fm_measurement + 120ms .. fm_measurement + 2s>=>OJIP
<fm_measurement + 20ms, fm_measurement + 80ms .. fm_measurement + 2s>=>OJIP_measure
;
;<fm_measurement + 400ms>=>checkPoint,"startFm"
;<fm_measurement + 2s>=>checkPoint,"endFm"
