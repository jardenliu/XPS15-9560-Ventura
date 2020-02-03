// Make brightness control and brightness keys work
// Patch: Rename BRT6 to BRTX 
// Find: QlJUNgKg 
// Replace: QlJUWAKg
// References:
// [1] https://github.com/daliansky/OC-little/tree/master/04-OC-PNLF%E6%B3%A8%E5%85%A5%E6%96%B9%E6%B3%95
// [2] https://github.com/daliansky/OC-little/tree/master/%E4%BF%9D%E7%95%99%E9%A1%B9%E7%9B%AE/X02-%E4%BA%AE%E5%BA%A6%E5%BF%AB%E6%8D%B7%E9%94%AE%E8%A1%A5%E4%B8%81

DefinitionBlock ("", "SSDT", 2, "hack", "BCKM", 0x00000000)
{
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.GFX0.LCD_, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (_SB_.PCI0.GFX0.XRT6, MethodObj)
    External (_SB_.PCI0.PEG0.PEGP, DeviceObj)

    // notify PS2K when brightness control key was pressed[2]
    Scope (\_SB.PCI0.GFX0)
    {
        Method (BRT6, 2, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                If ((Arg0 == One))
                {
                    Notify (LCD, 0x86) // Device-Specific
               Notify (\_SB.PCI0.LPCB.PS2K, 0x0406)
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x10) // Reserved
                }

                If ((Arg0 & 0x02))
                {
                    Notify (LCD, 0x87) // Device-Specific
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x0405)
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x20) // Reserved
                }
            }
            Else
            {
                \_SB.PCI0.GFX0.XRT6(Arg0, Arg1)
            }
        }
    }
    
    
    // inject PNLF for Skylake to make brightness control work[1]
    Scope (_SB)
    {
        Device (PNLF)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
            Name (_CID, "backlight")  // _CID: Compatible ID
            Name (_UID, 0x10)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }
    }

}

