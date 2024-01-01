---
sidebar_position: 5
---

# 内网穿透

内网穿透，就是无论你的盒子所处网络是否有公网IP，无论是否在复杂内部网络下，只要你的盒子能联通上网，就可以做好穿透，让你在异地随时访问和管理海纳思系统。

## 系统内置 frpc

海纳思系统（hinas）内置了一个frpc的穿透客户端软件，  
但是并没有开启，也没有运行。  
终端输入 ```frpc -v``` 可以看到它的版本号  
终端输入 ```systemctl enable frpc``` 可以设置为开机自启动  
终端输入 ```systemctl start frpc``` 可以运行它  
终端输入 ```systemctl status frpc``` 可以查看它运行后的状态是否正确  
如果你不喜欢，可以完全删除它  

```bash
sudo apt purge frpc-histb
```

当然，如果你哪天又想用了，就安装

```bash
sudo apt update && sudo apt install frpc-histb
```


## 开通 frpc 账号

## 手动配置案例

