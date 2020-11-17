//
// SSDT-UPRW.dsl
//
// Dell XPS 15 9560
//
// This SSDT provides USB sleep properties. Namely, this fixes "instant wake"
// on sleep while USB devices are plugged in.
//
// Would not have been possible without the work of RehabMan:
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config
//

DefinitionBlock("", "SSDT", 2, "hack", "UPRW", 0)
{
    External (YPRW, MethodObj)
    External (_SB.PCI0.XPRW, MethodObj)

    // In DSDT, native UPRW is renamed to XPRW with Clover binpatch.
    // As a result, calls to UPRW land here.
    //
    // The purpose of this implementation is to avoid "instant wake"
    // by returning 0 in the second position (sleep state supported)
    // of the return package.
    Scope (\)
    {
        Method (GPRW, 2)
        {
            If (0x6d == Arg0) { Return (Package() { 0x6d, 0, }) }
            Return (\YPRW (Arg0, Arg1))
        }
        
        Method (UPRW, 0)
        {
            Return (Zero)
            // The whole point of this is to make UPRW return 0
            // Don't need to call XPRW.
//            Return (\_SB.PCI0.XPRW())
        }
    }
}
//EOF
