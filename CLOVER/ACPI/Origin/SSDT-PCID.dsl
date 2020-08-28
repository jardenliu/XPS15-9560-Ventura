// PCI DeviceInject

DefinitionBlock ("", "SSDT", 2, "DXPS", "PCID", 0x00000000)
{
    // DMAC and PMCR
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    External (ECRB, MethodObj) // Embedded controller - Read byte
    External (ECWB, MethodObj) // Embedded controller - Write byte
    External (ECRW, MethodObj) // Embedded controller - Read word
    External (ECM1, MutexObj)  // Embedded controller - Battery mutex

    
    If (_OSI ("Darwin"))
    {
        Device (SMCD) // ACPISensors virtual device
        {
            Name (_HID, "MON00000") // _HID: Hardware ID

            Mutex (SMCX, 0x00)

        // Query embedded controller for data (byte)
            Method (ECQB, 3, Serialized)
            {
                Acquire (SMCX, 0xFFFF)

                If (Arg0 > Zero)
                {
                    \ECWB(Arg0, Arg2)
                }
                Local0 = Zero
                If (Arg1 > 0)
                {
                    Local0 = \ECRB(Arg1)
                }

                Release (SMCX)

                If (Local0 >= 0x80)
                {
                    Local0 = Zero
                }

                Return (Local0)
            }

            // Query embedded controller for data (word)
            Method (ECQW, 3, Serialized)
            {
                Acquire (SMCX, 0xFFFF)

                If (Arg0 > Zero)
                {
                    \ECWB(Arg0, Arg2)
                }
                Local0 = Zero

                If (Arg1 > 0)
                {
                    Local0 = \ECRW(Arg1)
                }

                Release (SMCX)

                Return (Local0)
            }

            // Note that only devices names as defined in xxxx are allowed.
            // https://github.com/RehabMan/OS-X-FakeSMC-kozlek/blob/master/FakeSMCKeyStore/FakeSMCPlugin.cpp#L38
            Name (TEMP, Package()
            {
                // B0D4._TMP - 8086_1903
                "CPU Heatsink", "TCPU",
                // SEN1._TMP - FAN1
                "CPU Proximity", "TFN1",
                // GEN1._TMP - FAN2
                "Mainboard", "TFN2",
                // SEN2._TMP - SSD HT4
                "PCH Proximity", "TSSD",
                // TMEM._TMP - Memory Temperature Sensor (HT1)
                "Memory Module", "TMEM",
            })

            Method (TCPU, 0, Serialized)
            {
                // B0D4._TMP
                Local0 = ECQB(0x33, 0x34, 0x00)
                Return (Local0)
            }

            Method (TFN1, 0, Serialized)
            {
                // SEN1._TMP
                Local0 = ECQB(0x33, 0x34, 0x01)
                Return (Local0)
            }

            Method (TFN2, 0, Serialized)
            {
                // GEN1._TMP
                Local0 = ECQB(0x33, 0x34, 0x02)
                Return (Local0)
            }
            Method (TSSD, 0, Serialized)
            {
                // SEN2._TMP
                Local0 = ECQB(0x33, 0x34, 0x03)
                Return (Local0)       
            }

            Method (TMEM, 0, Serialized)
            {
                // TMEM._TMP
                Local0 = ECQB(0x33, 0x34, 0x04)
                Return (Local0)               
            }

            Name (VOLT, Package()
            {
                "Battery", "VBAT"
            })

            Method (VBAT, 0, Serialized)
            {
                // BAT0._BST
                Acquire (ECM1, 0xFFFF)
                Local0 = ECQW(0x03, 0x14, 0x01)
                Release (ECM1)

                Return (Local0)
            }
        }

        Scope (\_SB)
        {
            Device (USBX)
            {
                Name (_ADR, Zero)  // _ADR: Address
                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If ((Arg2 == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03                                             // .
                        })
                    }

                    Return (Package (0x08)
                    {
                        "kUSBSleepPowerSupply", 
                        0x13EC, 
                        "kUSBSleepPortCurrentLimit", 
                        0x0834, 
                        "kUSBWakePowerSupply", 
                        0x13EC, 
                        "kUSBWakePortCurrentLimit", 
                        0x0834
                    })
                }
            }
            
            Scope (PCI0)
            {
                Device (MCHC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)
                    {
                        Return (0x0F)
                    }
                }
                Scope (SBUS)
                {
                    Device (BUS0)
                    {
                        Name (_CID, "smbus")
                        Name (_ADR, Zero)
                        Device (DVL0)
                        {
                            Name (_ADR, 0x57)
                            Name (_CID, "diagsvault")
                            Method (_DSM, 4, NotSerialized)
                            {
                                If (!Arg2)
                                {
                                    Return (Buffer (One)
                                    {
                                         0x03
                                    })
                                }
                                Return (Package (0x02)
                                {
                                    "address", 
                                    0x57
                                })
                            }
                        }
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (0x0F)
                        }
                    }
                }
                Scope (LPCB)
                {
                    Device (DMAC)
                    {
                        Name (_HID, EisaId ("PNP0200") /* PC-class DMA Controller */)  // _HID: Hardware ID
                        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                        {
                            IO (Decode16,
                                0x0000,             // Range Minimum
                                0x0000,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            IO (Decode16,
                                0x0081,             // Range Minimum
                                0x0081,             // Range Maximum
                                0x01,               // Alignment
                                0x11,               // Length
                                )
                            IO (Decode16,
                                0x0093,             // Range Minimum
                                0x0093,             // Range Maximum
                                0x01,               // Alignment
                                0x0D,               // Length
                                )
                            IO (Decode16,
                                0x00C0,             // Range Minimum
                                0x00C0,             // Range Maximum
                                0x01,               // Alignment
                                0x20,               // Length
                                )
                            DMA (Compatibility, NotBusMaster, Transfer8_16, )
                                {4}
                        })
                    }
                    Device (PMCR)
                    {
                        Name (_HID, EisaId ("APP9876"))
                        Name (_CRS, ResourceTemplate ()
                        {
                            Memory32Fixed (ReadWrite,
                                0xFE000000,
                                0x00010000 
                                )
                        })
                        Method (_STA, 0, NotSerialized)
                        {
                            Return (0x0B)
                        }
                    }
                }
            }
        }
    }
}

