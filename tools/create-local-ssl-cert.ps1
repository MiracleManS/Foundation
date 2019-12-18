# This script installs IIS and the features required to
# run West Wind Web Connection.
#
# * Make sure you run this script from a Powershel Admin Prompt!
# * Make sure Powershell Execution Policy is bypassed to run these scripts:
# * YOU MAY HAVE TO RUN THIS COMMAND PRIOR TO RUNNING THIS SCRIPT!

. $PSScriptRoot\_check-admin.ps1
. $PSScriptRoot\_get-hostnames.ps1

foreach ($hostName in $HOSTNAMES) {
	$cert = (Get-ChildItem $CERTPATH | where-object { $_.Subject -like "*$hostname*" } | Select-Object -First 1)
        
	if ($null -eq $cert) {
		$cert = New-SelfSignedCertificate -certstorelocation $CERTPATH -dnsname $hostName  -FriendlyName "Local Web Cert {$hostName}" -NotAfter (Get-Date).AddYears(25) -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.1")
		# $siteCertPath = $baseCertPath + $siteCert.Thumbprint
		# $pwd = ConvertTo-SecureString -String "fbMYuKd7xpfCduWmXUQn" -Force -AsPlainText
		# Export-PfxCertificate -cert $siteCertPath -FilePath "$hostName.pfx" -Password $pwd
		# Export-Certificate -Cert $siteCertPath -FilePath "$hostName.crt"
		# https://blog.davidchristiansen.com/2016/09/howto-create-self-signed-certificates-with-powershell/
		# https://stackoverflow.com/questions/44988163/create-self-signed-certificate-for-testing-localhost-and-have-it-accepted-by-the#47380762
		# https://docs.microsoft.com/en-us/dotnet/api/system.security.cryptography.x509certificates.storename?view=netframework-4.8
		$store = New-Object System.Security.Cryptography.X509Certificates.X509Store "Root", "LocalMachine"
		$store.Open("ReadWrite")
		$store.Add($cert)
		$store.Close()    
	}
	else {
		Write-Host "Cert exists for $hostName!"
	}
}