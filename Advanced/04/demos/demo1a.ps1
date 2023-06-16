Return "This is a demo script file"

#region Sort-Object

Get-Vegetable | Sort-Object -Property Name
#or descending
Get-Vegetable | sort Name -Descending

#modify the objects
Get-Vegetable -RootOnly | Set-Vegetable -CookingState Roasted
Set-Vegetable corn -CookingState Boiled
Set-Vegetable zucchini -CookingState Grilled
Get-Vegetable
cls

#here's a challenge
Get-Vegetable | sort state
Get-Vegetable | Get-Member

Get-Vegetable | sort CookedState
#this particular property is special, and you'll see this in other objects
Get-Vegetable | Get-Member cookedState

#It might be hard to tell but this is an enumeration
#You can use the .NET trick
[enum]::GetNames("psteachingtools.vegstatus")
#if that works, then try this
[enum]:: GetValues("psteachingtools.vegstatus") | Select-Object -property Value__
#the sort is using this value

#run a command like
# Get-Vegetable | sort {$_.CookedState.tostring()}
# to sort on the string value of the enumeration

cls

#Time for "real" objects
Get-Service | sort status -Descending
#shouldn't Running be last?
Get-Service bits | Get-Member status
[enum]::GetNames("System.ServiceProcess.ServiceControllerStatus")
#the sort is using the corresponding values
cls

#you can do multiple sorts in the same order
Get-Process s* | sort name, id

cls

#endregion
