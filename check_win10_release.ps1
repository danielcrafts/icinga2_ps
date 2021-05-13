	# Checks if is available
	$value = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\" -Name ReleaseID).ReleaseId
	
	
	# If path does not exist, return OK status
	if ($value -match "2009") {
	echo "OK - 20h2 "
	$returnCode=0
	}
	 
	# Else return WARNING status
	else {
	echo "WARNING - $value "
	$returnCode=1
	}
	 
	exit ($returnCode)