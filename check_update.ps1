	# Checks if is available
	$value = ((Get-WindowsUpdate).ComputerName | measure).count
	 
	# If path does not exist, return OK status
	if ($value -match "0") {
	echo "OK - No Update required"
	$returnCode=0
	}
	 
	# Else return WARNING status
	else {
	echo "WARNING - $value Update required"
	$returnCode=1
	}
	 
	exit ($returnCode)