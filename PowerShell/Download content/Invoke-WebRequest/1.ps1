$source = "https://example.com/file.exe"
$destination = "C:\path\to\save\file.exe"

Invoke-WebRequest -Uri $source -OutFile $destination