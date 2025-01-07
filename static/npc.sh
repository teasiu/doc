#!/bin/bash
# scripts for npc install

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
        wget --no-check-certificate ${dl_mirrors[i]}/${file_url} -P $save_path && printStr green "Successed download ${file_url}" && return
    done
    
    _exit 1 "Download $file_url failed"
}

dl_npc() {
    if [ ! -d /opt/npc ]; then
	printStr yellow "npc: adding new directry"
	mkdir -p /opt/npc
	dl_get "update/soft_init/npc-$(getconf LONG_BIT)" /opt/npc
	mv /opt/npc/npc-$(getconf LONG_BIT) /opt/npc/npc
	chmod +x /opt/npc/npc
	printStr yellow "npc: download successed"
	printf $GREEN_LINE
    fi
}

setup_npc() {
    if [ -f /opt/npc/npc ]; then
	printStr yellow "npc: setup progress"
	read -p "输入报名的手机号码:" phone
	cd /opt/npc
	./npc install -server=3.101.108.218:8024 -vkey=$phone
	sleep 2
	npc start
	printStr yellow "npc: setup successed"
	printStr yellow "npc: 已经成功安装并运行"
	printStr yellow "npc: 请访问你的测试域名"
	printf $GREEN_LINE
    fi
}

dl_npc
setup_npc

_exit 0 "all upgraded successed"
