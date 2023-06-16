#demo early filtering in Windows PowerShell

Return "This is a demo script file"

#to install the Get-Vegetable command: Install-Module PSTeachingTools -force
#early filtering

Get-Vegetable
help Get-Vegetable
cls
Get-Vegetable -name radish
#this parameter accepts wild cards. Not always true and don't assume help
#is correct. Never hurts to try
Get-Vegetable -name r*

#for anything more complex I'll have to use Where-Object
cls

help Get-Service
#using the name parameter
get-service m*
get-service m* -Exclude ms*

cls

dir c:\windows\system32\*.xml

#this doesn't work that way you think
dir c:\windows\system32 -include *.xml
#ignore access denied errors

dir c:\windows\system32 -include a*.xml -exclude appx*.xml -Recurse -Depth 1 -ErrorAction SilentlyContinue |
Select-Object Name


#you will see Filter parameters
dir C:\windows\System32 -filter *.xml

cls
#but you need to read the help

Get-CimInstance -ClassName Win32_SystemDriver |
Select-Object Name,State,ServiceType | more

help Get-CimInstance -Parameter Filter
cls
#this uses legacy operators
Get-CimInstance -ClassName Win32_SystemDriver -filter "state = 'running' and servicetype='file system driver'"
#or use your VBScript style queries
Get-CimInstance -query "Select DisplayName,Name,State from Win32_SystemDriver where state = 'running' and servicetype='file system driver'" | Format-Table
#the query doesn't affect any default formatting. The default format includes Status and Started even
#though I didn't ask for them

#Be selective
Get-CimInstance -query "Select DisplayName,Name,State from Win32_SystemDriver where state = 'running' and servicetype='file system driver'" | Select-Object DisplayName,Name,State

#another type of filtering
#this makes a difference at scale
Get-CimInstance -ClassName Win32_SystemDriver -filter  "state = 'running' and servicetype='file system driver'" -Property DisplayName,Name,State | Select-Object DisplayName,Name,State

cls

#parameters might depend on where you are running the command
dir alias: | more
#these techniques fail
dir alias: -filter c*
dir alias: -name c*
#this works
#-Include is technically not a filter as far as a provider is concerned
dir alias: -include c* -Recurse
#this might be easiest
dir alias:\c*
#or use the cmdlet
get-alias c*
cls
#we haven't talked about Providers in any detail
Get-PSProvider
help about_providers

cls

