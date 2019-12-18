if (!$WEBROOTPATH) {
	Write-Host "Please enter the full path to the folder for the website root"
	$WEBROOTPATH = Read-Host "Enter (ex: c:\full\path\to\folder\with\bin)"
}