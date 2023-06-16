#here's an example of the pipeline, not necessarily the best way to achieve the
#end result

Return "This is a demo script file"

Get-Content services.txt

#pipeline input
Help Get-Service -parameter Name

#by value
"lanmanserver","winrm" | Get-Service
Get-Content services.txt | Get-Service
#by object
$in = Import-Csv servicedata.csv
$in
$in | Get-Service 

cls
#see if you can visualize what PowerShell is doing

Get-Content services.txt |
Get-Service |
Restart-Service -passthru |
Out-File restart.txt


Get-Content c:\work\restart.txt

cls

#more examples of things changing in the pipeline.
#we'll cover this in more detail in the next module
Get-ChildItem c:\work -file -Recurse | Measure-Object -Property length -sum -Maximum -average

Get-ChildItem c:\windows -file | Group-Object -property extension | Tee-Object -Variable ex
$ex | Get-Member

$ex | Select-Object -Property Name,Count,
@{Name="Size";Expression = { $_.group |
Measure-Object -property length -sum |
Select-Object -ExpandProperty sum
}}


cls
