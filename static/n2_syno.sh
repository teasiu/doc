#!/bin/bash

dl_url="https://dl.ecoo.top/synology"

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
        wget -q $1 -O - | grep $2 | awk '{print $1}'
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
| 黑群晖安装系统 N2 恩兔 专用脚本温馨提示：
+----------------------------------------------------------------------
| 此专用脚本可以让你在任意版本的NAS系统下一键安装黑群晖系统,
+----------------------------------------------------------------------
| N2 恩兔 专用，原系统将完全清除，请注意保存资料。
+----------------------------------------------------------------------
| 如果不确定，请按CTRL+C结束此脚本.
+----------------------------------------------------------------------
"
read -p "输入安装密码继续执行？[y/n]: " result
[ "${result^^}" != "123" ] && exit

model=$(cat /etc/regname | cut -b 7-12)
platform=mv200

if [ "$(echo ${model})" != "$platform" ];then
	_exit 1 "本升级程序仅支持hi1798${platform}机型！"
fi

if [ $(whoami) != "root" ];then
	_exit 1 "请使用root权限切换系统命令！"
fi

dlfile="n2-synology.flash.gz"

printStr yellow "下载刷机包...移动网速度稍慢，电信和联通速度很快"
wget -q --show-progress --no-check-certificate ${dl_url}/${dlfile} -O /${dlfile} || _exit 1 "下载失败，请重试"
printStr yellow "校验刷机包..."
[ "$(get_md5 -c ${dl_url}/${dlfile}.md5sum ${dlfile})" != "$(get_md5 -l /${dlfile})" ] && _exit 1 "文件校验失败，请重试"
printStr green "下载完成！"

printStr yellow "刷机中，请勿断电..."
gunzip -c /${dlfile} | dd of=/dev/mmcblk0 bs=1024 status=progress conv=sync

[[ $? == 0 ]] && printStr yellow "
================================================================
刷机完成，请手工关闭电源并再次开启，运行Synology Assistant查找并安装。
================================================================" && reboot || \
	_exit 1 "刷机失败"

