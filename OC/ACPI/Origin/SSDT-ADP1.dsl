DefinitionBlock ("", "SSDT", 2, "hack", "ADP1", 0x00000000)
{
    External (_SB_.ADP1, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)

    Scope (\_SB.ADP1)
    {
        If (_OSI ("Darwin"))
        {
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x18, 
                0x03
            })
        }
    }

    Device (_SB.PCI0.LPCB.EC.CHRG)
    {
       
        Name (_HID, "DELLBBB1")  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Else
            {
                Return (0x0)
            }
        }
    }
}

