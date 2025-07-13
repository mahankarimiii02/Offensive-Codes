$source = "https://example.com/file.exe"
$destination =  "C:\path\to\save\file.exe"

$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($source , $destination)