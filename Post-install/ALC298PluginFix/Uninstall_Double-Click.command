#!/bin/bash


path=${0%/*}
sudo mount -uw /
sudo launchctl remove /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo rm -rf /Library/LaunchDaemons/good.win.ALCPlugFix.plist
sudo rm -rf /usr/bin/ALCPlugFix
sudo rm -rf /usr/bin/hda-verb

echo '卸载ALCPlugFix守护进程完成！'
echo 'Uninstalling ALCPlugFix Successfully! '
echo '重建缓存中，请稍候……'
echo 'Rebulding Kext Cache, please wait for a minite......'
sudo kextcache -i /
echo '安装程序结束，请重启电脑！！！'
echo 'Installation Program has finished. Please reboot your computer to take effect'
bash read -p '按任何键退出/Please press any key to exit'
