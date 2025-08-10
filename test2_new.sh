#!/bin/bash
current_dir=$(pwd)

if [ -d "$current_dir/mpos-banyan" ]; then
	echo "检测到残留文件，正在备份......"
	sudo rm -rf $current_dir/mpos*

fi


df -h /
echo "检查上方磁盘信息，可用空间 < 1G，需要清空文件；"
echo
read -p "请输入注册码：" store_code
read -p "需要确认注册码，按任意键继续......" tmp

echo "$store_code" | grep -o '[0-9A-Za-z]' | tr -d '\n'
echo

read -p "再次确认注册码，按任意键继续......" tmp
echo "开始生成配置文件......"

echo "{\"sn\":\"$(echo "$store_code" | grep -o '[0-9A-Za-z]' | tr -d '\n')"\"} > $current_dir/iotInfo.json

sudo chmod 777 /root
	
sudo mkdir -p $current_dir/mpos-banyan/db /root/.mpos-release
	

sudo cp $current_dir/iotInfo.json $current_dir/mpos-banyan/db 
sudo cp $current_dir/iotInfo.json /root/.mpos-release

cd $current_dir/mpos-banyan

sudo wget --no-check-certificate https://myj-zcm-sdp.obs.cn-south-1.myhuaweicloud.com:443/mpos/update/script/run-updater.sh && sudo sh run-updater.sh


