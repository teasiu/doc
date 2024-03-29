---
sidebar_position: 3
---

# 共享文档转移
用usb口插上外置大容量磁盘，把保存资料的位置转移到磁盘，可以满足你的一切存档需求。

## 磁盘分区与格式化

在入门教程里已经有描述，首先要做好分区和格式化。

## 磁盘挂载

内置的自动挂载脚本，请这样使用：

```bash
automount -u
#自动卸载所有外置磁盘
automount -a
#自动挂载所有外置磁盘
```

挂载位置默认为```/mnt/sda1``` 或 ```/mnt/sdb1``` 或 ```/mnt/mmcblk1p1```

提醒：ext4文件系统才支持赋权操作。

## 位置转移

- 修改应用程序的配置文件，把存储位置写到外置磁盘对应的新建文件夹。

  比如下载程序 aria2 和 transmission。比如可道云，比如

- 新建外置磁盘专门文件夹，把部分程序中的文件夹建立软链接到外置磁盘专用文件夹去。

  比如 ```/opt``` 下的一些程序文件， ```/var/www/html/files```下的 ```home``` 文件夹,

  软链方法：

  ```bash
  #ln -sf /目的地文件夹 /来源地
  #例如，把 /var/www/html/files/home这个位置软链到 /mnt/sda1/fileshome
  ln -sf /mnt/sda1/fileshome /var/www/html/files/home
  #那么，访问home位置任何指令，就实际在fileshome里操作了。
  ```

## 磁盘检查

盒子电路本质上是一个嵌入式的系统设计，所以，外置磁盘并没有完整的电源管理单元，

当你频繁重启或者断电时，外置磁盘文件系统会受到一定的碎片影响，无论固态还是机械。

ext4的文件系统，有超级块的模式，可以使用 ```fsck``` 命令修复。

当你重启后发现磁盘没有被挂载时，大概率需要进行超级块的修复。

```bash
ls -al /dev/sd*
#检查磁盘是否被内核识别，是否存在/dev/sda1
fsck /dev/sda1
#执行修复
```

