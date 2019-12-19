if ($null -eq $SOLUTIONPATH) {
    $SOLUTIONPATH = Read-Host("Please enter full path to SLN folder (ex: C:\folder\sub\)")
}

Get-ChildItem $SOLUTIONPATH -include node_modules,bin,obj,temp,packages,TestResults,*.log -Recurse | ForEach-Object ($_) { 
    Write-Host "Deleting " $_.FullName
    Remove-Item $_.FullName -Force -Recurse 
}