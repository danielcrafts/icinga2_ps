	param
	(
	$d = "7",
	$h = "0",
	$m = "0",
	$warn = "1",
	$crit = "2"
	)
	$sock = "C:\tmp\check_update.sock"
	$value = 666
	$value = ((Get-WindowsUpdate).ComputerName | measure).count
	
	if ($value -match "666") {
    echo "Critical - problem to execute Get-WindowsUpdate on machine"
	$returnCode=2
	}
	
	if ($value -lt "$crit") {
	echo "OK - $value Update required|update=$value;$warn;$crit"
	if ((test-path "$sock") -match "true"){
	Remove-Item -Path "$sock" -Force
	$returnCode=0
	}
	}
	 
	if (((test-path "$sock") -match "False") -and ($value -gt "$warn")) {
	New-Item -Path "$sock" -Force
    }
	
	$sockage = Test-Path $sock -OlderThan (Get-Date).AddDays(-"$d").AddHours(-"$h").AddMinutes(-"$m")

    if (($value -gt "$warn") -and ($sockage -match "true")) {
    echo "Critical - $value Update required|update=$value;$warn;$crit"
	$returnCode=2
    }

	if (($value -gt "$warn") -and ($sockage -match "false")) {
	echo "WARNING - $value Update required|update=$value;$warn;$crit"
	$returnCode=1
	}
	 
	exit ($returnCode)