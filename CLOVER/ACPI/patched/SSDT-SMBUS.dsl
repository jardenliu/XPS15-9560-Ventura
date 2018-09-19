//
// SSDT-SMBUS.dsl
//
// Dell XPS 15 9560
//
// This SSDT adds a missing SMBUS (Intel System Management Bus) device to the system.
//
// Credit to RehabMan:
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config
//

DefinitionBlock("", "SSDT", 2, "hack", "SMBUS", 0)
{
    Device(_SB.PCI0.SBUS.BUS0)
    {
        Name(_CID, "smbus")
        Name(_ADR, Zero)
    }
    Device(_SB.PCI0.SBUS.BUS1)
    {
        Name(_CID, "smbus")
        Name(_ADR, One)
    }
}
//EOF
