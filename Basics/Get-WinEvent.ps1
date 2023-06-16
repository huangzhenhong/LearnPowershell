Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'


$weParams = @{
  LogName      = "System"
  Credential   = Get-Credential jeff
  Computername = "prospero"
  OutVariable  = "all"
  MaxEvents    = 5000
}

#get event log data from the remote computer

$data = Get-WinEvent @weParams |
Group-Object ProviderName -NoElement |
Where-Object { $_.count -ge 50 }

$data[0]

$output = $data | ForEach-Object {
  [PSCustomObject]@{
    Source       = $_.Name.ToLower()
    Count        = $_.Count
    PctTotal     = "{0:p2}" -f ($_.count / $all.count)
    Computername = $weParams.Computername.toUpper()
    Report       = (Get-Date -Format d)
  }
}

$output.count

#format the output
$output | Sort-Object -Property count -Descending |
Format-Table -GroupBy @{Name = "LogName"; Expression = { "{0} [{1}]" -f $weParams.LogName, $_.Computername } } -Property Source,
Count, @{Name = "PercentOfTotal"; Expression = { $_.pctTotal }; Align = "Right" }


cls

#All of these examples are things you could turn into scripts and functions
#But you need to make sure you can run it first at the console

#Focus on the techniques and language elements I used, not the final results.

