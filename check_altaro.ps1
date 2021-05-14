#ID 5000 local backup
#ID 5005 offsite backup
param
(
$event = 5000
$pattern = "Failed"
)
$count = 0
$Backups = Get-WinEvent -FilterHashTable @{ProviderName="Altaro VM Backup";LogName="Application";ID=$event;StartTime=(get-date).AddHours(-24)} 

foreach ($Backup in $Backups)
{
	$server = $Backup.Message -split "`n" | Where-Object {$_ -match 'Name:'}
    $fail = $server.Split(':')[1]
	$fail = $fail -replace '\s',''
    if ($Backup.Message -match $pattern) {$count++}
	$sock = "C:\tmp\$fail.sock"
	$sock2 = "C:\tmp\$fail.lock"
	
	if ((test-path "$sock") -match "True") {
		$sockage = Test-Path $sock -OlderThan (Get-Date).AddDays(-"0").AddHours(-"49").AddMinutes(-"0")
		}
	if ($sockage -match "true"){
		Remove-Item $sock -Force
		}
	if ((test-path "$sock") -match "True") {
		New-Item -itemtype "file" -path "$sock2" -Force
		$count++
		}

}

Write-Host " 2 $pattern Backup for $count Machines in last 48 hours"