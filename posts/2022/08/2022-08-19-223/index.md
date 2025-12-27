---
title: "ss-libv"
date: 2022-08-19
categories: 
  - "linux"
---

sudo snap install core

sudo snap install shadowsocks-libev --edge

{

```
"server":["::0","0.0.0.0"],
"server_port":8388,
"method":"chacha20-ietf-poly1305",
"password":"ExamplePassword",
"mode":"tcp_and_udp",
"fast_open":false
```

}

sudo nano /var/snap/shadowsocks-libev/common/etc/shadowsocks-libev/config.json

sudo systemctl start snap.shadowsocks-libev.ss-server-daemon.service

sudo systemctl enable snap.shadowsocks-libev.ss-server-daemon.service

sudo systemctl status snap.shadowsocks-libev.ss-server-daemon.service
