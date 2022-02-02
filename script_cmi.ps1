Get-CimInstance -ClassName win32_operating -Filter "DeviceID='C:'" -ComputerName dc1,win1,wfa | GM

Get-CimInstance -ClassName win32_logicaldisk -Filter "DeviceID='C:'" -ComputerName dc1,win1,wfa | Select Pscomputername, FreeSpace

<#
Get-CimInstance -ClassName win32_logicaldisk -Filter "DeviceID='C:'" -ComputerName dc1,win1,wfa | 
    Select @{name="ComputerName";e={$_.PSComputerName}} ,
        @{Name="FreeSpaceinGB";E={$_.FreeSpace /1gb -as [int]}}

#>

<#
Get-CimInstance  -ComputerName win1 -ClassName win32_logicaldisk -Filter "DeviceID='C:'" | 
 select @{name="ComputerName";e={$_.PSComputerName}} ,
 @{Name="FreeSpaceinGB";E={$_.FreeSpace /1gb -as [int]}}

#>

$ServerName = 'dc1','win1','wfa', 'JUMPHOST'

Get-CimInstance  -ComputerName $ServerName -ClassName win32_logicaldisk -Filter "DeviceID='C:'" | 
 select @{name="ComputerName";e={$_.PSComputerName}} ,
 @{Name="FreeSpaceinGB";E={$_.FreeSpace /1gb -as [int]}}

# use of param

param{
[string[]] $ServerName =  'JUMPHOST'
}

#Code to get diskInfo
Get-CimInstance  -ComputerName $ServerName -ClassName win32_logicaldisk -Filter "DeviceID='C:'" | 
select @{name="ComputerName";e={$_.PSComputerName}} ,
@{Name="FreeSpaceinGB";E={$_.FreeSpace /1gb -as [int]}}




  