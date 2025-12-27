---
title: "cannot open serial ttyACM0 on ubuntu"
date: 2019-05-21
categories: 
  - "fpv"
---

sudo usermod -a -G dialout

firmware:

create a file : 45-stdfu-permissions.rules  
and fill with:

```
# DFU (Internal bootloader for STM32 MCUs)
SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0664", GROUP="plugdev"
```

then:

```
sudo cp 45-stdfu-permissions.rules /etc/udev/rules.d

sudo usermod -a -G plugdev <username>
```
