Return "This is a demo script file"

#region ForEach-Object demo

#my vegetables have property and method related to peeling
#but there is no cmdlet that will handle it
Get-Vegetable | Get-Member *peel*
Help Set-Vegetable
cls
Get-Vegetable | Select-Object -Property Count, Name, IsPeeled
Get-Vegetable Carrot | ForEach-Object { $_.peel() }
Get-Vegetable C* | Select-Object Name, IsPeeled

cls

cd C:\work
#create 2 test files
Get-Date | Out-File test.txt
Get-Date | Out-File test2.txt

dir | select name, attributes
#I want to invoke a method
Get-Item test.txt | Get-Member encrypt
dir test*.txt | foreach { $_.encrypt() }

#see the results
dir -file | select name, attributes

#Undo
# dir test*.txt | foreach {$_.decrypt()}

cls

#there are other ways to accomplish this but I
#hope this demonstrates the foreach approach
help Get-Volume -Parameter cimsession
Get-Content c:\work\servers.txt

#this fails
Get-Content c:\work\servers.txt | Get-Volume

#I'll save results to a variable

$c = Get-Content c:\work\servers.txt | foreach { Get-Volume -drive c -CimSession $_ }

$c
#I used Get-Member to discover property names
#note the use of the wildcard in the property name
$c | select PSComputername, DriveLetter, Size*

cls

#endregion
