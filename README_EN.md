# XPS15-9560-Catalina

> XPS15-9560 Hackintosh Clover Config.

[English](README_EN.md) | [中文](README.md)

## Configuration

- CPU：Intel I7 7700HQ
- RAM：16G(8G\*2) 2400MHz DDR4
- HardDisk：Toshiba NVMe 512G
- WIFI：DW1830
- Screen：4K(touch)

## What's not Working

1. Fingerprint sensor
2. Discrete graphic card, since macOS doesn't support Optimus technolog
3. SD Card Reader
4. Intel Bluetooth only works after warm restart from Windows
5. Intel Wi-Fi Killer 1535
6. Everything else works well

## Installation

Please refer to the detailed installation tutorial [Xiaomi Mi Notebook Pro High Sierra 10.13.6](https://www.tonymacx86.com/threads/guide-xiaomi-mi-notebook-pro-high-sierra-10-13-6.242724) or video tutorial [Xiaomi NoteBook PRO HACKINTOSH INSTALLATION GUIDE !!!](https://www.youtube.com/watch?v=72sPmkpxCvc).

If the tracpad doesn't work during installation, please plug a wired mouse or a wireless mouse projector before the installation. After the installation completes, open `Terminal.app` and type `sudo kextcache -i /`. Wait for the process ending and restart the device. Enjoy your trackpad!

## Warning

1. Don't turn on `FileValue Encryption`！！！

## Work around

#### 1. fix fuzzy font

open `Terminal.app` and exec

```bash
$ defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
```

then reboot.

#### 2. 1080P enable HIDPI

[xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi)

#### 3. Android USB Network Sharing

set `Post-install/HoRNDIS.kext` to `CLOVER/kexts/Other`

#### 4. Unlock Root directory

```
sudo mount -uw /
```

### Wifi & Bluetooth Setting

1. Disable Power Nap，`System Preferences` -> `Energy Saver` disable all `Power Nap` options, and disable `Wake for Wi-Fi network access` option.
2. dissble Wake for Bluetooth, `System Preferences` -> `Bluetooth` -> `Advanced` disable all options.

## Special Thanks to

[RehabMan](https://github.com/RehabMan)、[Acidanthera](https://github.com/acidanthera)、[PMheart](https://github.com/PMheart)、[alexandred](https://github.com/alexandred)、[wmchris](https://github.com/wmchris)、[darkhandz](https://github.com/darkhandz)、[gunslinger23](https://github.com/gunslinger23)、[goodwin](https://github.com/goodwin) and so on.
