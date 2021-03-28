$filename = "C:\ProgramData\PuppetLabs\puppet\cache\state\last_run_summary.yaml"
$value = Get-Content $filename |Select-String -Pattern 'failure'

	if ($value -match "0") {
	echo "OK $value"
	}
	 
	# Else return CRITICAL status
	else {
	echo "CRITICAL - $value "
	$returnCode=2
	}
	 
	exit ($returnCode)