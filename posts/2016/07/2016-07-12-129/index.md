---
title: "CenOS7 shadowsocks"
date: 2016-07-12
categories: 
  - "linux"
---

1. 安装 Shadowsocks

Shell

# 安装 python setup tools

yum install python-setuptools

# 安装pip

easy\_install pip

# 升级 pip

pip install --upgrade pip

# 安装 shadowsocks

pip install shadowsocks

2. 创建 shadowsocks 服务, 随系统启动.

nano /usr/lib/systemd/system/shadowsocks.service

写入下面的内容

\[Unit\]  
Description=Shadowsocks Server  
Documentation=[https://github.com/shadowsocks/shadowsocks](https://github.com/shadowsocks/shadowsocks)  
After=network.target remote-fs.target nss-lookup.target

\[Service\]  
Type=forking

# 设置启动时的配置文件,根据自己的需求改.

ExecStart=/usr/bin/ssserver -c /usr/share/nginx/etc/shadowsocks.json -d start  
ExecReload=/bin/kill -HUP $MAINPID  
ExecStop=/usr/bin/ssserver -d stop

\[Install\]  
WantedBy=multi-user.target  
保存退出  
说明：如果服务端口数值小于1024，Type行后加User=root

3.添加配置文件

# 改为上一步中的路径, 确保各级目录存在

nano /usr/share/nginx/etc/shadowsocks.json

{

```
"port_password":
{
    "8388":"密码1",
"端口2":"密码2"
},
"_comment":
{
    "8388":"注释1,日志中标识用户用的",
"端口2":"注释2"
},
"timeout":300,
"method":"aes-256-cfb",
"fast_open": false
```

}  
保存退出

4.启动服务

systemctl enable shadowsocks  
systemctl start shadowsocks

5.防火墙开放shadowsocks服务端口：

firewall-cmd --permanent --add-port=你的端口/tcp  
firewall-cmd --reload

6.常用操作

为了检查 shadowsocks 服务是否已成功启动，可以执行以下命令查看服务的状态：

$ systemctl status shadowsocks -l

停止shadowsocks服务：

systemctl stop shadowsocks-server.service  
取消shadowsocks开机自启

systemctl disable shadowsocks-server.service  
查看日志文件

less /var/log/shadowsocks.log
