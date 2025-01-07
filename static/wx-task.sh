#!/bin/bash
# scripts for onething_task_data install

dl_mirrors=("https://dl.ecoo.top" "https://www.ecoo.top")

readonly COLOUR_RESET='\e[0m'
declare -A COLORS
COLORS=(
    ["red"]='\e[91m'
    ["green"]='\e[32;1m' 
    ["yellow"]='\e[33m'
    ["grey"]='\e[90m'
)
readonly GREEN_LINE=" ${COLORS[green]}─────────────────────────────────────────────────────$COLOUR_RESET\n"

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

dl_get() {
    file_url=$1
    save_path=$2
    [ ! -d $save_path ] && mkdir -p $save_path
    for(( i=0;i<${#dl_mirrors[@]};i++));do
        echo "${dl_mirrors[i]}"
        wget -q --no-check-certificate ${dl_mirrors[i]}/${file_url} -P $save_path && printStr green "提示: 成功获取作者资源" && return
    done
    
    _exit 1 "提示: 资源获取失败，请联系作者"
}

check_os(){
	printStr yellow "提示: 检测系统版本中"
	if [ "$(hostname)" == "onething" ];then
	machine_id=$(cat /proc/msp/otp|grep -E '^00f0'|awk '{print $2 $3 $4 $5}')
	file_id=$(cat /usr/share/doc/ca-certificates/examples/ca-certificates-local/local/copyright2)
	[ "$machine_id" != "$file_id" ] && printStr red "提示: 系统非法篡改" && _exit 1 "提示: 程序终止" || printStr yellow "提示: 恭喜你检测通过，欢迎使用一键添加业务。"
	else
	printStr red "提示: 你的系统不符合网心云专用最新版，请到www.ecoo.top使用一键脚本切换或升级最新版。"
	_exit 1 "提示: 程序终止"
	fi
}
dl_task_data() {
	check_os
    if [ ! -d /opt/onething_task_data ]; then
    printStr yellow "onething_task_data: get progress"
	mkdir -p /opt/onething_task_data
	dl_get "onething_data.tar.gz" /opt/onething_task_data
	tar -zxf /opt/onething_task_data/onething_data.tar.gz -C /opt/onething_task_data
	rm /opt/onething_task_data/onething_data.tar.gz
	printStr yellow "onething_task_data: get successed"
	printf $GREEN_LINE
    fi
}

setup_onething_task_data() {
    if [ -d /opt/onething_task_data/onething_data ]; then
	printStr yellow "onething_task_data: setup progress"
	[ ! -f /mnt/disk/onething/storage/wxnode ] && printStr red "尚未安装网心云容器魔方程序" && _exit 1 "提示: 程序终止" || printStr yellow "onething_task_data: stetting up"
	systemctl stop docker
	rm -rf /mnt/disk/onething/storage/.onething_data/base_info
	cp -r /opt/onething_task_data/onething_data/base_info /mnt/disk/onething/storage/.onething_data
	rm -rf /mnt/disk/onething/storage/.onething_data/.info.Storage
	cp /opt/onething_task_data/onething_data/.info.Storage /mnt/disk/onething/storage/.onething_data
	rm -rf /mnt/disk/onething/storage/.onething_data/.nst
	cp /opt/onething_task_data/onething_data/.nst /mnt/disk/onething/storage/.onething_data
	rm -rf /opt/onething_task_data
	systemctl start docker
	printStr yellow "onething_task_data: setup successed"
	printf $GREEN_LINE
    fi
}

dl_task_data
setup_onething_task_data

_exit 0 "多业务模式已经添加完毕，请10分钟后检查业务情况。"
