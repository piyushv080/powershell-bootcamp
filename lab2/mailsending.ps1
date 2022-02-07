#Code for mail sending

$username = " "
$password = ConvertTo-SecureString -String " " -AsPlainText -Force
$credential_mail = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $username, $password
$sender_email = " "
$receiver_email= " "
$smtp_address = "smtp.outlook.com"
$smtp_port = 587
$Body_mail = " "
$Subject_mail =" "
Send-MailMessage -from $sender_email -to $receiver_email -Subject $Subject_mail -Body $Body_mail -BodyAsHtml -SmtpServer $smtp_address -port $smtp_port -UseSsl -Credential $credential_mail

#Code for export pass file 

Get-Credential | Export-Clixml -path "C:\Users\yellepeddy.laksh\OneDrive - HCL Technologies Ltd\Desktop\GET 22 Batch\Password New\pwd_new.xml"

#####################################################################################################

$credential = Import-Clixml -Path "C:\Users\yellepeddy.laksh\OneDrive - HCL Technologies Ltd\Desktop\GET 22 Batch\Password New\pwd_new.xml"
$health = Get-PhysicalDisk | Sort Size | FT FriendlyName, Size, MediaType, SpindleSpeed, HealthStatus, OperationalStatus -AutoSize |Out-String
$From = "manasa2702@outlook.com"
$To = "alinahussain07@gmail.com","hg096724@gmail.com","kowsalyas0226@gmail.com"
$Cc = "kowsalyas0226@gmail.com"
$Subject = "Health "
$Body = "$health"
$SMTPServer = "smtp.outlook.com"
$SMTPPort = "587"
Send-MailMessage -From $From -to $To -Cc $Cc -Subject $Subject -Body $Body -BodyAsHtml -SmtpServer $SMTPServer -Port $SMTPPort -UseSsl -Credential $Credential


