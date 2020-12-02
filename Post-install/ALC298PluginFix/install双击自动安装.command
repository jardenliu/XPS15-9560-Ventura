#!/bin/bash


path=${0%/*}
sudo mkdir -p /usr/local/bin
sudo cp -a "$path/ALCPlugFix" /usr/local/bin
sudo chmod 755 /usr/local/bin/ALCPlugFix
sudo chown root:wheel /usr/local/bin/ALCPlugFix
sudo cp -a "$path/hda-verb" /usr/local/bin
sudo chmod 755 /usr/local/bin/hda-verb
sudo chown root:wheel /usr/local/bin/hda-verb
sudo cp -a "$path/good.win.ALCPlugFix.plist" /Library/LaunchAgents
sudo chmod 644 /Library/LaunchAgents/good.win.ALCPlugFix.plist
sudo chown root:wheel /Library/LaunchAgents/good.win.ALCPlugFix.plist
sudo launchctl load /Library/LaunchAgents/good.win.ALCPlugFix.plist
echo '安装ALCPlugFix守护进程完成！'
echo '安装程序结束，请重启电脑！！！'
bash read -p '按任何键退出'
