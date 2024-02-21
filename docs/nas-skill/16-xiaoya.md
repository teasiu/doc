---
sidebar_position: 16
---

# 小雅安装教程

1、手机下载安装阿里云盘

![](./img/xiaoya1.jpg)

2、注册登录

![](./img/xiaoya2.jpg)

3、电脑浏览器打开阿里云盘官网

[点击此处前往登录](https://www.alipan.com/)

4、使用手机上的阿里云盘 App 扫码登录

![](./img/xiaoya3.png)

5、创建小雅缓存的文件夹 xiaoya（文件名可以自行定义），注意不能使用备份盘

![](./img/xiaoya4.png)

6、获取所需的第一个参数 folderId,将这串数字复制保存

![](./img/xiaoya5.png)

7、获取 refreshToken（32 位长）

访问链接扫码登录即可获取

[点击此处前往获取 refreshToken](https://csb.histb.com/)

将这串字符复制保存

![](./img/xiaoya6.png)

8、获取 token（280 位长）

[点击此处前往获取 token](https://alist.nn.ci/tool/aliyundrive/request.html)

点击按钮,生成登录二维码

![](./img/xiaoya7.png)

手机扫码授权

![](./img/xiaoya8.jpg)

授权完成后点击按钮生成 280 位 token

![](./img/xiaoya9.png)

复制保存 token（280 位）

![](./img/xiaoya10.png)

9、准备好了 3 个参数，开始正式安装

```shell
#执行下面的命令
bash <(curl https://ecoo.top/update/soft_init/tmp/xiaoya.sh)
```

点击回车按钮确认执行

![](./img/xiaoya11.png)

将上面 6、7、8 三个步骤获取到的参数复制粘贴，按回车确认即可完成安装

![](./img/xiaoya12.png)

10、等待 5-10 分钟后访问 http://盒子 ip:5678,比如盒子的 ip 是 192.168.1.16 那么就访问http://192.168.1.16:5678

出现下面的情况只需静静等待几分钟后刷新页面即可

![](./img/xiaoya13.png)

刷新后出现下面的画面即安装成功

![](./img/xiaoya14.png)

现在可以开始你的观看之旅了

![](./img/xiaoya15.png)
