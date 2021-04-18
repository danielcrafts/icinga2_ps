$value = Get-WmiObject -Class Win32_ComputerSystem | Select-Object UserName
$user = Get-Content .\specific_user.conf

	if ($value -match $user) {
	echo "OK $value"
	}
	 
	# Else return CRITICAL status
	else {
	echo "CRITICAL - $value "
	$returnCode=2
	}
	 
	exit ($returnCode)