---
sidebar_position: 2
---

# docker使用

内核支持直接安装ubuntu20.04的docker.io

## 安装docker程序

```bash
apt update && apt install docker.io
```

```consle
root@hi3798mv200:~# docker version
Client:
 Version:           20.10.12
 API version:       1.41
 Go version:        go1.16.2
 Git commit:        20.10.12-0ubuntu2~20.04.1
 Built:             Wed Apr  6 02:16:12 2022
 OS/Arch:           linux/arm64
 Context:           default
 Experimental:      true

Server:
 Engine:
  Version:          20.10.12
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.2
  Git commit:       20.10.12-0ubuntu2~20.04.1
  Built:            Thu Feb 10 15:03:35 2022
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          1.5.9-0ubuntu1~20.04.4
  GitCommit:
 runc:
  Version:          1.1.0-0ubuntu1~20.04.1
  GitCommit:
 docker-init:
  Version:          0.19.0
  GitCommit:

```

- 拉取镜像

  ```bash
  docker pull xxx/xxx
  ```

  

- 运行容器

  ```bash
  docker run xxx/xxx --options
  ```

- 列出运行中的容器

  ```bash
  docker ps -a
  ```

  会列出所有运行中的容器名称和 ```id```

- 停止运行中的容器

  ```bash
  docker stop [ id 的前4位数]
  ```

  

- 删除已停止的容器

  ```bash
  docker rm [ id的前4位数字]
  ```

  

- 列出所有镜像

  ```bash
  docker images
  ```

  

- 删除已停止的镜像

  ```bash
  docker rmi [镜像id的前4位数]
  ```



## 注意

海纳思系统内置了几个一键安装的脚本，非常便利。推荐需要时选择。

```bash
install-portainer.sh #中文容器管理面板
install-qinglong.sh #青龙面板
install-jellyfin.sh #电影削刮器
install-homeassistant.sh #智能家居
install-teslamate1.sh #特斯拉远控系统
```

