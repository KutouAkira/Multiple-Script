#!/usr/bin/env bash

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"

start_menu(){
clear
echo && echo -e " Akira Installation Script 
 ————————————— 安装模块 —————————————
 ${Green_font_prefix}1.${Font_color_suffix} 安装 v2ray
 ${Green_font_prefix}2.${Font_color_suffix} 安装 TCP加速
 ${Green_font_prefix}3.${Font_color_suffix} 安装 caddy
 ${Green_font_prefix}4.${Font_color_suffix} 安装 Node Media Server
 ${Green_font_prefix}5.${Font_color_suffix} 安装 ffmpeg
 ${Green_font_prefix}6.${Font_color_suffix} 安装 宝塔面板
 ${Green_font_prefix}7.${Font_color_suffix} 运行VPS测试
 ${Green_font_prefix}8.${Font_color_suffix} 退出脚本
" 
read -p " 请输入数字 [1-8]:" num
case "$num" in
	1)
	install_v2
    read -p "按Enter继续"
    start_menu
	;;
	2)
	install_tcp
    read -p "按Enter继续"
    start_menu
	;;
	3)
	install_caddy
    read -p "按Enter继续"
    start_menu
	;;
	4)
	install_nms
    read -p "按Enter继续"
    start_menu
	;;
	5)
	install_ff
    read -p "按Enter继续"
    start_menu
	;;
	6)
	install_bt
    read -p "按Enter继续"
    start_menu
	;;
	7)
    test_vps
    read -p "结果已保存至/root/test.log,按Enter继续"
	exit 1
	;;
	8)
    clear
	exit 1
	;;
	*)
	clear
	echo -e "请输入正确数字 [0-10]"
	sleep 3s
	start_menu
	;;
esac
}

check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
}

install_v2(){
    if [[ "${release}" == "centos" ]]; then
        systemctl disable firewalld
        systemctl stop firewalld
    fi
    bash <(curl -s -L https://git.io/v2ray.sh)
}

install_tcp(){
    bash <(curl -L -s https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh)
}

install_caddy(){
    wget -N --no-check-certificate https://raw.githubusercontent.com/KutouAkira/Multiple-Script/master/caddy_install.sh && chmod +x caddy_install.sh && bash caddy_install.sh install http.filebrowser
}

install_nms(){
    if [[ "${release}" == "centos" ]]; then
        yum install -y epel-release 
        yum update -y
        yum install -y nodejs
        yum install -y git
    else
        apt-get -y update
        apt-get -y upgrade
        apt-get install -y nodejs
        apt-get install -y npm
        apt-get install -y git
    fi
    git clone https://github.com/illuspas/Node-Media-Server
    mv Node-Media-Server nms
    cd nms
    npm i
}

install_ff(){
    if [[ "${release}" == "centos" ]]; then 
        yum update -y
    else
        apt-get -y update
        apt-get -y upgrade
        apt-get install -y ffmpeg
    fi
    wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz
    tar -xvJf ffmpeg-release-amd64-static.tar.xz
    cd ffmpeg*
    cp -f ff* /usr/bin
}

install_bt(){
    wget -O install.sh http://download.bt.cn/install/install_6.0.sh && bash install.sh
}

test_vps(){
    wget https://raw.githubusercontent.com/chiakge/Linux-Server-Bench-Test/master/linuxtest.sh -N --no-check-certificate && bash linuxtest.sh
}

check_sys
start_menu
