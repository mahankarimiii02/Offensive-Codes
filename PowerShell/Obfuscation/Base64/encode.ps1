<#
"$username = $env:username;echo $username"  ==>  "JHVzZXJuYW1lID0gJGVudjp1c2VybmFtZTtlY2hvICR1c2VybmFtZQ=="
#>

$Command = "$username = $env:username;echo $username"
$EncodedBytes = [System.Text.Encoding]::UTF8.GetBytes($Command)
$Base64Command = [Convert]::ToBase64String($EncodedBytes)
Write-Host $Base64Command






