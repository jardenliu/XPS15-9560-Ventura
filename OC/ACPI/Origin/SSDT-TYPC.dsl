//
// USB Type-C Hotplug Fix

DefinitionBlock ("", "SSDT", 2, "DXPS", "TYPC", 0x00000000)
{
    External (_SB_.PCI0.RP15.PXSX, DeviceObj)
    External (_SB_.PCI0.RP15.PXSX.XRMV, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP15.PXSX.XSTA, MethodObj)    // 0 Arguments

    Scope (_SB.PCI0.RP15.PXSX)
    {
        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
        {
            If (_OSI ("Darwin"))
            {
                Return (1)
            }

            Return (\_SB.PCI0.RP15.PXSX.XRMV ())
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (15)
            }

            Return (\_SB.PCI0.RP15.PXSX.XSTA ())
        }
    }
}