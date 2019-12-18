if (!$HOSTNAMES) {
	Write-Host "Please enter host names for SSL certs to create (comma separated)"
	$HOSTNAMES = (Read-Host "Enter (ex: local.website.com,local2.website.com").Split(",", [System.StringSplitOptions]::RemoveEmptyEntries)
}