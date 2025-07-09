<#
"JHVzZXJuYW1lID0gJGVudjp1c2VybmFtZTtlY2hvICR1c2VybmFtZQ=="  ==>  "$username = $env:username;echo $username"
#>

$Base64EncodedCommand = "JHVzZXJuYW1lID0gJGVudjp1c2VybmFtZTtlY2hvICR1c2VybmFtZQ=="
$DecodedBytes = [Convert]::FromBase64String($Base64EncodedCommand)
$DecodedCommand = [System.Text.Encoding]::UTF8.GetString($DecodedBytes)
Write-Host $DecodedCommand






