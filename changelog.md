# 更新日志

## 主版本更新 Main Version Update log

### 2020-08-04

1. 添加对Big Sur的基础支持（需要使用PrelinkedKernel启动，4K屏用户需自行注入合适的EDID）
   Add basic support for Big Sur (Need PrelinkedKernel. Also need Inject Suitable EDID if you are using this laptop with 4K display screen)

### 2020-02-02
1. 添加OpenCore引导（仅供测试）
   Add branch of OpenCore(Only for test)
### 2019-10-08

1. 支持 10.15 正式版
   Support 10.15

## 内核扩展、引导等更新 Integrated Kexts, EFI and so on Update log

### 2020-08-28

1. 更新`Clover`至5122;
   Update `Clover` to 5122; 
1. 更新`所有内核扩展`至最新版（可能有非正式发布的版本）;
   Update All `Kext Extensions` to latest version (Might have some kexts not at stable branch);
1. 重写`Hotpatch`部分以与OC分支同步;
   Rewrite `Hotpatch` to async with `OpenCore` branch;


### 2020-08-04

1. 更新`Clover`至5120;
   Update `Clover` to 5120; 
1. 更新`所有内核扩展`至最新版;
   Update All `Kext Extensions` to latest version;
1. 提高`HDMI`稳定性，修复`HDMI`音频问题;
   Improve the stability of `HDMI`, and Fix some issues about `HDMI Audio`
1. 使用`AppleRTC`以修复一些潜在的启动问题;
   Use RTC fix to fix some boot issues;

### 2020-06-02

1. 更新所有`内核扩展`至最新版;
   Update All `Kext Extensions` to latest version;
1. 尝试修复睡眠唤醒后HDMI无信号的问题([@AntSYau](https://github.com/jardenliu/XPS15-9560-Catalina/pull/143/commits/5c918a6fca9b300754a5659e3efb78e8571f02f4)提交);
   Try to fix no HDMI signal after wake from sleep(committed by [@AntSYau](https://github.com/jardenliu/XPS15-9560-Catalina/pull/143/commits/5c918a6fca9b300754a5659e3efb78e8571f02f4));

### 2020-05-25

1. 更新`Clover`至5118;
   Update `Clover` to 5118; 

### 2020-05-07

1. 更新`Clover`至5116;
   Update `Clover` to 5116;
1. 更新`Lilu`系驱动至最新;
   Update `Lilu` series kexts to the latest;
1. 添加读卡器支持;
   Add Support for SD Card Reader; 
   
### 2020-04-29

1. 更新`VoodooI2C`至 2.4.2
   Update `VoodoI2C` to `2.4.2`
1. 更新`Clover`至5114;
   Update `Clover` to 5114;

### 2020-03-31

1. 修复部分亮度背光档位问题；
   Fix some Backlight level issues;
2. 更新`Lilu`系驱动至最新版;
   Update all `Lilu` plugins to last version;
1. 更新`Clover`至5108;
   Update `Clover` to 5108;
4. 替换内置主题为`Outlines`;
   Replace Clover Theme to `Outlines`;

### 2020-03-02

1. 更新 `Lilu`系驱动至最新版;
   Update all `Lilu` plugins to last version;

### 2020-02-23

1. 更新`Clover`版本至5104;
   Update `Clover` to 5104;

### 2020-01-21

1. 更新 `Lilu` 及其组件至最新版本;
   Update all `Lilu` plugins to last version;
1. 更新`FakeSMC`分支驱动至最新版本;
   Update all Kexts in branch `FakeSMC` to last version;
1. 祝大家新年快乐!
   Happy Chinese New Year!

### 2019-12-20

1. 更新`VoodooI2C`至 2.3
   Update `VoodoI2C` to `2.3`
