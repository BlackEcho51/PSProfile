$PSProfileFolder = Split-Path -Path $PROFILE
$PSHistoryPath = "$PSProfileFolder\.history.xml"
$PSMaximumHistoryCount = 1KB

if (!(Test-Path $PSProfileFolder -PathType Container)) {
	New-Item $PSProfileFolder -ItemType Directory -Force
}

if (Test-path $PSHistoryPath) {
    $count=0
    Import-CliXml $PSHistoryPath | 
        ForEach-Object { $count++; $_ } | 
        Add-History
    Write-Host "Successfully Added $Count History Items." -ForegroundColor Green
}

Register-EngineEvent PowerShell.Exiting -Action {
	Get-History -Count $PSMaximumHistoryCount | Export-CliXml $PSHistoryPath
    [enviroment]::Exit(0)
} | out-null
