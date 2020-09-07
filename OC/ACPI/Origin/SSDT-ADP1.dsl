// AC Table
DefinitionBlock ("", "SSDT", 2, "DXPS", "ADP1", 0)
{
    External (_SB_.AC__, DeviceObj)
    If (_OSI ("Darwin"))
    {
        Scope (\_SB.AC)
        {
            Name (_PRW, Package ()  // _PRW: Power Resources for Wake
            {
                0x18, 
                3
            })
        }
    }
}

