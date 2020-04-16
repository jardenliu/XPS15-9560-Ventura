// PCI DeviceInject

DefinitionBlock ("", "SSDT", 2, "DXPS", "PCID", 0x00000000)
{
    // DMAC and PMCR
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PCI0.LPCB, DeviceObj)
    
    If (_OSI ("Darwin"))
    {
        Scope (_SB.PCI0.LPCB)
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
            Device (EC)
            {
                Name (_HID, "ACID0001")
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0F)
                }
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

        Scope (_SB.PCI0)
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
        }
    }
}

