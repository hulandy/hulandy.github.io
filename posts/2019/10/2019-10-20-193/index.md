---
title: "BetaFlight 固件功能定制"
date: 2019-10-20
categories: 
  - "fpv"
---

警告  
某些功能组合起来可能会导致编译失败。禁用某些功能可能会导致飞行不稳定或使您的穿越机根本无法解锁。在启用/禁用某些功能之前，请确保您知道自己在做什么。  
“我有一些F3飞控板，他们没坏，还挺好用的，我还想接着用。”没问题，通过自行编译固件，现在你可以接着用你的F3来享受高级功能所带来的性能提升了，只需要使固件体积小于F3飞控板载闪存大小即可。  
为了确保你知道启用/禁用的功能的意义，在下方列出功能详细信息：（基于BF4.0）

USE\_ACC //启用加速度计，关闭则无法使用自稳半自稳模式  
USE\_ACRO\_TRAINER //启用新手训练模式，对于经验老道的飞手来说可以关闭  
USE\_ABSOLUTE\_CONTROL //启用绝对控制，启用后会略微影响手感，不建议开启  
USE\_BARO //启用气压计  
USE\_BLACKBOX //启用黑盒子，如果飞控板没有黑盒子而你又不想用的话建议禁用  
USE\_CAMERA\_CONTROL //启用摄像头控制功能，如果摄像头不支持则建议禁用  
USE\_GPS //启用GPS，如果你不用GPS则建议禁用  
USE\_GPS\_NMEA //启用GPS NMEA协议  
USE\_GPS\_UBLOX //启用GPS UBLOX协议  
USE\_GPS\_RESCUE //启用GPS救援功能  
USE\_HOTT\_TEXTMODE //启用HOTT文字模式  
USE\_I2C //启用此，则可使用I2C外置传感器  
USE\_MULTI\_GYRO //用于配置多陀螺仪，如果是单陀螺仪飞控，建议关闭  
USE\_LAUNCH\_CONTROL //启用起飞控制模式  
USE\_LED\_STRIP //启用LED灯带模式  
USE\_LED\_STRIP\_STATUS\_MODE //LED灯带状态灯模式，若无特殊需要建议关闭  
USE\_PINIO //启用PINIO功能，用于配置True PitMode  
USE\_PINIOBOX //启用PINIOBOX功能，依赖上一条  
USE\_RCDEVICE //使用RunCam设备，若无则建议禁用  
USE\_RUNAWAY\_TAKEOFF //启用起飞防暴走功能，若无特殊需求建议开启  
USE\_RX\_LINK\_QUALITY\_INFO //用于计算RSSI和LQ，若不需要可禁用  
USE\_SERVOS //启用舵机功能，若无特殊需要建议禁用  
USE\_SMART\_FEEDFORWARD //启用智能前馈功能，建议禁用  
USE\_UNCOMMON\_MIXERS //启用则可使用不常见的混控模式，例如三轴、Y4和六轴等USE\_VARIO //适用于有多的传感器GPS  
USE\_BRUSHED\_ESC\_AUTODETECT //启用有刷电机自动检测模式，常见用于有刷空心杯  
USE\_CLI //启用CLI命令行模式，最好开启  
USE\_SERIAL\_PASSTHROUGH //允许通过串口向其他设备刷写固件，禁用则无法通过飞控更改  
USE\_TASK\_STATISTICS //启用系统负载统计功能，建议开启  
USE\_GYRO\_REGISTER\_DUMP //陀螺仪上拉电阻，保持默认即可  
USE\_IMU\_CALC //IMU传感器计算，如果需要飞自稳或启用其他调用IMU状态信息的则建议开启USE\_PPM //允许使用PPM接收机  
USE\_GYRO\_OVERFLOW\_CHECK //使用陀螺仪溢出检测功能，ICM陀螺仪必开  
USE\_YAW\_SPIN\_RECOVERY //使用反自旋功能，建议开启  
USE\_DSHOT\_DMAR //使用DMAR来驱动Dshot  
USE\_SERIALRX\_CRSF //使用CRSF遥控信号输入  
USE\_SERIALRX\_IBUS //使用IBUS遥控信号输入  
USE\_SERIALRX\_SBUS //使用SBUS遥控信号输入  
USE\_SERIALRX\_SPEKTRUM //使用SPEKTRUM遥控信号输入，SPEKTRUM的最新协议  
USE\_SERIALRX\_SUMD //使用SUMD遥控信号输入，SPEKTRUM的协议  
USE\_SERIALRX\_SUMH //使用SUMH遥控信号输入，SPEKTRUM的协议  
USE\_SERIALRX\_XBUS //使用XBUS遥控信号输入，JR的遥控协议  
USE\_SERIALRX\_FPORT //使用Fport信号输入，Frsky的最新协议  
USE\_SERIALRX\_JETIEXBUS //使用JETIEXBUS信号输入，Jeti的协议  
USE\_TELEMETRY //开启回传功能  
USE\_TELEMETRY\_FRSKY\_HUB //FPORT协议的回传  
USE\_TELEMETRY\_SMARTPORT //FRSKY的X模式的回传  
USE\_TELEMETRY\_CRSF //黑羊Crossfire的回传  
USE\_TELEMETRY\_SRXL //SPEKTRUM的回传  
USE\_TELEMETRY\_HOTT //HOTT的回传  
USE\_TELEMETRY\_LTM //由iNav开发的轻量级回传  
USE\_TELEMETRY\_IBUS //IBUS的回传  
USE\_TELEMETRY\_IBUS\_EXTENDED //IBUS扩展回传  
USE\_TELEMETRY\_JETIEXBUS //JETIEXBUS的回传  
USE\_TELEMETRY\_MAVLINK //MAVLINK的回传USE\_CMS //启用OSD CMS菜单  
USE\_EXTENDED\_CMS\_MENUS //启用OSD CMS扩展菜单  
USE\_MSP\_DISPLAYPORT //启用MSP显示功能，常见于外接OLED屏幕，可以关闭  
USE\_MSP\_OVER\_TELEMETRY //启用MSP回传功能，可以关闭  
USE\_VIRTUAL\_CURRENT\_METER //启用虚拟电流计，常见于需要在Configurator内自行配置电流计参数的电流传感器  
USE\_VTX\_COMMON //启用图传常用功能，如果图传不受飞控控制则建议关闭，下同  
USE\_VTX\_CONTROL //启用图传控制功能  
USE\_VTX\_SMARTAUDIO //配置SMARTAUDIO协议  
USE\_VTX\_TRAMP //配置TRAMP协议  
USE\_ESC\_SENSOR //启用ESC传感器功能，如电调没有此功能则建议关闭  
USE\_ESC\_SENSOR\_INFO //启用ESC传感器配置功能，同上  
USE\_ESC\_SENSOR\_TELEMETRY //启用ESC回传功能，同上  
USE\_SERIAL\_4WAY\_BLHELI\_BOOTLOADER //启用四路BLheli电调烧录功能，建议开启  
USE\_GYRO\_LPF2 //启用第二级陀螺仪低通滤波，建议开启  
USE\_DYN\_LPF //启用动态低通滤波，建议开启  
USE\_D\_CUT //启用D\_Cut功能，在后续版本中更新为D\_MIN，建议开启  
USE\_THROTTLE\_BOOST //启用油门增压功能，建议开启  
USE\_INTEGRATED\_YAW\_CONTROL //启用现代化偏航控制功能，建议开启  
USE\_ITERM\_RELAX //启用Iterm释放功能，建议开启  
USE\_RC\_SMOOTHING\_FILTER //启用遥控信号平滑功能，建议开启  
USE\_THRUST\_LINEARIZATION //启用油门线性化功能，建议开启  
USE\_TPA\_MODE //启用多TPA模式，允许衰减PD或单独衰减D，建议开启  
USE\_PWM //允许使用PWM信号输入和输入  
USE\_HUFFMAN //启用霍夫曼编码功能，保持默认即可  
USE\_BOARD\_INFO //启用飞控板详细信息写入功能，可以关闭  
USE\_RTC\_TIME //在控制回路中使用真实时间，保持默认即可  
USE\_RX\_MSP //使用MSP作为RX信号输入，可视情况决定启用/禁用  
USE\_CRSF\_CMS\_TELEMETRY //允许通过遥控器调用CRSF脚本来调用CMS菜单  
USE\_DASHBOARD //启用飞行统计功能，即飞行结束后上锁所显示的统计页面，若有OSD则建议开启  
USE\_GYRO\_DLPF\_EXPERIMENTAL //启用实验性的陀螺仪Dterm低通滤波功能，如无特殊需求建议关闭  
USE\_OSD //启用OSD功能，若无OSD芯片则建议关闭  
USE\_OSD\_OVER\_MSP\_DISPLAYPORT //允许OSD通过MSP显示到外接OLED上，可以禁用  
USE\_OSD\_ADJUSTMENTS //启用OSD飞行中实时调试功能  
USE\_OSD\_PROFILES //启用OSD多页面功能  
USE\_OSD\_STICK\_OVERLAY //在OSD内显示摇杆位置  
USE\_SENSOR\_NAMES //使用自定义传感器名称  
USE\_SIGNATURE //使用电子签名，可以关闭  
USE\_ESCSERIAL\_SIMONK //允许通过串口为SIMONK电调进行刷写操作  
USE\_CMS\_FAILSAFE\_MENU //当Failsafe触发时显示FAILSAFE菜单，可以开启  
USE\_TELEMETRY\_SENSORS\_DISABLED\_DETAILS //允许在飞行统计数据上显示回传传感器信息，保持默认即可
