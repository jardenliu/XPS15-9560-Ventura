//
// USB Type-C Hotplug Fix

DefinitionBlock ("", "SSDT", 2, "DXPS", "TYPC", 0x00000000)
{
    External (XWAK, MethodObj)
    External (_GPE.XTFY, MethodObj)
    External (_SB_.TBFP, MethodObj)
    External (_SB_.PCI0.RP15, DeviceObj)
    External (_SB_.PCI0.RP15.PXSX.XRMV, MethodObj)
    External (_SB_.PCI0.RP15.PXSX, DeviceObj)  // 0 Arguments
    External (_SB_.PCI0.RP15.VDID, FieldUnitObj)
    External (_SB_.PCI0.RP15.PXSX.TBL1, DeviceObj)
    External (_SB_.PCI0.RP15.PXSX.TBL2, DeviceObj)  
    
//    Scope (\_GPE)
//    {
//        Method (NTFY, 1, Serialized)
//        {
//            If(_OSI("Darwin")&&15==ToInteger (Arg0))
//            {
//                Notify (\_SB.PCI0.RP15.PXSX.TBL1.NHI0, Zero) // TB3 controller
//            }
//            Else
//            {
//                \_GPE.XTFY(Arg0)
//            }
//        }
//        Method (RWAK, 1, Serialized)
//        {
//            XWAK (Arg0)

//            If (_OSI("Darwin") && ((Arg0 == 0x03) || (Arg0 == 0x04)))
//            {
//                If ((\_SB.PCI0.RP15.VDID != 0xFFFFFFFF))
//                {
//                    Notify (\_SB.PCI0.RP15.PXSX.TBL1.NHI0, Zero) // TB3 controller
//                }
//            }

//            Return (Package (0x02)
//            {
//                Zero, 
//                Zero
//            })
//        }
//    }
    
    Scope (\_SB.PCI0.RP15)
    {
        Scope (PXSX)
        {
            If (_OSI ("Darwin"))
            {
                OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                Field (A1E0, ByteAcc, NoLock, Preserve)
                {
                    AVND,   32, 
                    BMIE,   3, 
                    Offset (0x18), 
                    PRIB,   8, 
                    SECB,   8, 
                    SUBB,   8, 
                    Offset (0x1E), 
                        ,   13, 
                    MABT,   1
                }

                Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                {
                    Return (SECB) /* \_SB_.PCI0.RP15.PXSX.SECB */
                }
                
                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                {
                    If (_OSI ("Darwin"))
                    {
                        Return (1)
                    }

                    Return (\_SB.PCI0.RP15.PXSX.XRMV ())
                }

                If (CondRefOf (\_SB.PCI0.RP15.PXSX.TBL1))
                {
                    Scope (TBL1)
                    {
                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                        Field (A1E0, ByteAcc, NoLock, Preserve)
                        {
                            AVND,   32, 
                            BMIE,   3, 
                            Offset (0x18), 
                            PRIB,   8, 
                            SECB,   8, 
                            SUBB,   8, 
                            Offset (0x1E), 
                                ,   13, 
                            MABT,   1
                        }

                        OperationRegion (A1E1, PCI_Config, 0xC0, 0x40)
                        Field (A1E1, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            Offset (0x08), 
                            Offset (0x0A), 
                                ,   5, 
                            TPEN,   1, 
                            Offset (0x0C), 
                            SSPD,   4, 
                                ,   16, 
                            LACR,   1, 
                            Offset (0x10), 
                                ,   4, 
                            LDIS,   1, 
                            LRTN,   1, 
                            Offset (0x12), 
                            CSPD,   4, 
                            CWDT,   6, 
                                ,   1, 
                            LTRN,   1, 
                                ,   1, 
                            LACT,   1, 
                            Offset (0x14), 
                            Offset (0x30), 
                            TSPD,   4
                        }

                        OperationRegion (A1E2, PCI_Config, 0x80, 0x08)
                        Field (A1E2, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            PSTA,   2
                        }

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP15.PXSX.TBL1.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (Zero)
                        }

                        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                        {
                            If (!Arg2)
                            {
                                Return (Buffer (One)
                                {
                                     0x03                                             // .
                                })
                            }

                            Return (Package (0x02)
                            {
                                "PCIHotplugCapable", 
                                One
                            })
                        }

                        Device (NHI0)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            Name (_STR, Unicode ("Thunderbolt"))  // _STR: Description String
                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                            {
                                Return (Zero)
                            }

                            OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                            Field (A1E0, ByteAcc, NoLock, Preserve)
                            {
                                AVND,   32, 
                                BMIE,   3, 
                                Offset (0x18), 
                                PRIB,   8, 
                                SECB,   8, 
                                SUBB,   8, 
                                Offset (0x1E), 
                                    ,   13, 
                                MABT,   1
                            }

                            Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                            {
                                If ((Arg2 == Zero))
                                {
                                    Return (Buffer (One)
                                    {
                                         0x03                                             // .
                                    })
                                }

                                Return (Package (0x0D)
                                {
                                    "built-in", 
                                    Buffer (One)
                                    {
                                         0x00                                             // .
                                    }, 

                                    "device_type", 
                                    Buffer (0x19)
                                    {
                                        "Thunderbolt 3 Controller"
                                    }, 

                                    "AAPL,slot-name", 
                                    Buffer (0x09)
                                    {
                                        "Built-In"
                                    }, 

                                    "model", 
                                    Buffer (0x2D)
                                    {
                                        "Intel Alpine Ridge DSL6340 Thunderbolt 3 NHI"
                                    }, 

                                    "name", 
                                    Buffer (0x34)
                                    {
                                        "Intel Thunderbolt 3 Controller"
                                    }, 

                                    "power-save", 
                                    One, 
                                    Buffer (One)
                                    {
                                         0x00                                             // .
                                    }
                                })
                            }
                        }
                    }
                }

                If (CondRefOf (\_SB.PCI0.RP15.PXSX.TBL2))
                {
                    Scope (TBL2)
                    {
                        Name (_SUN, One)  // _SUN: Slot User Number
                        OperationRegion (A1E0, PCI_Config, Zero, 0x40)
                        Field (A1E0, ByteAcc, NoLock, Preserve)
                        {
                            AVND,   32, 
                            BMIE,   3, 
                            Offset (0x18), 
                            PRIB,   8, 
                            SECB,   8, 
                            SUBB,   8, 
                            Offset (0x1E), 
                                ,   13, 
                            MABT,   1
                        }

                        OperationRegion (A1E1, PCI_Config, 0xC0, 0x40)
                        Field (A1E1, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            Offset (0x08), 
                            Offset (0x0A), 
                                ,   5, 
                            TPEN,   1, 
                            Offset (0x0C), 
                            SSPD,   4, 
                                ,   16, 
                            LACR,   1, 
                            Offset (0x10), 
                                ,   4, 
                            LDIS,   1, 
                            LRTN,   1, 
                            Offset (0x12), 
                            CSPD,   4, 
                            CWDT,   6, 
                                ,   1, 
                            LTRN,   1, 
                                ,   1, 
                            LACT,   1, 
                            Offset (0x14), 
                            Offset (0x30), 
                            TSPD,   4
                        }

                        OperationRegion (A1E2, PCI_Config, 0x80, 0x08)
                        Field (A1E2, ByteAcc, NoLock, Preserve)
                        {
                            Offset (0x01), 
                            Offset (0x02), 
                            Offset (0x04), 
                            PSTA,   2
                        }

                        Method (_BBN, 0, NotSerialized)  // _BBN: BIOS Bus Number
                        {
                            Return (SECB) /* \_SB_.PCI0.RP15.PXSX.TBL2.SECB */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Return (0x0F)
                        }

                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                        {
                            Return (Zero)
                        }

                        Device (TBLU)
                        {
                            Name (_ADR, Zero)  // _ADR: Address
                            OperationRegion (ARE0, PCI_Config, Zero, 0x04)
                            Field (ARE0, ByteAcc, NoLock, Preserve)
                            {
                                AVND,   16
                            }

                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                            {
                                Return (Zero)
                            }

                            Device (TB00)
                            {
                                Name (_ADR, Zero)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }

                                Device (DEV0)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_STA, 0, NotSerialized)  // _STA: Status
                                    {
                                        Return (0x0F)
                                    }

                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        Return (One)
                                    }
                                }
                            }

                            Device (TB03)
                            {
                                Name (_ADR, 0x00030000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }

                                Device (TB3U)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        Return (One)
                                    }

                                    Device (TB30)
                                    {
                                        Name (_ADR, Zero)  // _ADR: Address
                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }
                                        }
                                    }

                                    Device (TB33)
                                    {
                                        Name (_ADR, 0x00030000)  // _ADR: Address
                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            Return (One)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                Return (One)
                                            }
                                        }
                                    }

                                    Device (TB34)
                                    {
                                        Name (_ADR, 0x00040000)  // _ADR: Address
                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            Return (One)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                Return (One)
                                            }
                                        }
                                    }

                                    Device (TB35)
                                    {
                                        Name (_ADR, 0x00050000)  // _ADR: Address
                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            Return (One)
                                        }
                                    }

                                    Device (TB36)
                                    {
                                        Name (_ADR, 0x00060000)  // _ADR: Address
                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            Return (One)
                                        }
                                    }
                                }
                            }

                            Device (TB04)
                            {
                                Name (_ADR, 0x00040000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }

                                Device (TB4U)
                                {
                                    Name (_ADR, Zero)  // _ADR: Address
                                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                    {
                                        Return (One)
                                    }

                                    Device (TB40)
                                    {
                                        Name (_ADR, Zero)  // _ADR: Address
                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                Return (One)
                                            }
                                        }
                                    }

                                    Device (TB43)
                                    {
                                        Name (_ADR, 0x00030000)  // _ADR: Address
                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            Return (One)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                Return (One)
                                            }
                                        }
                                    }

                                    Device (TB44)
                                    {
                                        Name (_ADR, 0x00040000)  // _ADR: Address
                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            Return (One)
                                        }

                                        Device (DEV0)
                                        {
                                            Name (_ADR, Zero)  // _ADR: Address
                                            Method (_STA, 0, NotSerialized)  // _STA: Status
                                            {
                                                Return (0x0F)
                                            }

                                            Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                            {
                                                Return (One)
                                            }
                                        }
                                    }

                                    Device (TB45)
                                    {
                                        Name (_ADR, 0x00050000)  // _ADR: Address
                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            Return (One)
                                        }
                                    }

                                    Device (TB46)
                                    {
                                        Name (_ADR, 0x00060000)  // _ADR: Address
                                        Method (_STA, 0, NotSerialized)  // _STA: Status
                                        {
                                            Return (0x0F)
                                        }

                                        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                        {
                                            Return (One)
                                        }
                                    }
                                }
                            }

                            Device (TB05)
                            {
                                Name (_ADR, 0x00050000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }
                            }

                            Device (TB06)
                            {
                                Name (_ADR, 0x00060000)  // _ADR: Address
                                Method (_STA, 0, NotSerialized)  // _STA: Status
                                {
                                    Return (0x0F)
                                }

                                Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                                {
                                    Return (One)
                                }
                            }
                        }
                    }
                }

                Method (DTGP, 5, NotSerialized)
                {
                    If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b")))
                    {
                        If ((Arg1 == One))
                        {
                            If ((Arg2 == Zero))
                            {
                                Arg4 = Buffer (One)
                                    {
                                         0x03                                             // .
                                    }
                                Return (One)
                            }

                            If ((Arg2 == One))
                            {
                                Return (One)
                            }
                        }
                    }

                    Arg4 = Buffer (One)
                        {
                             0x00                                             // .
                        }
                    Return (Zero)
                }
            }
        If (_OSI ("Darwin"))
        {
            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
//                \_SB.TBFP (One)
//                TBTS = One
//                Local0 = 10000 // 10 seconds
//                While (Local0 > 0 && \_SB.PCI0.RP15.PXSX.AVND == 0xFFFFFFFF)
//                {
//                    Sleep (1)
//                    Local0--
//                }    
//                Notify (\_SB.WTBT, 0)
            }
        }
        }
    }
}

