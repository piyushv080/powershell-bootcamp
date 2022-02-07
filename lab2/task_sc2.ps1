#creating files by new item

1..10 | foreach { new-item -Path c:\Files\$_.tmp -value "this is a temporary file"}
1..10 | foreach { new-item -Path c:\Files\$_.bat -value "this is a bat file"}
1..10 | foreach { new-item -Path c:\Files\$_.exe -value "this is a executable file"}
1..10 | foreach { new-item -Path c:\Files\$_.txt -value "this is a text file"}

#calculating file size

$size = Get-ChildItem | Measure-Object -Sum length

#removing-item 

Remove-Item -Path C:\Files\*.tmp
Remove-Item -Path C:\Files\*.bat
Remove-Item -Path C:\Files\*.exe
Remove-Item -Path C:\Files\*.txt

#Print Output on  console
$size 
