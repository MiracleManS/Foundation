. $PSScriptRoot\_check-admin.ps1
. $PSScriptRoot\_get-hostnames.ps1
. $PSScriptRoot\_get-websiteroot.ps1

Import-Module WebAdministration

$hostname = $HOSTNAMES[0]
$iisSite = $HOSTNAME

# http.sys mapping of ip/hostheader to cert
$cert = (Get-ChildItem $CERTPATH | where-object { $_.Subject -like "*$hostname*" } | Select-Object -First 1).Thumbprint
$guid = [guid]::NewGuid().ToString("B")
netsh http add sslcert hostnameport="${hostname}:443" certhash=$cert certstorename=MY appid="$guid"

$appPoolExists = Get-ChildItem -Path "IIS:\AppPools\" | Where-Object { $_.Name -eq $hostname } | Select-Object -First 1

if ($appPoolExists) {
    $appPool = $appPoolExists
}
else {
    $appPool = New-WebAppPool -name $hostname -Force
    $appPool.enable32BitAppOnWin64 = 1
    $appPool | Set-Item
}
New-Website -Name $iisSite -Port 80 -HostHeader $hostname -PhysicalPath $WEBROOTPATH -ApplicationPool $appPool.Name -Force

# iis site mapping ip/hostheader/port to cert - also maps certificate if it exists
# for the particular ip/port/hostheader combo
# SSL FLAGS
# 0  No SNI
# 1  SNI Enabled
# 2  Non SNI binding which uses Central Certificate Store.
# 3  SNI binding which uses Central Certificate store

New-WebBinding -name $iisSite -Protocol https  -HostHeader $hostname -Port 443 -SslFlags 1

# netsh http delete sslcert hostnameport="${hostname}:443"
# netsh http show sslcert

Write-Host "Setting Permissions"

$path = $WEBROOTPATH
$user = "IIS APPPOOL\$hostname" #User account to grant permisions too.
$Rights = "FullControl" #Comma seperated list.
$InheritSettings = "Containerinherit, ObjectInherit" #Controls how permissions are inherited by children
$PropogationSettings = "None" #Usually set to none but can setup rules that only apply to children.
$RuleType = "Allow" #Allow or Deny.

$acl = Get-Acl $path
$perm = $user, $Rights, $InheritSettings, $PropogationSettings, $RuleType
$rule = New-Object -TypeName System.Security.AccessControl.FileSystemAccessRule -ArgumentList $perm
# https://docs.microsoft.com/en-us/dotnet/api/system.security.accesscontrol.filesystemrights?view=netframework-4.8
$rule2 = New-Object System.Security.AccessControl.FileSystemAccessRule("IIS_IUSRS", "ReadData", "ContainerInherit,ObjectInherit", "None", "Allow")
$acl.SetAccessRule($rule)
$acl.SetAccessRule($rule2)
$acl | Set-Acl -Path $path