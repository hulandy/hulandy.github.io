---
title: "DD&fdisk"
date: 2016-11-03
categories: 
  - "linux"
---

fdisk和dd命令  
查看：  
$ sudo fdisk -u -l  
备份：  
$ dd bs=512 count=\[fdisk命令中最大的end数+1\] if=/dev/sda6 of=/sysbackup.img  
恢复：  
$ dd if=sysbackup.img of=/dev/sda  
压缩备份：  
$ dd bs=512 count=\[fdisk命令中最大的end数+1\] if=/dev/sda6 | gzip -6 > /sysbackup.img.gz  
恢复：  
$ gzip -dc /sysbackup.img.gz | dd of=/dev/sda

最好先umount所有 if和of 设备的分区。后执行sudo sync。

如果对整个硬盘进行备份和恢复 count=\[fdisk命令中最大的end数+1\] bs=512可以去掉。

当你刚装完redhat 7.3第一次启动时，总会死掉。主要原因是Linux在安装时探测到有usb-uhci和ehci-hcd两个控制器，但在启动时，加载完usb-uhci再加载ehci-hcd就会有冲突。分析认为redhat7.3系统内核在支持USB2.0标准上存在问题。在其他版本的Linux中均不存在此问题。

解决办法：在lilo或grub启动时用命令行传递参数init=/sbin/init。这样在启动后就不运行其他服务而直接启动shell。然后运行  
mount -o remount,rw / 使/ 可写，init直接启动的系统默认只mount /为只读  
然后vi /etc/modules.config文件(modules.conf)  
删除alias usb-controller1 ehci-hcd一行。或前面加#注释掉  
然后mount -o remount,ro / 使/ 只读，避免直接关机破坏文件系统  
然后就可以按Ctrl-Alt-Delete直接重启了  
或许，你有更简单的办法：换USB键盘和鼠标为PS2接口，启动后修改/etc/modules.config文件。  
linux压缩文件为.tar.gz的命令

1. .tar格式

解包： tar -xvf FileName.tar  
打包： tar -cvf FileName.tar DirName(注：tar是打包，不是压缩)

2. .gz格式

解压1：gunzip FileName.gz  
解压2：gzip -d FileName.gz  
压缩：gzip FileName

3. .tar.gz格式

解压： tar -zxvf FileName.tar.gz  
压缩： tar -zcvf Filename.tar.gz DirName

4. .bz2格式

解压1： bzip2 -d filename.bz2  
解压2： bunzip2 filename.bz2  
压缩： bzip2 -z filename

5. .tar.bz2格式

解压： tar -jxvf filename.tar.bz2  
压缩： tar -jcvf filename.tar.bz2 dirname

6. .bz格式

解压1： bzip2 -d filename.bz  
解压2： bunzip2 filename.bz

7. .tar.bz格式

解压：tar -jxvf filename.tar.bz

8. .Z格式

解压： uncompress filename.Z  
压缩：compress filename

9. .tar.Z格式

解压： tar -Zxvf filename.tar.Z  
压缩： tar -Zcvf filename.tar.Z dirname

10. .tgz格式

解压： tar -zxvf filename.tgz

11. .tar.tgz格式

解压： tar -zxvf filename.tar.tgz  
压缩： tar zcvf filename.tar.tgz filename

12. .zip格式

解压： unzip filename.zip  
压缩： zip Filename.zip dirname

13. .lha格式

解压： lha -e filename.lha  
压缩： lha -a filename.lha filename

14. .rar格式

解压： rar a filename.rar  
压缩： rar e filename.rar
