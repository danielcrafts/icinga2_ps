#ID 5000 local backup
#ID 5005 offsite backup
param
(
$event = 5000,
$pattern = "Failed"
)
$count = 0
$Backups = Get-WinEvent -FilterHashTable @{ProviderName="Altaro VM Backup";LogName="Application";ID=$event;StartTime=(get-date).AddHours(-24)} 
if((test-path "C:\tmp\altaro\") -match "False" ) {New-Item -itemtype "directory" -path "C:\tmp\altaro\" -Force}
$socks = ls C:\tmp\altaro\

#cleanup sock and lock here
foreach ($file in $socks.name){
	$fileage = Test-Path $file -OlderThan (Get-Date).AddDays(-"0").AddHours(-"25").AddMinutes(-"0")
	if ($fileage -match "True") {
		Remove-Item -itemtype "file" -path "C:\tmp\altaro\$file" -Force
		}
	}
		
foreach ($Backup in $Backups){
	# Format VM Name
	$server = $Backup.Message -split "`n" | Where-Object {$_ -match 'Name:'}
    $fail = $server.Split(':')[1]
	$fail = $fail -replace '\s',''

	#Specific Vars and sock
	$sock = "C:\tmp\altaro\$fail.sock"
	$sock2 = "C:\tmp\altaro\$fail.lock"
		if((test-path $sock) -match "False" ) {
		New-Item -itemtype "file" -path "$sock" -Force
		}
	$sockage = Test-Path $sock -OlderThan (Get-Date).AddDays(-"0").AddHours(-"25").AddMinutes(-"0")
	
	if ($sockage -match "True") {
		New-Item -itemtype "file" -path "$sock2" -Force
		$count++
		}

	}

#mesure sock for warning
$sockcount = (ls C:\tmp\altaro\*.sock | measure).count
#mesure lock for crit
$lockcount = (ls C:\tmp\altaro\*.lock | measure).count

if ($lockcount -gt "0") {
	Write-Host " Critical - 2 $pattern Backup for $lockcount Machines in last 48 hours"
	$returnCode=2
	}

if (($sockcount -gt "0") -and ($lockcount -match "0")) {
	Write-Host " Warning - 1 $pattern Backup for $sockcount Machines in last 24 hours"
	$returnCode=1
	}

if (($sockcount -match "0") -and ($lockcount -match "0")) {
	Write-Host " OK - no failed Backups"
	$returnCode=1
	}
	
	exit ($returnCode)
