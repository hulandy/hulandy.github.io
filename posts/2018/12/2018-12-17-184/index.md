---
title: "如何用diskpart为win10分区并使用DISM++装系统"
date: 2018-12-17
categories: 
  - "default"
---

\*这一篇可以作为上一篇的续集也可以单独阅读。  
如果你有一个单独的WIN10系统优盘请忽略，因为你选择安装盘的时候它会自动为你划分分区。如果你有一个国产的PE优盘，也可以用图形界面的磁盘工具分区。而如果你就是喜欢命令行，可以像我一样。我是出于对国产PE的不信任，做了一个微软官方的PE优盘，它是不带传统桌面的，启动完毕只有一个SHELL窗口，但却可以运行DISM++这种图形界面的软件，包括技嘉的BIOS刷新工具图形版。也许有时间我会做一个自己的带桌面的PE优盘。那现在就先这样吧。\*

在shell下直接输入diskpart回车，就可以运行diskpart。你也可以从国产pe的开始菜单里打开shell窗口。

`diskpart>`

一个win10的分区基本上如下图所示，有点linux分区的意思了。所以也不要怀疑给SSD分区会不会降低磁盘性能，你看，win10本来就是多分区的。你只需要保证分区4K对齐就行了。

![dep-win10-partitions-uefi.png](images/571343640.png "dep-win10-partitions-uefi.png")

<1> EFI分区,又叫系统分区(System)或ESP,它最小要求机械盘100M，而固态要求最小是260M，必须为fat32格式（fat32分区要求必须至少包含65527个簇，原生4K盘，每簇按4K，4K\*65527=256MB）. 这东西大了用处不大。

<2> 随后的MSR分区称作微软保留空间它是16M，在win10看不见但你用diskpart可以看到。

<3> 然后是windows分区，随后你可以分一个自己的DATA分区.建议不分区，另外的D盘实在想要可以在win下磁盘管理“压缩卷”分出来。

<4> 最后是恢复分区recovery简称RE。

如果你不关心这些，那直接输命令吧。**每输完一行是需要回车的**，如遇错误请仔细检查字母，另外windows不区分大小写。

假设你已经运行了diskpart，得到如下指示  
`diskpart>`

你需要依次输入：

`select disk 0` //也可以缩写为sel disk 0,只有一个主硬盘的情况下就是数字0，不放心可以打list disk确认盘号

`convert gpt` //把此磁盘设定为GPT分区表

`create partition efi size=260` //创建了一个EFI分区，大小为260M.

`format quick fs=fat32 label="System"` //格式化了刚创建的EFI，格式为FAT32。卷标System

`assign letter="S"` //设定盘符为S

`create partition msr size=16` //创建了微软保留分区，大小16M

`create partition primary` //创建了一个之后会成为C盘的主分区

`shrink minimum=500` //为最后的recovery区留500M，也可以加大比如1G.或者你想多分一个区的话，这个数字将是硬盘总大小减去你想为C盘准备的大小的数值，比如我的256G-100=156，156\*1000=160000，输入minimum=160000

`format quick fs=ntfs label="Windows"` //快速格式化它为ntfs分区，卷标Windows

`assign letter="W"` //后面重启电脑会自动分配它为C盘。

如果你想多分一个区开始：  
\==========================可选分区开始  
`create partition primary` //这一行是选择性的，如果你不要D盘这行就不要输

`shrink minimum=500` //为最后一个区准备500M或者更大，如果不要D盘不要输因为上面输过了

`format quick fs=ntfs label="Data"` //你可以自己命名，就是D盘卷标。如果不要不要输

`assign letter="D"` //你要的D盘结束了  
\==========================可选分区结束

`create partition primary` //创建了一个即将成为RE分区的主分区

`format quick fs=ntfs label="Recovery tools"` //快速格式化了RE分区并分配卷标

`assign letter="R"` //分配盘符

`set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac"` //RE必须的ID，要不然它只是普通分区

`gpt attributes=0x8000000000000001` //标记为不让系统给它分配盘符

`list volume` //回车，显示卷列表

`exit` //回车，退出

分区结束，重启电脑，让盘符C正确识别出来。不重启也可以，自己控制。

现在可以愉快地装系统了。 [使用DISM++安装系统](https://www.chuyu.me/zh-Hans/Document.html?file=Best/%E4%BD%BF%E7%94%A8Dism%20%20%E5%AE%89%E8%A3%85%E7%B3%BB%E7%BB%9F.md)

* * *

如果你连DISM++都不想用，那就用命令行的DISM来，微软官方：[用DISM命令行安装系统](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/apply-images-using-dism)

假设在命令行`x:\windows\system32>`

输入命令  
`Dism /apply-image /imagefile:"N:\Images\my-windows-partition.wim" /index:1 /ApplyDir:C:\`  
//注意N:的部分修改成你自己的wim文件路径，就是从系统镜像ISO中提取出的install.wim，最后的C:如果你没重启应该改为上面我们设置的w：，如不确定可以用diskpart查看list partition

这样无法引导，需要在EFI建立基本的引导：进入刚才dism apply-image安装好的windows文件夹，假设进入c:\\windows\\system32

`c:\windows\system32>bcdboot C:\Windows /l zh-cn` 此时已经可以引导了，重启电脑就可以等待系统初始化完成了

延申设置：[更进一步设置RE分区](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/deploy-windows-re)

* * *

引用：

1. [微软官方DISKPART为WIN10分区的链接](https://docs.microsoft.com/en-us/windows-hardware/manufacture/desktop/configure-uefigpt-based-hard-drive-partitions)
