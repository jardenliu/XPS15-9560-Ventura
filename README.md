# XPS15-9560-Catalina

> xps15-9560 吃上黑果的 clover 配置，不方便下载的童鞋可以前往[yeliujun/XPS15-9560-Catalina](https://gitee.com/yeliujun/XPS15-9560-Catalina.git)

 [中文](README.md) | [English](README_EN.md)

## 更新日志

### 主要版本更新 2020-08-04

1. 添加对Big Sur的基础支持（4K屏用户需自行注入合适的EDID）。

更多详见[changelog.md](https://github.com/jardenliu/XPS15-9560-Catalina/blob/master/changelog.md)


### 内核扩展、引导等更新 2020-08-28

1. 更新`Clover`至5121;
2. 更新`所有内核扩展`至最新版（可能有非正式发布的版本）;
3. 重写`Hotpatch`部分以与OC分支同步;

当前配置可在 macOS `10.15.6` 下正常运行。

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
- USB: USB3 端口均正常使用; TYPE-C 可以热插拔（每次拔插之间需要间隔10s）使用；雷电 3 不支持热插拔
- 显卡：集显 HD630 注入`591B0000`正常驱动；独显 GTX 1050 无解。
- 读卡器：应该可以使用，具体没有测试
- DRM：可以播放，但TV应用中DRM硬解目前WEG的进度来看仍旧需要独显，不能完美支持
- 睡眠：目前明确Type-C口睡眠前进行高频写操作可能会出现Kennel Panic的问题，短期内不好解决，看日后雷电驱动的情况。

## 升级教程

1. 下载仓库配置文件。
2. 将自己的三码替换到下 CLOVER 目录下的`config.plist`对应位置。
3. 把下载的 CLOVER 替换自己本地的 CLOVER 文件夹。
4. 升级完之后，可能会出现以下异常现象，如`亮度不能调节`，`USB-C设备不能正常工作`等，则需要重建kext缓存。打开`终端`运行`sudo kextcache -i /`命令，重建缓存，重启。
5. 建议：每次小版本升级后请重建缓存，可以在桌面新建一个`rebuilt.command`文件，内用文本编辑器写入`sudo kextcache -i /`后保存即可，有需要时双击后输入电脑密码即可重建。

## 安装教程

可以参考小米笔记本 pro 的安装教程，详见[bilibili 小米 pro 教程](https://www.bilibili.com/video/av23052183)
下面为SilverSliver提供的安装教程，仅供XPS 15系列参考：
1. 下载macOS原版镜像（或者其他人提供带引导的也可以），文件格式为`dmg`；
2. 使用[`etcher`](https://www.balena.io/etcher/)或其他工具刻录镜像至U盘；
3. 将提供的`CLOVER`文件夹通过各种手段（如使用`DiskGenius`挂载等不一一列举）放在硬盘的`EFI`或者`ESP`分区中的`EFI`文件夹下，然后重启进入`BIOS`；
4. 重启在`DELL`LOGO出现时按`F2`进入`BIOS`（建议：进入`BIOS`前先拔掉U盘等所有外置可引导设备，只留硬盘），我们开始创建启动项：
	1. 在`Boot Sequence`->`Boot List Option`确保是启动方式是`UEFI`，然后右边点击`Add Boot Option`出现一个对话框；
	2. 对话框有三部分`Boot Option Name`，`File System List`和`File Name`，这里我们先填写`Boot Option Name`，为了便于识别可以填写为`Clover`（其他的也可以）；
	3. 点击`File Name`那里右边的`...`按钮，会再弹出一个窗口；
	4. 在弹出的新窗口下有三部分：`File System`用来选择引导设备，中间是图形化的文件选择器，最下面`Selection`则是选择的文件路径。这里如果没有其他外置可引导设备则默认为硬盘的`EFI`，如果不是请手动在`File System`的下拉菜单切换；
	5. 在中间的图形化文件选择器中依次选择`EFI``CLOVER``CLOVERX64.efi`后，一路确认回到`Boot Sequence`那里，然后将你创建的启动项通过右边的上下按钮调整到第一个；
	6. 修改完成之后保存退出`BIOS`即可。
	
5. 插上镜像U盘，然后启动电脑，在`CLOVER`中选择`macOS Install from XXX(表示移动设备名称)`进入安装界面；
6. 这步和白果一样，如果你需要分区，可以在`磁盘管理`进行分区，如果已经分好区，但是在安装阶段不可用，则需要在磁盘管理格式化分区，这里需要记下自己安装macOS的分区名称，这里先记作`XXXX`，随后就是无脑安装了；
7. 安装过程中会重启几次，当重启后`CLOVER`中出现`macOS Install from XXXX(分区名称)`则选择该项（U盘的使命已经结束）拔掉U盘，这步安装完成后会重启；
8. 待第七步结束之后你的`CLOVER`中应该会出现一个`macOS`的选项，回车键进入就可以正常使用了。

## 提示

1. 不要开启`文件保险箱加密(FileValue)`，不要开启`文件保险箱加密(FileValue)`，不要开启`文件保险箱加密(FileValue)`！！！

## 其他配置（i5/1080P）说明
如果你是1080P用户，请注意以下几点：
1. （非必须）使用[xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi)项目提供的方式开启HiDPI；
2. 使用`Clover Configurator`修改`CLOVER\Config.plist`中`启动背景`部分所有值删掉留空保存或者使用`其他文本编辑器（如记事本等）`删掉：
   ```
   <key>BootGraphics</key>
	<dict>
		<key>EFILoginHiDPI</key>
		<integer>2</integer>
		<key>UIScale</key>
		<integer>2</integer>
		<key>flagstate</key>
		<integer>1</integer>
	</dict>
   ```
3. 使用`Clover Configurator`修改`CLOVER\Config.plist`中`引导界面`部分`主题`部分填写`Outlines1080`或使用`其他文本编辑器（如记事本等）`将`Outlines4K`替换为`Outlines1080`（如果想换回原先的主题则修改改为`Universe`）；

如果你是非i7用户，请注意以下几点：
1. （必须）确保你现在已经安装好系统了；
2. （必须）删除项目中`CLOVER\Kexts\Other\CPUFriendDataProvider.kext`;
3. （必须）使用[stevezhengshiqi/one-key-cpufriend](https://github.com/stevezhengshiqi/one-key-cpufriend/blob/master/README_CN.md)提供的方式生成新的`CPUFriendDataProvider.kext`并放至`CLOVER\Kexts\Other`;

## 安装后处理

### 1. 耳机Mic切换修复

1. 双击`Post-install\AlCPlugFix\Install_Double-CLick.command`，按照弹出终端窗口提示进行操作；
2. 重启电脑以使其生效。

### 2. Wifi 蓝牙设置

1. 关闭 wifi 唤醒和小憩，`系统偏好设置` -> `节能` 取消两个选项卡中的`小憩`和`唤醒以供Wi-Fi网络访问`的勾选。
2. 关闭蓝牙唤醒电脑, `系统偏好设置` -> `蓝牙` -> `高级` 取消所有勾选。
3. 对于 *非 DW1830* ，需要替换`Post-install/非DW1830BT/USBPower.kext`到`CLOVER/kexts/Other/`
4. 对于 *DW1830* ，为了让其在Windows下以更佳状态工作，请在Windows中按下`Win+X+M`打开`设备管理器`，在`网络适配器`栏目下双击`Dell Wireless 1830 802.11ac`（即无线网卡）在高级选项卡中找到`Bluetooth Cooperation`（前面 Bluetooth 一致，后边可能不同），设置为`Disable`。

### 3. 仿冒以太网卡以使用App Store（来自 [keysun11952](https://github.com/keysun11952)）

该部分适用于在macOS下使用USB网卡等方式上网并需要使用App Store的用户。

1. 将`Post-install/FakeEthernetAdapter/NullEthernet.kext`放入`CLOVER/Kexts/Other`中；
2. 将`Post-install/FakeEthernetAdapter/SSDT-ETH.aml` 放入 `CLOVER/ACPI/patched`；
3. 在`CLOVER/config.plist`-`ACPI/SortedOrder`中添加`SSDT-ETH.aml`；
4. 重启电脑以使其生效。

### 4. 安卓 USB 网络共享

1. 将`Post-install\AndroidUSBNetworkShare(安卓USB共享)\HoRNDIS.kext`放入`CLOVER/kexts/Other`中；
2. 重启电脑以使其生效。

## 小问题处理方式

#### 1. 字体细、发虚

终端执行`defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO`，注销再登录即可

#### 2. 解锁根目录

```
sudo mount -uw /
```

## 贡献者

[SilentSliver](https://github.com/SilentSliver)

## 鸣谢

[Apple](https://www.apple.com)、[RehabMan](https://github.com/RehabMan)、[Acidanthera](https://github.com/acidanthera)、[PMheart](https://github.com/PMheart)、[alexandred](https://github.com/alexandred)、[wmchris](https://github.com/wmchris)、[darkhandz](https://github.com/darkhandz)、[gunslinger23](https://github.com/gunslinger23)、[goodwin](https://github.com/goodwin)、[cholonam](https://github.com/cholonam/)、[Menchen](https://github.com/Menchen)、[blackosx](https://sourceforge.net/u/blackosx/profile/)[Badruzeus](https://sourceforge.net/u/badruzeus/profile/)等

注：排名不分先后；如有遗漏，请勿见怪，感谢您的付出；
