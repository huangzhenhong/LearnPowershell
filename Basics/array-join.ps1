Return 'This is a demo script file. Open this file in the PowerShell ISE or VS Code.'

#let's do something practical using arrays

#initialize an empty array
$t = @()
#add 3 random numbers between 1 and 10
1..3 | ForEach-Object { $t += Get-Random -Minimum 1 -Maximum 20 }
$t
#create an array of characters
$c = '*', '#', '@', '<', '?', ']', '\'
#add 3 random characters to the array
$t += ($c | Get-Random -Count 3)
$t

#a random seed word you could pull from a dictionary list
$w = 'BaNanA'
#strings can be treated as arrays
$w[0..2]
$w.ToCharArray()
#add the character array to the array $t
$t += $w.ToCharArray()

#what is in the array now?
$t
#let's randomize the elements in the array
$rando = $t | Get-Random -Count 9
#join the elements of the array
$pass = -join $rando
#here's a complex password
$pass

#you could create a PowerShell function based on these commands
#learn more
help about_Join

cls
