$HostFile = 'C:\Windows\System32\drivers\etc\hosts'
 
. $PSScriptRoot\_check-admin.ps1
. $PSScriptRoot\_get-hostnames.ps1

# Get the contents of the Hosts file
$File = Get-Content $HostFile
 
# write the Entries to hosts file, if it doesn't exist.
foreach ($HostFileEntry in $HOSTNAMES) {
    Write-Host "Checking existing HOST file entries for $HostFileEntry..."
     
    #Set a Flag
    $EntryExists = $false
     
    if ($File -contains "127.0.0.1 `t $HostFileEntry") {
        Write-Host "Host File Entry for $HostFileEntry is already exists."
        $EntryExists = $true
    }
    #Add Entry to Host File
    if (!$EntryExists) {
        Write-host "Adding Host File Entry for $HostFileEntry"
        Add-content -path $HostFile -value "127.0.0.1 `t $HostFileEntry"
    }
}