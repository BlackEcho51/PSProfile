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

filter ConvertFrom-Base64 {
	param (
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[String[]]
		$Value
	)

	[System.Convert]::FromBase64String($Value)
}

function ConvertTo-Base64 {
	param (
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[byte[]]
		$Value
	)

	begin {
		$ByteArray = @()
	}

	process {
		$ByteArray += $Value
	}
	
	end {
		[System.Convert]::ToBase64String($ByteArray)
	}
}
