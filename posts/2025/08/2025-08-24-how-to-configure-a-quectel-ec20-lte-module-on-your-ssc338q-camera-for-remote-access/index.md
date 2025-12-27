---
title: "How to Configure a Quectel EC20 LTE Module on Your SSC338Q Camera for Remote Access"
date: 2025-08-24
categories: 
  - "fpv"
---

If you're building a remote surveillance system, giving your camera cellular connectivity with a Quectel EC20 module is a powerful upgrade. Once configured in ECM (Ethernet Control Model) mode, the module acts like a virtual Ethernet card, pulling an IP address directly from your mobile carrier.

This guide will walk you through the setup process on an SSC338Q-based camera. A key pro tip: **we'll configure a VPN like WireGuard or ZeroTier first**. This crucial step will save you from being locked out of your camera once it switches to the cellular network, allowing for secure remote access without complex router configurations.

* * *

### **Prerequisites & Planning**

1. **Hardware:** A camera with an SSC338Q chipset and a Quectel EC20 module (specifically variant `0x2c7c:0x0125`).

3. **Initial Access:** Physical access to the camera or a connection to its local network for the initial setup.

5. **VPN Setup:** A configured VPN server (e.g., WireGuard or ZeroTier) installed on a cloud server, Raspberry Pi, or your local network. Ensure your camera can reach it and that you know how to connect your laptop to it.

**Why VPN First?** Once the EC20 module is active, your camera's network interface will change. It will be on your ISP's cellular network, not your local Wi-Fi. Without a VPN already running on the camera, you will have no way to SSH into it to complete the setup. The VPN provides a secure "tunnel" back to your device.

* * *

### **Step 1: Verify EC20 Module Detection**

Start by establishing an SSH connection to your camera over your local network.

Run the `lsusb` command to list all connected USB devices. You should see a line identifying your Quectel module:

bash

```
ssh root@your-camera-local-ip
lsusb
```

**Expected Output:**  
`Bus 001 Device 003: ID 2c7c:0125 Quectel Wireless Solutions Co., Ltd. EC20 LTE modem`

If you don't see this device, **stop here**. Check your USB connections, cables, and power supply to the EC20 module.

Because the new config has been added so step2 is no longer needed.

* * *

* * *

### **Step 3: Apply the Configuration and Reboot**

Now, we tell the system to use our new `ec25` configuration and reboot.

1. Set the boot environment variable:fw\_setenv wlandev ec25

3. Reboot the camera for the changes to take effect:reboot

**⚠️ Important Note:** After rebooting, the camera's USB interface (`usb0`) will be assigned a **static IP address: `192.168.2.10`**. To maintain SSH access during this phase:

- You must set your computer's Ethernet IP address to `192.168.2.1` (subnet `255.255.255.0`).

- Connect directly to the camera's USB port or via a router configured for the `192.168.2.x` subnet.

* * *

### **Step 4: Final Verification and VPN Connection**

1. After the reboot and reconnection (via the `192.168.2.10` IP), SSH back into the camera.

3. Run `ifconfig`. You should now see a new network interface (likely `usb0` or `wwan0`) that has obtained a **public IP address from your cellular ISP**. This means the EC20 module is working correctly!

5. **Connect via VPN:** Since you pre-configured your VPN, simply activate the VPN connection on your laptop. You should now be able to SSH directly to the camera's VPN IP address from anywhere with an internet connection, no longer needing the `192.168.2.10` workaround.

* * *

### **Troubleshooting and Reverting**

- **Something went wrong?** If the configuration fails and you lose access, you may need a serial console connection to revert. If you can still access the camera, you can clear the `wlandev` setting:bashfw\_setenv wlandev rebootThis will tell the camera to bypass the EC20 setup on the next boot.

- **No Internet on EC20?** Check your APN settings. You may need to use `udhcpc` or additional scripts to handle the DHCP client process on the `usb0` interface.

By following these steps and planning with a VPN, you've created a robust, remotely accessible cellular camera. Happy monitoring!
