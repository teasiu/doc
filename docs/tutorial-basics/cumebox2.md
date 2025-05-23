---
sidebar_position: 9

---

# 比特米盒（晶晨S905x)刷机

轻 nas 盒子，名称很多，私家云二代、比特米盒、cumebox2、cm2-b  
这盒子扩展接口非常丰富，有两个 usb2.0，一个 typec，一个 sd 卡槽，  
一个 hdmi ，一个百兆网口，然后盒子里面还有两个2.5寸 sata 硬盘仓。  
作者已编译适配刷入海纳思系统固件。  
已修复led屏显，wifi，自动风扇等。  

![pic](pic/cumebox/cumebox-1.jpg)   
![pic](pic/cumebox/cumebox-2.jpg)  

## 一、准备工作  

### 1.准备一个 USB-TypeC 数据连接线 

![pic](pic/cumebox/cumebox-3.jpg)  

### 2.下载以下全部软件

a.晶晨烧录工具: USB_Burning_Tool.exe  
b.安卓 6 代固件： atv6.img  
c.安卓切换卡载系统应用包：切换卡载系统V1.0.apk  
d. U 盘启动的固件包：Hinas_cumebox_USB.img  
e. 刷入 emmc 的海纳思固件包：Hinas_cumebox_EMMC.img  

[下载地址：https://alist.ecoo.top/amlogic/s9xxx/cumebox](https://alist.ecoo.top/amlogic/s9xxx/cumebox)  

![pic](pic/cumebox/cumebox-4.jpg)  
  
### 3.拆开盒子，取出主板  

-撬开4个垫胶片，拧开4枚螺丝  

![pic](pic/cumebox/cumebox-5.jpg)  

-再拧开里面1枚螺丝  
-拇指往下按，外壳往上抽，即可取出主板  


### 4. 准备晶晨烧录软件

下载和安装好:  
![pic](pic/s805/tools.png)  
晶晨烧录工具: [USB_Burning_Tool.exe](https://www.ecoo.top/update/soft_init/amlproject/USB_Burning_Tool_v2.1.3.exe)


## 二、烧写刷入安卓 6.0 系统  

:::tip
这是一次性的刷安卓系统，可以看电视，安装安卓应用软件等功能，  
如果已经刷过安卓系统，可以忽略跳过此步骤。
:::


### 1. 找到主板短接点：
下面提供作者收集到的图例：  

![pic](pic/cumebox/cumebox-6.jpg)  
![pic](pic/cumebox/cumebox-7.jpg)  

### 2. 晶晨烧写工具导入安卓包

打开 USB_Burning_Tool 软件工具，导入刚才下载的 atv6.img 固件   

![pic](pic/cumebox/cumebox-8.jpg)  


### 3. 烧写安卓系统

数据线一端插入电脑的 USB 口，

短接住两个短接点-->TypeC 口插入盒子-->显示已连接-->放开短接-->点击 “开始” 按钮  

![pic](pic/cumebox/cumebox-9.jpg)  

正常情况下，你短接到位，就一定会显示```已连接``` ;  
如果烧写失败，一般都是数据线接触不良，请检查每个步骤，重新操作即可。  


### 5. 拔掉数据线、关闭软件。  

最后，拔掉连接线，关闭软件。至此，安卓系统烧写刷入完成。  

### 6. 安装切换卡载系统V1.0.apk


## 三、制作可引导启动的 U 盘海纳思系统


## 四、将海纳思系统刷入内置存储 EMMC

 
## 五、启动海纳思 NAS 系统

### 1. 重新上电，等待 2-3 分钟，首次初始化启动完毕

 等待 2-3 分钟，首次启动完毕，即可到路由器查找自动分配的 IP；  
 这个 IP 在你的路由器客户端列表中，显示的 mac 地址是 `00:11:22:33:44:66`  

### 2. 浏览器打开该 IP 地址，进入 web 管理页面  

详细阅读[《开始使用》](/docs/tutorial-extras/start) 教程！  


## 六、恭喜你拥有这台低功耗的家用 NAS 系统


我是小盒子，也是大世界！  
海纳思系统，绝对值得拥有！   


## 六、常见问题解答










