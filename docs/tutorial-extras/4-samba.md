---
sidebar_position: 4
---

# 网络共享

海纳思系统已经默认内置安装了 samba 程序提供使用。

## 修改配置

samba 的配置文档在/etc/samba/smb.conf

请使用 vi 或 nano 编辑该配置文档

## 添加外置 USB 硬盘共享文件夹

海纳思已经默认共享了/home/ubuntu/downloads 文件夹

如果你需要添加一个外置 u 盘的文件夹，以下为示例

```bash
mkdir -p /mnt/sda1/usb-share
chmod -R 777 /mnt/sda1/usb-share
```

在配置/etc/samba/smb.conf 中添加如下代码

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

windows 下在文件管理器输入: `\\192.168.111.20`

即可访问.

在网上邻居也可以找到这个共享文件夹了
