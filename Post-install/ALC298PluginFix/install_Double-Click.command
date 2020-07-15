#!/bin/bash


path=${0%/*}
sudo mount -uw /
sudo cp -a "$path/ALCPlugFix" /usr/bin
sudo chmod 755 /usr/bin/ALCPlugFix
sudo chown root:wheel /usr/bin/ALCPlugFix
sudo cp -a "$path/hda-verb" /usr/bin
sudo chmod 755 /usr/bin/hda-verb
sudo chown root:wheel /usr/bin/hda-verb
sudo cp -a "$path/good.win.ALCPlugFix.plist" /Library/LaunchDaemons/
sudo chmod 644 /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo chown root:wheel /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo launchctl load /Library/LaunchDaemons/good.win.ALCPlugFix.plist
echo '安装ALCPlugFix守护进程完成！'
echo 'Installing ALCPlugFix Successfully! '
echo '重建缓存中，请稍候……'
echo 'Rebulding Kext Cache, please wait for a minite......'
sudo kextcache -i /
echo '安装程序结束，请重启电脑！！！'
echo 'Installation Program has finished. Please reboot your computer to take effect'
bash read -p '按任何键退出/Please press any key to exit'
