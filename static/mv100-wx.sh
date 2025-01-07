#!/bin/bash

declare -a system_versions
system_versions=(
    [1]='海思机顶盒网心云专用固件 onething-32.gz'
    [2]='海纳思系统 Ubuntu-20.04.5-armhf.gz'
)

echo "
+----------------------------------------------------------------------
| 海纳思系统网心云固件切换专用脚本温馨提示：
+----------------------------------------------------------------------
| 切换后原系统将完全清除，请注意保存资料。
+----------------------------------------------------------------------
| 如果不确定，请按CTRL+C结束此脚本.
+----------------------------------------------------------------------
"

temp_file=$(mktemp)
curl -sSL https://hi.ecoo.top/mirror-utils.sh > $temp_file
if [ ! -f /etc/public-download.sh ] || [ "$(cat $temp_file|md5sum|awk '{print $1}')" != "$(cat /etc/public-download.sh|md5sum|awk '{print $1}')" ]; then
	cp $temp_file /etc/public-download.sh
fi
rm -f $temp_file
source /etc/public-download.sh

if [ $(whoami) != "root" ];then
	_exit 1 "请使用root权限切换系统命令！"
fi

#nasversion=`cat /etc/nasversion`
#if [ $nasversion != "20230701" ];then
#	_exit 1 "请使用最新20230701系统！网站公告有升级方法。"
#fi

is64bit=$(getconf LONG_BIT)
if [ "${is64bit}" != '32' ];then
	_exit 1 "抱歉, 当前系统切换版本不支持64位系统, 请使用32位系统!";
fi

for index in "${!system_versions[@]}"; do
    printStr green "$index. $(echo ${system_versions[$index]}|awk '{print $1}')" 
done

while :; do
    printStr yellow "你想要安装哪个版本? 输入数字后按回车确定：" 
    read version_number
    for index in "${!system_versions[@]}"; do
        if [ "$version_number" = "$index" ]; then
            selected_version="$(echo ${system_versions[$index]}|awk '{print $1}')" 
            dlfile="$(echo ${system_versions[$index]}|awk '{print $2}')" 
            break 2
        fi
    done
done

printStr yellow "检测并选定下载节点..."
get_mirror_url

printStr yellow "下载刷机包..."
dl_get update/system/${dlfile} /root/${dlfile}
[ "$(get_md5 -c ${NODE_URL}/update/system/${dlfile}.md5sum ${dlfile})" != "$(get_md5 -l /root/${dlfile})" ] && _exit 1 "文件校验失败，请重试"

mv /root/${dlfile} /root/backup-32.gz
mkdir -p /root/backup
mount /dev/mmcblk0p8 /root/backup
mv /root/backup-32.gz /root/backup
sync
umount /root/backup

printStr yellow "
==============================================================
配置已完成，盒子正在重启并准备初始化中，
若5分钟后还没有获得ip，请手动重启盒子，并继续稍等初始化结束
=============================================================="
recoverbackup -a
