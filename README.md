# XPS15-9560-BigSur

> xps15-9560 吃上黑果的 OpenCore 配置，不方便下载的童鞋可以前往[yeliujun/XPS15-9560-BigSur](https://gitee.com/yeliujun/XPS15-9560-BigSur.git)

 [中文](README.md) | [English](README_EN.md)

 ## 下载
[i7-4K](https://github.com/jardenliu/XPS15-9560-BigSur/releases/download/latest/i7-4K-OC.zip)<br/>
[i7-1080P](https://github.com/jardenliu/XPS15-9560-BigSur/releases/download/latest/i7-1080P-OC.zip)<br/>
[i5-4K](https://github.com/jardenliu/XPS15-9560-BigSur/releases/download/latest/i5-4K-OC.zip)<br/>
[i5-1080P](https://github.com/jardenliu/XPS15-9560-BigSur/releases/download/latest/i5-1080P-OC.zip)

### 2020-12-18
1. 更新`OpenCore`至0.6.4； 
2. 更新所有`内核扩展`到最新版 
3. 4K内屏支持60Hz刷新率 
4. 更新`ALC298PlugFix`为`ALCPlugFix-Swift`.


更多详见[changelog.md](https://github.com/jardenliu/XPS15-9560-BigSur/blob/OpenCore/changelog.md)


## 配置

- CPU：Intel I7 7700HQ
- 内存：16G(8G\*2) 2400MHz DDR4
- 硬盘：东芝 NVMe 512G
- WIFI 网卡：已更换为博通 DW1830
- 屏幕分辨率：4K 触控屏

## 特性

- CPU: I7-7700HQ，已启用原生电源管理；多档变频正常，添加了`CPUFriendDataProvider.kext`,低频可到`800MHZ`，续航表现更好。
- 声卡: ALC298, 注入 ID：72，声音正常。耳机切换采用 ALCPluginFix。
- 触摸板: 含触屏，使用`VoodooI2C`,支持 Mac 原生手势。缺点就是没有防误触
- WIFI: 原配 Killer 1535 无法驱动，更换 DW1830, 实现免驱。（DW1560 应该也可以正常使用）
- 蓝牙: 驱动正常，极少数情况下会设备丢失，handoff 也正常。（没测过 1535 的蓝牙）
- ACPI： 使用 hotpatch 进行热修复，亮度快捷键映射正常。
- USB: USB3 端口均正常使用; TYPE-C 暂时不可以热插拔使用；雷电 3 不支持热插拔
- 显卡：集显 HD630 注入`591B0000`正常驱动；独显 GTX 1050 无解。
- 读卡器：无法使用
- DRM：可以播放，但TV应用中DRM硬解目前WEG的进度来看仍旧需要独显，不能完美支持

## 当前问题
1. ~~可能会出现插电源kp的情况~~（已修复）

## 升级教程

1. 下载仓库配置文件。
2. 将自己的三码替换到下 OC 目录下的`config.plist`对应位置。
3. 把下载的 OC 替换自己本地的 OC 文件夹。
<!-- 4. 升级完之后，可能会出现以下异常现象，如`亮度不能调节`，`USB-C设备不能正常工作`等，则需要重建kext缓存。打开`终端`运行`sudo kextcache -i /`命令，重建缓存，重启。 -->
<!-- 5. 建议：每次小版本升级后请重建缓存，可以在桌面新建一个`rebuilt.command`文件，内用文本编辑器写入`sudo kextcache -i /`后保存即可，有需要时双击后输入电脑密码即可重建。 -->

## 安装教程

可以参考小米笔记本 pro 的安装教程，详见[bilibili 小米 pro 教程](https://www.bilibili.com/video/av23052183)
下面为SilverSliver提供的安装教程，仅供XPS 15系列参考：
1. 下载macOS原版镜像（或者其他人提供带引导的也可以），文件格式为`dmg`；
2. 使用[`etcher`](https://www.balena.io/etcher/)或其他工具刻录镜像至U盘；
3. 将提供的`OC`文件夹通过各种手段（如使用`DiskGenius`挂载等不一一列举）放在硬盘的`EFI`或者`ESP`分区中的`EFI`文件夹下，然后重启进入`BIOS`；
4. 重启在`DELL`LOGO出现时按`F2`进入`BIOS`（建议：进入`BIOS`前先拔掉U盘等所有外置可引导设备，只留硬盘），我们开始创建启动项：
	1. 在`Boot Sequence`->`Boot List Option`确保是启动方式是`UEFI`，然后右边点击`Add Boot Option`出现一个对话框；
	2. 对话框有三部分`Boot Option Name`，`File System List`和`File Name`，这里我们先填写`Boot Option Name`，为了便于识别可以填写为`OpenCore`（其他的也可以）；
	3. 点击`File Name`那里右边的`...`按钮，会再弹出一个窗口；
	4. 在弹出的新窗口下有三部分：`File System`用来选择引导设备，中间是图形化的文件选择器，最下面`Selection`则是选择的文件路径。这里如果没有其他外置可引导设备则默认为硬盘的`EFI`，如果不是请手动在`File System`的下拉菜单切换；
	5. 在中间的图形化文件选择器中依次选择`EFI``OC``OpenCore.efi`后，一路确认回到`Boot Sequence`那里，然后将你创建的启动项通过右边的上下按钮调整到第一个；
	6. 修改完成之后保存退出`BIOS`即可。
	
5. 插上镜像U盘，然后启动电脑，在`OpenCore`中选择`macOS Install from XXX(表示移动设备名称)`进入安装界面；
6. 这步和白果一样，如果你需要分区，可以在`磁盘管理`进行分区，如果已经分好区，但是在安装阶段不可用，则需要在磁盘管理格式化分区，这里需要记下自己安装macOS的分区名称，这里先记作`XXXX`，随后就是无脑安装了；
7. 安装过程中会重启几次，当重启后`OpenCore`中出现`macOS Install from XXXX(分区名称)`则选择该项（U盘的使命已经结束）拔掉U盘，这步安装完成后会重启；
8. 待第七步结束之后你的`OpenCore`中应该会出现一个`macOS`的选项，回车键进入就可以正常使用了。

## 提示

1. 不要开启`文件保险箱加密(FileValue)`，不要开启`文件保险箱加密(FileValue)`，不要开启`文件保险箱加密(FileValue)`！！！
2. 使用OC前，请务必保证你已经解锁了`CFGlock`!如果你没有解锁`CFGLock`，则必须修改配置中`AppleXcpmCfgLock`以及`IgnoreInvalidFlexRatio`两项为`True`否则将启动失败。


## UEFI BIOS 设置

| Variable                                 | Offset | Default         | Desired         | Comment |
|------------------------------------------|--------|-----------------|-----------------|---------|
| Above 4GB MMIO BIOS assignment           | 0x79A  | 0x00 (Disabled) | 0x01 (Enabled)  |         |
| ACPI Removal Object Suppport             | 0x491  | 0x00 (Disabled) | 0x00            |         |
| CFG Lock                                 | 0x4ED  | 0x01 (Enabled)  | 0x00 (Disabled) |         |
| CSM Support                              | 0xFC8  | 0x01 (Enabled)  | 0x00 (Disabled) |         |
| DVMT Pre-Allocated                       | 0x795  | 0x02 (64M)      | 0x02 (64M)      |         |
| DVMT Total Gfx Memory                    | 0x796  | 0x02 (256M)     | 0x03 (MAX)      |         |
| GPIO filter                              | 0x47B  | 0x00            | 0x01            |         |
| GPIO3 Force Pwr                          | 0x45F  | N/A             | 0x01            |         |
| Native OS Hot Plug                       | 0x479  | N/A             | 0x01            |         |
| Skip PCI OptionRom                       | 0x48F  | 0x00            | 0x00            |         |
| SW SMI on TBT hot-plug                   | 0x47A  | 0x01 (Enabled)  | 0x01            |         |
| Thunderbolt Boot Support                 | 0x45B  | 0x00 (Disabled) | 0x01            |         |
| Thunderbolt Usb Support                  | 0x45A  | 0x00 (Disabled) | 0x01            |         |
| Thunderbolt(TM) PCIe Cache-line Size     | 0x45E  | 0x20 (32)       | 0x80 (128)      |         |
| Wait time in ms after applying Force Pwr | 0x460  | 0xC8 (200)      | 0xC8 (200)      |         |
| Wake From Thunderbolt(TM) Devices        | 0x452  | 0x01 (Enabled)  | 0x01            |         |

## 其他配置（i5等/1080P）说明
如果你是1080P用户，请注意以下几点：
1. （非必须）使用[xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi)项目提供的方式开启HiDPI；
2. 使用`ProperTree`或者`OpenCore Configurator`修改`OC\Config.plist`中`NVRAM\4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14`部分`UIScale`值设置为`1`或用`其他文本编辑器（如记事本等）`修改`UIScale`部分如下：

```
<key>4D1EDE05-38C7-4A6A-9CC6-4BCCA8B38C14</key>
<dict>
	<key>UIScale</key>
	<data>AQ==</data>
</dict>
```

如果你是非i7用户，请注意以下几点：
1. （必须）确保你现在已经安装好系统了；
2. （必须）删除项目中`OC\Kexts\CPUFriendDataProvider.kext`;
3. （必须）使用[stevezhengshiqi/one-key-cpufriend](https://github.com/stevezhengshiqi/one-key-cpufriend/blob/master/README_CN.md)提供的方式生成新的`CPUFriendDataProvider.kext`并放至`OC\Kexts\`;

## 小问题处理方式

#### 1. 字体细、发虚

终端执行`defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO`，注销再登录即可

#### 2. 安卓 USB 网络共享

把`Post-install`里面的`HoRNDIS.kext`放入`OC/kexts/`中，并使用文本编辑器在`Kernel/Add`项下添加以下内容。
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

#### 3. 解锁根目录

```
sudo mount -uw / (需要删除快照)
```

### Wifi 蓝牙设置

1. 关闭 wifi 唤醒和小憩，`系统偏好设置` -> `节能` 取消两个选项卡中的`小憩`和`唤醒以供Wi-Fi网络访问`的勾选。
2. 关闭蓝牙唤醒电脑, `系统偏好设置` -> `蓝牙` -> `高级` 取消所有勾选。
3. 对于 *非 DW1830* ，需要替换`Post-install/非DW1830BT/SSDT-USBP.aml`到`OC/ACPI/`
4. 对于 *DW1830* ，为了让其在Windows下以更佳状态工作，请在Windows中按下`Win+X+M`打开`设备管理器`，在`网络适配器`栏目下双击`Dell Wireless 1830 802.11ac`（即无线网卡）在高级选项卡中找到`Bluetooth Cooperation`（前面 Bluetooth 一致，后边可能不同），设置为`Disable`。

## 贡献者
[SilentSliver](https://github.com/SilentSliver)

## 鸣谢

[RehabMan](https://github.com/RehabMan)、[Acidanthera](https://github.com/acidanthera)、[PMheart](https://github.com/PMheart)、[alexandred](https://github.com/alexandred)、[wmchris](https://github.com/wmchris)、[darkhandz](https://github.com/darkhandz)、[gunslinger23](https://github.com/gunslinger23)、[goodwin](https://github.com/goodwin)等

注：排名不分先后；如有遗漏，请勿见怪，感谢您的付出；
