---
sidebar_position: 8
---

# 定时任务
优秀的Linux crontab任务管理器

## 使用基础
- 编辑任务管理器
```bash
crontab -e
```
- 浏览任务管理器
```bash
crontab -l
```

## 添加任务

- 实例1：每1分钟执行一次myCommand
```bash
* * * * * myCommand
```

- 实例2：每晚的21:30重启smb
```bash
30 21 * * * systemctl restart smbd
```

- 实例3：每一小时重启smb
```bash
0 */1 * * * systemctl restart smbd
```

## 学习教材

[www.runoob.com](https://www.runoob.com/w3cnote/linux-crontab-tasks.html)
