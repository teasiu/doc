#!/bin/bash
# scripts for ota update

dl_mirrors=("https://www.ecoo.top" "https://dl.ecoo.top")

filemodel=$(cat /etc/regname | cut -b 7-12)

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
        wget --no-check-certificate -q ${dl_mirrors[i]}/${file_url} -P $save_path && printStr green "Successed download" && return
    done
    
    _exit 1 "Download $file_url failed"
}

up_task() {
      printStr yellow "update: task"
      dl_get "update/soft_init/task-$(getconf LONG_BIT)" /tmp
      cp -af /tmp/task-$(getconf LONG_BIT) /usr/bin/task
      chmod +x /usr/bin/task
      dl_get "nst/nst.zip" /tmp
      rm /etc/bak/*
      unzip /tmp/nst.zip -d /etc/bak >/dev/null 2>&1
      printStr yellow "task任务程序已更新"
      printf $GREEN_LINE
}

up_task

_exit 0 "all upgraded successed"
