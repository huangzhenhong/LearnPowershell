#objects in the pipeline

Return "This is a demo script file"

#start with objects
# If you haven't already, you can install the PSTeachingTools module to get the vegetable commands.
# Install-Module PSTeachingtools -force
# Answer yes to prompts.

Get-Vegetable
#don't assume table headings are all the property names or even the correct ones

#Get-Member
Get-Vegetable | Get-Member

#limit the results
Get-Vegetable | Get-Member -MemberType Properties

#notice the differences
Get-Vegetable -Name corn

Help Get-Vegetable

#we'll do more these properties in the next module
cls

#methods
Get-Vegetable | Get-Member -MemberType Methods

#you don't have to rely on methods. Look for commands
help Set-Vegetable

Set-Vegetable -name corn -cookingstate grilled -Whatif
Set-Vegetable -name corn -cookingstate grilled
#did it change?
Get-Vegetable corn
help Set-Vegetable -Parameter Passthru
#we can also use the pipeline
Get-Vegetable -RootOnly | Set-Vegetable -CookingState Roasted -count 5 -Passthru
cls

#try with "real" commands
#start notepad
notepad
Get-Process notepad | Get-Member
help stop-process
Get-Process notepad | Stop-Process
#why didn't I see a result?

#Whatif can be a lifesaver
Get-Process | Stop-Process -whatif

#we'll cover Select-Object in the next module
Get-Process | Select-Object -first 3
#look at the column headings
#now look at the object
Get-Process | Get-Member | more
#you can use any property you see. This is what we'll get to in the next module

cls

