// TPxx is my new's device
DefinitionBlock("", "SSDT", 2, "ACDT", "I2C-TPXX", 0)
{
    External(_SB.PCI0.I2C1, DeviceObj)
    //External(OSYS, FieldUnitObj)
     
    External(GPDI, FieldUnitObj)
    External(SDM1, FieldUnitObj)
    External(SDS1, FieldUnitObj)
    External(_SB.GGIV, MethodObj)
    External(_SB.SHPO, MethodObj)
    External(_SB.CBID, MethodObj)
    External(_SB.GNUM, MethodObj)
    External(_SB.INUM, MethodObj)
    External(_SB.PCI0.HIDD, MethodObj)
    External(_SB.PCI0.TP7D, MethodObj)
    External(_SB.PCI0.HIDG, IntObj)
    External(_SB.PCI0.TP7G, IntObj)
    
    //path:_SB.PCI0.I2C1
    Scope (_SB.PCI0.I2C1)
    {
        Name (SSCN, Package () { 528, 640, 30 })
        Name (FMCN, Package () { 128, 160, 30 })
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
            Name (SBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, _Y2A)
                {
                    0x00000000,
                }
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0001b
                    }
            })
            CreateWordField (SBFG, 0x17, INT1)
            CreateDWordField (SBFI, \_SB.PCI0.I2C1.TPXX._Y2A._INT, INT2)  // _INT: Interrupts
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                //If (LLess (OSYS, 0x07DC))
                //{
                //    SRXO (GPDI, One)
                //}

                Store (GNUM (GPDI), INT1)
                Store (INUM (GPDI), INT2)
                If (LEqual (SDM1, Zero))
                {
                    SHPO (GPDI, One)
                }

                //If (LEqual (SDS1, 0x07))
                If (One)
                {
                    _HID = "DLL07BE"
                    If (CondRefOf (GGIV))
                    {
                        Local0 = GGIV (0x0102000F)
                    }

                    If ((Local0 == One))
                    {
                        _HID = "DLL07BF"
                    }

                    Store (0x20, HID2)
                    //Return (Zero)
                }
            }

            Name (_HID, "XXXX0000")  // _HID: Hardware ID
            Name (_CID, "PNP0C50")  // _CID: Compatible ID
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If (LEqual (Arg0, HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, HID2))
                }

                If (LEqual (Arg0, TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFB, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                           
                })
            }
  
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (ConcatenateResTemplate (SBFB, SBFG))
                //Return (ConcatenateResTemplate (SBFB, SBFI))
            }
        }
    }
}
//EOF