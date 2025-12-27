---
title: "arduino+w5100+dht11+Sharp’s GP2Y1010AU0F"
date: 2013-08-05
categories: 
  - "arduino"
---

第二块红板AIOP飞控的USB口被我插掉了，其实我一直觉得第二块板的焊接质量不如第一块，GPS插座也掉过。通过TTL连接调试，见鬼的把FTDI插到I2C口上去了，传感器都完蛋了。不能再三啊，购入2560 R3和GY86自己组AIOP，用起来还行，可实在是大得讨厌。拆了，把GY86装回坏的AIOP上，顺便把USB也焊好了。开发板还是做它应该做的事去吧。

一直喜欢电子玩意儿。又购入dht11温湿度传感器和Sharp’s GP2Y1010AU0F颗粒传感器，W5100网络模组，准备连2560上传数据到yeelink（我的摄像头就是传到yeelink），顺便还能推微博，无限装13。不会编程啊，爬了两天网也没找到合适的代码，不是网络模组不匹配就是没有DHT11和GY2P1010AUOF的组合，要么就是传到其它网站的。撂摊子。

由于昨晚装好了修复的AIOP飞控后心情大好，今早又开始爬文。yeelink论坛置顶的库文件引起了我的注意，简洁，方便。一通乱弄，成了。贡献下代码给也许有和我一样的的门外汉用：[dht11sharp.rar](http://www.gejing.org/usr/uploads/2013/08/148501473.rar "dht11sharp.rar") 别忘了去yeelink论坛自己下载库文件。dht库：[Sensor.rar](http://www.gejing.org/usr/uploads/2013/08/3368535449.rar "Sensor.rar")

参考  
[http://www.sfan20.cn/post-111.html](http://www.sfan20.cn/post-111.html)  
GY2P1010AU0F连接图 [http://sensorapp.net/?p=479](http://sensorapp.net/?p=479)  
[http://www.guokr.com/article/434130/](http://www.guokr.com/article/434130/)  
[http://bbs.yeelink.net/forum.php?mod=viewthread&tid=172&extra=](http://bbs.yeelink.net/forum.php?mod=viewthread&tid=172&extra=)  
玩转这些需要简单了解一下ARDUINO，其实玩过四轴就知道了，或者干脆加入ARDUINO的世界吧

我的传感器地址：[http://www.yeelink.net/devices/4175](http://www.yeelink.net/devices/4175)  
[![thumbnail.jpg](images/442239141.jpg)](http://www.gejing.org/attachment/48/ "thumbnail.jpg")
