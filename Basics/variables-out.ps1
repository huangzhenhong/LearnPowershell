# Other variable options
# How to use Common variable parameters OutVariable and PipelineVariable

Return "This is a demo script file. Open this file in the PowerShell ISE or VS Code."

Get-Vegetable -root | Tee-Object -Variable root
$root
$root | Sort-Object count -Descending

help Tee-Object

cls

help Get-Vegetable

#ov is an alias for the OutVariable parameter
Get-Vegetable -OutVariable v | Where-Object { $_.count -ge 10 } -ov w

$v | Sort-Object Name
$w | Sort-Object count

#you can append
Get-Service b* -ov b
$b

Get-Service c* -ov +b
$b

help about_CommonParameters  

cls
