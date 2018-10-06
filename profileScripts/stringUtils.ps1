filter Where-String {
	param (
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[String[]] $Value,
		[Parameter(Mandatory=$false)]
		[String] $Contains=$null,
		[Parameter(Mandatory=$false)]
		[String] $StartsWith=$null
	)

	$Value |
		Where-Object { $Contains -eq $null -or $_.Contains($Contains) } |
		Where-Object { $StartsWith -eq $null -or $_.StartsWith($StartsWith) }

}
