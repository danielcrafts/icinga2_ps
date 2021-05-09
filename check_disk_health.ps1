$disk = (Get-PhysicalDisk).HealthStatus

	if ($disk -match "Healthy") {
	echo "OK - Disk Healthy"
	$returnCode=0
	}

    else {
    echo "Critical - Disk not Healthy"
	$returnCode=1
    }

	exit ($returnCode)
