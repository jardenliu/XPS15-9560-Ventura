//
// I2C Inject Table
// Rename In Config:
// _STA to XSTA at GPI0
// Find: 5F535441
// Replace: 58535441
// TgtBridge: 47504930
//
// _CRS to XCRS in TPD1
// Find: 5F435253
// Replace: 58435253
// TgtBridge: 54504431
//
DefinitionBlock ("", "SSDT", 2, "DXPS", "I2C", 0x00000000)
{
    External (_SB_.PCI0.GPI0, DeviceObj)
    External (_SB_.PCI0.GPI0.XSTA, MethodObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.I2C1.TPD1, DeviceObj)
    External (_SB_.PCI0.I2C1.TPD1.SBFB, FieldUnitObj)
    External (_SB_.PCI0.I2C1.TPD1.SBFG, FieldUnitObj)
    External (_SB_.PCI0.I2C1.TPD1.XCRS, MethodObj)
    // To use GPIO Interrupt, _STA in Device GPI0 must return 0F
    Scope (_SB.PCI0.GPI0)
    {
        Method (_STA, 0)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            // Native Method from DSDT
            Return (\_SB.PCI0.GPI0.XSTA ())
        }
    }
    // To use I2C TrackPad with VoodooI2C, _CRS in Device TPD1 must return SBFB and SBFG
    Scope (_SB.PCI0.I2C1.TPD1)
    {
        Method (_CRS, 0)  // _CRS: Current Resource Settings
        {
            If (_OSI ("Darwin"))
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }
            // Native Method from DSDT
            Return (\_SB.PCI0.I2C1.TPD1.XCRS ())
        }
    }
}

