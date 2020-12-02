//
// BackLight Fix Table
// Rename In Config:
// BRT6 to BRTX 
// Find: 14204252 543602
// Replace: 14204252 545802
//
DefinitionBlock ("", "SSDT", 2, "DXPS", "BRT6", 0)
{
    External (_SB_.PCI0.GFX0, DeviceObj)
    External (_SB_.PCI0.GFX0.LCD_, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (_SB_.PCI0.GFX0.BRTX, MethodObj)
    External (ALSD, DeviceObj)

    // Fix Bright Function Key
    Scope (_SB.PCI0.GFX0)
    {
        Method (BRT6, 2)
        {
            If (_OSI ("Darwin"))
            {
                If ((Arg0 == One))
                {
                    Notify (^LCD, 0x86) // Device-Specific
                    Notify (^^LPCB.PS2K, 0x10) // Reserved
                    Notify (^^LPCB.PS2K, 0x0206)
                    Notify (^^LPCB.PS2K, 0x0286)
                }

                If ((Arg0 & 0x02))
                {
                    Notify (^LCD, 0x87) // Device-Specific
                    Notify (^^LPCB.PS2K, 0x20) // Reserved
                    Notify (^^LPCB.PS2K, 0x0205)
                    Notify (^^LPCB.PS2K, 0x0285)
                }
            }
            Else
            {
                \_SB.PCI0.GFX0.BRTX (Arg0, Arg1)
            }
        }
    }

    //Inject PNLF to Control Backlight
    If (_OSI ("Darwin"))
    {
        Scope (_SB)
        {
            Device (PNLF)
            {
                Name(_ADR, Zero)
                Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
                Name (_CID, "backlight")  // _CID: Compatible ID
                Name (_UID, 0x10)  // _UID: Unique ID
                Method (_STA, 0)  // _STA: Status
                {
                    Return (0x0B)
                }
            }
            Device (ALS0)
            {
                Name (_HID, "ACPI0008" /* Ambient Light Sensor Device */)  // _HID: Hardware ID
                Name (_CID, "smc-als")  // _CID: Compatible ID
                Name (_ALI, 0x012C)  // _ALI: Ambient Light Illuminance
                Name (_ALR, Package (0x01)  // _ALR: Ambient Light Response
                {
                    Package (0x02)
                    {
                        0x64, 
                        0x012C
                    }
                })
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {

                    Return (0x0F)
     
                }
            }
        }
    }
}
