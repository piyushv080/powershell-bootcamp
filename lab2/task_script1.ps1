#ServerName , Status , BootUpTime , UpTime , CPUUtlization , MemoryUtilization , DiskUtlization

$ServerName = "C:\Script\Serverlist.txt"

$Servers = Get-Content -Path $ServersListFile -ErrorAction SilentlyContinue
# Intializing Array to store the object
$Array = @()
#Set a Threshold Value
$ThresholdValue = 90
#Polling Interval Count
$RepeatCount = 24
#Set Sleep Interval ( In Sec) 1 hour --> 3600 sec
$SleepInterval = 3600
#Intliazing the Counter
$Count = 0
$UtilCount = 0
#Iterating Server List

foreach($server in $servers){
   
   $csname=(Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $server).csname
   $Bootuptime = (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $server).LastbootUpTime
   $uptime = $currentdate - $Bootuptime
   $status = (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $server).Status
   $CurrentDate = Get-Date
   $TotalVisibleMemorySize =  (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $server).TotalVisibleMemorySize
   
   #$disk = (Get-CimInstance  -ComputerName $ServerName -ClassName win32_logicaldisk -Filter "DeviceID='C:'")      
    
        
   #$diskHtml = $disk | ConvertTo-Html 

   Write-Output "ServerName $csname" , "Status $status", "LastBootUpTime $Bootuptime" 
   Write-Output "$server Uptime : $($uptime.Days) Days, $($uptime.Hours) Hours, $($uptime.Minutes) Minutes"
   Write-Output "Memory Size $TotalVisibleMemorySize"
}



