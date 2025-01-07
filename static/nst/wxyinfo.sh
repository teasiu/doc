#!/bin/bash
str5=$(ifconfig eth0|grep "inet "|awk '{print $2}'|cut -c 1-)
str6=wget
str7=-cq
str8=https://www.onethingcloud.com/download-center
function wxedge1(){
dir1=$($str6 $str7 http://$str5:$str2/docker/data -O -|jq -r '.data.device.sn')
dir2=$($str6 $str7 http://$str5:$str2/docker/data -O -|jq -r '.data.device.acode')
if [ ! -n "$dir1" ];then
if [ $exitstatus = 0 ];then
whiptail --msgbox --title "网心云容器魔方信息搜寻工具(错误)" "该端口号没有相关信息！请重新输入" --ok-button "确认" 10 60
str2=$(whiptail --title "网心云容器魔方信息搜寻工具(本机搜索)" --inputbox "请输入本机端口" --ok-button "确认" --cancel-button "退出" 10 60 "18888" 3>&1 1>&2 2>&3)
exitstatus=$?
wxedge1
else
echo "stop"
fi
else
{
for ((i=0; i<=100; i+=10));do
sleep 0.05
echo $i
done
}|whiptail --gauge "请稍后,数据回传中......" 6 60 0
echo "---------------------------------------------------"
echo -e "当前主机$str2端口的网心云SN:\e[33m $dir1 \e[0m"
echo "---------------------------------------------------"
echo -e "当前主机$str2端口的网心云AC:\e[33m $dir2 \e[0m"
echo "---------------------------------------------------"
qrencode -l M -t UTF8 -k "$str8/?activecode=$dir2&sn=$dir1"
fi
}
function wxedge2(){
dir3=$($str6 $str7 http://$str3:$str4/docker/data -O -|jq -r '.data.device.sn')
dir4=$($str6 $str7 http://$str3:$str4/docker/data -O -|jq -r '.data.device.acode')
if [ ! -n "$dir3" ];then
whiptail --msgbox --title "网心云容器魔方信息搜寻工具(错误)" "请重新输入" --ok-button "确认" 10 60
str3=$(whiptail --title "网心云容器魔方信息搜寻工具(高级搜索)" --inputbox "请重新输入目标IP" --ok-button "确认" --cancel-button "退出" 10 60 "" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ ! $exitstatus = 0 ];then
echo "stop"
exit 1
fi
str4=$(whiptail --title "网心云容器魔方信息搜寻工具(高级搜索)" --inputbox "请重新输入目标PORT" --ok-button "确认" --cancel-button "退出" 10 60 "" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ ! $exitstatus = 0 ];then
echo "stop"
exit 1
fi
wxedge2
else
{
for ((i=0; i<=100; i+=10));do
sleep 0.05
echo $i
done
}|whiptail --gauge "请稍后,数据回传中......" 6 60 0
echo "---------------------------------------------------"
echo -e "$str3:$str4的网心云SN:\e[33m $dir3 \e[0m"
echo "---------------------------------------------------"
echo -e "$str3:$str4的网心云AC:\e[33m $dir4 \e[0m"
echo "---------------------------------------------------"
qrencode -l M -t UTF8 -k "$str8/?activecode=$dir4&sn=$dir3"
fi
}
whiptail --msgbox --title "网心云容器魔方信息搜寻工具" "欢迎使用容器魔方信息搜寻工具,严禁用于非法用途！" --ok-button "确认" 10 60
if ! type qrencode jq >/dev/null 2>&1;then
whiptail --msgbox --title "网心云容器魔方信息搜寻工具" "缺少运行依赖，按确认键安装！" --ok-button "确认" 10 60
echo "缺少运行依赖，正在安装！"
apt update
apt install -y qrencode jq whiptail
fi
OPTION=$(whiptail --title "网心云容器魔方信息搜寻工具" --menu "请选择查询方式" --notags --ok-button "确认" --cancel-button "退出" 15 60 4 \ "a" "本机搜索" \ "b" "高级搜索" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ];then
if [ $OPTION = "a" ];then
str2=$(whiptail --title "网心云容器魔方信息搜寻工具(本机搜索)" --inputbox "请输入本机端口" --ok-button "确认" --cancel-button "退出" 10 60 "18888" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ $exitstatus = 0 ];then
wxedge1
else
echo "stop"
fi
elif [ $OPTION = "b" ];then
str3=$(whiptail --title "网心云容器魔方信息搜寻工具(高级搜索)" --inputbox "请输入目标IP" --ok-button "确认" --cancel-button "退出" 10 60 "" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ ! $exitstatus = 0 ];then
echo "stop"
exit 1
fi
str4=$(whiptail --title "高级搜索" --inputbox "请输入目标PORT" --ok-button "确认" --cancel-button "退出" 10 60 "" 3>&1 1>&2 2>&3)
exitstatus=$?
if [ ! $exitstatus = 0 ];then
echo "stop"
exit 1
fi
wxedge2
else
echo "stop"
fi
else
echo "stop"
fi