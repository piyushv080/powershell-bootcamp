#Try - catch - finally

try
{
 1/0
}
catch [DivideByZeroException]
{
Write-Host "Divide by zero expection"
}
catch
{
Write-Host "Other Exception"
}
finally
{
Write-Host "Cleaning up ....."
}

###############################
Try
{
 Stop-Process -Id 123456 -ErrorAction Stop
}
Catch{
 "Non-Terminating Error: Invalid Process ID"
}

################################### Example for try catch finally #################################

$ErrorActionPreference = "Stop"
try
{
Set-Location $HOME\Desktop
Get-Content hello.txt
}
catch
{
Write-Output "Could not find the file"
}
finally
{
Write-Output "Task Completed"
}

# Demonstrate an example using Try, Catch, Finally and upload here #

try
{
$TestVar = "This is  test"
Write-Host 'Statement before the error'
[System.IO.File]::ReadAllLines('c:\script\exist.txt')
Write-Host 'Statement after the error'
}
catch [System.IO.IOException]
{
Write-Host 'An Exception was caught.'
Write-Host "Exception tye:$($_.Exception.GetType().FullName))"

}
catch 
{
Write-Host "Some other type of error was caught"
}
finally
{
$TestVar = 'The finally block was executed '
}

#Calling defined variable
$TestVar