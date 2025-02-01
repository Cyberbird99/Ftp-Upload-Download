# Check if PSFtp module is installed and install it if not
If(!(Get-InstalledModule PSFtp)){
    Install-Module PSFtp -Force
}
else {
    Write-Host "PSFtp Module is already installed"
}

# Define FTP login credentials for anonymous access
$ftpUsername = "unkown"
$ftpPassword = ConvertTo-SecureString -String "unkown" -AsPlainText -Force
$ftpCredentials = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $ftpUsername, $ftpPassword

# Establish FTP connection session
$ftpSessionName = "MyFtpSession"
Set-FtpConnection -Server "ftp://speedtest.tele5.net/" -Session $ftpSessionName -Credentials $ftpCredentials -verbose

# Get details of the active FTP session
$activeFtpSession = Get-FtpConnection -Session $ftpSessionName

# List the contents of the FTP server's root directory
Get-FtpChildItem -Session $activeFtpSession -Path /

# Download a specific file from the FTP server
Get-FtpItem -Path "download.zip" -Session $activeFtpSession

# Upload a file to the FTP server's /upload directory
$localFilePath = .\upload.txt
$uploadDirectory = "/upload"
Add-FtpItem -Path $uploadDirectory -LocalPath $localFilePath -Session $activeFtpSession
