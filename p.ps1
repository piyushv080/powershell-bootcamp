$ServerName = Get-Content C:\Script\server.txt
$Liveserver = @()
$deadserver = @()

$currentdate = Get-Date
foreach($Server in $servers){
    $pingtest = Test-Connection -ComputerName $ServerName -Quiet -Count 1 -ErrorAction SilentlyContinue

    if($pingtest){
    $Liveserver += "$server"
    }
    else{
    $deadserver += "$server"
    }
    
}
foreach($pc in $Liveserver){
$BootupTime = (Get-CimInstance -ClassName win32-operatingsystem -ComputerName $pc ).Lastbootuptime
$uptime = $currentdate - $BootupTime
Write-Output "$pc uptime : $($uptime.Day) Day,$($uptime.Hour) Hour, $(uptime.Minute) Minute"
}