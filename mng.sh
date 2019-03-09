#!/usr/bin/env bash

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"

start_menu(){
clear
echo && echo -e " Akira Management Script
 ———————————— caddy管理模块 ————————————
 ${Green_font_prefix}1.${Font_color_suffix} 启动caddy
 ${Green_font_prefix}2.${Font_color_suffix} 重启caddy
 ${Green_font_prefix}3.${Font_color_suffix} 查看caddy状态
 ${Green_font_prefix}4.${Font_color_suffix} 查看caddy运行日志
 ${Green_font_prefix}5.${Font_color_suffix} 停止caddy
 ———————————————————————————————
 ${Green_font_prefix}6.${Font_color_suffix} 运行VPS测试
 ${Green_font_prefix}7.${Font_color_suffix} 退出脚本
" 
read -p " 请输入数字 [1-7]:" num
case "$num" in
    1)
	start_caddy
    read -p "按Enter继续"
    start_menu
	;;
    2)
	restart_caddy
    read -p "按Enter继续"
    start_menu
	;;
    3)
	status_caddy
    read -p "按Enter继续"
    start_menu
	;;
    4)
	info_caddy
    read -p "按Enter继续"
    start_menu
	;;
    5)
	stop_caddy
    read -p "按Enter继续"
    start_menu
	;;
	6)
    test_vps
    read -p "按Enter继续"
	exit 1
	;;
    7)
    clear
	exit 1
	;;
	*)
	clear
	echo -e "请输入正确数字 [0-16]"
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

start_caddy(){
    /etc/init.d/caddy start
}

restart_caddy(){
    /etc/init.d/caddy restart
}

status_caddy(){
    /etc/init.d/caddy status
}

info_caddy(){
    tail /tmp/caddy.log
}

stop_caddy(){
    /etc/init.d/caddy stop
}
    systemctl stop nginx
    systemctl status nginx | grep "Active"
}

test_vps(){
    wget https://raw.githubusercontent.com/chiakge/Linux-Server-Bench-Test/master/linuxtest.sh -N --no-check-certificate && bash linuxtest.sh
}

check_sys
start_menu
