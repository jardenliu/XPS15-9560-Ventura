//
// I2C Inject Table
//
DefinitionBlock ("", "SSDT", 2, "DXPS", "I2C", 0x00000000)
{
    External (_SB.PCI0.GPI0._HID, MethodObj)
    External (_SB.PCI0.I2C1, DeviceObj)
    External (USTP, FieldUnitObj)
    External (FMD1, IntObj)
    External (FMH1, IntObj)
    External (FML1, IntObj)
    External (SSD1, IntObj)
    External (SSH1, IntObj)
    External (SSL1, IntObj)
    External (SMD0, FieldUnitObj)
    External (GPEN, FieldUnitObj)
    External (GPDI, FieldUnitObj)
    External (SDM1, FieldUnitObj)
    External (SDS1, FieldUnitObj)
    External (_SB.SRXO, MethodObj)
    External (_SB.SHPO, MethodObj)
    External (_SB.CBID, MethodObj)
    External (_SB.GNUM, MethodObj)
    External (_SB.INUM, MethodObj)
    External (_SB.PCI0.HIDD, MethodObj)
    External (_SB.PCI0.TP7D, MethodObj)
    External (_SB.PCI0.HIDG, IntObj)
    External (_SB.PCI0.TP7G, IntObj)
    
    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            SMD0 = 0
            GPEN = 1
            SDS1 = 0

            Method (PKGX, 3, Serialized)
            {
                Name (PKG, Package (0x03)
                {
                    Zero, 
                    Zero, 
                    Zero
                })
                PKG [Zero] = Arg0
                PKG [One] = Arg1
                PKG [0x02] = Arg2
                Return (PKG)
            }
        }
    }
    
    //path:_SB.PCI0.I2C1
    Scope (_SB.PCI0.I2C1)
    {
        Method (SSCN, 0, NotSerialized)
        {
            Return (PKGX (SSH1, SSL1, SSD1))
        }

        Method (FMCN, 0, NotSerialized)
        {
            Return (PKGX (0x0101, 0x012C, 0x62))
            //Return (PKGX (FMH1, FML1, FMD1))
        }
        Device (TPXX)
        {
            Name (HID2, Zero)
            Name (SBFB, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,"\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,)
                {
                    0x1B
                    //0x7B
                }
            })
            CreateWordField (SBFG, 0x17, INT1)
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {

                INT1 = GNUM (GPDI)
                If ((SDM1 == Zero))
                {
                    SHPO (GPDI, One)
                }
                HID2 = 0x20
            }

            Name (_HID, "DLL07BE")  // _HID: Hardware ID
            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                }

                If ((Arg0 == TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }
            
            Method (_STA, 0)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }

                Return (Zero)
            }

            Method (_CRS, 0)
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
            }
        }
    }
}

