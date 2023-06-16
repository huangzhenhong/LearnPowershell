## Check the current version
$psversiontable

$stoppedService = Get-Service | Where-Object Status -eq 'Stopped'

Write-Output $stoppedService