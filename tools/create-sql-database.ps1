if (!$SQLSERVER) {
	Write-Host "Please enter SQL server (ex .)"
	$SQLSERVER = Read-Host "Enter (ex: .|localhost)"
}

if (!$DATABASENAME) {
	Write-Host "Please enter database name"
	$DATABASENAME = Read-Host "Enter"
}

New-DbaDatabase -Name $DATABASENAME -SqlInstance $SQLSERVER -Collation Latin1_General_CS_AI

$COMMERCEDBNAME = $DATABASENAME + ".Commerce"
$CREATECOMMERCEDB = Read-Host "Also create a $COMMERCEDBNAME database (y|n)"

if ($CREATECOMMERCEDB -eq "Y" -or $CREATECOMMERCEDB -eq "y") {
	New-DbaDatabase -Name $COMMERCEDBNAME -SqlInstance $SQLSERVER -Collation Latin1_General_CS_AI
}

#TODO USER Creation...
#TODO SQL ConnectionString Setup

# Example of removing
#Get-DbaDatabase -SqlInstance . -Database SqlTemp11 | Remove-DbaDatabase -Confirm:$false