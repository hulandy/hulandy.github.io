---
title: "好记性不如烂键盘"
date: 2016-07-13
categories: 
  - "linux"
---

CentOS6:

添加iptables -A INPUT -p tcp --dport 6001 -j ACCEPT

查看iptables -L -n

保存service iptables save

所有进程ps auxw  
开机启动 /etc/rc.local #For example:/usr/bin/ssserver --manager-address \[yours:6001\] -c /etc/server-multi-passwd.json -d start

```
    /etc/rc.sysinit
    /etc/inittab
    /etc/profile
```

chkconfig --list

Centos7

firewall-cmd --add-port=6001/tcp --permanent

firewall-cmd --reload

ssh -p 27016 root@0.0.0.0
