// Fix instant wake when sleeping on AC power
// Patch: Rename GPRW to XPRW
// References:
// [1] https://github.com/daliansky/OC-little/tree/master/14-0D6D%E8%A1%A5%E4%B8%81
// [2] https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/hotpatch/SSDT-UPRW.dsl

DefinitionBlock ("", "SSDT", 2, "hack", "GPRW", 0x00000000)
{
    External (XPRW, MethodObj)    // 2 Arguments

    Scope (\)
    {
        Method (GPRW, 2, NotSerialized)
        {
            If (_OSI ("Darwin") && (0x6D == Arg0))
            {
                Return (Package (0x02)
                {
                    0x6D, 
                    Zero
                })
            }
            
            Return (\XPRW (Arg0, Arg1))
        }
    }
    External(_SB.LID0, DeviceObj)
    External(_SB.XTNV, MethodObj)
    
    Scope (_SB)
    {
        Method (BTNV, 2, NotSerialized)
        {
            If (_OSI ("Darwin") && (Arg0 == 2))
            {
                If (\SLPC.SMOD == 1) //PNP0C0E
                {
                    \SLPC.SFNK =1
                    \_SB.XTNV(Arg0, Arg1)
                }
                Else //PNP0C0D
                {
                    If (\SLPC.SFNK!=1)
                    {
                        \SLPC.SFNK =1
                    }
                    Else
                    {
                        \SLPC.SFNK =0
                    }
                    Notify (\_SB.LID0, 0x80)
                }
            }
            Else
            {
                \_SB.XTNV(Arg0, Arg1)
            }
        }
    }
    
    External(_SB.LID0, DeviceObj)
    External(_SB.LID0.XLID, MethodObj)
    Scope (_SB.LID0)
    {
        Method (_LID, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                if(\SLPC.SFNK==1)
                {
                    Return (0)
                }
                Else
                {
                    Return (\_SB.LID0.XLID())
                }
            }
            Else
            {
                Return (\_SB.LID0.XLID())
            }
        }
    }

    Method (WAKL, 1, NotSerialized)
    {   
        If (3 == Arg0)
        {
                Notify (\_SB.LID0, 0x80)

        }
    }
    
    Device (SLPC)
    {
        Name (_ADR, Zero)  // _ADR: Address
        Method (HELP, 0, NotSerialized)
        {
            Debug = "SMOD indicates mode of sleep. 0: PNP0C0D, 1: PNP0C0E"
            Debug = "SFNK indicates state of sleep. 1: Press Sleep Function Key"
        }
        Name (SMOD, Zero)
        Name (SFNK, Zero)
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
    } 

}

