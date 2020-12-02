// 
// Sleep Issues Fix Table
// Rename In Config:
//
// GPRW to XPRW
// Find:47505257 02
// Replace: 58505257 02
//
// UPRW to YPRW
// Find: 55505257 00
// Replace: 59505257 00
//
// _WAK to ZWAK
// Find: 14395F57 414B01
// Replace: 14395A57 414B01
//
DefinitionBlock ("", "SSDT", 2, "DXPS", "SLP5", 0)
{
    External (_SB.PCI0, DeviceObj)
    External (RMDC.DGOF, MethodObj)
    External (XPRW, MethodObj)
    External (ZWAK, MethodObj)

    // Abstract a New Device and Define some variables to control dgpu and sleep
    If (_OSI ("Darwin"))
    {
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
            Name (DIDE, 0)
            Name (DPTS, 1)
            Method (_STA, 0)  // _STA: Status
            {
                Return (0x0F)
            }
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

    Method (_WAK, 1)  // _WAK: Wake
    {
        Local0 = ZWAK (Arg0)
        If (_OSI ("Darwin"))
        {
            \RMDC.DGOF ()
        }
        Return (Local0)
    }

    If (_OSI ("Darwin") && (\SLPC.DIDE == 1))
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
