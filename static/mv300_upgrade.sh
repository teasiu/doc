#!/bin/bash

dlfile="mv300-99.flash.gz"  # 文件路径

echo "
+----------------------------------------------------------------------
| 海纳思系统hi3798mv300升级系统专用脚本温馨提示：
+----------------------------------------------------------------------
| 此专用脚本可以让你在任意版本的NAS系统下一键升级到20240201,
+----------------------------------------------------------------------
| 升级20250201版专用，原系统将完全清除，请注意保存资料。
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

model=$(cpuid)
platform=hi3798mv300

if [ "$(echo ${model})" != "$platform" ];then
	_exit 1 "本升级程序仅支持${platform}机型！"
fi

if [ $(whoami) != "root" ];then
	_exit 1 "请使用root权限切换系统命令！"
fi

is64bit=$(getconf LONG_BIT)
if [ "${is64bit}" != '64' ];then
	_exit 1 "抱歉, 当前系统切换版本不支持32位系统, 请使用64位系统!";
fi

promode=$(uname -r|cut -c 13-)
if [ $promode = 36010066 ];then
	_exit 1 "专业版用户请使用vipupgrade命令进行升级！"
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
get_mirror_url


printStr yellow "下载刷机包..."
dl_get update/system/${dlfile} /${dlfile}
printStr yellow "校验刷机包..."
[ "$(get_md5 -c ${NODE_URL}/update/system/${dlfile}.md5sum ${dlfile})" != "$(get_md5 -l /${dlfile})" ] && _exit 1 "文件校验失败，请重试"
printStr green "下载完成！"

printStr yellow "刷机中，请勿断电..."
gunzip -c /${dlfile} | dd of=/dev/mmcblk0 bs=1024 seek=1024 status=progress conv=sync

[[ $? == 0 ]] && printStr yellow "
==============================================================
刷机已完成，请手工关闭电源并再次开启，等待初始化5-8分钟即可。
==============================================================" && reboot || \
	_exit 1 "刷机失败"
