---
sidebar_position: 13
---

# TvHeadend 使用教程

## 安装与卸载

```shell
#更新
apt update
#安装tvheadend
apt install tvheadend -y

#卸载tvheadend
apt remove tvheadend -y
```

填写用户名

![image-20240119112539935](.\img\tvheadend1.png)

填写密码

![image-20240119112626397](.\img\tvheadend2.png)

最后使用浏览器访问 http://设备 ip:9981 即可

## 使用

待补充

## 注意事项

1. 登录不进去，提示 403Forbidden？

   造成原因：安装的过程没有仔细查看提示信息并正确输入用户名和密码，导致用户名和密码验证失败。

   解决方法：使用管理终端或者文件管理器等工具，编辑文件"/var/lib/tvheadend/superuser"

   ![image-20240119113412054](.\img\tvheadend3.png)

   自行修改用户名和密码后保存（用户名和密码明文存储）

   ```shell
   #重启tvheadend
   systemctl restart tvheadend
   ```

   最后使用修改后用户名和密码登录即可
