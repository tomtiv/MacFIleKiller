cls

"--------------------------"
" Starting Mac File Killer "
"--------------------------"
" "

#$LocalDrives = gwmi Win32_LogicalDisk -filter "DriveType=3"
$NetworkDrives = gwmi Win32_LogicalDisk -filter "DriveType=4"

#"Found " + $LocalDrives.Count + " Local Drive(s)"
"Found " + $NetworkDrives.Count + " Network Drive(s)"

#foreach ($disk in Get-WMIObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 -or $_.DriveType -eq 4})
foreach ($disk in $NetworkDrives)
{
	" "
#   Example of skipping a drive you don't want to 	
	if($disk.DeviceID -eq "X:")
	{
		"Skipping " + $disk.DeviceID
	}
	else
	{
		"--------------------------"
		"Processing " + $disk.DeviceID
		cd -LiteralPath $disk.DeviceID
		dir * -include "._*", ".DS_*" -Recurse -Force | Remove-Item -Force
		"Done With " + $disk.DeviceID
		"--------------------------"		
	}
	" "
}
"--------------------------"
"ALL DONE!"
"--------------------------"