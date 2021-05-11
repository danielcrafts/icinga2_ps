$disk = Get-PhysicalDIsk | Get-StorageReliabilityCounter |  Select-Object DeviceID, ReadErrorsTotal, WriteErrorsTotal, Wear, Temperature
$state = 0

if ($disk.ReadErrorsTotal -gt "0"){
$state = 1
}

if ($disk.WriteErrorsTotal -gt "0"){
$state = 1
}

if ($disk.Wear -gt "0"){
$state = 1
}

if (($disk.Temperature -gt "64") -and ($disk.Temperature -lt "240")){
$state = 1
}

	if ($state -match "0") {
	echo "OK - no error, temp normal"
	$returnCode=0
	}

    if ($state -match "1") {
    echo "Critical - $disk"
	$returnCode=2
    }

	exit ($returnCode)
