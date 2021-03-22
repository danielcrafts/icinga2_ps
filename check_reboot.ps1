	# Checks if RebootRequired key exists, if so returns a warning.
	# This key is deleted upon a successful reboot.
	# This may indicate that Windows patching has taken place, without a reboot.
		 
	# Checks if RebootRequired reg path exists
	$value = test-path -path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"
	 
	# If path does not exist, return OK status
	if ($value -match "False") {
	echo "OK - No Reboot required"
	$returnCode=0
	}
	 
	# Else return WARNING status
	else {
	echo "WARNING - Reboot required"
	$returnCode=1
	}
	 
	exit ($returnCode)