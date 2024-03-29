---
title: regname

---

# 设备管脚配置名称（海思芯片机顶盒）


## 一、什么叫做 reg 名称

reg 是海思 SDK 里对 fastboot 代码的表格配置文件名称，也叫做“管脚配置表”。  
表格中的内容全是寄存器的配置，主要涉及单板硬件关键参数说明、PLL、DDR、外设时钟、管脚复用、网口配置等。  
我们来看两个例子：  
比如 Hi3798Mv100 (华为悦盒 ec6108v9c 型号)的 reg 名称是：  

hi3798mdmo1g_hi3798mv100_ddr3_1gbyte_16bitx2_4layers_emmc.reg  

比如 Hi3798Mv200 (恩兔 n2ns1、n2c)的 reg 名称是：  

hi3798mv2dmc_hi3798mv200_DDR4-2133_2GB_16bitx2_4layers_emmc.reg  

我们从上面的名称可以判断这个板子的 CPU、DDR、闪存类型、pbc板层数等信息。  
这样，我们就可以轻易的对照自己的机顶盒判断选择适合刷入对应的神雕开发固件了。  

## 二、获取 reg 名称的四种常用方法

简单介绍以下四种可以获得你的机型对用的regname  

### 1.串口跑码读取参数

利用串口读写器 TTL 读取。或详细参考[TTL线刷教程](/docs/tutorial-basics/ttl-flash)  
把 usb 转 ttl 小板插入电脑，用杜邦线和针脚连接到板子的 GDN、TX、RX，  
使用串口终端跑码读取 fastboot 的参数，如下图：  

![pic](img/hitool-run-reg.png)

### 2.利用现有安卓系统后台终端读取参数

破解你的盒子安卓系统，adb进去后台，在adb shell终端输入。或详细参考[ADB 线刷教程](/docs/tutorial-basics/adb-flash)  

adb终端输入以下命令：  
```bash
cat /dev/block/mmcblk0p1 | grep -a hi3798
```

将会得到如下图的结果，包括了你的盒子的专用 reg 名称：  

![pic](img/grepreg.png)

### 3.利用你已知的可以刷机的安卓包文件信息

找到你曾经可以成功刷入这个机顶盒的安卓包，解压这个包，在里面得到一个fastboot.bin  

放到任意 linux 终端下当前位置，然后执行以下命令：  
   
```bash
cat ./fastboot.bin | grep -a hi3798
```

获得的返回信息包含了你的盒子reg名称。


### 4.本站已收集的已知适配机型

详情请看[设备适配表](/devices)。也欢迎提交你测试成功的不在已知列表里的机型名称给作者。

