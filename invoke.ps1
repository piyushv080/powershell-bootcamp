Enter-PSSession -ComputerName dc1
Invoke-Command -ScriptBlock {New-Item -Path C:\Training\b.txt -ItemType File}
Exit-PSSession

Test-Path -Path '\\dc1\C$\Training\b.txt'