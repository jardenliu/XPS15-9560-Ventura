//
// SSDT-PTSWAK.dsl
//
// Dell XPS 15 9560 
//
// This SSDT powers up the dGPU before sleep and turns it off after wake.
// This is needed because the DSDT sleep routine expects the device to exist.
// Otherwise, upon waking the laptop the dGPU might be residually powered
// and power consumption jumps (ex. 1.5W idle to 5W idle), which kills battery life.
//
// DSDT patches to rename _PTS and _WAK to ZPTS and ZWAK are needed.
//
// Would not have been possible without the work of RehabMan.
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config
//

DefinitionBlock("", "SSDT", 2, "hack", "PTSWAK", 0)
{
    External(ZPTS, MethodObj)
    External(ZWAK, MethodObj)

    External(_SB.PCI0.PEG0.PEGP._ON, MethodObj)
    External(_SB.PCI0.PEG0.PEGP._OFF, MethodObj)

    External(RMCF.DPTS, IntObj)
    External(RMCF.SHUT, IntObj)

    // In DSDT, native _PTS and _WAK are renamed ZPTS/ZWAK
    // As a result, calls to these methods land here.
    Method(_PTS, 1)
    {
        // Shutdown fix, if enabled
        If (CondRefOf(\RMCF.SHUT)) { If (\RMCF.SHUT && 5 == Arg0) { Return } }
        // More  like: yeah, why would you turn on the dGPU before shutdown???

        If (CondRefOf(\RMCF.DPTS))
        {
            If (\RMCF.DPTS)
            {
                // enable discrete graphics
                \_SB.PCI0.PEG0.PEGP._ON()
            }
        }

        // call into original _PTS method
        ZPTS(Arg0)
    }
    Method(_WAK, 1)
    {
        // Take care of bug regarding Arg0 in certain versions of OS X...
        // (starting at 10.8.5, confirmed fixed 10.10.2)
        If (Arg0 < 1 || Arg0 > 5) { Arg0 = 3 }

        // call into original _WAK method
        Local0 = ZWAK(Arg0)

        If (CondRefOf(\RMCF.DPTS))
        {
            If (\RMCF.DPTS)
            {
                // disable discrete graphics
                \_SB.PCI0.PEG0.PEGP._OFF()
            }
        }

        // return value from original _WAK
        Return (Local0)
    }
}
//EOF
