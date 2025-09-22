#!/bin/bash
# scripts for ota update

dl_mirrors=("https://www.ecoo.top" "https://www.hinas.top")

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
        wget --no-check-certificate -q ${dl_mirrors[i]}/${file_url} -P $save_path && printStr green "Successed download ${file_url}" && return
    done
    
    _exit 1 "Download $file_url failed"
}

get_cpuid() {
    if [ ! -f /usr/bin/cpuid ]; then
      printStr yellow "update: update cpuid"
      dl_get "update/soft_init/cpuid-$(getconf LONG_BIT)" /tmp
      cp /tmp/cpuid-$(getconf LONG_BIT) /usr/bin/cpuid
      chmod +x /usr/bin/cpuid
    fi
    filemodel=$(cpuid | cut -c 7-12)
}

ota_script() {
    if [ -f /usr/bin/nasupdate ]; then
      rm /usr/bin/nasupdate
    fi
cat <<EOF > /usr/bin/nasupdate
#!/bin/bash
    
bash <(curl https://ecoo.top/ota.sh)

EOF

chmod +x /usr/bin/nasupdate
printStr yellow "ota_script: upgraded"
printf $GREEN_LINE

}

up_histb() {
printStr yellow "update: update histb"
rm -f /usr/sbin/histb /usr/bin/histb
dl_get "update/soft_init/histb-$(getconf LONG_BIT)" /tmp
cp /tmp/histb-$(getconf LONG_BIT) /usr/sbin/histb
chmod +x /usr/sbin/histb
printStr yellow "histb code updated"
printf $GREEN_LINE
}

up_vipupgrade() {
      printStr yellow "update: update vipupgrade"
      dl_get "update/soft_init/vipupgrade-$(getconf LONG_BIT)" /tmp
      mv /tmp/vipupgrade-$(getconf LONG_BIT) /usr/sbin/vipupgrade
      chmod +x /usr/sbin/vipupgrade
      printStr yellow "vipupgrade updated"
      printf $GREEN_LINE
}

up_kaitongfrp() {
	if [ -f /usr/sbin/kaitong-frpc ]; then
		rm /usr/sbin/kaitong-frpc
	fi
	if [ -f /usr/bin/kaitong-frp ]; then
		rm /usr/bin/kaitong-frp
	fi
	printStr yellow "update: update script"
	if [ -f /usr/bin/setup-bt ]; then
		dl_get "update/soft_init/kaitong-frp-bt-$(getconf LONG_BIT)" /tmp
		mv /tmp/kaitong-frp-bt-$(getconf LONG_BIT) /usr/bin/kaitong-frp
	else
		dl_get "update/soft_init/kaitong-frp-$(getconf LONG_BIT)" /tmp
		mv /tmp/kaitong-frp-$(getconf LONG_BIT) /usr/bin/kaitong-frp
	fi
	chmod +x /usr/bin/kaitong-frp
	printStr yellow "scripts updated"
	printf $GREEN_LINE
}

up_od4b() {
	if [ -f /usr/bin/onedrive-public ]; then
		rm /usr/bin/onedrive-public
	fi
    if [ ! -f /usr/bin/onedrive-public ]; then
      printStr yellow "update: update script"
      dl_get "update/soft_init/onedrive-public-$(getconf LONG_BIT)" /tmp
      cp /tmp/onedrive-public-$(getconf LONG_BIT) /usr/bin/onedrive-public
      chmod +x /usr/bin/onedrive-public
      printStr yellow "scripts updated"
      printf $GREEN_LINE
    fi
}

up_nasupgrade() {
	if [ -f /usr/sbin/nasupgrade ]; then
		rm /usr/sbin/nasupgrade
	fi
	if [ -f /usr/bin/nasupgrade ]; then
		rm /usr/bin/nasupgrade
	fi
	exhostname=$(cat /etc/hostname)
	if [ "$exhostname" != "hinas" ]; then
	      printStr yellow "update: update nasupgrade"
	      dl_get "${filemodel}_upgrade.sh" /tmp
	      cp /tmp/${filemodel}_upgrade.sh /usr/bin/nasupgrade
	      chmod +x /usr/bin/nasupgrade
	      printStr yellow "scripts updated"
	      printf $GREEN_LINE
	fi
}

up_chatgpt() {
printStr yellow "update: update chatgpt"
dl_get "update/soft_init/install-chatgpt.sh" /tmp
cp /tmp/install-chatgpt.sh /usr/bin/
chmod +x /usr/bin/install-chatgpt.sh
printStr yellow "chatgpt script updated"
printf $GREEN_LINE
}

up_aliyunpan() {
printStr yellow "update: update aliyunpan"
dl_get "update/soft_init/aliyunpan-$(getconf LONG_BIT)" /tmp
cp /tmp/aliyunpan-$(getconf LONG_BIT) /usr/bin/aliyunpan
chmod +x /usr/bin/aliyunpan
printStr yellow "aliyunpan script updated"
printf $GREEN_LINE
}

up_alist() {
if [ -f /usr/bin/update-alist ]; then
	rm /usr/bin/update-alist
fi
printStr yellow "update: update alist"
dl_get "update/soft_init/update-alist.sh" /tmp
mv /tmp/update-alist.sh /usr/bin/update-alist
chmod +x /usr/bin/update-alist
printStr yellow "alist script updated"
printf $GREEN_LINE
}

up_justlist() {
if [ -f /usr/bin/install-justlist.sh ]; then
	rm /usr/bin/install-justlist.sh
fi
printStr yellow "update: install-justlist.sh"
dl_get "update/soft_init/install-justlist.sh" /tmp
mv /tmp/install-justlist.sh /usr/bin/install-justlist.sh
chmod +x /usr/bin/install-justlist.sh
printStr yellow "install-justlist.sh script updated"
printf $GREEN_LINE
}

up_TestNAT() {
      printStr yellow "update: TestNAT"
      dl_get "update/soft_init/ksp2p/test-nat.sh" /tmp
      mv /tmp/test-nat.sh /usr/bin/test-nat.sh
      chmod +x /usr/bin/test-nat.sh
      printStr yellow "scripts updated"
      printf $GREEN_LINE
}

up_ksrun() {
	ARCH=$(dpkg --print-architecture)
	printStr yellow "update: ksp2p-run"
	dl_get "update/soft_init/ksp2p/ksp2p-run-${ARCH}" /tmp
	mv /tmp/ksp2p-run-${ARCH} /usr/bin/ksp2p-run
	chmod +x /usr/bin/ksp2p-run
	printStr yellow "scripts updated"
	printf $GREEN_LINE
}

up_deb() {
	ARCH=$(dpkg --print-architecture)
	printStr yellow "update: histb-deb"
	dl_get "update/soft_init/histb-deb-${ARCH}" /tmp
	mv /tmp/histb-deb-${ARCH} /usr/sbin/histb-deb
	chmod +x /usr/sbin/histb-deb
	printStr yellow "histb-deb scripts updated"
	printf $GREEN_LINE
}

up_installdisk() {
	ARCH=$(dpkg --print-architecture)
	printStr yellow "update: install-harddisk"
	dl_get "update/soft_init/install-harddisk-${ARCH}" /tmp
	mv /tmp/install-harddisk-${ARCH} /usr/bin/install-harddisk
	chmod +x /usr/bin/install-harddisk
	printStr yellow "install-harddisk scripts updated"
	printf $GREEN_LINE
}

up_pulldocker() {
	ARCH=$(dpkg --print-architecture)
	printStr yellow "update: pulldocker"
	dl_get "update/soft_init/pulldocker-${ARCH}" /tmp
	mv /tmp/pulldocker-${ARCH} /usr/bin/pulldocker
	chmod +x /usr/bin/pulldocker
	printStr yellow "scripts updated"
	printf $GREEN_LINE
}
get_cpuid
#ota_script
up_histb
up_deb
up_vipupgrade
up_kaitongfrp
up_nasupgrade
#up_chatgpt
#up_alist
#up_justlist
#up_TestNAT
#up_ksrun
up_pulldocker
up_installdisk

_exit 0 "all upgraded successed"
