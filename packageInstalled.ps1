$packageName = "Microsoft Visual C++ * X64 Minimum Runtime*"
$packageInstalled = Get-WmiObject -Class Win32_Product | Where-Object {
    $_.Name -like $packageName -and $_.Version -ne $null
}
if($packageInstalled -ne $null) {
    return $true
}else {
    return $false
}

Get-InstalledProgram | Where-Object {$_.DisplayName -like "MsSqlCmd*"}



$msiPath = "C:\Download\MsSqlCmdLnUtils.msi"
$arguments = "/qn /i $msiPath"

Start-Process -FilePath "msiexec.exe" -ArgumentList $arguments -Wait -PassThru


$packageName = "Microsoft Command Line Utilities 15 for SQL Server"
$packageInstalled = Get-WmiObject -Class Win32_Product | Where-Object {
    $_.Name -like $packageName -and $_.Version -ne $null
}
if($packageInstalled -ne $null) {
    return $true
}else {
    return $false
}