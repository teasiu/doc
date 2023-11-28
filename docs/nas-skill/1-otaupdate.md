---
sidebar_position: 1
---

# 系统更新和软件更新

海纳思系统几乎每天都有更新，20231201往后版本，以deb包版本更迭，apt管理器进行升级和更新。

## 新版本升级

新版本全部采用apt软件包管理器进行更新，符合debian系Linux的规范

### 升级命令

直接在终端输入以下命令，即可无损更新系统和软件：

```bash
sudo apt-get update
sudo apt-get upgrade
```

### 更新源节点

海纳思系统提供以下三个更新源的节点，你可以自行切换，以获得更快的下载速度。  

- 官源gpg密钥

```
curl -fsSL https://www.ecoo.top/update/soft_init/histb.gpg |apt-key add -
```

- 节点源1

```bash
echo "deb https://node.histb.com:9088/update/repo/$(dpkg --print-architecture) histb main" > /etc/apt/sources.list.d/histb.list
```

- 节点源2

```bash
echo "deb https://node2.histb.com/update/repo/$(dpkg --print-architecture) histb main" > /etc/apt/sources.list.d/histb.list
```

- 节点源3

```bash
echo "deb https://node3.histb.com:9088/update/repo/$(dpkg --print-architecture) histb main" > /etc/apt/sources.list.d/histb.list
```

上面三句任选其一，然后：

```bash
apt-get update
apt-get upgrade
```


## 旧版本升级  

以往的旧版本，提供以下一键命令方法全新升级系统。  

### hi3798mv100机型  

```bash
bash <(curl https://ecoo.top/mv100_upgrade.sh)
```

### hi3798mv200机型

```bash
bash <(curl https://ecoo.top/mv200_upgrade.sh)
```

### hi3798mv200恩兔n2ns1机型

```bash
bash <(curl https://ecoo.top/n2_upgrade.sh)
```

### hi3798mv300机型

```bash
bash <(curl https://ecoo.top/mv300_upgrade.sh)
```

### 玩客云 S805 机型

```bash
bash <(curl https://ecoo.top/s805_upgrade.sh)
```


## 常用脚本ota更新

- ota升级的细节，一般会在社区发布帖子进行公布，请自行留意更新。
- ota升级原则上是修复或新增系统的某些功能，不会影响现有系统使用中的程序和用户数据。
