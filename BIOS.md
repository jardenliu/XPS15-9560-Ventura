# BIOS设置
> 推荐使用1.4.x以上版本，我用的是1.9.1

### System Information
- 检查Video Memory是不是刚好64MB
- Advanced Boot Options (全部off)

### System Configuration
- SATA Operation (AHCI)
- Drives (全部on)
- SMART Reporting (on)
- USB Configuration (全部on)
- Dell Type-C Dock Configuration (on)
- Thunderbolt Adapter Configuration (全部 on, no security)
- USB PowerShare (on)
- Audio (全部 on)
- Touchscreen (on)
- Miscellaneous Devices (全部on，except SD Card Reader)
- CPU XD (on)

### Secure Boot
- Secure Boot Enable (disabled)

### Intel Software Guard Extensions
- Intel SGX Enable (Software-Controlled)

### Performance
- (所有都 on或enabled)
### Power Management
- (USB Wake Support = off)
- (Wake on Dell USB-C Dock = on)
- Wake on WLAN (off)
- Block Sleep (off)

### Virtualization Support
(全部 on)
