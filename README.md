# XPS15-9560-Mojave
> xps15-9560吃上黑果的clover配置，不方便下载的童鞋可以前往[yeliujun/XPS15-9560-Mojave](https://gitee.com/yeliujun/XPS15-9560-Mojave.git)

## VirtualSmc版本已更新
* 想更换VirtualSmc，请到[VirtualSmc 分支](https://github.com/jardenliu/XPS15-9560-Mojave/tree/VirtualSmc)下载

## 更新日志
### 2019-04-03
- 日常更新Lilu系列

更多详见[changelog.md](https://github.com/jardenliu/XPS15-9560-Mojave/blob/master/changelog.md)

## 配置
- CPU：Intel I7 7700HQ
- 内存：16G(8G*2) 2400MHz DDR4
- 硬盘：东芝 NVMe 512G
- WIFI网卡：已更换为博通DW1830
- 屏幕分辨率：4K触控屏

## 特性
- CPU: I7-7700HQ，已启用原生电源管理；多档变频正常，添加了`CPUFriendDataProvider.kext`,低频可到`800MHZ`，续航表现更好。
- 声卡: ALC298, 注入ID：72，声音正常。耳机切换采用ALCPluginFix。(Combo jack在Mojave下面似乎失效了)
- 触摸板: 含触屏，使用`VoodooI2C`,支持Mac原生手势。缺点就是没有防误触
- WIFI: 原配Killer 1535无法驱动，更换DW1830, 实现免驱。（DW1560应该也可以正常使用）
- 蓝牙: 驱动正常，极少数情况下会设备丢失，handoff也正常。（没测过1535的蓝牙）
- ACPI： 使用hotpatch进行热修复，亮度快捷键映射正常。
- USB: USB3端口均正常使用; TYPE-C 可以热插拔使用；雷电3 不支持热插拔
- 显卡：集显HD630注入`591B0000`正常驱动；独显GTX 1050无解。
- 读卡器：无法使用

## 升级教程
1. 下载仓库配置文件。
2. 将自己的三码替换到下CLOVER目录下的`config.plist`对应位置。
3. 把下载的CLOVER替换自己本地的CLOVER文件夹。
4. 升级完之后，可能会出现以下异常现象，如`亮度不能调节`等。打开`终端`运行`sudo kextcache -i /`命令，重建缓存，重启。


## 安装教程
  实在不想写教程，可以参考小米笔记本pro的安装教程，详见[bilibili小米pro 教程](https://www.bilibili.com/video/av23052183)
  
## 小问题处理方式
#### 1. 字体细、发虚
  终端执行`defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO`，注销再登录即可
#### 2. 1080P开启HIDPI
  使用[xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi)
#### 3. 安卓USB网络共享
  把`Post-install`里面的`HoRNDIS.kext`放入`CLOVER/kexts/Other`
  
### Wifi蓝牙设置
1. 关闭wifi唤醒和小憩，`系统偏好设置` -> `节能` 取消两个选项卡中的`小憩`和`唤醒以供Wi-Fi网络访问`的勾选。
2. 关闭蓝牙唤醒电脑, `系统偏好设置` -> `蓝牙` -> `高级` 取消所有勾选。
3. ***非DW1830*** 需要替换`Post-install/非DW1830BT/USBPower.kext`到`CLOVER/kexts/Other/`
4. ***DW1830*** 在windows下设置，设备管理器，右键dw1830（即无线网卡）->属性->高级->Bluetooth Cooperation（前面Bluetooth一致，后边可能不同），设置为disable


  
## 鸣谢
[RehabMan](https://github.com/RehabMan)、[Acidanthera](https://github.com/acidanthera)、[PMheart](https://github.com/PMheart)、[alexandred](https://github.com/alexandred)、[wmchris](https://github.com/wmchris)、[darkhandz](https://github.com/darkhandz)、[gunslinger23](https://github.com/gunslinger23)、[goodwin](https://github.com/goodwin)等

注：排名不分先后；如有遗漏，请勿见怪，感谢您的付出；


