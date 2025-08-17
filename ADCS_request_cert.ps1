# Variables
$caUrl     = "https://ec2-xxx-xxx-xxx-xxx.compute-1.amazonaws.com/certsrv/certfnsh.asp"
$template  = "TLS/SSL"   # <-- update to the template name you need
$csrPath   = "C:\file\path\cert.csr"   # path to your CSR file
$outFile   = ".\issued_cert.cer" # output file for the certificate
$username = "DOMAIN\svc-account"
$password = "PASSWORD" | ConvertTo-SecureString -AsPlainText -Force #for testing purposes only
$cred = New-Object System.Management.Automation.PSCredential ($username, $password)

# Path to your CSR file
$csr = Get-Content $csrPath -Raw

# Request body
$body = @{
    Mode        = "newreq"
    CertRequest = $csr
    CertAttrib  = "CertificateTemplate:$template"
    FriendlyType = "Saved-Request Certificate"
    TargetStoreFlags = "0"
    SaveCert    = "yes"
}

# Submit CSR to AD CS externally
$response = Invoke-WebRequest -Uri $caUrl `
    -Method Post `
    -Body $body `
    -Credential $cred

# Extract ReqID from the HTML
if ($response.Content -match "ReqID=(\d+)") {
    $reqId = $matches[1]
    Write-Host "$reqId"

    # Build download URL (base64 encoded)
    $downloadUrl = "https://ec2-xxx-xxx-xxx-xxx.compute-1.amazonaws.com/certsrv/certnew.cer?ReqID=$reqId&Enc=b64"
    Write-Host "$downloadUrl"

    # Download certificate
    $certResponse = Invoke-WebRequest -Uri $downloadUrl -Credential $cred -UseBasicParsing
    #Write-Host "$certResponse"
    $asciiNumbers = $certResponse.Content
    $text = -join ($asciiNumbers | ForEach-Object { [char]$_ })
    Write-Host "text: $text"
    $certFile = ".\issued.cer"
    $text | Out-File -FilePath $certFile -Encoding ascii
    Write-Host "Certificate saved to $certFile"

} else {
    Write-Host "Could not find ReqID in response"
    $response.Content | Out-File ".\error.html"
}
