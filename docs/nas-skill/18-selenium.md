---
sidebar_position: 18
---

# selenium 教程

## 1、安装 pip

内存占用 148MB

```shell
apt install pip
```

## 2、安装 firefox 浏览器

内存占用 273MB

```shell
apt install firefox
```

## 3、安装 geckodriver

内存占用 78MB
[点击下载 armv7 的版本](https://ali.any168.net/armv7/geckodriver)
[点击下载 arm64 的版本](https://ali.any168.net/arm64/geckodriver)
将 geckodriver 拷贝到目录/usr/local/bin 目录中

```shell
#给予执行权限
chmod +x /usr/local/bin/geckodriver
#查看版本信息,测试是否可用
geckodriver --version
```

## 4、安装 selenium

```shell
pip3 install selenium
```
