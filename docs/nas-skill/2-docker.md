---
sidebar_position: 2
---

# docker使用

海纳思系统内置了一键安装 docker 程序的脚本；  
直接一键命令即可安装，包含docker-compose；  
在终端输入这个命令即可 ```install-docker.sh```  

## 安装docker程序

```bash
install-docker.sh
```

![](./img/install-docker.png)

```consle
root@hinas:~# docker version
Client: Docker Engine - Community
 Version:           24.0.7
 API version:       1.43
 Go version:        go1.20.10
 Git commit:        afdd53b
 Built:             Thu Oct 26 09:08:47 2023
 OS/Arch:           linux/arm
 Context:           default

Server: Docker Engine - Community
 Engine:
  Version:          24.0.7
  API version:      1.43 (minimum version 1.12)
  Go version:       go1.20.10
  Git commit:       311b9ff
  Built:            Thu Oct 26 09:08:47 2023
  OS/Arch:          linux/arm
  Experimental:     false
 containerd:
  Version:          1.6.26
  GitCommit:        3dd1e886e55dd695541fdcd67420c2888645a495
 runc:
  Version:          1.1.10
  GitCommit:        v1.1.10-0-g18a0cb0
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
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

