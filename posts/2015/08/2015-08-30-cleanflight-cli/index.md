---
title: "Cleanflight CLI"
date: 2015-08-30
---

其实cc3d飞控用cp2102联机目前已经很完美了，没有发现什么bug。今天继续测试老机kim400，电调为sn20的换壳版rctimer mini20a，rlink ppm连接飞控。

飓风2216返厂回来变成了自锁桨夹，电调没有开启damplight。开始测试机身非常晃动，主要是pitch，和之前用minix大风中感觉一致。

pid固然不完美，但这太离谱，果断是震动引起的。查了下CF命令行，设置低通滤波为set gyro\_lpf=20。好了很多。手感不太好，目测机身已经没有摇晃和颤动。

CF的命令行设置参数太方便了，mwc时代需要用arduno编辑config.h然后刷新整个固件…
