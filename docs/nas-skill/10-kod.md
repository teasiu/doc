---
sidebar_position: 10
---

# 可道云安装与使用

海纳思系统适配了可道云的一键安装脚本，  
用户可以直接安装使用。

## 一、安装

如果你的海纳思系统发行版本是20231201以后的，直接以下命令安装：  

```bash
apt update && apt upgrade -y
install-kod.sh install
```

如果是更早的版本，或者非NAS版本，  
则先添加海纳思的专用 apt 仓库源：  

```bash
bash <(curl https://www.ecoo.top/ota.sh)
histb-deb
apt install install-kod -y
insatll-kod.sh install
```

然后刷新首页，即可看到以下图标和链接：  
![](./img/kod1.jpg)  








