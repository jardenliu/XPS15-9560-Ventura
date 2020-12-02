// AC Table
DefinitionBlock ("", "SSDT", 2, "DXPS", "ADP1", 0)
{
    External (_SB_.AC__, DeviceObj)
    External (_SB_.PCI0.LPCB.ECDV, DeviceObj)
    If (_OSI ("Darwin"))
    {
        Scope (\_SB.AC)
        {
            Name (_PRW, Package ()  // _PRW: Power Resources for Wake
            {
                0x18, 
                3
            })
        }

        Device (_SB.PCI0.LPCB.ECDV.CHRG)
        {
            Name (_HID, "DELLBBB1")  // _HID: Hardware ID
            Method (_STA, 0)  // _STA: Status
            {
                Return (0x0F)
            }
        }
    }
}

