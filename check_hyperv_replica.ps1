	# Checks if RebootRequired key exists, if so returns a warning.
	# This key is deleted upon a successful reboot.
	# This may indicate that Windows patching has taken place, without a reboot.
		 
	# Checks if RebootRequired reg path exists
	$value = (Get-VMReplication –ReplicationState Error | measure).count
	 
	# If path does not exist, return OK status
	if ($value -match "0") {
	echo "OK - No Replication Error's"
	$returnCode=0
	}
	 
	# Else return Critical status
	else {
	echo "CRITICAL - $value Replication errors"
	$returnCode=1
	}
	 
	exit ($returnCode)