# powershell command
get-alias ps
ps -c WFA

#date
get-date
get-date -format hh:mm

#function 
get-date -format hh:mm
function Get-time{
get-date -format hh:mm
}

Get-time