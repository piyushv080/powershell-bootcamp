﻿#ServerName , Status , BootUpTime , UpTime , CPUUtlization , MemoryUtilization , DiskUtlization
$ServerName = "C:\Script\server.txt"

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

ForEach($Server in $Servers){
    $Server = $Server.trim()
    Write-Host "$Server - " -ForegroundColor Green -NoNewline
    $TestPath = Test-Path "\\$Server\c$"
    #Testing Server Connection  
    If($TestPath -match "False")
    {
        Write-Host "ERROR:   Failed to connect"
        $Status               = "Offline"
        $LastBootUpTime       = "(Null)"
        $uptime               = "(Null)"
        $Processor            = "(Null)"
        $RoundMemory          = "(Null)"
        $up                   = "(Null)"
        $diskUtilization      = "(Null)"
        $diskHtml             = "(Null)"
        $UtilCount            = "(Null)"
    }
    
        Write-Host "SUCCESS: Server is up"
        $Status = "Online"
        # Get OS details using CIM query
        
        $System = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $server | Select-Object LastBootUpTime,LocalDateTime,TotalVisibleMemorySize,FreePhysicalMemory
        
        # Get bootup time and local date time  
        $LastBootUpTime = (($System).LastBootUpTime)
        $LocalDateTime  = (($System).LocalDateTime)
        # Calculate uptime - this is automatically a timespan
        $up = $LocalDateTime - $LastBootUpTime
        $uptime = "$($up.Days) days, $($up.Hours)h, $($up.Minutes)mins"


        # CPU utilization
        $Processor = (Get-CimInstance -ComputerName $Server -Class win32_processor -ErrorAction Stop | Measure-Object -Property LoadPercentage -Average | Select-Object Average).Average
        # Memory utilization
        $ComputerMemory =  Get-CimInstance -Class WIN32_OperatingSystem -ComputerName $Server
        $Memory = ((($ComputerMemory.TotalVisibleMemorySize - $ComputerMemory.FreePhysicalMemory)*100)/ $ComputerMemory.TotalVisibleMemorySize)
        $RoundMemory = [math]::Round($Memory, 2)
        #Disk Utilization
        
        #$disk = Get-WmiObject -Class win32_Volume -ComputerName $Server -Filter "DriveLetter = 'C:'" | Select-object @{Name = "C PercentFree"; Expression = {“{0:N2}” -f  (($_.FreeSpace / $_.Capacity)*100) }}
        $disk = Get-CimInstance Win32_logicaldisk -ComputerName LocalHost -Filter "DriveType=3" |select -property DeviceID,<#@{Name="Size(GB)";Expression={[decimal]("{0:N0}" -f($_.size/1gb))}},@{Name="Free Space(GB)";Expression={[decimal]("{0:N0}" -f($_.freespace/1gb))}},#>@{Name="Free (%)";Expression={"{0:N2}" -f((($_.freespace/1gb) / ($_.size/1gb))*100)}},@{Name="Utilize (%)";Expression={"{0:N2}" -f(100 - ((($_.freespace/1gb) / ($_.size/1gb))*100))}}
        $diskUtilization= $disk
        $diskHtml = $disk | ConvertTo-Html
    }
 #Checking that Utlization of is above threshold value or not.
    foreach( $dk in $diskUtilization)
    {
        If( ($dk.'Utilize (%)') -ge $ThresholdValue)
        {
            $UtilCount += 1
        }
    }
    #Checking that Utlization is above threshold value or not
    If(($Processor -ge $ThresholdValue) -or ($RoundMemory -ge $ThresholdValue))
    {
        $Count += 1
    }
    # Creating custom object
        $Object = New-Object PSObject -Property ([ordered]@{
                        "ServerName"             = $Server
                        "Status"                 = $Status
                        "BootUpTime"             = $LastBootUpTime
                        "UpTime"                 = $uptime
                        "CPUUtlization"          = $Processor
                        "MemoryUtilization%"     = $RoundMemory
                        "DiskUtlization"         = $diskUtilization
                        "DiskHtmlTable"          = $diskHtml
                        "Count"                  = $UtilCount
        })
    # Add object to our array
    $Array += $Object

### HTML REPORT ############################################################################################################################
# Creating head style
$Style = @"
      
    <style>
      body {
        font-family: "Arial";
        font-size: 8pt;
        color: #4C607B;
        }
      th, td { 
        border: 1px solid #e57300;
        border-collapse: collapse;
        padding: 5px;
        }
      th {
        font-size: 1.2em;
        text-align: left;
        background-color: #003366;
        color: #ffffff;
        }
      td {
        color: #000000;
        
        }
      .even { background-color: #ffffff; }
      .odd { background-color: #bfbfbf; }
    </style>
      
"@
# Creating head style and header title
$output = '<html><head>'
#Import hmtl style file
$output += $Style
$output += '</head><body>'
$output += "<h3 style='color: #0B2161'>Server Health Report</h3>"
$output += '<strong><font color="red">WARNING: </font></strong>'
$output += "Please review attached report.</br>"
$output += '</br>'
$output += '<hr>'
$output += "<h4>Report of all the Server:</h4>"
$output += "
            <table>
                <tr>
                    <th>Server Name</th>
                    <th>Status</th>
                    <th>Boot Up Time</th>
                    <th>Up Time</th>
                    <th>CPU Utlization</th>
                    <th>Memory Utilization %</th>
                    <th>Disk Utlization</th>
                </tr>"
Foreach($Entry in $Array)
{
    If(($Entry.CPUUtlization -ge $ThresholdValue) -or ($Entry.'MemoryUtilization%' -ge $ThresholdValue) -or ($Entry.Count -ge 1 ))
    {
        $output += "<tr bgcolor=red style = 'font-weight: bold'>"
    }
    Else
    {
        $output += "<tr>"
    }
    $output += "
                 <td>$($Entry.ServerName)</td>
                 <td>$($Entry.Status)</td>
                 <td>$($Entry.BootUpTime)</td>
                 <td>$($Entry.UpTime)</td>
                 <td>$($Entry.CPUUtlization)</td>
                 <td>$($Entry.'MemoryUtilization%')</td>
                 <td>$($Entry.DiskHtmlTable)</td>
                 </tr>  "
    }
    <#$output += "<td>$($diskHtml)</td>
                 </tr>" #>
$output += "</table></body></html>"
If($Array)
{
    Write-Host "`nResults" -ForegroundColor Green
    # Display results in console
    #$Array | Select-Object ServerName, Status, BootUpTime, UpTime, CPUUtlization, MemoryUtilization%, DiskUtlization  | Format-Table -AutoSize -Wrap
    #Display results in new window
    #$Array | Out-GridView
    # Save as CSV file
    #$Array | Export-Csv -Path C:\temp\results.csv -NoTypeInformation 
    # Save as Html File
    $output  | out-file C:\Script\print.html

    # Define the txt which will be in the email body
$Txt_File = "c:\Script\print.html"
function Send_mail {
 #Define Email settings
 $EmailFrom = "piyushverma0820@outlook.com"
 $EmailTo = "1716510074@kit.ac.in"
 $Txt_Body = Get-Content $Txt_File -RAW
 $Body = $Body_Custom + $Txt_Body
 $Subject = "Powershell Server report"
 $SMTPServer = "smtpserver.domain.com"
 $SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 25)
 $SMTPClient.EnableSsl = $True
 $SMTPClient.Send($EmailFrom, $EmailTo, $Subject, $Body)
}
$Body_Custom = "This is what contain file.txt : "
Send_mail

}

