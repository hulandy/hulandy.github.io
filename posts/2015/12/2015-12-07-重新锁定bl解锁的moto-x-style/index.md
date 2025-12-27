---
title: "恢复MOTO X STYLE的BOOTLOADER解锁状态"
date: 2015-12-07
---

**_虽然界面可以做到完美锁定状态，但不代表MOTO官方无法追踪实情。所以在解锁前还需要您仔细考虑。另外，即便你的手机问题并不是因解锁BL引起，也依然会失去保修的条例，的确不够人性化。_** 前些天濮阳下大雪，单位通知不上班，但我还是带着相机跑了出去，溜达了一圈回来手机也没什么问题。等到下午又大雪封山，依旧不用上班，因在咸鱼卖了一只耳机，去南院发货回来时碰见洋芋就聊了会天儿，掏出手机发现屏幕下方1/3处花屏了。回家暖了一会复原。但之后只要一出门就会花掉，情况越来越差，直到在家里一天也不会自己复原了，而且在全黑状态还出现了一个红斑。我不太确定这是否和早先在登月跑步时掏出手机掉地上有关，因为是橡胶跑道也没什么痕迹。必须要解决了，搜下淘宝要500RMB,才买俩月，还是去售后吧...但问题是我解锁了bootloader！解锁警告我：别想找我们修手机！ 论坛发问得到的回答是无法重新上锁。谷歌一下，在XDA找到了一篇“How can I relock bootloader ： http://forum.xda-developers.com/moto-x-style/help/how-relock-bootloader-t3207771” 米国网友tylerwatt12进行了回复： I just relocked mine, no white screen on boot.

but it says Device is LOCKED. Status Code: 2 Software status: Modified

Here's how I did it. download this

open cmd, navigate to the folder extracted from the zip in the link above, this will erase your entire phone, reset to stock firmware and relock the bootloader

boot into bootloader pwr+vol down run these commands

Code: fastboot oem lock begin fastboot flash partition gpt.bin fastboot flash bootloader bootloader.img fastboot flash logo logo.bin fastboot flash boot boot.img fastboot flash recovery recovery.img fastboot flash system system.img\_sparsechunk.0 fastboot flash system system.img\_sparsechunk.1 fastboot flash system system.img\_sparsechunk.2 fastboot flash system system.img\_sparsechunk.3 fastboot flash system system.img\_sparsechunk.4 fastboot flash system system.img\_sparsechunk.5 fastboot flash system system.img\_sparsechunk.6 fastboot flash system system.img\_sparsechunk.7 fastboot flash system system.img\_sparsechunk.8 fastboot flash system system.img\_sparsechunk.9 fastboot flash modem NON-HLOS.bin fastboot erase modemst1 fastboot erase modemst2 fastboot flash fsg fsg.mbn fastboot erase cache fastboot erase userdata fastboot oem lock

Now If I can figure out how to remove the status code and make the software status official. It's probably impossible, for now at least.

那么我来简单说一下，文中提到的下载这个，其实就是我们说的底包。如果你想照他说的做，应该这样：下载国行完整底包，下载adb工具，解压底包，顺便把adb工具也解压进去，然后就可以在文件夹内运行CMD输入以上命令进行锁定+刷机了~ 由于他们是美版而我们大陆版只有system.img\_sparsechunk.5 ，那后面的6789就忽略。又由于某些原因你可能会卡在fastboot flash modem NON-HLOS.bin这一步，但是不要担心，跳过它执行后面的，直到命令最后一行后你会发现，Device is LOCKED. Status Code: 2 Software status: Modified 。有点爽吧 ~~ 虽然已经显示LOCKED，但由于是官方底包，开机仍然会有大大的解锁警告~ 不要担心，用你之前下载无警告的logo文件刷进去就好了，命令：fastboot flash logo logo.bin 妈的，fastboot就是这么方便。 好了，目前离完美还差1步。进入系统，重新开启开发者模式，“关于手机最后一行一直点，然后进入开发者选项允许解锁OEM” ，就像你曾经做过的那样。再次进入fastboot，输入fastboot oem unlock xxxxxxxxx （xxxx是你邮箱里的解锁码，不是真的xxxx） 重新刷入"第三方recovery twrp 2.8.7.0",进入它，不要乱动，看见它说什么了吗？是的，可以选择KEEP READ ONLY 和完全允许系统更改，我们当然点keep read only！ 回到fastboot界面，怎么样，software status ： official 。 巨爽~ 那么，再把网友tylerwatt12的命令再来一遍吧~哦，这次连NON-HLOS.bin都可以顺利刷入了。 经过两次刷机你会得到下面完美的锁定画面：

[![locked](images/locked-225x300.jpg)](http://gejing.org/wp-content/uploads/2015/12/locked.jpg)
