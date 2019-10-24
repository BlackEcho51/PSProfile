filter Find-String {
	<#
	.SYNOPSIS
	Selects strings from a collection based on the provided criteria.
	.DESCRIPTION
	Find-String searches through a collection for A string that matches the critera, provided via the other arguments.
	.PARAMETER Contains
	This parameter indicates that strings in the pipeline should only be returned if they contain the value. 
	It defaults to null, which means do not filter based on the contains criteria.
	.PARAMETER StartsWith
	This parameter indicates that strings in the pipeline should only be returned if they start with the value. 
	It defaults to null, which means do not filter based on the starts with criteria.

	#>
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

Set-Alias -Name Where-String -Value Find-String
Set-Alias -Name ?s -Value Find-String

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
