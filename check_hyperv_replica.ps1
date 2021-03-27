 	# Checks if hyperV replica is running
	$value = (Get-VMReplication –ReplicationState Error | measure).count
	 
	# If path does not exist, return OK status
	if ($value -match "0") {
	echo "OK - No Replication errors"
	$returnCode=0
	}
	 
	# Else return WARNING status
	else {
	echo "WARNING - $value Replication errors"
	$returnCode=1
	}
	 
	exit ($returnCode)