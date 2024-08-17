# Define variables
$certSubject = "CN=spark"
$currentDir = Get-Location
$pfxFilePath = "$currentDir\ArchLinuxWSL.pfx"
$crtFilePath = "$currentDir\ArchLinuxWSL.crt"
$pfxPassword = "spark"

# Create a self-signed certificate
$cert = New-SelfSignedCertificate -Type CodeSigning -Subject $certSubject -CertStoreLocation "Cert:\CurrentUser\My"

# Export the certificate to a PFX file
Export-PfxCertificate -Cert $cert -FilePath $pfxFilePath -Password (ConvertTo-SecureString -String $pfxPassword -Force -AsPlainText)

# Export the certificate to a CRT file
$certBytes = $cert.Export([System.Security.Cryptography.X509Certificates.X509ContentType]::Cert)
[System.IO.File]::WriteAllBytes($crtFilePath, $certBytes)

# Output the thumbprint of the certificate
$cert.Thumbprint