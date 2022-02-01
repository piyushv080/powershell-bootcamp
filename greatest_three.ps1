[int]$a = Read-Host "enter a"
[int]$b = Read-Host "enter b"
[int]$c = Read-Host "enter c"
if($a -gt $b){
    if($a -gt $c){
        Write-Host "$b is greatest"
    }
    else{
        Write-Host "$c is greatest"
    }
}
else{
    if($b -gt $c){
        Write-Host "$b is greatest"
    }
    else{
        Write-Host "$c is greatest"
    }
}