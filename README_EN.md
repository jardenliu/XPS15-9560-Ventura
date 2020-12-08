# XPS15-9560-BigSur

> XPS15-9560 Hackintosh OpenCore Config.

 [中文](README.md) | [English](README_EN.md) 

 ## Warning
 - Known bug: The Refresh-Rate is only 48Hz at 4K resolution
 - **Now only OC branch supports macOS Big Sur**
 -  If yours' processor is `Core i5` or yours' screen resolution is `1080P`, please read the [Other Configurations (CPU like i5 or others/1080P) Note](##-Other-Configurations-(CPU-like-i5-or-others/-1080P)-Note)

## Integrated Kexts, EFI and so on Update 2020-12-7

1. Update `OpenCore` to 0.6.04
2. Update All `Kernel Extensions` to the latest version;
3. Support BOTH `macOS Big Sur 11.0.1` and `macOS Catalina 10.15.7 19H12`
4. Fixed battery && trackpad setting

For more details, please visit [changelog.md](https://github.com/jardenliu/XPS15-9560-BigSur/blob/OpenCore/changelog.md)

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
   
8. In macOS Big Sur, the miniDisplayPort video output of some dock like `Dell WD15` could only output 1080P resolution due to macOS Big Sur (the HDMI port works fine, all ports works fine in Catalina via this OC bootloader).

## Installation

Please refer to the detailed installation tutorial [Xiaomi Mi Notebook Pro High Sierra 10.13.6](https://www.tonymacx86.com/threads/guide-xiaomi-mi-notebook-pro-high-sierra-10-13-6.242724) or video tutorial [Xiaomi NoteBook PRO HACKINTOSH INSTALLATION GUIDE !!!](https://www.youtube.com/watch?v=72sPmkpxCvc).

## From Clover to OpenCore
To make macOS Big Sur working for XPS 15 9560, it is highly recommended to switch from Clover to OpenCore

Steps:
1. Download OpenCore Configurator(OCG)与Clover Configurator(CCG) and make necessary backups.
2. Unlock `CFG Lock` or change other values to make OpenCore ready for macOS, see [Warning](##Warning) for details.
3. Download the zip file that fits your model from release, extract the zip file and put it into `EFI partition/EFI/`. 
4. If you decide to keep your serial number you have used in Clover, you should read the old serial number info using CCG and restore these data manually. Otherwise, you could re-generate a series of SN info via OCG, the model should be `MacBookPro14,3`, remember check if the generated has been occupied.**IF YOU CHANGE YOUR SN, PLEASE LOGOUT YOUR APPLE ID IN SYSTEM PREFERENCE IN ADVANCE**
5. If yours' internal screen resolution is  `1080P`, delete the injected EDID in config.plist, see `OtherConfigurationNote`.
6. Restart after you configurated OpenCore properly, then add OpenCore.efi to the Boot Sequence in BIOS settings and boot via OpenCore.
7. If you cannot login to App Store, hit `Space` in OpenCore bootloader menu and choose `Reset NVRAM`.


If the tracpad doesn't work during installation, please plug a wired mouse or a wireless mouse projector before the installation.

## Warning

1. Don't turn on `FileValue Encryption`！！！
2. Before using `OpenCore`, please make sure you have disabled `CFGlock`! If you don't disable `CFGLock`, you need change values of `AppleXcpmCfgLock` and `IgnoreInvalidFlexRatio` must be `True` or you will boot failure.

## Other Configurations (CPU like i5 or others/1080P) Note

If you are using a 1080P screen, please notice：
1. If you occurred the issue that your internal display couldn't work while your external display works fine, you should delete the injected EDID in config.plist, use either editor is OK:

```
	<key>AAPL00,override-no-connect</key>
	<data>AP///////wBNEI0UAAAAAAUcAQSlIhN4Dt8ZqVM0vCUMUVQAAAABAQEBAQEBAQEBAQEBAQEBUNAAoPBwPoAwIDUAWMIQAAAapqYAoPBwPoAwIDUAWMIQAAAYAAAA/QA4TB5TEQAKICAgICAgAAAA/ABDb2xvciBMQ0QKICAgAJM=</data>
```

2. (not must)Use [xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi) to enable HiDPI；
3. Use `ProperTree` or `OpenCore Configurator` to edit `OC\Config.plist`, and change the `UIScale` part Value to `1`, or use `Other Text Editor (Such as NotePad)` and edit the `UIScale` part as after shows：
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
sudo mount -uw / (remove snapshot required)
```

<!-- #### 4. macOS Minor Update Suggestions

Rebuild kextcache after each macOS minor update, you can create a file named `rebuilt.command` containing the command `sudo kextcache -i /`. When an update is finished, you can directly run this file and input your password to rebuild kextcache. This can repair some minor issues such as `Brightness Control Failure` or `USB-C Device cannot work properly`. -->


### Wifi & Bluetooth Setting

1. Disable Power Nap，`System Preferences` -> `Energy Saver` disable all `Power Nap` options, and disable `Wake for Wi-Fi network access` option.
2. dissble Wake for Bluetooth, `System Preferences` -> `Bluetooth` -> `Advanced` disable all options.
3. For **_non DW1830_** users, you need replace `Post-install/non-DW1830BT/SSDT-USBP.aml` to `OC/ACPI/`;
4. For **_DW1830_** users, in order to imporve its performance and stability in Windows, please hit `Win+X+M` to open `Device Manager`, find the column Network Adapter and find `Dell Wireless 1830 802.11ac` and double click it, in the `Advanced` tab, find `Bluetooth Cooperation` and set it to `Disable`.  

## Contributor
[SilentSliver](https://github.com/SilentSliver)

## Special Thanks to

[RehabMan](https://github.com/RehabMan)、[Acidanthera](https://github.com/acidanthera)、[PMheart](https://github.com/PMheart)、[alexandred](https://github.com/alexandred)、[wmchris](https://github.com/wmchris)、[darkhandz](https://github.com/darkhandz)、[gunslinger23](https://github.com/gunslinger23)、[goodwin](https://github.com/goodwin) and so on.
