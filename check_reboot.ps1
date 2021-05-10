$sock = "C:\tmp\check_reboot.sock"
$reg = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"
$d = "7"
$h = "0"
$m = "0"

	if ((test-path -path $reg) -match "False") {
		if ((test-path "$sock") -match "True") {
		Remove-Item $sock -Force
		}
	echo "OK - No Reboot required"
	$returnCode=0
	}

	if (((test-path "$sock") -match "False") -and ((test-path -path $reg) -match "true")) {
	New-Item -itemtype "file" -path "$sock" -Force
    }
	
$sockage = Test-Path $sock -OlderThan (Get-Date).AddDays(-"$d").AddHours(-"$h").AddMinutes(-"$m")

    if (((test-path -path $reg) -match "true") -and ($sockage -match "true")) {
    echo "Critical - Reboot required"
	$returnCode=2
    }

	if (((test-path -path $reg) -match "true") -and ($sockage -match "false")) {
	echo "WARNING - Reboot required"
	$returnCode=1
	}
	 
	exit ($returnCode)
