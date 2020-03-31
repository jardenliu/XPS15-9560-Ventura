// Adding PNLF device for WhateverGreen.kext and others.
// This is a modified PNLF version originally taken from RehabMan/OS-X-Clover-Laptop-Config repository:
// https://raw.githubusercontent.com/RehabMan/OS-X-Clover-Laptop-Config/master/hotpatch/SSDT-PNLF.dsl
// Rename GFX0 to anything else if your IGPU name is different.
//
// Licensed under GNU General Public License v2.0
// https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/License.md

DefinitionBlock("", "SSDT", 2, "hack", "_PNLF", 0)
{
    External (_SB.PCI0.GFX0, DeviceObj)
    External (_SB.PCI0.GFX0.DD1F._BCL, MethodObj)
    External (_SB.PCI0.GFX0.DD1F._BCM, MethodObj)
    External (_SB.PCI0.GFX0.DD1F._BQC, MethodObj)
    External (_SB.PCI0.GFX0._DOS, MethodObj)
    Scope(_SB)
    {
        Device(PNLF)
        {
            Name (_ADR, Zero)
            Name (_HID, EisaId ("APP0002"))
            Name (_CID, "backlight")
            Name (_UID, 16)
            // _BCM/_BQC: set/get for brightness level
            Method (_BCM, 1, NotSerialized)
            {
                \_SB.PCI0.GFX0.DD1F._BCM(Arg0)
            }
            Method (_BQC, 0, NotSerialized)
            {
                Return(\_SB.PCI0.GFX0.DD1F._BQC())
            }
            Method (_BCL, 0, NotSerialized)
            {
                Return (Package (0x13)
                {
                    0x056C, 
                    0xFC, 
                    Zero, 
                    0x18, 
                    0x27, 
                    0x3A, 
                    0x52, 
                    0x71, 
                    0x96, 
                    0xC4, 
                    0xFC, 
                    0x0140, 
                    0x0193, 
                    0x01F6, 
                    0x026E, 
                    0x02FE, 
                    0x03AA, 
                    0x0478, 
                    0x056C
                })
            }
            Method (_DOS, 1, NotSerialized)
            {
                \_SB.PCI0.GFX0._DOS(Arg0)
            }
            // extended _BCM/_BQC for setting "in between" levels
            Method (XBCM, 1, NotSerialized)
            {
                // Update backlight via existing DSDT methods
                \_SB.PCI0.GFX0.DD1F._BCM(Arg0)
            }
            Method (XBQC, 0, NotSerialized)
            {
                Return(\_SB.PCI0.GFX0.DD1F._BQC())
            }
            // Use XOPT=1 to disable smooth transitions
            Name (XOPT, Zero)
            // XRGL/XRGH: defines the valid range
            Method (XRGL, 0, NotSerialized)
            {
                Store(_BCL(), Local0)
                Store(DerefOf(Index(Local0, 2)), Local0)
                Return(Local0)
            }
            Method (XRGH, 0, NotSerialized)
            {
                Store(_BCL(), Local0)
                Store(DerefOf(Index(Local0, Subtract(SizeOf(Local0), 1))), Local0)
                Return(Local0)
            }
            Method (_INI, 0, NotSerialized)
            {
                //XRGL()
                //XRGH()
            }
            Method (_STA, 0, NotSerialized)
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0B)
                }
                Else
                {
                    Return (Zero)
                }
            }
        }        
    }
}
