#!/bin/bash

dl_url="https://dl.ecoo.top/amlogic"

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
| 海纳思系统玩客云S805升级系统专用脚本温馨提示：
+----------------------------------------------------------------------
| 此专用脚本可以让你在任意版本的NAS系统下一键升级到20230401,
+----------------------------------------------------------------------
| 升级202304版专用，原系统将完全清除，请注意保存资料。
+----------------------------------------------------------------------
| 如果不确定，请按CTRL+C结束此脚本.
+----------------------------------------------------------------------
"
read -p "继续执行？[y/n]: " result
[ "${result^^}" != "Y" ] && exit

if [ $(whoami) != "root" ];then
	_exit 1 "请使用root权限切换用户！"
fi
if [ ! -d /backupbox ];then
	_exit 1 "系统恢复机制不存在，建议按照官方网站 ecoo.top 教程重新刷机！"
fi
dlfile="amlogic-backup-32-base.gz"

printStr yellow "下载刷机包...移动网速度稍慢，电信和联通速度很快"
wget -q --show-progress --no-check-certificate ${dl_url}/${dlfile} -O /backupbox/amlogic-backup-32.gz || _exit 1 "下载失败，请重试"
printStr yellow "校验刷机包..."
[ "$(get_md5 -c ${dl_url}/${dlfile}.md5sum ${dlfile})" != "$(get_md5 -l /backupbox/amlogic-backup-32.gz)" ] && _exit 1 "文件校验失败，请重试"
printStr green "下载完成！"
recoverbackup
