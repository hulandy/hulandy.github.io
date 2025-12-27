---
title: "FPV over Celluar"
date: 2025-04-20
categories: 
  - "fpv"
---

![](images/20250420_171729.jpg)

If you're looking for a cellular-based FPV solution, here's what I've been using. It's not perfect, but it works reliably for me. Currently I will skip the details in order to separate some troubles. You need certain basic skills and effort. You need to familiarize the logic behind Ardupilot ground station control and Mavlink related knowledges.

The star of this setup is OpenIPC - currently the most popular open-source HD FPV system. While other systems like OpenHD also support cellular FPV though.

Most developers don't recommend Celluar FPV due to the inherent latency and signal interruptions as modems switch between cell towers. Personally, I've made peace with these limitations by pairing the system with an ArduPilot flight controller that automatically returns home if signal is lost. Even with these constraints, it's still incredibly fun to use!

Here's how to set it up:

**Hardware You'll Need:**

1. An OpenIPC camera (we use sc338q)

3. An EC25 or EC20 USB modem (You need to carefully choose the model that works in your region.)

5. An optional antenna for better signal

7. A cloud server with static IP (Or your home server, it supports dynamic dns domain)

**Why I recommend these:**

- Flashing is simple with just a router, USB-TTLs are not necessary.

- The ssc338 is powerful.

**Setup Process:**

1. **Modem Preparation:**  
    My EC20（EC20CEHDLG） default firmware doesn't support ECM mode\[check the version, R06 and R08 are different, can't use the same firmware \]. Or maybe you don't need to do this:

- First upgrade its firmware(I obtained a newer version from their engineers:[https://drive.google.com/file/d/1XnojI4Ga-Vz-CopdG2HZQSvPcmvmlqww/view?usp=sharing](https://drive.google.com/file/d/1XnojI4Ga-Vz-CopdG2HZQSvPcmvmlqww/view?usp=sharing))

- Then switch it to ECM mode (RMNET/RNDIS/MBIM works too but not recommanded)connect your hardware, ssh to the cam, use command : echo -e 'AT+QCFG="usbnet",2\\r' > /dev/ttyUSB2 or AT+QCFG=“usbnet”,1**_Some EC20 modules forget mode after power cycle. Add persistent config:_** echo -e 'AT&F\\r' > /dev/ttyUSB2 . sometimes use AT+CFUN=1,1 to reboot the module only.

You can log into two OpenIPC terminals simultaneously, one to monitor using `cat /dev/ttyUSB2`, and the other to send commands using `echo 'at+qcfg="usbnet"' > /dev/ttyUSB2`. Sometimes the ECM mode of the EC20 changes to `usbnet,1`, and other times it becomes `usbnet,2`. I'm not sure why this happens. If any issues occur, you can use the above commands to check and configure it.

- **_It is a bit tricky here_**, for EC25 use usbnet=1,for ec20 it is usbnet=2)

2. **Camera Firmware (**[https://drive.google.com/file/d/1cXaD3SduyULz16U8iiBQtctAndUUTRRz/view?usp=sharing](https://drive.google.com/file/d/1cXaD3SduyULz16U8iiBQtctAndUUTRRz/view?usp=sharing)**)**  
    

4. If you want to compile your own one: Due to limited flash storage, we must carefully select only essential modules:

- Start with one config file like fpv or lite or ultimate

- Remove unnecessary components (wifibroadcast, wifi drivers, etc)

- Add Wireguard/Zerotier and datalink, Mavlinkrouterd.

- Modify the kernel config to ensure contains:

- CONFIG\_USB=y

- CONFIG\_USB\_SUPPORT=y

- CONFIG\_USB\_EHCI\_HCD=y

- CONFIG\_USB\_EHCI\_HCD\_PLATFORM=y

- CONFIG\_USB\_NET\_DRIVERS=y

- CONFIG\_USB\_USBNET=m

- CONFIG\_USB\_NET\_CDCETHER=m

- CONFIG\_USB\_ACM=m

- CONFIG\_MODULES=y

3. **Firmware Installation**

5. Details about configuration: [https://www.gejing.org/2025/08/24/how-to-configure-a-quectel-ec20-lte-module-on-your-ssc338q-camera-for-remote-access/](https://www.gejing.org/2025/08/24/how-to-configure-a-quectel-ec20-lte-module-on-your-ssc338q-camera-for-remote-access/)

4\. Cloud **Server Configuration:** Install zerotier or wireguard, open the ports it needs. You can forward mavlink data and video stream by using mavrouter installed on the server and socat. With wireguard you can skip this but turn on the ipv4 forward.

5\. Camera Configuaration: Edit majestic.conf "outgoing" to your address. Modify datalink.conf, mavlink.conf, telemetry.conf, zerotier conf and/or wiregurd.conf(also need to modify rc.local to add ifup wg0, wg0.conf inside network/interface.d/). Somehow I need to add /usr/bin/mavlink-routerd -c /etc/mavlink.conf & into rc.local as well.

Now on your phone or computer, install qgroundstation or the equivalent combine the vpn that you chose to controll it. Enjoy.
