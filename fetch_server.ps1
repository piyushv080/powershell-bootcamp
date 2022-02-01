#fetching server list

$ComputerName = Get-Content -Path "C:\Training\ServerList.txt"
$filename = "abc", "abd", "bcd"

#iterating list in server

foreach($Servername in $ComputerName)
{
$checkPath = Test-Path -path \\$Server\CS\
    if($checkPath -eq 'true')
    {
        New-Item -Path \\ServerName\C$\Temp-Practice -ItemType Directory
    }
    else
    {
        Write-Host "wrong path or server is down or connectivity is not possible"
    }
}