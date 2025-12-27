---
title: "Radxa 3w zero connect wifi before login"
date: 2025-02-28
categories: 
  - "linux"
---

So here is the thing:  
I want to use one of my radxa 3w zero to be a light server, but for some reason their CLI version can not start up, which is insane. And I tried, it just stuck at the beginning.

So I uninstalled the xfce of debian-xfce version. And everything I need were working properly.  
Except the Wi-Fi. It only connects when I login.

I have tried several methods. And finally.

At /etc/NetworkManager/system-connections/mywifi.nmconnection

Then disable the line "permissions" and it works.
