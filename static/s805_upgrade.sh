#!/bin/bash

: ${mirrors_source:=${MIRRORS_SOURCE:-"https://hi.ecoo.top/mirrors-update.txt"}}

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
	
    curl -sL ${mirrors_source} | while read mirror_name mirror_url; do
		NODE_CHECK=$(curl -k --connect-timeout 3 -m 3 2>/dev/null -w "%{http_code} %{time_total}" ${mirror_url}/net_test|xargs)
		NODE_STATUS=$(echo ${NODE_CHECK}|awk '{print $2}')
		TIME_TOTAL=$(echo ${NODE_CHECK}|awk '{print $3 * 1000 }'|cut -d '.' -f 1)
		if [ "${NODE_STATUS}" == "200" ];then
            echo "$TIME_TOTAL $mirror_name $mirror_url" >> $tmp_file
		fi
    done
    
    if [ "$(cat $tmp_file)" = "" ]; then
        _exit 1 "not found any useful mirror site"
    fi
    
	NODE_NAME=$(cat $tmp_file|sort -g -t " " -k 1|head -n 1|awk '{print $2}')
	NODE_URL=$(cat $tmp_file|sort -g -t " " -k 1|head -n 1|awk '{print $3}')
	printStr green "using mirror: $NODE_NAME"
	rm -f $tmp_file
}

get_url_ok() {
    file_uri=$1
    local urls=()
    url_index=0
    url_status=$(curl -k -sL --head ${NODE_URL}/${file_uri} | head -n 1 | awk '{print $2}')
    if [ "$url_status" != "404" ];then
        echo ${NODE_URL}/${file_uri}
    fi
}

dl_get() {
    file_uri=$1
    save_path=$2
    shift 2
    
    local url_ok=$(get_url_ok $file_uri)
    if [ "$url_ok" != "" ];then
		for(( t=0;t<3;t++));do
			if [ $t -gt 0 ];then
				printStr yellow "下载重试... ($NODE_NAME)"
			else
				printStr yellow "下载$(basename $save_path)...($NODE_NAME)"
			fi
			wget -q --no-check-certificate --show-progress $* ${url_ok} -O $save_path && return
		done
        _exit 1 "下载失败，请检查网络"
    else
        _exit 1 "下载链接 ${NODE_URL}/${file_uri} 不存在，请稍后再试"
    fi
}

get_md5() {
    case $1 in
    -c)
        shift
        local md5_url=$1
        for(( t=0;t<3;t++));do
            url_md5=$(wget -q --no-check-certificate ${md5_url} -O - | cat)
            if [ "$url_md5" != "" ]; then
                echo $url_md5 | head -n 1 | awk '{print $1}' && return
            fi
        done
        echo "failed"
        ;;
    -l)
        shift
        [ ! -f "$1" ] && return 1
        md5sum $1 2> /dev/null | awk '{print $1}'
        ;;
    esac
}

check_md5() {
	file_name=$(basename ${1})
    md5_url=($(get_url_ok ${1}.md5sum))
    [ "${md5_url}" = "" ] && clear_exit "校验文件不存在，请稍后重试"
    md5=$(get_md5 -c ${md5_url})
    [ "$md5" = "failed" ] && clear_exit "校验文件下载失败，请稍后重试"
    [ "$md5" != "$(get_md5 -l /backupbox/${file_name})" ] && clear_exit "文件校验失败，请重试"
    printStr green "校验成功"
}

get_sha256() {
    case $1 in
    -c)
        shift
        wget -q $1 -O - | grep $2 | awk '{print $1}'
    ;;
    -l)
        shift
        [ ! -f "$1" ] && return 1
        sha256sum $1 2> /dev/null | awk '{print $1}'
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
| 海纳思系统玩客云S805升级系统专用脚本温馨提示：
+----------------------------------------------------------------------
| 此专用脚本可以让你在任意版本的NAS系统下一键升级到20231201,
+----------------------------------------------------------------------
| 升级专用，原系统将完全清除，请注意保存资料。
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
printStr yellow "选择镜像服务器..."
get_mirror_url
dl_backup_file="amlogic-backup-32.gz"
dl_get update/system/s805/${dl_backup_file} /backupbox/${dl_backup_file}
printStr yellow "校验刷机包..."
check_md5 update/system/s805/${dl_backup_file}

recoverbackup -a
