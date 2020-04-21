
This driver creates a fake buildin ethernet adapter (en0)
Allowing AppStore login / access and enabling SideCar for 
those who do not have a functioning WiFi adapter

1.  Copy SSDT-ETH.aml to EFI\CLOVER\ACPI\patched
2.  Copy NullEthernet.kext to EFI\CLOVER\kexts\Other
3.  Add SSDT to config.plist

example:
	...
	<string>SSDT-SATA.aml</string>
	<string>SSDT-ALC298.aml</string>
	<string>SSDT-ETH.aml</string>
	...
	<key>BooterConfig</key>
	<string>0x28</string>
	...

4.  Rebuild kernel extension cache:
	sudo kextcache -i /
