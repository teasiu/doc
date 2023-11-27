---
sidebar_position: 4
---

# 更改MAC网卡地址

支持手动更改默认的固件 MAC 地址 ```00:11:22:33:44:55```

## 原理

机顶盒的mac地址由启动阶段的 ```bootargs.bin``` 进行传递。

作者为了便利用户更改，制作了```mkbootargs```的程序提供在线制作```bootargs.bin```文件。

## 制作生成

- 原始文档：(每个系统都是单独对应的数值，请务必使用当前系统下的文档)

  ```/etc/bootargs_input.txt```

  ```html
  root@hi3798mv200:~# cat /etc/bootargs_input.txt
  baudrate=115200
  ethaddr=00:11:22:33:44:55
  ipaddr=192.168.1.10
  netmask=255.255.255.0
  gatewayip=192.168.1.1
  serverip=192.168.1.1
  bootcmd=mmc read 0 0x1FFFFC0 0x7000 0x14000;bootm 0x1FFFFC0
  bootargs_512M=mem=512M mmz=ddr,0,0,48M vmalloc=500M
  bootargs_1G=mem=1G mmz=ddr,0,0,48M vmalloc=500M
  bootargs_2G=mem=2G mmz=ddr,0,0,48M vmalloc=500M
  bootargs_768M=mem=768M mmz=ddr,0,0,48M vmalloc=500M
  bootargs_1536M=mem=1536M mmz=ddr,0,0,48M vmalloc=500M
  bootargs_3840M=mem=3840M mmz=ddr,0,0,48M vmalloc=500M
  bootargs=model=mv200 console=ttyAMA0,115200 root=/dev/mmcblk0p9 rootfstype=ext4 rootwait blkdevparts=mmcblk0:1M(boot),1M(bootargs),4M(baseparam),4M(pqparam),4M(logo),40M(kernel),64M(busybox),512M(backup),-(ubuntu)
  bootdelay=0
  stdin=serial
  stdout=serial
  stderr=serial
  
  ```

  自行修改第2行的```ethaddr=00:11:22:33:44:55``` 例如为 ```ethaddr=00:11:22:33:44:66```

  ***注意***：这个mac地址必须是16进制的数字或字母，强烈建议你看机顶盒背后的标签来写。

- 制作生成：

  ```bash
  mkbootargs -s 64 -r /etc/bootargs_input.txt -o bootargs.bin
  ```

- 刷入第二分区：

  将上一步生成的```bootargs.bin``` 刷入第2分区

  ```bash
  dd if=bootargs.bin of=/dev/mmcblk0p2 bs=1024 count=1024
  ```

  

- 重启生效



### 自动脚本

作者也做了一个自动脚本直接完成上面的操作，

```html
http://192.168.xx.xx/macedit.php
```



## 软改mac

上面的方法是硬改mac，这里也阐述一下软改的办法：

```bash
vi /etc/network/interfaces.d/eth0       # 编辑配置文件
# 增加下面的内容 (实际内容可按需修改)
pre-up ifconfig eth0 hw ether 00:11:22:33:44:66
```

