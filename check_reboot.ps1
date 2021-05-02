$sock = "C:\tmp\check_test.sock"
$reg = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"

	if ((test-path -path $reg) -match "False") {
		if ((test-path "$sock") -match "True") {
		Remove-Item $sock -Force
		}
	echo "OK - No Reboot required"
	$returnCode=0
	}

	if (((test-path "$sock") -match "False") -and ((test-path -path $reg) -match "true")) {
	New-Item -Path "$sock" -Force
    }
	
$sockage = Test-Path $sock -OlderThan (Get-Date).AddDays(-7).AddHours(-0).AddMinutes(-0)

    if (((test-path -path $reg) -match "true") -and ($sockage -match "true")) {
    echo "Critical - Reboot required"
	$returnCode=1
    }

	if (((test-path -path $reg) -match "true") -and ($sockage -match "false")) {
	echo "WARNING - Reboot required"
	$returnCode=1
	}
	 
	exit ($returnCode)
