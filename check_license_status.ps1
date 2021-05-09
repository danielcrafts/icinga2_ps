$win = Get-CimInstance SoftwareLicensingProduct -Filter "Name like 'Windows%'" | where { $_.PartialProductKey } | select Description, LicenseStatus

	if (($win).LicenseStatus -match "1") {
	echo "OK - activated"
	$returnCode=0
	}

    else {
    echo "Critical - not activated"
	$returnCode=1
    }

	exit ($returnCode)
