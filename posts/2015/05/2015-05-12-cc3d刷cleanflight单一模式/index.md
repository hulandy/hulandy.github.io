---
title: "CC3D刷CleanFlight单一模式"
date: 2015-05-12
---

和使用FTDI更新CC3D的BL是一样的，教程参考官方：[openpilot](https://wiki.openpilot.org/display/WIKI/How+to+Flash+Bootloaders+with+an+FTDI+Cable) 更多图片的教程：[点我](http://www.southquay3d.com/index.php?route=news/article&news_id=9) 由于CC3D不支持DFU模式所以略显麻烦。以后用FTDI配置飞控就支持重启了。OP官方说法是CC3D的USB直接和CPU连接，真正即插即用无需驱动，板子更简洁。

一般来说看上面两个链接的文章就能顺利刷写成功了，有详细的图片，即使不看文字。唯一的区别是把BootLoader文件换成CF的HEX文件。 特别需要注意的是，STM32只支持CP2102芯片的FTDI，我试了232和2303都没能成功。先插入FTDI，运行FlashLoader，再接CC3D。

[1.8.1hex](http://bbs.gejing.org/ss/cleanflight_CC3D.hex) [FlashLoader](http://www.st.com/st-web-ui/static/active/en/st_prod_software_internet/resource/technical/software/demo_and_example/stsw-mcu005.zip) [备用：cc3d bootloader](http://bbs.gejing.org/ss/bl_cc3d.bin)
