$outputFilePath = "C:\Users\piyush_verma\OneDrive - HCL Technologies Ltd\Desktop\cpu_excel.xlsx\training\Capcity Mgmt Server-$(Get-Date -Format "hh:mm:ss")"
#collection Interval in Seconds.
$sampleInterval = 20
#How many samples should be collecteed at the interval specified. Set to 0 for continuous collection.
$maxSamples = 10 

#SYSTEM NAME INPUT#
($Servername = (Get-Content (Read-Host "Enter the Hosts File path")))

C:\script\server.txt

foreach($Server in $Servername)
{

#checkk for connection to each server from the list of servers $TP=Test-Connection $Server -Quiet -Count 1
If($TP -eq 'True')
{

Write-Host "connection successful : $Server" -ForegroundColor Yellow 

### Excel File Creation #####
Write-Host("creating excel file")
$excel = New-Object -ComObject Excel.Application -ErrorAction stop
$excel.Visible = $true
$excel.DisplayAlerts = $false
$workbook = $excel.Workbooks.Add()
[void]$workbook.worksheets.add()#######SHEET 1#######$sheet1 = $workbook.worksheets.Item(1)
$sheet1.name = "CPU"
$sheet1.Range("A1:B1").Font.Bold = $True#Average cpu util calculation
$Worksheet = $workbook.worksheets.Item("cpu")
$Worksheet.Activate()
$excel.cells.item(1,1) = "$server//Time"
$excel.cells.item(1,2) = "Avg cpu util (%)"
$col=2$s1 = $maxSamples
$cumm_avg_cpu = 0while($s1 -ne 0)
{
#time
$date_time = (Get-Date -Format "dd/MM/yyyy HH:mm:ss").ToString()
$excel.cells.item($s1+1,1) = $date_time #avg cpu
$avg_cpu = Get-Process|Sort-object -Property CPU ,@{Name = 'CPU In (%)';
Expression = {$TotalSec = (New-TimeSpan -Start $_.StartTime).TotalSeconds;[Math]::Round( ($_.CPU * 100 /$TotalSec),2)}},@{Expression={$_.threads.count};Label="Threads";},@{Name="Mem Usage(MB)";Expression={[math]::round($_.ws / 1mb)}},@{Name="VM(MB)";Expression={"{0:N3}" -f($_.VM/1mb)}} $excel.cells.item($s1+1,2) = $avg_cpu
$cumm_avg_cpu =$cumm_avg_cpu +$avg_cpu $s1 = $s1 - 1 Start-Sleep ($sampleInterval-2)
}
$total_avg_cpu = $cumm_avg_cpu /$maxSamples
$excel.cells.item($maxSamples+2,1)= "Average cpu utilization (%)"
$excel.cells.item($maxSamples+2,2)=$total_avg_cpu $cpu_check =$total_avg_cpu
if($cpu_check -le 30.00)
{
$excel.cells.item($maxSamples+6,1)= "decrease cpu allocation"
$excel.cells.item($maxSamples+6,1).entirerow.font.bold =$true
$excel.cells.item($maxSamples+6,1).entirerow.interior.colorindex =4
}
elseif($cpu_check -gt 30.00 -and $cpu_check -lt 60.00)
{
$excel.cells.item($maxSamples+6,1)= "no cpu allocation is changed"
$excel.cells.item($maxSamples+6,1).entirerow.font.bold =$true
$excel.cells.item($maxSamples+6,1).entirerow.interior.colorindex =4
}
else
{
$excel.cells.item($maxSamples+6,1)= "increase cpu allocation"
$excel.cells.item($maxSamples+6,1).entirerow.font.bold =$true
$excel.cells.item($maxSamples+6,1).entirerow.interior.colorindex =4
}
#### Adding Data to Excel File ####$Worksheet = $Workbook.worksheets.Item("CPU")
$Worksheet.Activate()
$excel.cells.item(1,1) = "$server//Time”
$excel.cells.item(1,2) = “Avg CPU Util (%)”
$col=2#### Close Excel File ######
Write-Host("Saving and closing the excel file : "+$outputFilePath)
#SAVING AND CLOSING THE EXCEL FILE
$workbook.SaveCopyAs($outputFilePath)
$Workbook.Saved = $True
$excel.Quit()########Creating Graphs --- Sheet 1################### Creating excel com object
$xl = new-object -ComObject Excel.Application
$fileName = $outputFilePath
$wb = $xl.Workbooks.Open($fileName)
#Open the first sheet of the excel
$wsChart = $wb.WorkSheets.item(1)# Activating the Data sheet
$wsChart.activate()# Adding the Chart
$chart = $wsChart.Shapes.AddChart().Chart
$chart.chartType = 4 # Set it true if want to have chart Title
$chart.HasTitle = $true # Providing the Title for the chart
$chart.ChartTitle.Text = " CPU Usage " # Save the sheet
$wb.Save()# Closing the work book and xl
$wb.close()
$xl.Quit()
# Releasting the excel com object
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($xl)
}
else
{
    Write-Host "connection failed :$server" -ForegroundColor DarkBlue
}
}

