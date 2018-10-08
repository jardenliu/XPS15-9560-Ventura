# XPS15-9560-Mojave
> xps15-9560吃上黑果的clover配置，不方便下载的童鞋可以前往[yeliujun/XPS15-9560-Mojave](https://gitee.com/yeliujun/XPS15-9560-Mojave.git)

## 更新日志
### 2018-09-26
- 添加`USBPower.kext`替代`SSDT-UIAC.aml`和`USBInjectAll.kext`
- 添加`agdpmod=pikera`启动参数patch HDMI,移除 `NvidiaGraphicsFixup.kext`

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
3. 把下载的CLOVER全覆盖自己本地的CLOVER文件夹。



## 全新安装教程

### 准备工具
* U盘(推荐8G以上)


### 第一步：设置BIOS
1. 使用windows下载官网新版本BIOS，推荐1.4以上版本。(!!!!!一定要从官网下载还有验证MD5)
2. 参照[BIOS.md](https://github.com/jardenliu/XPS15-9560-Mojave/blob/master/BIOS.md)进行设置

### 第二步：下载并制作镜像

1. 下载系统镜像，推荐下载到[黑果小兵 dalianksy](https://daliansky.github.io/)的博客下载（ps：也可以从商店下载原版文件自己制作镜像）
2. 在`Windows`下面使用`TransMac`把系统镜像写进U盘。（或者Mac下用磁盘工具`恢复`镜像到U盘）

### 第三步：添加启动项，安装系统
1. 下载此仓库的配置文件，并复制到硬盘EFI分区。
2. 添加Clover到UEFI的启动项中。
3. 插入U盘，重启。
4. 使用Clover引导U盘启动进入安装界面，进行全新安装。

### 第四步: 登陆你的AppleID
1. 安装完成后，不要第一时间登录你的AppleID。



# 未完待续

**精力有限，尚未完善，敬请期待~~~**
