#!/bin/bash
dlfile="mv100-99.flash.gz"
echo "
+----------------------------------------------------------------------
| 海纳思系统hi3798mv100升级系统专用脚本温馨提示：
+----------------------------------------------------------------------
| 此专用脚本可以让你在任意版本的NAS系统下一键升级到20260101,
+----------------------------------------------------------------------
| 升级20260101版专用，原系统将完全清除，请注意保存资料。
+----------------------------------------------------------------------
| 如果不确定，请按CTRL+C结束此脚本.
+----------------------------------------------------------------------
"
read -p "继续执行？[y/n]: " result
[ "${result^^}" != "Y" ] && exit

temp_file=$(mktemp)
curl -sSL https://hi.ecoo.top/mirror-utils.sh > $temp_file
if [ ! -f /etc/public-download.sh ] || [ "$(cat $temp_file|md5sum|awk '{print $1}')" != "$(cat /etc/public-download.sh|md5sum|awk '{print $1}')" ]; then
    cp $temp_file /etc/public-download.sh
fi
rm -f $temp_file
source /etc/public-download.sh

if [ $(whoami) != "root" ]; then
    _exit 1 "请使用root权限切换用户！"
fi

model=$(cpuid)
platform=hi3798mv100
if [ "$(echo ${model})" != "$platform" ]; then
    _exit 1 "本升级程序仅支持${platform}机型！"
fi

promode=$(uname -r|cut -c 13-)
if [ $promode = 16010066 ]; then
    _exit 1 "专业版用户请使用vipupgrade命令进行升级！"
fi

# ---------------------------------------------------------------
# 检测 /tmp 剩余空间，不足 400M 时尝试扩容或清理
# ---------------------------------------------------------------
printStr yellow "检测 /tmp 可用空间..."
TMP_AVAIL=$(df -T | grep '/tmp' | awk '{print int($5)}')   # 单位：KB

if [ "${TMP_AVAIL}" -lt 409600 ]; then   # 409600 KB = 400M
    printStr yellow "/tmp 剩余空间不足 400M（当前 ${TMP_AVAIL} KB），尝试 remount 扩容..."

    mount -o remount,size=500M /tmp 2>/dev/null
    if [ $? -eq 0 ]; then
        printStr green "/tmp 已扩容至 500M"
    else
        printStr yellow "remount 失败，尝试清理 /tmp 旧文件..."
        # 删除超过 1 天的普通文件
        find /tmp -type f -mtime +1 -delete 2>/dev/null
        # 删除同名残留包（防止上次下载中断）
        rm -f /tmp/${dlfile}

        # 清理后再次尝试扩容
        mount -o remount,size=400M /tmp 2>/dev/null
        if [ $? -eq 0 ]; then
            printStr green "清理后 remount 成功，/tmp 已扩容至 400M"
        else
            # 最后兜底：检查清理后实际剩余空间是否已满足要求
            TMP_AVAIL=$(df -T | grep '/tmp' | awk '{print int($5)}')
            if [ "${TMP_AVAIL}" -lt 409600 ]; then
                _exit 1 "/tmp 空间不足且无法扩容（当前 ${TMP_AVAIL} KB），请手动清理后重试！"
            else
                printStr green "清理后 /tmp 剩余空间已满足要求（${TMP_AVAIL} KB）"
            fi
        fi
    fi
else
    printStr green "/tmp 剩余空间充足（${TMP_AVAIL} KB），继续..."
fi
# ---------------------------------------------------------------

printStr yellow "检测并选定下载节点..."
get_mirror_url

printStr yellow "下载刷机包..."
dl_get update/system/${dlfile} /tmp/${dlfile}

printStr yellow "校验刷机包..."
echo "${NODE_URL}/update/system/${dlfile}.md5sum"
[ "$(get_md5 -c ${NODE_URL}/update/system/${dlfile}.md5sum ${dlfile})" != "$(get_md5 -l /tmp/${dlfile})" ] && \
    _exit 1 "文件校验失败，请重试"
printStr green "下载完成！"

printStr yellow "刷机中，请勿断电..."
gunzip -c /tmp/${dlfile} | dd of=/dev/mmcblk0 bs=1024 seek=1024 status=progress conv=sync

if [[ $? == 0 ]]; then
    rm -f /tmp/${dlfile}   # 刷机成功后清理临时文件
    printStr yellow "
==============================================================
恭喜刷机已完成，系统重启中，待初始化5-8分钟结束后即可登录。
=============================================================="
    reboot
else
    _exit 1 "刷机失败"
fi
