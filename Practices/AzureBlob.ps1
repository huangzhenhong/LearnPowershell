Write-Host "Download DownloadSqlCmdUtil"
                
$storageAccountName = "dregionaleus2iacnmtqst"
$storageAccountKey = "zBOxdPptHWf3y0kCOV8kU++FgpZSHb5kQGE8pPgrtiwE98K7rl1l0KMdlC4JirYKvL0zfwPvZ7t9+AStmIn0lQ=="
$containerName = "bastion-install"
$blobName = "MsSqlCmdLnUtils.msi"
$destinationPath = "C:\Download\MsSqlCmdLnUtils.msi"

# Generate SAS token
$context = New-AzStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey
$startTime = Get-Date
$endTime = $startTime.AddHours(2.0)

# Download the file using SAS token
$blobUri = New-AzStorageBlobSASToken -Container $containerName -Blob $blobName -Context $context -StartTime $startTime -ExpiryTime $endTime -Permission r -FullUri
Invoke-WebRequest -Uri $blobUri -OutFile $destinationPath