$value = Get-WmiObject -Class Win32_ComputerSystem | Select-Object UserName
$user = Get-Content .\specific_user.conf

#Path Function
function Get-ScriptDirectory {
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value
    Split-Path $Invocation.MyCommand.Path
}
 
#Fixing Admin Path
$runningpath = Get-ScriptDirectory
cd $runningpath

	if ($value -match $user) {
	echo "OK $value"
	}
	 
	# Else return CRITICAL status
	else {
	echo "CRITICAL - $value "
	$returnCode=2
	}
	 
	exit ($returnCode)