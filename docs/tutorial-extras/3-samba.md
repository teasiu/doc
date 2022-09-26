---
sidebar_position: 3
---

# 网络共享
海纳思系统已经默认内置安装了samba程序提供使用。
## 修改配置
samba的配置文档在/etc/samba/smb.conf

请使用vi或nano编辑该配置文档

## 添加外置USB硬盘共享文件夹

海纳思已经默认共享了/home/ubuntu/downloads文件夹

如果你需要添加一个外置u盘的文件夹，以下为示例
```bash
mkdir -p /mnt/sda1/usb-share
chmod -R 777 /mnt/sda1/usb-share
```
在配置/etc/samba/smb.conf中添加如下代码
```
[usb-shares]
path = /mnt/sda1/usb-share
read only = no
guest ok = yes
create mask = 0777
directory mask = 0777
browseable = yes
```

最后重启服务生效：
```bash
systemctl restart smbd
```
## 使用技巧

windows下在文件管理器输入: ```\\192.168.111.20``` 

即可访问.

在网上邻居也可以找到这个共享文件夹了

