// Inject CodeC of ALC298
DefinitionBlock ("", "SSDT", 1, "DXPS", "HDCC", 0)
{
    External (_SB_.PCI0.HDAS, DeviceObj)
    
    Scope (_SB_.PCI0.HDAS)
    {
        Name (RMCF, Package ()
        {
            "CodecCommander", Package()
            {
                "Custom Commands", Package()
                {
                    Package(){}, // signifies Array instead of Dictionary
                    Package()
                    {
                        // 0x18 SET_PIN_WIDGET_CONTROL 0x22
                        "Command", Buffer() { 0x01, 0x87, 0x07, 0x22 },
                        "On Init", ">y",
                        "On Sleep", ">n",
                        "On Wake", ">y",
                    },
                    Package()
                    {
                        // 0x1a SET_PIN_WIDGET_CONTROL 0x23
                        "Command", Buffer() { 0x01, 0xa7, 0x07, 0x23 },
                        "On Init", ">y",
                        "On Sleep", ">n",
                        "On Wake", ">y",
                    },
                    Package()
                    {
                        // 0x21 SET_UNSOLICITED_ENABLE 0x83
                        "Command", Buffer() { 0x02, 0x17, 0x08, 0x83 },
                        "On Init", ">y",
                        "On Sleep", ">n",
                        "On Wake", ">y",
                    },
                },
                "Perform Reset", ">n",
                //"Perform Reset on External Wake", ">n", // enable if using AppleALC
                "Send Delay", 10,
                "Sleep Nodes", ">n",
            }
        })
    }
}