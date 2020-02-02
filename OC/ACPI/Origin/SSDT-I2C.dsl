DefinitionBlock ("", "SSDT", 2, "hack", "I2C", 0x00000000)
{
    External (_SB_.PCI0.GPI0, DeviceObj)
    External (_SB_.PCI0.GPI0.XSTA, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.I2C1.TPD1, DeviceObj)
    External (_SB_.PCI0.I2C1.TPD1.SBFB, FieldUnitObj)
    External (_SB_.PCI0.I2C1.TPD1.SBFG, FieldUnitObj)
    External (_SB_.PCI0.I2C1.TPD1.XCRS, MethodObj)    // 0 Arguments

    Scope (_SB.PCI0.GPI0)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }

            Return (\_SB.PCI0.GPI0.XSTA ())
        }
    }

    Scope (_SB.PCI0.I2C1.TPD1)
    {
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            If (_OSI ("Darwin"))
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }

            Return (\_SB.PCI0.I2C1.TPD1.XCRS ())
        }
    }
}
