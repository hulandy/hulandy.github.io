---
title: "编译Ardupilot会遇到的坑"
date: 2022-08-05
categories: 
  - "fpv"
---

使用WINDOWS11，WSL2 - ubuntu22.04进行编译。

需要安装Virtual Machine Platform和Windows Subsystem for Linux两个模块。当然还要打开bios的cpu虚拟化。

编译需要在非root下执行，所以建立新的用户 adduser 然后再赋予sudo组: usermod -a -G 可能我的ubuntu安装步骤不完整，理论上应该提示创建不需要手动。

使用git克隆项目。

编译环境按手册搭建好之后默认在master分支下，趁机编译bootloader(其它的版本比如Copter4.1.5编译会出错)如果你已经切换至其它tag那么需要回来编译bootloader: git branch, git checkout master

更新submodule: git submodule update --init --recursive --force  
有时候需要git submodule update --remote --merge  
开始编译:  
./waf distclean  
./waf configure --board yourboard --bootloader  
./waf clean  
./waf bootloader

使用自动配置环境有时下载C编译器会失败，配置waf时提示没有编译器，重新执行自动配置并不能识别这个错误，需手动重新下载。

复制并改名Ap\_bootloader.bin至Tools/bootloader 为 yourboard\_bl.bin  
切换至目标tag， 如：

git checkout tags/Copter-4.1.5

git submodule update --init --recursive

./waf distclean  
./waf configure --board yourboard  
./waf copter

如遇错误可能是网络的问题，需要确认你的文件完整，更新也没有报错。
