#!/bin/bash

#  uninstall.command
#  ALCPlugFix-Swift
#  
#  Created by zty199 on 12/15/20
#  
 
# Clean up installs

sudo launchctl unload /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo rm /Library/LaunchAgents/com.black-dragon74.ALCPlugFix.plist
sudo rm /Library/Preferences/com.black-dragon74.ALCPlugFix.config.plist
sudo rm /usr/local/bin/ALCPlugFix
