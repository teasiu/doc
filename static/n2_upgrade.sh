#!/bin/bash

declare -A node_url_map=(
    ["ah"]="https://node4.histb.com:9088/update/system"
    ["hk"]="https://node2.histb.com/update/system"
    ["dl"]="https://dl.ecoo.top/update/system"
)

dlfile="n2-99.flash.gz"  # 文件路径

dl_node=""

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
	return 0
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
        wget -q -4 $1 -O - | grep $2 | awk '{print $1}'
        ;;
    -l)
        shift
        [ ! -f "$1" ] && return 1
        md5sum $1 2> /dev/null | awk '{print $1}'
        ;;
    esac
	return 0
}

echo "
+----------------------------------------------------------------------
| 海纳思系统hi3798mv200升级系统 N2 恩兔 专用脚本温馨提示：
+----------------------------------------------------------------------
| 此专用脚本可以让你在任意版本的NAS系统下一键升级到20251001,
+----------------------------------------------------------------------
| 升级20251001版专用，原系统将完全清除，请注意保存资料。
+----------------------------------------------------------------------
| 如果不确定，请按CTRL+C结束此脚本.
+----------------------------------------------------------------------
"
read -p "继续执行？[y/n]: " result
[ "${result^^}" != "Y" ] && exit

model=$(cat /etc/regname | cut -b 7-12)
platform=mv200

if [ "$(echo ${model})" != "$platform" ];then
	_exit 1 "本升级程序仅支持hi1798${platform}机型！"
fi

if [ $(whoami) != "root" ];then
	_exit 1 "请使用root权限切换系统命令！"
fi

promode=$(uname -r|cut -c 13-)
if [ $promode = 26010066 ];then
	_exit 1 "专业版用户请使用vipupgrade命令进行升级！"
fi

is64bit=$(getconf LONG_BIT)
if [ "${is64bit}" != '64' ];then
	_exit 1 "抱歉, 当前系统切换版本不支持32位系统, 请使用64位系统!";
fi

#nasversion=`cat /etc/nasversion`
#if [ $nasversion = "20230101" ];then
#	_exit 1 "已经是20230101最新版，无需升级系统！"
#fi

space_left=$(df -hT|grep /dev/root|awk '{print $4}')
if [ "$(expr $(echo ${space_left%%G}) \> 1)" != 1 ];then
	_exit 1 "请确保剩余空间大于1G！"
fi

printStr yellow "检测并选定下载节点..."
for node in "${!node_url_map[@]}"; do
    url=${node_url_map[$node]}
    
    if curl --output /dev/null --silent --head --fail -m 3 "$url/$dlfile"; then
        dl_node=$node
        break
    else
        printStr yellow "$node 不可访问，尝试下一个节点"
    fi
done

if [ ! -z "$dl_node" ]; then
    printStr green "选定下载地址为节点: $dl_node"
    dl_url=${node_url_map[$dl_node]}
else
    _exit 1 "所有节点均不可访问"
fi
printStr yellow "下载刷机包..."
wget -q --show-progress --no-check-certificate ${dl_url}/${dlfile} -O /${dlfile} || _exit 1 "下载失败，请重试"
printStr yellow "校验刷机包..."
[ "$(get_md5 -c ${dl_url}/${dlfile}.md5sum ${dlfile})" != "$(get_md5 -l /${dlfile})" ] && _exit 1 "文件校验失败，请重试"
printStr green "下载完成！"

printStr yellow "刷机中，请勿断电..."
gunzip -c /${dlfile} | dd of=/dev/mmcblk0 bs=1024 seek=1024 status=progress conv=sync

[[ $? == 0 ]] && printStr yellow "
==============================================================
刷机已完成，请手工关闭电源并再次开启，等待初始化5-8分钟即可。
==============================================================" && reboot || \
	_exit 1 "刷机失败"

