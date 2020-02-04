// Disable Some Device on bootup
// Reference:
// [1] https://github.com/RehabMan/OS-X-Clover-Laptop-Config/blob/master/hotpatch/SSDT-DDGPU.dsl

DefinitionBlock ("", "SSDT", 2, "hack", "RMDC", 0x00000000)
{
    External (_SB_.PCI0.PEG0.PEGP._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP02, DeviceObj)
    External (_SB_.PCI0.RP02.PXSX.XSTA, MethodObj)
    External (_SB_.PCI0.I2C0, DeviceObj)  
    External (_SB_.PCI0.I2C0.XSTA, MethodObj) 
    External (_SB_.PCI0.RP02.PXSX._OFF, MethodObj) 
    External (ZWAK, MethodObj)
    // disable dGPU on bootup[1]
    
    Method (DGPU, 0, NotSerialized){
        If ((_OSI ("Darwin")) && (CondRefOf (\_SB.PCI0.PEG0.PEGP._OFF)))
            {
                \_SB.PCI0.PEG0.PEGP._OFF ()
            }
    }
    
    // disable ExpressCard on bootup
    Method (DXPC, 0, NotSerialized){
         If ((_OSI ("Darwin")) && (CondRefOf (\_SB.PCI0.RP02.PXSX._OFF)))
            {
                \_SB.PCI0.RP02.PXSX._OFF ()
            }
    }
    
    Device (RMDC)
    {
        Name (_HID, "RMD10000")  // _HID: Hardware ID
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            DGPU ()
            DXPC ()
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
}

