---
title: "Install a MTK7601 chip based usb Wi-Fi stick on Sierra"
date: 2017-05-30
categories: 
  - "hack"
---

In my case, the USB wireless adapter is a cheap EDUP EP-MS8552S. And I was confused about why the official installation for osx could not put the kext files to the right place. So here is my method:

1.Download [EP-N8551 Driver from Official](http://www.szedup.com/support/driver-download/ep-n8551-driver/) (MacOS10.11 the latest, You'll get MT7612\_7610U\_D5.0.1.25\_SDK1.0.2.18\_UI5.0.0.27\_20151209.dmg)  
2.Download [Pacifist](http://cvad-mac.narod.ru/index/0-4) for extract RT2870USBWirelessDriver.kext from mounted dmg file USB wireless-Install.pkg.

3. Download [kext utility](http://cvad-mac.narod.ru/index/0-4) and install the kext from step 2.
4. Install USB wireless-Install.pkg then reboot the OS.
5. Enjoy.
