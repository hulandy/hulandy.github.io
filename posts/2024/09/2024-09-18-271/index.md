---
title: "4G"
date: 2024-09-18
categories: 
  - "fpv"
---

apt-get update  
apt-get install -y socat

/etc/systemd/system/socat\_forward.service

\[Unit\]  
Description = Socat Daemon For Port Forward  
After = network-online.target

\[Service\]  
Type = simple  
ExecStart = /usr/bin/socat -dd TCP-LISTEN:XXXX,fork TCP:1.2.3.4:XXXX //UDP  
Restart = on-failure  
TimeoutSec = 15

\[Install\]  
WantedBy = multi-user.target

\==================================

sudo apt update  
sudo apt install git

git clone [https://github.com/intel/mavlink-router.git](https://github.com/intel/mavlink-router.git)  
cd mavlink-router  
git submodule update --init --recursive  
sudo apt install git meson ninja-build pkg-config gcc g++ systemd

//Build and install  
//If you didn’t install pip3, you can install it by sudo apt install python3-pip

sudo pip3 install meson  
meson setup build .  
ninja -C build

//[https://github.com/intel/mavlink-router.git](https://github.com/intel/mavlink-router.git)

Create a config file  
sudo mkdir /etc/mavlink-router  
cd /etc/mavlink-router  
sudo pico main.conf  
My config is:

\[General\]  
TcpServerPort = 5760  
ReportStats = false  
MavlinkDialect = common  
#\[UartEndpoint serial0\]  
\# Device=/dev/serial0 Baud=38400  
\[UdpEndpoint bravo\]  
Mode = Server  
Address = 10.0.58.125  
\# Address = 10.0.0.1  
Port = 14551

\[UdpEndpoint charlie\]  
Mode = Normal  
Address = 10.0.9.235  
\# Address = 10.0.0.3  
Port = 14550

Auto start mavlink-router when system boot  
Create the file below to /etc/systemd/system/mavlink-router.service

\[Unit\]  
Description=MAVLink Router  
Wants=zerotier-one.service  
After=network-online.target zerotier-one.service

\[Service\]  
Type=simple  
ExecStart=/usr/bin/mavlink-routerd -e 10.0.9.235:14550  
Restart=on-failure  
RestartSec=3

\[Install\]  
WantedBy=multi-user.target

//Start the service

sudo systemctl start mavlink-router.service  
View the log

//If there is error, you can view the log:

sudo journalctl -u mavlink-router.service  
Enable the service

//If the start runs fine, we can enable the service.

sudo systemctl enable mavlink-router.service

//Check the status

//If you find the mavlink-router didn’t start up, you can check the status:

systemctl status mavlink-router.service

\==================================

apt-get install -y apt-transport-https gnupg mc iftop  
curl -s [https://install.zerotier.com](https://install.zerotier.com) | sudo bash  
curl -O [https://s3-us-west-1.amazonaws.com/key-networks/deb/ztncui/1/x86\_64/ztncui\_0.7.1\_amd64.deb](https://s3-us-west-1.amazonaws.com/key-networks/deb/ztncui/1/x86_64/ztncui_0.7.1_amd64.deb)  
apt-get install ./ztncui\_0.7.1\_amd64.deb

echo 'HTTPS\_PORT=6443' > /opt/key-networks/ztncui/.env  
echo 'NODE\_ENV=production' >> /opt/key-networks/ztncui/.env  
echo 'HTTPS\_HOST=nn.mm.ff.dd' >> /opt/key-networks/ztncui/.env

systemctl restart ztncui

/usr/bin/mavlink-routerd -c /etc/mavlink.conf &
