Param
(
    [Parameter(Mandatory=$true)] [string]$Environment, [Parameter(Mandatory=$true)] [string]$DropFolder
)
write-host "IdentityProviderSecret: $IdentityProviderSecret"
write-host "Environment: $Environment"
write-host "DropFolder: $DropFolder"

$configMapPath = "$DropFolder/Configuration/ConfigMaps/appsettings.configmaps.json"
$configMapJson = Get-Content $configMapPath | ConvertFrom-Json
$now = Get-Date
$configMapJson.ConfigMaps.Environment = -join("$Environment", " ", $now.ToUniversalTime().ToString('HH:mm:ss'))
$configMapJson | ConvertTo-Json | set-content $configMapPath

