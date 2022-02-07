#Getting all the processes

Get-Process | Select-Object ProcessName,CPU | Sort-Object CPU -Descending | Select -First 10 |
ConvertTo-Html -title "Process Report Output" -PreContent "<h1>Process Output</h1>" -Head "  
<style> h1,th,td{font-family: Segoe UI;}th {background-color: Green;} td {border: 1px solid black; padding : 4px;} 
</style>"|   
Out-File "C:\Script\out.html" 
 
#Use of Process
 
Get-Process | Select-Object ProcessName,CPU | Sort-Object CPU -Descending | Select -First 10|
ConvertTo-Html -title "Process Report Output" -PreContent "<h1>Process Output</h1>" -Head "  

 <style> h1,th,td{font-family: Segoe UI;}
 th {background-color: Green;} 
 td {border: 1px solid black; padding : 4px;}   
 </style>"|    
 
Out-File "C:\Script\out.html" 

# Getting all the services

Get-Service -ComputerName dc1, localhost -name bits
