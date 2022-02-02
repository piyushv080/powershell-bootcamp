#Advanced excel intregration 

$outputFilePath = "path\Demo.xlsx"

### Excel File Creation #####
Write-Host("creating excel file")
$excel = New-Object -ComObject Excel.Application -ErrorAction stop
$excel.Visible = $true
$excel.DisplayAlerts = $false
$workbook = $excel.Workbooks.Add()
[void]$workbook.worksheets.add()


#### Adding Data to Excel File ####

$Worksheet = $Workbook.worksheets.Item("CPU")
$Worksheet.Activate()
$excel.cells.item(1,1) = "$server//Time”
$excel.cells.item(1,2) = “Avg CPU Util (%)”
$col=2

#######SHEET 1#######

$sheet1 = $workbook.worksheets.Item(1)
$sheet1.name = "CPU"
$sheet1.Range("A1:B1").Font.Bold = $True

#### Close Excel File ######
Write-Host("Saving and closing the excel file : "+$outputFilePath)
#SAVING AND CLOSING THE EXCEL FILE
$workbook.SaveCopyAs($outputFilePath)
$Workbook.Saved = $True
$excel.Quit()

########Creating Graphs --- Sheet 1##################

# Creating excel com object
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