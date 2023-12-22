---
sidebar_position: 6
---

# 网盘使用
采用H5ai开源软件，nginx+php环境搭建，一个轻量而又强大的个人网盘分享程序。

## 使用
程序位置: /var/www/html/files/

默认登陆用户名和密码 ***admin*** ***admin***

网盘系统可以直接播放音视频和查看文档内容。

在文档名称前面打勾, 左上角的下载按钮, 可以直接将文档打包zip格式并浏览器下载。

## 修改到外置磁盘
内置的home是一个范例，它软链接到/home/ubuntu/files

可以轻松的选择将保存的文档位置链接到外置磁盘空间。

例子：
```bash
#创建一个新的外置磁盘的文件夹
mkdir /mnt/sda1/files
#给这个文件夹赋权
chown -R www-data:www-data /mnt/sda1/files
#删除原来的默认链接
rm /var/www/html/files/home
#创建这个新文件夹的软链接到默认home的位置
ln -sf /mnt/sda1/files /var/www/html/files/home
```

也可以个性化你指定位置的页首或页脚显示，例如：
```bash
echo "## 这是外置磁盘链接到home的页首显示" > /mnt/sda1/files/_h5ai.header.md
echo "## 这是外置磁盘链接到home的页脚说明" > /mnt/sda1/files/_h5ai.footer.md
```

一旦修改到外置磁盘位置，上传小插件也跟随到了新位置。

## 访问密码修改
- 更改密码

```bash
echo -n 'admin:' | tee /etc/nginx/passwords-h5ai.list
openssl passwd -apr1 | tee -a /etc/nginx/passwords-h5ai.list
nginx -s reload
```

- 删除密码

取消h5ai登陆密码
```bash
vi /etc/nginx/locations.d/h5ai
```

```bash
#将后面两行删掉即可：
auth_basic "admin";
auth_basic_user_file /etc/nginx/passwords-h5ai.list;
#最后重启一下nginx服务
nginx -s reload
```
