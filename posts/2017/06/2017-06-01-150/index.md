---
title: "Dell d630 with Sierra hackintosh microphone tuning"
date: 2017-06-01
categories: 
  - "hack"
---

Thanks to this entire manual I could installed Sierra to my old laptop: [http://forum.osxlatitude.com/index.php?/topic/8645-dell-latitude-d630-with-core2duo-and-nvidia-quadro-nvs-135m-el-capitansierra/](http://forum.osxlatitude.com/index.php?/topic/8645-dell-latitude-d630-with-core2duo-and-nvidia-quadro-nvs-135m-el-capitansierra/)

There was a little bit issue when I try to use the microphone. The playback was too loud and noisy. After tuning two values it got a clear sound:  
Right click on /Library/Extensions/VooDooHDA.kext "Show package contents", "contents", copy Info.plist to desktop, modify "Boost" integer from "1" to "0", "Rec" integer from "70" to "30", close it and drop back, close all opened window, then open the well-known "Kext Utility" after done, reboot.
