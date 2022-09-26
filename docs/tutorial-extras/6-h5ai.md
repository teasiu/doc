---
sidebar_position: 6
---

# 网盘使用
采用H5ai开源软件，nginx+php环境搭建，一个轻量而又强大的个人网盘分享程序。

## 使用指南
程序位置: /var/www/html/files/

默认登陆用户名和密码 ***admin*** ***admin***

网盘系统可以直接播放音视频和查看文档内容。

在文档名称前面打勾, 左上角的下载按钮, 可以直接将文档打包zip格式并浏览器下载。

## 修改到外置磁盘
内置的home是一个范例，它软链接到/home/ubuntu/files

可以轻松的选择将保存的文档位置链接到外置磁盘空间。

例子：
```bash
mkdir /mnt/sda1/files
#创建一个外置磁盘的文件夹
chown -R www-data:www-data /mnt/sda1/files
#给这个文件夹赋权
ln -sf /mnt/sda1/files /var/www/html/files/home
#创建这个文件夹的软链接到默认home的位置
```

也可以个性化你指定位置的页首或页脚显示，例如：
```bash
echo "## 这是外置磁盘链接到home的页首显示" > /mnt/sda1/files/_h5ai.header.md
echo "## 这是外置磁盘链接到home的页脚说明" > /mnt/sda1/files/_h5ai.footer.md
```

## 访问密码修改
- 更改密码
- 删除密码

