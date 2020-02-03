// Disable discrete GPU on bootup
// Reference:
// [1] https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/hotpatch/SSDT-DDGPU.dsl

DefinitionBlock ("", "SSDT", 2, "hack", "RMDC", 0x00000000)
{
    External (_SB_.PCI0.PEG0.PEGP._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP02, DeviceObj)
    External (_SB_.PCI0.RP02.PXSX.XSTA, MethodObj) 
    External (ZWAK, MethodObj)
    // disable dGPU on bootup[1]
    
    Method (DGPU, 0, NotSerialized){
        If ((_OSI ("Darwin")) && (CondRefOf (\_SB.PCI0.PEG0.PEGP._OFF)))
            {
                \_SB.PCI0.PEG0.PEGP._OFF ()
            }
    }
    
    Device (RMDC)
    {
        Name (_HID, "RMD10000")  // _HID: Hardware ID
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            DGPU ()
        }
    }

    Scope (_SB.PCI0.RP02)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (\_SB.PCI0.RP02.PXSX.XSTA ())
            }
        }
    }
        Method (_WAK, 1)
    {
        Local0 = ZWAK (Arg0)
        If (_OSI ("Darwin"))
        {
            DGPU ()
        }
        Return (Local0)
    }

}

