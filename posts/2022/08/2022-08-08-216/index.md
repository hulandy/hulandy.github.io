---
title: "Ardupilot Copter 4.1.5 firmware for BetaflightF4 controller"
date: 2022-08-08
categories: 
  - "fpv"
---

Visit here for the latest: [https://github.com/hulandy/hulandy.github.io/releases](https://github.com/hulandy/hulandy.github.io/releases)

\=============

Updated on 2022.08.13

Today I've compiled another 4.1.5 copter firmware for this board. It contains 6 PWM output, PA0 pin (CAM or TM pin depends on varieties) is for the PWM5, LED pin is the PWM6, thus adding a super low cost sonar on it to incorporate with optic flow is possible now. The other functionality maintains the same. If you attach a MS5611 module on it, then you don't need to do anything in order to make it working. In theory, you can use a different barometer like BMP280 then you set it as an external module (In this case, set BARO\_PROBE\_EXT to 2, after reboot you'll be able to check the "press\_abs" and "press\_temp" in Status).

My setup : MS5611 module, GL9306 optic flow, GY-US42v2 Sonar works in PWM mode, 5883L compass. It works great~ Test flight footage and the firmware below :  
[Testflight](http://v.youku.com/v_show/id_XNTg5NDYwNjAxMg==.html?x&sharefrom=iphone&sharekey=5f66c62fdb1929debb1e2ce6c1e4ef213)

[Firmware](https://www.gejing.org/usr/uploads/2022/08/2748726646.zip)

\=====================================================================================  
I just compiled two firmware for the old target betaflightf4 controller (Initially created by BorisB and FpvModel), I believe that iFlight SucceX-E and LDARC-KKT30D are both using the same target. There has no Baro on the board.

One of the firmware is for external Baro -BMP280 [bff428\_with\_bl.zip](https://www.gejing.org/usr/uploads/2022/08/1788575882.zip) and another is for MS56XX [bff456\_with\_bl.zip](https://www.gejing.org/usr/uploads/2022/08/318542715.zip).

There is also a slightly different between these two firmware, that is MS56XX one has PA0 pin (TM or Cam control) for PWM 5 but hopefully it will work.

Common function: The default USART3 is I2C, you can set BRD\_ALT\_CONFIG=1 to use it as a normal USART (most unlikely, somehow if you don’t attach a baro on it, “speed” goes crazy, I’m an AP noob, tell me if you know what is going on in this case). By default, B08 is the RCin, on LDARC KK30D is PPM pin.

I haven't flight it yet, but it supposed to be fine. Just for test purposes only.

Use iNav configurator to flash it, newer Betaflight configurator doesn't work.  
Since STM32 use rom for bootloader so you won't brick it.
