# This script installs IIS and the features required to
# run West Wind Web Connection.
#
# * Make sure you run this script from a Powershel Admin Prompt!
# * Make sure Powershell Execution Policy is bypassed to run these scripts:
# * YOU MAY HAVE TO RUN THIS COMMAND PRIOR TO RUNNING THIS SCRIPT!
Set-ExecutionPolicy Bypass -Scope Process
. $PSScriptRoot\_check-admin.ps1

if ($null -eq $VSMODE) {
    Write-Host "Choose Visual Studio version from options below"
	Write-Host "visualstudio2019buildtools|visualstudio2019enterprise|visualstudio2019professional|visualstudio2019community"
	$VSMODE =  Read-Host "Please enter selection"
}

if ($null -eq $SQLMODE) {
    Write-Host "Choose Sql Server version from options below"
	Write-Host "sql-server-2017|sql-server-2019"
	$SQLMODE =  Read-Host "Please enter selection"
}
. $PSScriptRoot\_epi-wait.ps1

# To list all Windows Features: dism /online /Get-Features
# Get-WindowsOptionalFeature -Online 
# LIST All IIS FEATURES: 
# Get-WindowsOptionalFeature -Online | where FeatureName -like 'IIS-*'

Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-WebServerRole 
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-WebServer
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-CommonHttpFeatures
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-HttpErrors
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-HttpRedirect
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-ApplicationDevelopment

Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName NetFx4Extended-ASPNET45
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-NetFxExtensibility45

Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-HealthAndDiagnostics
#Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-HttpLogging
#Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-LoggingLibraries
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-RequestMonitor
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-HttpTracing
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-Security
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-RequestFiltering
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-Performance
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-WebServerManagementTools
#Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-IIS6ManagementCompatibility
#Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-Metabase
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-ManagementConsole
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-URLAuthorization
#Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-BasicAuthentication
#Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-WindowsAuthentication
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-StaticContent
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-DefaultDocument
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-WebSockets
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-ApplicationInit
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-ISAPIExtensions
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-ISAPIFilter
Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-HttpCompressionStatic

Enable-WindowsOptionalFeature -Online -NoRestart -FeatureName IIS-ASPNET45

# Disable Loopback Check on a Server - to get around no local Logins on Windows Server
# New-ItemProperty HKLM:\System\CurrentControlSet\Control\Lsa -Name "DisableLoopbackCheck" -Value "1" -PropertyType dword

############### Now Chocolatey

Write-Host "INSTALLING CHOCOLATEY AND PACKAGES"
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#:::: IIS Features
choco install webdeploy -y
choco install urlrewrite -y

#:::: Utilities + other
choco install 7zip.install -y
choco install nuget.commandline -y
choco install microsoftazurestorageexplorer -y

#:::: Browsers
choco install googlechrome -y
choco install firefox -y

#:::: Dev tools
choco install azure-cli -y
choco install vscode -y
choco install git -y
choco install postman -y
choco install vswhere -y
choco install nodejs-lts -y

choco install $VSMODE -y --package-parameters "--allWorkloads --includeRecommended --includeOptional --passive --locale en-US"

#:::: SQL tools
choco install $SQLMODE -y --params="/SECURITYMODE:SQL" # enables mixed mode auth
choco install sql-server-management-studio -y 
choco install dbatools -y

Write-Host "Attempting to start MS SQl Server"
net start "SQL Server (MSSQLSERVER)"

Write-Host "Please restart the computer now"