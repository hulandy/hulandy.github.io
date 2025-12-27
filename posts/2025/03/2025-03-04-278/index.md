---
title: "在Radxa Zero 3上运行deepseek"
date: 2025-03-04
categories: 
  - "linux"
---

在Zero上编译非常痛苦，所以使用交叉编译：

安装步骤 更新包列表：

sudo apt update 安装交叉编译工具链：

sudo apt install gcc-aarch64-linux-gnu g++-aarch64-linux-gnu //gcc-aarch64-linux-gnu：ARM64架构的C编译器。

//g++-aarch64-linux-gnu：ARM64架构的C++编译器。

验证安装：

aarch64-linux-gnu-gcc --version aarch64-linux-gnu-g++ --version

3. 设置交叉编译环境 在项目目录中创建一个 toolchain.cmake 文件，用于指定交叉编译工具链。

创建 toolchain.cmake 文件 cmake

# toolchain.cmake

set(CMAKE\_SYSTEM\_NAME Linux) set(CMAKE\_SYSTEM\_PROCESSOR aarch64)

set(CMAKE\_C\_COMPILER /usr/bin/aarch64-linux-gnu-gcc) set(CMAKE\_CXX\_COMPILER /usr/bin/aarch64-linux-gnu-g++)

set(CMAKE\_FIND\_ROOT\_PATH /usr/aarch64-linux-gnu) set(CMAKE\_FIND\_ROOT\_PATH\_MODE\_PROGRAM NEVER) set(CMAKE\_FIND\_ROOT\_PATH\_MODE\_LIBRARY ONLY) set(CMAKE\_FIND\_ROOT\_PATH\_MODE\_INCLUDE ONLY)

4. 交叉编译项目 使用交叉编译工具链编译项目。

步骤 1：生成构建文件

cmake -B build -DCMAKE\_TOOLCHAIN\_FILE=toolchain.cmake 步骤 2：编译项目

cmake --build build --config Release -j 2 步骤 3：验证编译结果 检查生成的可执行文件是否为ARM64架构：

file build/my\_program 输出示例：

build/my\_program: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, for GNU/Linux 3.7.0, not stripped

5. 将程序复制到RK3566 使用 scp 或U盘将编译好的程序复制到RK3566上运行。

使用 scp 复制

scp build/my\_program user@rk3566\_ip:/path/to/destination 在RK3566上运行

./llama-server -m DeepSeek-R1-Distill-Qwen-1.5B-Q4\_K\_M.gguf --host 0.0.0.0

使用精简蒸馏模型DeepSeek-R1-Distill-Qwen-1.5B-Q4\_K\_M.gguf

结果还是非常意料之内的，缓慢无比。0.2 t/s
