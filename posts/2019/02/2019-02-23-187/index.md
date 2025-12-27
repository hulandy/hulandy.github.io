---
title: "Use a SMB directory on Apache2"
date: 2019-02-23
categories: 
  - "linux"
  - "raspi"
---

Install samba client:

```
apt-get install  samba-common smbclient samba-common-bin smbclient  cifs-utils

mkdir /mnt/abc
mount -t cifs //yourIP/yourShare /mnt/abc

```

If you need to add credentials at the mount time:

```

mount -t cifs //server/share /mnt/abc -o user=user,pass=password,dom=domain
```

If you want to dismount the share later:

```
umount /mnt/abc
```

Mount permanently:

```
sudo nano /etc/fstab
```

Add: `//server/share /mnt/abc cifs guest,uid=1000,iocharset=utf8,x-systemd.automount 0 0`

For more information visit:  
[https://wiki.ubuntu.com/MountWindowsSharesPermanently](https://wiki.ubuntu.com/MountWindowsSharesPermanently)[Ubuntu forum](https://wiki.ubuntu.com/MountWindowsSharesPermanently)

Access Permission(May not necessary):

```
chown -R $USER:$USER /mnt/abc
chmod -R 755 /mnt/abc
```

Apache2 on Debian based OS:

Modify apache2.conf add lines:

```
<Directory /mnt/abc/>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
```

Modify conf in sites-available directory:

```
    <VirtualHost *:80>
DocumentRoot /mnt/abc
ServerName myv.host.com
ServerAlias myv.host.com
ErrorLog logs/myvhost-error_log
CustomLog logs/myvhost-access_log combined
ServerAdmin myv@host.com
<Directory /mnt/abc/>
    AllowOverride All
    Options +Indexes
</Directory>
</VirtualHost>

```
