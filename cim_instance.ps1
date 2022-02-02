Get-CimInstance -ClassName Win32_ComputerSystem , Win32_BootUpTime

Get-CimInstance -ClassName win32_logicaldisk -Filter "DeviceID='C:'" -ComputerName dc1

$s = New-CimSession -ComputerName dc1,win1
Get-CimInstance -ClassName Win32_ComputerSystem -CimSession $s

