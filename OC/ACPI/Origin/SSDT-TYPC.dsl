// Type-C hotplug
// Patch: Rename RP15.PXSX._RMV to XRMV
// Find: X1JNVgCkABQGX1BTMAAUSwVfUFMzAHJNTVRCC0gFYFuAUFhWRABgCghbgRBQWFZEA1RCMlAgUDJUQiCgLpCTVEJUUwGTU0JOUlRCVVNBREJHDXNlbmRpbmcgU1hfU1RBUlQAcAodUDJUQhQtSFBNRQigJpCSk1ZESUQM
// Replace: WFJNVgCkABQGX1BTMAAUSwVfUFMzAHJNTVRCC0gFYFuAUFhWRABgCghbgRBQWFZEA1RCMlAgUDJUQiCgLpCTVEJUUwGTU0JOUlRCVVNBREJHDXNlbmRpbmcgU1hfU1RBUlQAcAodUDJUQhQtSFBNRQigJpCSk1ZESUQM
// References:
// [1] https://www.insanelymac.com/forum/topic/324366-dell-xps-15-9560-4k-touch-1tb-ssd-32gb-ram-100-adobergb%E2%80%8B/
// [2] https://www.tonymacx86.com/threads/usb-c-hotplug-questions.211313/
// [3] https://github.com/the-darkvoid/XPS9360-macOS/issues/118

DefinitionBlock ("", "SSDT", 2, "hack", "TYPC", 0x00000000)
{
    External (_SB_.PCI0.RP15.PXSX, DeviceObj)

    // turn off warning that will cause sleep failure[2]
    Scope (\_GPE)
    {
        Method (YTBT, 2, NotSerialized)
        {
            Return (Zero)
        }
    }

    Scope (\_SB.PCI0.RP15.PXSX)
    {
        // key method to make type-c removable
        Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
        {
            If (_OSI ("Darwin"))
            {
                Return (One)
            }
            Else
            {
                Return (Zero)
            }
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (0x0F)
        }
    }
}

