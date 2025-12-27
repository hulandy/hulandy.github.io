---
title: "修改虚拟机网卡eth0"
date: 2016-10-28
categories: 
  - "linux"
---

修改文件/etc/sysconfig/network-scripts/ifcfg-eth0中的MAC为正确地址后  
（ifconfig -a中的)

然后删除/etc/udev/rules.d/70-persistent-net.rules

使用/etc/init.d/network restart 或reboot
