---
title: 系统最新升级公告

---

# 海纳思系统官方通告

## 2023年12月01日

## 一键升级系统或切换系统命令

### 1. 一键升级到最新专业版（40元）
- 注意，目前仅支持mv100/mv200通用机型。
- 终端输入`nasupdate`。
- 接着输入`histb`。
- 将会得到一个机顶盒识别码，将此码复制后发给群主，等待通知一键命令升级即可。

[专业版有什么区别？](https://www.ecoo.top/professional.html)

##### 仅内网穿透服务，25 元/年
- 终端输入`nasupdate`。
- 接着输入`histb`。
- 将会得到一个机顶盒识别码，将此码复制后发给群主。
- 开通账号后输入`kaitong-frp`即可使用。

### 2. 从老版本一键升级到20231201版本
- 统一方法：在终端输入 `nasupdate` 然后输入 `nasupgrade` 即可一键全新升级新版本。
- 或者更老的版本升级，请复制下面的命令粘贴到终端按回车运行

    - mv100
        ```shell
        bash <(curl https://www.ecoo.top/mv100_upgrade.sh)
        ```
    - mv200
        ```shell
        bash <(curl https://www.ecoo.top/mv200_upgrade.sh)
        ```
    - mv300
        ```shell
        bash <(curl https://www.ecoo.top/mv300_upgrade.sh)
        ```
    - N2 恩兔专用
        ```shell
        bash <(curl https://www.ecoo.top/n2_upgrade.sh)
        ```
    - 玩客云 S805 专用
        ```shell
        bash <(curl https://www.ecoo.top/s805_upgrade.sh)
        ```

### 3. 网心云专用固件（付费10元）一键切换安装
- 注意，网心云专用固件是纯净版系统，优化了跑容器魔方的配置。
- 注意，一键切换后请务必等待10分钟系统初始化，之前不可做任何操作。
- 切换后到路由器重新找自动分配的IP，浏览器打开首页，发激活码给群主激活。
- 注意，未激活前，无法登录后台。


- mv100
    ```shell
    bash <(curl https://www.ecoo.top/mv100-wx.sh)
    ```
- mv200/mv300
    ```shell
    bash <(curl https://www.ecoo.top/mv23-wx.sh)
    ```

[点击链接注册网心云可以再获得5元奖励加成。](https://act.walk-live.com/acts/invite/v3/?inviteid=cb9bbacd)

![网心云](img/onething.jpg)

版权 © 2023 [www.ecoo.top](http://www.ecoo.top/)

