# XPS15-9560-Catalina

> XPS15-9560 Hackintosh OpenCore Config.

 [中文](README.md) | [English](README_EN.md) 

## Integrated Kexts, EFI and so on Update 2020-08-04

1. Update `OpenCore` to 0.6.0;
2. Update All `Kernel Extensions` to the last version;
3. Fix some HDMI Issues;
4. Use RTC Fix to fix some boot issues;

For more details, please visit [changelog.md](https://github.com/jardenliu/XPS15-9560-Catalina/blob/OpenCore/changelog.md)

## Configuration

- CPU：Intel I7 7700HQ
- RAM：16G(8G\*2) 2400MHz DDR4
- HardDisk：Toshiba NVMe 512G
- WIFI：Dell Wireless 1830 (Also named as DW1830)
- Screen：4K(touch)

## What's not Working

1. Fingerprint sensor
2. Discrete graphic card, since macOS doesn't support Optimus technolog
3. ~~SD Card Reader~~
4. Intel Bluetooth only works after warm restart from Windows
5. Stock Wi-Fi Card Killer Wireless 1535
6. ~~USB Type-C Hotplug~~
7. Everything else works well

## Installation

Please refer to the detailed installation tutorial [Xiaomi Mi Notebook Pro High Sierra 10.13.6](https://www.tonymacx86.com/threads/guide-xiaomi-mi-notebook-pro-high-sierra-10-13-6.242724) or video tutorial [Xiaomi NoteBook PRO HACKINTOSH INSTALLATION GUIDE !!!](https://www.youtube.com/watch?v=72sPmkpxCvc).

If the tracpad doesn't work during installation, please plug a wired mouse or a wireless mouse projector before the installation. After the installation completes, open `Terminal.app` and type `sudo kextcache -i /`. Wait for the process ending and restart the device. Enjoy your trackpad!

## Warning

1. Don't turn on `FileValue Encryption`！！！
2. Before using `OpenCore`, please make sure you have disabled `CFGlock`! If you don't disable `CFGLock`, you need change values of `AppleXcpmCfgLock` and `IgnoreInvalidFlexRatio` must be `True` or you will boot failure.

## Other Configurations (CPU like i5 or others/1080P) note
If you are using a 1080P screen, please notice：
1. （not must）Use [xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi) to enable HiDPI；
2. Use `ProperTree` or `OpenCore Configurator` to edit `OC\Config.plist`, and change the `UIScale` part Value to `1`, or use `Other Text Editor (Such as NotePad)` and edit the `UIScale` part as after shows：
   ```
   <key>4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14</key>
	<dict>
		<key>UIScale</key>
		<data>AQ==</data>
	</dict>
   ```

If you are **not** using i7-7700HQ，please notice：
1. (**Must**)Please Insure you have already boot in your macOS normally；
2. (**Must**)Delete `OC\Kexts\CPUFriendDataProvider.kext`;
3. (**Must**)Use [stevezhengshiqi/one-key-cpufriend](https://github.com/stevezhengshiqi/one-key-cpufriend/blob/master/README_CN.md) to generate a new `CPUFriendDataProvider.kext` and place it in `OC\Kexts`;

## Work around

#### 1. fix fuzzy font

open `Terminal.app` and exec

```bash
$ defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
```

then reboot.

#### 2. Android USB Network Sharing

set `Post-install/HoRNDIS.kext` to `OC/kexts`, then edit `Kernel/Add` part in `OC/config.plist` with following content.
```
<dict>
	<key>BundlePath</key>
	<string>HoRNDIS.kext</string>
	<key>Comment</key>
	<string>Android Hotpot</string>
	<key>Enabled</key>
	<true/>
	<key>ExecutablePath</key>
	<string>Contents/MacOS/HoRNDIS</string>
	<key>MaxKernel</key>
	<string></string>
	<key>MinKernel</key>
	<string></string>
	<key>PlistPath</key>
	<string>Contents/Info.plist</string>
</dict>
```

#### 3. Unlock Root directory

```
sudo mount -uw /
```

#### 4. macOS Minor Update Suggestions

Rebuild kextcache after each macOS minor update, you can create a file named `rebuilt.command` containing the command `sudo kextcache -i /`. When an update is finished, you can directly run this file and input your password to rebuild kextcache. This can repair some minor issues such as `Brightness Control Failure` or `USB-C Device cannot work properly`.


### Wifi & Bluetooth Setting

1. Disable Power Nap，`System Preferences` -> `Energy Saver` disable all `Power Nap` options, and disable `Wake for Wi-Fi network access` option.
2. dissble Wake for Bluetooth, `System Preferences` -> `Bluetooth` -> `Advanced` disable all options.
3. For **_DW1830_** users, in order to imporve its performance and stability in Windows, please hit `Win+X+M` to open `Device Manager`, find the column Network Adapter and find `Dell Wireless 1830 802.11ac` and double click it, in the `Advanced` tab, find `Bluetooth Cooperation` and set it to `Disable`.  

## Contributor
[SilentSliver](https://github.com/SilentSliver)

## Special Thanks to

[RehabMan](https://github.com/RehabMan)、[Acidanthera](https://github.com/acidanthera)、[PMheart](https://github.com/PMheart)、[alexandred](https://github.com/alexandred)、[wmchris](https://github.com/wmchris)、[darkhandz](https://github.com/darkhandz)、[gunslinger23](https://github.com/gunslinger23)、[goodwin](https://github.com/goodwin) and so on.
