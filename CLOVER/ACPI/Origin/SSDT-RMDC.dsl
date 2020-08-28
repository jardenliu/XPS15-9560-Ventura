// Remove Some Device Table
// Remove NVIDIA GPU and Realtek SD Card
//
DefinitionBlock ("", "SSDT", 2, "DXPS", "RMDC", 0)
{
    External (_SB_.PCI0.PEG0.PEGP._OFF, MethodObj)
    External (_SB_.PCI0.PEG0.PEGP._ON, MethodObj)
    External (_SB_.PCI0.RP02.PXSX, PowerResObj)
    External (_SB_.PCI0.RP02.PXSX._OFF, MethodObj)
    External (_SB_.PCI0.RP02.PXSX.XSTA, MethodObj)
    
    // Abstract a New Device and Disable Devices when intilize the new one
    If (_OSI ("Darwin"))
    {
        Device (RMDC)
        {
            Name (_HID, "RMD10000")  // _HID: Hardware ID
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
            
                DGOF ()
                //SDOF ()
            }
            // Disable Nvidia GPU
            Method (DGOF, 0)
            {
                If (CondRefOf (\_SB.PCI0.PEG0.PEGP._OFF))
                {
                    \_SB.PCI0.PEG0.PEGP._OFF ()
                }
            }
            // Enable Nvidia GPU
            Method (DGON, 0)
            {
                If (CondRefOf (\_SB.PCI0.PEG0.PEGP._ON))
                {
                    \_SB.PCI0.PEG0.PEGP._ON ()
                }
            }
            // Diable SD Card
            Method (SDOF, 0)
            {
                If (CondRefOf (\_SB.PCI0.RP02.PXSX._OFF))
                {
                    \_SB.PCI0.RP02.PXSX._OFF ()
                }
            }
        }
    }
        // Ensure Disable SDCard
//    Scope (_SB.PCI0.RP02.PXSX)
//    {
//        Method (_STA, 0, NotSerialized)  // _STA: Status
//        {
//            If (_OSI ("Darwin"))
//            {
//                Return (Zero)
//            }
//            Return (\_SB.PCI0.RP02.PXSX.XSTA ())
//        }
//    }
}

