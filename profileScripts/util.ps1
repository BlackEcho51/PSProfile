function Set-BinaryContent {
	param (
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[byte[]]
		$Value,
		[Parameter(Mandatory=$true)]
		[String]
		$Path
	)

	begin {
		if (Test-Path $Path)
		{
			Remove-Item $Path
		}
		$Buffer = @()
	}

	process {
		$Buffer += $Value
	}

	end {
		[io.file]::WriteAllBytes($Path, $Buffer)
		$Buffer = @()
	}
}

function Get-BinaryContent {
	param (
		[Parameter(Mandatory=$true)]
		$Path
	)

	[io.file]::ReadAllBytes($Path)
}
