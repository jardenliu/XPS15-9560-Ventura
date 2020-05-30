
DefinitionBlock ("", "SSDT", 2, "hack", "XOSI", 0x00000000)
{
    External (_SB.ACOS, IntObj)
    External (_SB.ACSE, IntObj)
    External (OSUM, MutexObj)
    External (_PR_.DTSE, UnknownObj)
    External (_PR_.DSAE, UnknownObj)
    External (TBTS, FieldUnitObj)
    External (TBSE, FieldUnitObj)
    External (OSYS, FieldUnitObj)
    External (W98S, StrObj)
    External (NT5S, StrObj)
    External (WINM, StrObj)
    External (WXP, StrObj)
    External (WLG, StrObj)
    External (WIN7, StrObj)
    External (WIN8, StrObj)
    External (WN81, StrObj)
    External (LINX, StrObj)
    External (_SB, DeviceObj)
    External (_SB.PCI0, DeviceObj)
    External (WFEV, EventObj)
    External (EV3_, MethodObj)
    External (ECG3, MethodObj)
    External (P8XH, MethodObj)
    External (STRE, MethodObj)
    External (_GPE.TINI, MethodObj)
    External (_SB_.PCI0.GFX0.GLID, MethodObj)
    Scope (_SB)
    {
        Name (OSX, "Darwin")
        Method (OSID, 0, NotSerialized)
        {
            If ((ACOS == Zero))
            {
                ACOS = One
                ACSE = Zero
                If (CondRefOf (\_OSI, Local0))
                {
                    If (_OSI (WXP))
                    {
                        ACOS = 0x10
                    }

                    If (_OSI (WLG))
                    {
                        ACOS = 0x20
                    }

                    If (_OSI (WIN7))
                    {
                        ACOS = 0x80
                    }

                    If (_OSI (WIN8))
                    {
                        ACOS = 0x80
                        ACSE = One
                    }

                    If (_OSI (WN81) || _OSI (OSX))
                    {
                        ACOS = 0x80
                        ACSE = 0x02
                    }

                    If (_OSI (LINX))
                    {
                        ACOS = 0x40
                    }
                }
                Else
                {
                    If (STRE (_OS, W98S))
                    {
                        ACOS = 0x02
                    }

                    If (STRE (_OS, WINM))
                    {
                        ACOS = 0x04
                    }

                    If (STRE (_OS, NT5S))
                    {
                        ACOS = 0x08
                    }
                }
            }

            OperationRegion (SBAD, SystemIO, 0x72, 0x02)
            Field (SBAD, ByteAcc, Lock, Preserve)
            {
                B72P,   8, 
                B73P,   8
            }

            B72P = Zero
            B73P = Zero
            Return (ACOS) /* \_SB_.ACOS */
        }
    }
    Scope (_SB.PCI0)
    {
        Method (_INI, 0, Serialized)  // _INI: Initialize
        {
            OSYS = 0x07D0
            If (CondRefOf (\_OSI))
            {
                If (_OSI ("Windows 2001"))
                {
                    OSYS = 0x07D1
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    OSYS = 0x07D1
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    OSYS = 0x07D2
                }

                If (_OSI ("Windows 2001.1"))
                {
                    OSYS = 0x07D3
                }

                If (_OSI ("Windows 2006"))
                {
                    OSYS = 0x07D6
                }

                If (_OSI ("Windows 2009"))
                {
                    OSYS = 0x07D9
                }

                If (_OSI ("Windows 2012"))
                {
                    OSYS = 0x07DC
                }

                If (_OSI ("Windows 2013"))
                {
                    OSYS = 0x07DD
                }

                If (_OSI ("Windows 2015") || _OSI ("Darwin"))
                {
                    OSYS = 0x07DF
                }
            }

            If (CondRefOf (\_PR.DTSE))
            {
                If ((\_PR.DTSE >= One))
                {
                    \_PR.DSAE = One
                }
            }

            If ((TBTS == One))
            {
                Acquire (OSUM, 0xFFFF)
                P8XH (Zero, 0x51)
                \_GPE.TINI (TBSE, Zero)
                Release (OSUM)
                Signal (WFEV)
            }

            EV3 (0x02, Zero)
            If (ECG3 ())
            {
                ^GFX0.GLID (0x03)
            }
            Else
            {
                ^GFX0.GLID (Zero)
            }

            If (CondRefOf (\_OSI, Local0))
            {
                If ((_OSI ("Windows 2009") || _OSI ("Windows 2013")))
                {
                    OperationRegion (PCF0, SystemMemory, 0xF0100000, 0x0200)
                    Field (PCF0, ByteAcc, NoLock, Preserve)
                    {
                        HVD0,   32, 
                        Offset (0x160), 
                        TPR0,   8
                    }

                    OperationRegion (PCF1, SystemMemory, 0xF0200000, 0x0200)
                    Field (PCF1, ByteAcc, NoLock, Preserve)
                    {
                        HVD1,   32, 
                        Offset (0x160), 
                        TPR1,   8
                    }

                    OperationRegion (PCF2, SystemMemory, 0xF00E0000, 0x0300)
                    Field (PCF2, ByteAcc, NoLock, Preserve)
                    {
                        HVD2,   32, 
                        Offset (0x20C), 
                        BPR2,   8
                    }

                    OperationRegion (PCF3, SystemMemory, 0xF00E2000, 0x0300)
                    Field (PCF3, ByteAcc, NoLock, Preserve)
                    {
                        HVD3,   32, 
                        Offset (0x20C), 
                        BPR3,   8
                    }

                    If ((HVD0 == 0x24FD8086))
                    {
                        If ((TPR0 != 0xF0))
                        {
                            TPR0 = 0xF0
                            BPR2 = 0xF0
                        }
                    }

                    If ((HVD1 == 0x24FD8086))
                    {
                        If ((TPR1 != 0xF0))
                        {
                            TPR1 = 0xF0
                            BPR3 = 0xF0
                        }
                    }
                }
            }
        }
    }
}

