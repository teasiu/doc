#!/bin/bash

ARCH_BIT=$(getconf LONG_BIT)
[ "$ARCH_BIT" = "32" ] && ARCH="armhf" || ARCH="arm64"

dl_url="https://dl.ecoo.top/update/system"
declare -a system_versions
system_versions=(
    [1]="海纳思Hi-OpenWrt固件 openwrt-armvirt-${ARCH_BIT}-root.ext4.gz"
    [2]="海纳思NAS完整版固件 Ubuntu-20.04.5-${ARCH}.gz"
)

readonly COLOUR_RESET='\e[0m'
declare -A COLORS
COLORS=(
    ["red"]='\e[91m'
    ["green"]='\e[32;1m' 
    ["yellow"]='\e[33m'
)

printStr() {
    color=$1
    printf ${COLORS[${color}]}"$2"${COLOUR_RESET}"\n"
}

_exit() {
    exit_singal=$1
    shift
    [ "$exit_singal" != "0" ] && printStr red "$*" || printStr green "$*"
    exit $exit_singal
}

get_md5() {
    case $1 in
    -c)
        shift
        wget -q $1 -O - | grep $2 | awk '{print $1}'
        ;;
    -l)
        shift
        [ ! -f "$1" ] && return 1
        md5sum $1 2> /dev/null | awk '{print $1}'
        ;;
    esac
}

echo "
+----------------------------------------------------------------------
| 海纳思hi-op固件切换专用脚本温馨提示：
+----------------------------------------------------------------------
| 切换后原系统将完全清除，请注意保存资料。
+----------------------------------------------------------------------
| 如果不确定，请按CTRL+C结束此脚本.
+----------------------------------------------------------------------
"

if [ $(whoami) != "root" ];then
    _exit 1 "请使用root权限切换系统命令！"
fi

#nasversion=`cat /etc/nasversion`
#if [ $nasversion != "20230401" ];then
#    _exit 1 "请使用最新20230401系统！"
#fi

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

wget -q --show-progress --no-check-certificate ${dl_url}/${dlfile} -O /tmp/${dlfile} || _exit 1 "下载失败，请重试"
[ "$(get_md5 -c ${dl_url}/${dlfile}.md5sum ${dlfile})" != "$(get_md5 -l /tmp/${dlfile})" ] && _exit 1 "文件校验失败，请重试"

mv /tmp/${dlfile} /tmp/backup-${ARCH_BIT}.gz
mkdir -p /tmp/backup
mount /dev/mmcblk0p8 /tmp/backup
if [ ! -f /tmp/backup/backup-${ARCH_BIT}1.gz ]; then
	mv /tmp/backup/backup-${ARCH_BIT}.gz /tmp/backup/backup-${ARCH_BIT}1.gz
fi
mv /tmp/backup-${ARCH_BIT}.gz /tmp/backup
sync
umount /tmp/backup

printStr yellow "
==============================================================
配置已完成，盒子正在重启并准备初始化中，
若5分钟后还没有获得ip，请手动重启盒子，并继续稍等初始化结束
=============================================================="
recoverbackup
