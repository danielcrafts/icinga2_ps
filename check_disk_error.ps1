$disk = Get-PhysicalDIsk | Get-StorageReliabilityCounter |  Select-Object DeviceID, ReadErrorsTotal, WriteErrorsTotal, Wear, Temperature
$state = 0
$read = ""
$write = ""
$wear = ""
$temp = ""

if ($disk.ReadErrorsTotal -gt "0"){
$state = 1
$read = ReadErrorsTotal
}

if ($disk.WriteErrorsTotal -gt "0"){
$state = 1
$write = WriteErrorsTotal
}

if ($disk.Wear -gt "0"){
$state = 1
$wear = Wear
}

if (($disk.Temperature -gt "64") -and ($disk.Temperature -lt "240")){
$state = 1
$temp = Temperature
}

	if ($state -match "0") {
	echo "OK - no error, temp normal"
	$returnCode=0
	}

    if ($state -match "1") {
    echo "Critical - $read $write $wear $temp"
	$returnCode=1
    }

	exit ($returnCode)

