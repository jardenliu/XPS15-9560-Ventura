// 
// Sleep Issues Fix Table
// Rename In Config:
//
// GPRW to XPRW
// Find:47505257 02
// Replace: 58505257 02
//
// BTNV to XTNV
// Find:42544E56 02
// Replace: 58544E56 02
//
// _LID to XLID
// Find: 5F4C4944 00
// Replace: 5F4C4944 00
//
// _PTS to ZPTS
// Find: 1449045F 50545301
// Replace: 1449045A 50545301
//
// _WAK to ZWAK
// Find: 14395F57 414B01
// Replace: 14395A57 414B01
//
DefinitionBlock ("", "SSDT", 2, "DXPS", "SLP5", 0)
{
    External (_SB_, DeviceObj)
    External (_SB_.LID0, DeviceObj)
    External (_SB_.LID0.XLID, MethodObj)
    External (_SB_.PCI0.PEG0.PEGP._OFF, MethodObj)
    External (_SB_.PCI0.PEG0.PEGP._ON_, MethodObj)
    External (_SB_.XTNV, MethodObj)
    External (WAKL, MethodObj)
    External (XPRW, MethodObj)
    External (ZPTS, MethodObj)
    External (ZWAK, MethodObj)

    // Abstract a New Device and Define some variables to control dgpu and sleep 
    Device (SLPC)
    {
        Name (_ADR, 0)  // _ADR: Address
        Method (HELP, 0)
        {
            Debug = "SMOD indicates mode of sleep. 0: PNP0C0D, 1: PNP0C0E"
            Debug = "SFNK indicates state of sleep. 1: Press Sleep Function Key"
            Debug = "DIDE indicates type of sleep. 1: DeepIdle"

        }

        Name (SMOD, 0)
        Name (SFNK, 0)
        Name (DIDE, 1)
        Name (DPTS, 1)
        Method (_STA, 0)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Return (0)
        }
    }
    
    // Change return value of GPRW to fix device couldnt sleep normally
    Scope (\)
    {
        Method (GPRW, 2)
        {
            If ((_OSI ("Darwin") && (0x6D == Arg0)))
            {
                Return (Package (2)
                {
                    0x6D, 
                    Zero
                })
            }

            Return (\XPRW (Arg0, Arg1))
        }
    }

    // Rewrite BTNV to fix kernel panic after sleep
    Scope (_SB)
    {
        Method (BTNV, 2)
        {
            If ((_OSI ("Darwin") && (Arg0 == 2)))
            {
                If ((\SLPC.SMOD == 1))
                {
                    \SLPC.SFNK = 1
                    \_SB.XTNV (Arg0, Arg1)
                }
                Else
                {
                    If ((\SLPC.SFNK != 1))
                    {
                        \SLPC.SFNK = 1
                    }
                    Else
                    {
                        \SLPC.SFNK = 0
                    }

                    Notify (\_SB.LID0, 0x80) // Status Change
                }
            }
            Else
            {
                \_SB.XTNV (Arg0, Arg1)
            }
        }
    }

    // Rewrite _LID to fix kernel panic after close lip sleep
    Scope (_SB.LID0)
    {
        Method (_LID, 0)  // _LID: Lid Status
        {
            If (_OSI ("Darwin"))
            {
                If ((\SLPC.SFNK == 1))
                {
                    Return (0)
                }
                Return (\_SB.LID0.XLID ())
            }
            Return (\_SB.LID0.XLID ())
        }
    }

    // Add a method to notify system sleep
    Method (WAKL, 1)
    {
        If ((3 == Arg0))
        {
            Notify (\_SB.LID0, 0x80) // Status Change
        }
    }

    Method (_PTS, 1)  // _PTS: Prepare To Sleep
    {
        If (_OSI ("Darwin"))
        {
            If ((\SLPC.SFNK == 1))
            {
                Arg0 = 3
            }

            \_SB.PCI0.PEG0.PEGP._ON ()
        }

        ZPTS (Arg0)
    }

    Method (_WAK, 1)  // _WAK: Wake
    {
        If (_OSI ("Darwin"))
        {
            If ((\SLPC.SFNK == 1))
            {
                \SLPC.SFNK = 0
                Arg0 = 3
            }

            \_SB.PCI0.PEG0.PEGP._OFF ()
            WAKL (Arg0)
        }

        Local0 = ZWAK (Arg0)
        Return (Local0)
    }

    If ((\SLPC.DIDE == 1))
    {

    Scope (\_SB)
    {
        Method (LPS0, 0)
        {
            Return (1)
        }
    }

    Scope (\_GPE)
    {
        Method (LXEN, 0)
        {
            Return (1)
        }
    }

    Scope (\)
    {
        Name (SLTP, 0)
        Method (_TTS, 1)  // _TTS: Transition To State
        {
            SLTP = Arg0
        }
    }
    }
}

