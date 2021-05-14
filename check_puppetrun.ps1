$filename = "C:\ProgramData\PuppetLabs\puppet\cache\state\last_run_report.yaml"
$value = Get-Content $filename |Select-String -Pattern 'status:'

	if ($value -match "failed") {
    echo "CRITICAL - last run failed "
	$returnCode=2
	}
	 
	# Else return CRITICAL status
	else {
	echo "OK - no error"
	$returnCode=0
	}
	 
	exit ($returnCode)