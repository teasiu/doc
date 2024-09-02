#!/bin/bash

print_status() {
    echo
    echo "## $1"
    echo
}

if test -t 1; then # if terminal
    ncolors=$(which tput > /dev/null && tput colors) # supports color
    if test -n "$ncolors" && test $ncolors -ge 8; then
        termcols=$(tput cols)
        bold="$(tput bold)"
        underline="$(tput smul)"
        standout="$(tput smso)"
        normal="$(tput sgr0)"
        black="$(tput setaf 0)"
        red="$(tput setaf 1)"
        green="$(tput setaf 2)"
        yellow="$(tput setaf 3)"
        blue="$(tput setaf 4)"
        magenta="$(tput setaf 5)"
        cyan="$(tput setaf 6)"
        white="$(tput setaf 7)"
    fi
fi

print_bold_deprecation() {
    title="$1"
    text="$2"

    echo
    echo "${bold}${red}================================================================================${normal}"
    echo "${bold}${red}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${normal}"
    echo "${bold}${red}================================================================================${normal}"
    echo
    echo -e "  ${bold}${yellow}${title}${normal}"
    echo
    echo -en "  ${text}"
    echo
    echo "${bold}${red}================================================================================${normal}"
    echo "${bold}${red}▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓${normal}"
    echo "${bold}${red}================================================================================${normal}"
}

repo_deprecation_warning() {
  print_bold_deprecation \
"                         ${underline}小雅播放程序安装指南${normal}                    " "\

  ${green}${bold}注意：你必须首先取得个人阿里云盘app的token！

  注意：32位token获得地址：https://csb.histb.com
  
  注意：280位token获得地址:https://alist.nn.ci/tool/aliyundrive/request.html
  
  注意：阿里云盘资源库文件夹id，请自行百度参考相关教程
  
  请完全准备好上述3个参数再运行安装本脚本。${normal}


                          ${underline}${bold}${yellow}小雅播放程序安装指南${normal}
                          
                    ${bold}${yellow}海纳思系统，我是小盒子，也是大世界${normal}
"

        echo
        echo "${cyan}${bold}10秒冷却时间等待中${normal}"
        echo
        sleep 10
        echo "${green}按回车键确认继续执行 (或者按 Ctrl-C 取消执行) ...${normal}"
        echo
        read wait
}

repo_deprecation_warning

if [ -x "$(command -v docker)" ]; then
  echo "${green}docker程序已安装 ...${normal}"
else
  install-docker.sh
fi

if [ -d /etc/xiaoya/mytoken.txt ]; then
	rm -rf /etc/xiaoya/mytoken.txt
fi
mkdir -p /etc/xiaoya
touch /etc/xiaoya/mytoken.txt
touch /etc/xiaoya/myopentoken.txt
touch /etc/xiaoya/temp_transfer_folder_id.txt

mytokenfilesize=$(cat /etc/xiaoya/mytoken.txt)
mytokenstringsize=${#mytokenfilesize}
if [ $mytokenstringsize -le 31 ]; then
	echo -e "\033[32m"
	read -p "输入你的阿里云盘 Token（32位长）: " token
	token_len=${#token}
	if [ $token_len -ne 32 ]; then
		echo "长度不对,阿里云盘 Token是32位长"
		echo -e "安装停止，请参考指南配置文件\nhttps://xiaoyaliu.notion.site/xiaoya-docker-69404af849504fa5bcf9f2dd5ecaa75f \n"
		echo -e "\033[0m"
		exit
	else	
		echo $token > /etc/xiaoya/mytoken.txt
	fi
	echo -e "\033[0m"
fi	

myopentokenfilesize=$(cat /etc/xiaoya/myopentoken.txt)
myopentokenstringsize=${#myopentokenfilesize}
if [ $myopentokenstringsize -le 279 ]; then
	echo -e "\033[33m"
        read -p "输入你的阿里云盘 Open Token（280位长或者335位长）: " opentoken
	opentoken_len=${#opentoken}
        if [[ $opentoken_len -ne 280 ]] && [[ $opentoken_len -ne 335 ]]; then
                echo "长度不对,阿里云盘 Open Token是280位长或者335位"
		echo -e "安装停止，请参考指南配置文件\nhttps://xiaoyaliu.notion.site/xiaoya-docker-69404af849504fa5bcf9f2dd5ecaa75f \n"
		echo -e "\033[0m"
                exit
        else
        	echo $opentoken > /etc/xiaoya/myopentoken.txt
	fi
	echo -e "\033[0m"
fi

folderidfilesize=$(cat /etc/xiaoya/temp_transfer_folder_id.txt)
folderidstringsize=${#folderidfilesize}
if [ $folderidstringsize -le 39 ]; then
	echo -e "\033[36m"
        read -p "输入你的阿里云盘转存目录folder id: " folderid
	folder_id_len=${#folderid}
	if [ $folder_id_len -ne 40 ]; then
                echo "长度不对,阿里云盘 folder id是40位长"
		echo -e "安装停止，请参考指南配置文件\nhttps://xiaoyaliu.notion.site/xiaoya-docker-69404af849504fa5bcf9f2dd5ecaa75f \n"
		echo -e "\033[0m"
                exit
        else
        	echo $folderid > /etc/xiaoya/temp_transfer_folder_id.txt
	fi	
	echo -e "\033[0m"
fi

#echo "new" > /etc/xiaoya/show_my_ali.txt
if command -v ifconfig &> /dev/null; then
        localip=$(ifconfig -a|grep inet|grep -v 172.17 | grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"|head -n1)
else
        localip=$(ip address|grep inet|grep -v 172.17 | grep -v 127.0.0.1|grep -v inet6|awk '{print $2}'|tr -d "addr:"|head -n1|cut -f1 -d"/")
fi

if [ $1 ]; then
if [ $1 == 'host' ]; then
	if [ ! -s /etc/xiaoya/docker_address.txt ]; then
		echo "http://$localip:6789" > /etc/xiaoya/docker_address.txt
	fi	
	docker stop xiaoya-hostmode
	docker rm xiaoya-hostmode
	docker rmi xiaoyaliu/alist:hostmode
	docker pull xiaoyaliu/alist:hostmode
	if [[ -f /etc/xiaoya/proxy.txt ]] && [[ -s /etc/xiaoya/proxy.txt ]]; then
        	proxy_url=$(head -n1 /etc/xiaoya/proxy.txt)
		docker run -d --env HTTP_PROXY="$proxy_url" --env HTTPS_PROXY="$proxy_url" --env no_proxy="*.aliyundrive.com" --network=host -v /etc/xiaoya:/data --restart=always --name=xiaoya-hostmode xiaoyaliu/alist:hostmode
	else	
		docker run -d --network=host -v /etc/xiaoya:/data --restart=always --name=xiaoya-hostmode xiaoyaliu/alist:hostmode
	fi	
	exit
fi
fi

if [ ! -s /etc/xiaoya/docker_address.txt ]; then
        echo "http://$localip:5678" > /etc/xiaoya/docker_address.txt
fi
docker stop xiaoya
docker rm xiaoya
docker rmi registry.cn-hangzhou.aliyuncs.com/histb/xiaoya:latest 
docker pull registry.cn-hangzhou.aliyuncs.com/histb/xiaoya:latest
if [[ -f /etc/xiaoya/proxy.txt ]] && [[ -s /etc/xiaoya/proxy.txt ]]; then
	proxy_url=$(head -n1 /etc/xiaoya/proxy.txt)
       	docker run -d -p 5678:80 -p 2345:2345 -p 2346:2346 --env HTTP_PROXY="$proxy_url" --env HTTPS_PROXY="$proxy_url" --env no_proxy="*.aliyundrive.com" -v /etc/xiaoya:/data --restart=always --name=xiaoya registry.cn-hangzhou.aliyuncs.com/histb/xiaoya:latest
else
	docker run -d -p 5678:80 -p 2345:2345 -p 2346:2346 -v /etc/xiaoya:/data --restart=always --name=xiaoya registry.cn-hangzhou.aliyuncs.com/histb/xiaoya:latest
fi	

