. $PSScriptRoot\_check-admin.ps1

$CREATEMORE = "N"

DO {
. $PSScriptRoot\_get-hostnames.ps1
. $PSScriptRoot\_get-websiteroot.ps1
. $PSScriptRoot\update-hostfile.ps1;
. $PSScriptRoot\create-local-ssl-cert.ps1;
. $PSScriptRoot\create-iis-site.ps1;

# Reset Variables
$HOSTNAMES = $null
$WEBROOTPATH = $null
$CREATEMORE = READ-HOST("Create another site? (y|n)")

} WHILE($CREATEMORE -eq "y" -or $CREATEMORE -eq "Y")
