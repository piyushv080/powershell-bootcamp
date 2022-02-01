# list system file
ls
$a=sample.xml
$a=Get-Content sample.xml
$a
$a.id
$a.book
$a.book.id
$a.catalog
$a.catalog.book.id
$a.gettype()
clear
$xml = Get-Content sample.xml
$a.gettype()
$x.gettype()
$xml.gettype()
$xml.book
$xml[2]
$xml = [xml] (Get-Content sample.xml)
$xml.gettype()
$xml.book
$xml.catalog
$xml.catalog.id
$xml.catalog.book.author
#$xml.catalog.book.id[0]
$xml.catalog.book.author | sort count
$xml.catalog.book.author | Group-Object Author |sort count
$xml.catalog.book | Group-Object Author | sort count
$xml.catalog.book.autohr | Group-Object Author |sort count
$xml | ConvertTo-Html
$xml | ConvertTo-Html | Out-File test.html
test.html
invoke test.html
Get-Content sample.xml | ConvertTo-Html | OutFile test1.html
Get-Content sample.xml | ConvertTo-Json
$xml | ConvertTo-Json
$xml.catalog | convertto-Json
$xml.catalog.book.id | Convertto-Json
$xml.catalog.book.id | ConvertTo-Json |ConvertTo-Html
$xml.catalog.book.id | ConvertTO-html
$xml.catalog.book.id | ConvertTo-Json 
$xml.catalog.book.id | ConvertTo-JSon | ConvertTo-Html
$xml.catalog.book.author | ConvertTo-Json
$xml.catalog.book.author | ConvertTo-Json |ConvertTo-html
$xml.catalog.book.author | ConvertTO-Json
$ab=$xml.catalog.book.author | ConvertTo-Json
$ab | ConvertTo-Html



