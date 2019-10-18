$ProfileDir = Split-Path $Profile
$ProfileScriptsPath = "/profileScripts/"

Get-ChildItem "$(Join-Path $ProfileDir $ProfileScriptsPath)*.ps1" -Exclude *.Tests.ps1 | 
	Where-Object Extension -eq .ps1 |
	ForEach-Object { . $_.FullName }
