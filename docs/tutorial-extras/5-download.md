---
sidebar_position: 5
---

# 网络下载

海纳思系统提供了 aria2 和 transmission 两套下载管理器。

🌏️别说了，快上车，妥妥的一台网络下载机！

## aria2 使用

内置了 P3TER PRO 版的aria2下载软件，支持直连下载，BT下载，磁力下载等。

默认下载目的地 ```/home/ubuntu/downloads```

RPC端口 ```6800```

## 更新 Tracker 列表（提速）
终端输入命令可以更新最新的种子跟踪tracker列表

```bash
update-tracker.sh
#然后按提示操作
```

## 更改 aria2 配置

以下命令可以配置文件

```bash
vi /usr/local/aria2/aria2.conf
```

例如将下载位置修改到外挂磁盘位置：

将 ```dir=/home/ubuntu/downloads``` 修改为 ```dir=/mnt/sda1/downloads```

![](./img/aria2.png)

## transmission 使用
默认登陆帐号 ***admin*** 密码 ***admin***

这是一款优秀的种子文件下载器。

## 更改 transmission 配置

配置文件位置```/etc/transmission-daemon/settings.json```

密码修改方法：
```bash
# 停止 Transmission 服务
/etc/init.d/transmission-daemon stop
# 修改密码
# 编辑配置文件: vi /etc/transmission-daemon/settings.json
# 找到以下内容:
"rpc-password": "{1e82c73f8f4b5c3ba4e2d94227fc19dc3442abf7nSWuZtsb",
"rpc-port": 9091,
"rpc-url": "/transmission/",
"rpc-username": "admin",
# 只需要修改 password、username 后面 "" 内的内容即可
# 开启 Transmission 服务
/etc/init.d/transmission-daemon start
```

默认下载位置和修改下载位置，同上参考。

![](./img/transmission.png)

