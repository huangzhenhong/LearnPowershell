#demo Where-Object

Return "This is a demo script file"

Get-Vegetable | where color -eq 'green'
Get-Vegetable | where {$_.color -eq 'green'}
#need this syntax for complex examples
#remember we discovered the true property name with Get-Member

Get-Vegetable |
where {$_.color -eq 'green' -AND $_.cookedstate -eq 'raw'} |
Sort Count -Descending


cls

#let's try examples from the slides
Get-Service w* | where {$_.Status -eq 'running'}

$now = Get-Date
#find temp files created in the last 7 days
#remember, you can use any object property you find with Get-member
Get-ChildItem $env:TEMP -file -Recurse | Where {$psitem.CreationTime -ge $now.AddDays(-7) }

cls

#you can use any thing in the scriptblock that will give a True or False result
#you can use your own computername multiple times for testing
get-content c:\work\servers.txt
#cat is an alias for Get-Content
$servers = cat C:\work\servers.txt | where { Test-Connection -ComputerName $_ -count 2 -Quiet }
$servers
cls

#let's prove the performance difference
#get a sample
Get-Ciminstance -ClassName win32_process | Select -first 5
cls
#the wrong way

Measure-Command {
 Get-CimInstance win32_process -ComputerName $servers |
 Where WorkingSetSize -ge 50MB
}

#a better, PowerShell way
#even though it may run quickly for me, it is the principal that matters. Be consistent

Measure-Command {
 Get-CimInstance win32_process -ComputerName $servers -filter "WorkingSetSize >=52428800"
}

#here's another way using PowerShell shortcuts

Get-CimInstance win32_process -filter "WorkingSetSize >= $(50mb)" -ComputerName $servers |
Sort WorkingSetSize -Descending

cls
