
DefinitionBlock("", "SSDT", 2, "ACDT", "PTSWAK", 0)
{
    External(ZPTS, MethodObj)
    External(ZWAK, MethodObj)
    External(WAKL, MethodObj)
    External (_SB_.PCI0.PEG0.PEGP._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.PEG0.PEGP._ON_, MethodObj) 
    External (SLPC.SFNK, IntObj)
    External (SLPC.SMOD, IntObj)
    
    Method (_PTS, 1, NotSerialized) //Method (_PTS, 1, Serialized)
    {
        If (_OSI ("Darwin"))
        {
            if(\SLPC.SFNK ==1)
            {
                Arg0 = 3
            }
        }

        ZPTS(Arg0)
    }
    
    Method (_WAK, 1, NotSerialized) //Method (_WAK, 1, Serialized)
    {   
        If (_OSI ("Darwin"))
        {
            if(\SLPC.SFNK ==1)
            {
                \SLPC.SFNK =0
                Arg0 = 3
            }
            WAKL(Arg0)
        }

        Local0 = ZWAK(Arg0)
        Return (Local0)
    }
}
//EOF
