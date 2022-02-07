$cpu =Get-Process | select-object CPU | sort CPU -Descending |Select -First 10Write-Host $Cpu.CPU$processName = Get-Process | 
select-object ProcessName | sort CPU -Descending |Select -First 10 Write-Host $ProcessName.ProcessName$id = Get-Process | select-object Id | 
sort CPU -Descending |Select -First 10Write-Host $Id.Id$handles= Get-Process | select-object Handles | sort CPU -Descending |
Select -First 10Write-Host $Handles.Handles 


 $Array = @()
 $util= Get-Process | select-object CPU, ProcessName, Id, Handles  | sort CPU -Descending |Select -First 10
 foreach($entry in $util)
 {
    #Write-Host $entry  
  # Creating custom object
  $Object = New-Object PSObject -Property ([ordered]@
  {
    "CPU" = $entry.CPU
    "Process" = $entry.ProcessName
    "Id" = $entry.Id
    "Handles" = $entry.Handles  })
    # Add object to our array  
    $Array += $Object}
    #Write-Host $Array
    $Style = @." 
     
    <style>
    body {font-family: "Arial";font-size: 8pt;color: #4C607B;}
    th, td {border: 1px solid #e57300;border-collapse: collapse;background-color:black;color:white;padding: 5px;}
    th {font-size: 1.2em;text-align: left;background-color:7F7F7F;color: #ffffff;}
    </style>  "@
    
    # Creating head style and header title
    
    $output = '<html><head>'#Import hmtl style file$output += $Style$output += '</head><body>'$output += "<h3 style='color:red'>List of Top 10 Process!</h3>"
    $output += '<hr>'$output += "<table><tr><th>CPU</th><th>ProcessName</th><th>Id</th><th>Handles</th></tr>"
    Foreach($Entry in $Array){
    #Write-Host $Entry.CPU$output += "<tr>"$output += "<td>$($Entry.CPU)</td><td>$($Entry.Process)</td><td>$($Entry.Id)</td><td>$($Entry.Handles)</td></tr> "}
    $output += "</table></body></html>"$output |


 out-file "C:\Training\output.html"Invoke-Item -Path "C:\Script\output.html"