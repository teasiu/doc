---
sidebar_position: 1
---

# TTL 刷机(海思)

需要用到USB转TTL刷机线，这种刷机方法通过TTL刷机线连接盒子与电脑。通过电脑软件与盒子进行命令行交互，实时显示盒子后台，类似电脑命令行。

## 准备工作

- 一套USB转TTL设备小板（推荐CH340G），杜邦线，排针，或需要电络铁；
- Hitool工具（华为海思官方刷机工具）；
- 一根网线连接机顶盒到路由器的LAN口；

| 使用平台            | 国内高速下载地址        | 备用海外下载地址 | 
| ------------------ | --------------------- | ----------------- | 
| Windows    | [海兔工具Windows版](https://node2.histb.com/update/soft_init/hitool/HiTool-windows.7z)	 |	[海兔工具Windows版](https://node2.histb.com/update/soft_init/hitool/HiTool-windows.7z)   | 
| Linux      | [海兔工具Linux版](https://node2.histb.com/update/soft_init/hitool/hitool_linux.tar.gz)| [海兔工具Linux版](https://node2.histb.com/update/soft_init/hitool/hitool_linux.tar.gz)| 

<img src="/img/ch340.png" alt="usb2ttl" width="100" height="100"> <img src="/img/hitool-ttl-line.png" alt="杜邦线" width="100" height="100">

## 确认机顶盒reg名称

- [什么是机顶盒reg名称？如何知道我的机顶盒reg名称？](https://www.ecoo.top/getreg.html)
- [目前作者开发支持适配的机型列表](/devices)

## 下载匹配的固件

- [作者发布的官方网站下载地址](/download)

## 刷机

20220808开始的固件，在刷机完成后，还需要耐心等待3分钟左右的初始化过程，

在初始化完成前，请不要做任何操作。

部分mv200/mv300机型可能需要手动关闭电源，再打开电源，再等待初始化结束。

初始化结束后，请尝试到路由器客户端列表管理页面查看自动分配给机顶盒的IP，浏览器输入该IP地址进入盒子的NAS管理首页。
