#!/bin/bash

declare -A dl_mirrors
dl_mirrors=(
    ["neimeng"]="https://node.histb.com:9088/update/system/s805"
    ["hunan"]="https://node3.histb.com:9088/update/system/s805"
    ["hongkong"]="https://node2.histb.com/update/system/s805"
    ["dl"]="https://dl.ecoo.top/update/system/s805"
)

declare -a system_versions
system_versions=(
    [1]='海纳思NAS公开版固件 amlogic-backup-32.gz'
    [2]='海纳思宝塔专用固件 Ubuntu-bt-s805.gz'
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

get_mirror_url() {
	tmp_file=/dev/shm/net_test.pl
	[ -f "${tmp_file}" ] && rm -f ${tmp_file}
	touch $tmp_file
	
    for mirror_name in ${!dl_mirrors[*]}; do
        mirror_url=${dl_mirrors[$mirror_name]}
		NODE_CHECK=$(curl -k --connect-timeout 3 -m 3 2>/dev/null -w "%{http_code} %{time_total}" ${mirror_url}/net_test|xargs)
		NODE_STATUS=$(echo ${NODE_CHECK}|awk '{print $2}')
		TIME_TOTAL=$(echo ${NODE_CHECK}|awk '{print $3 * 1000 }'|cut -d '.' -f 1)
		if [ "${NODE_STATUS}" == "200" ];then
            echo "$TIME_TOTAL $mirror_name $mirror_url" >> $tmp_file
		fi
    done

	NODE_NAME=$(cat $tmp_file|sort -g -t " " -k 1|head -n 1|awk '{print $2}')
	NODE_URL=$(cat $tmp_file|sort -g -t " " -k 1|head -n 1|awk '{print $3}')
	printStr green "using mirror: $NODE_NAME"
	rm -f $tmp_file
}

get_md5() {
    case $1 in
    -c)
        shift
        wget -4 -q --no-check-certificate $1 -O - | grep $2 | awk '{print $1}'
        ;;
    -l)
        shift
        [ ! -f "$1" ] && return 1
        md5sum $1 2> /dev/null | awk '{print $1}'
        ;;
    esac
}
if grep -qs '/dev/mmcblk1p3' /proc/mounts; then
    echo "/dev/mmcblk1p3 已经挂载."
else
    # 如果没有挂载，则尝试挂载到 /backupbox
    echo "未找到 /dev/mmcblk1p3 的挂载点，正在尝试挂载..."
    mkdir -p /backupbox  # 确保目录存在
    mount /dev/mmcblk1p3 /backupbox  # 尝试挂载
    if [ $? -eq 0 ]; then
        echo "/dev/mmcblk1p3 成功挂载到 /backupbox."
    else
        _exit 1 "系统恢复机制不存在，建议按照官方网站 ecoo.top 教程重新刷机！"
    fi
fi
echo "
+----------------------------------------------------------------------
| 海纳思系统固件切换专用脚本温馨提示：
+----------------------------------------------------------------------
| 切换后原系统将完全清除，请注意保存资料。
+----------------------------------------------------------------------
| 如果不确定，请按CTRL+C结束此脚本.
+----------------------------------------------------------------------
"

if [ $(whoami) != "root" ];then
	_exit 1 "请使用root权限切换系统命令！"
fi

date_20230818=$(date -d '20230818' +%s)
if [ $(date -d $(cat /etc/nasversion) +%s) -lt ${date_20230818} ]; then
	_exit 1 "请升级到 20230818 或更新的版本后再执行此命令！"
fi

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
get_mirror_url
wget -4 -q --show-progress --no-check-certificate ${NODE_URL}/${dlfile} -O /backupbox/amlogic-backup-32.gz || _exit 1 "下载失败，请重试"
printStr yellow "校验刷机包..."
[ "$(get_md5 -c ${NODE_URL}/${dlfile}.md5sum ${dlfile})" != "$(get_md5 -l /backupbox/amlogic-backup-32.gz)" ] && _exit 1 "文件校验失败，请重试"

printStr green "下载完成！"
recoverbackup -a
