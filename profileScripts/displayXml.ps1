function Format-Xml {
	param (
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[String[]] $Value
	)

	$Value -split "`n" | ForEach-Object {
		$lastChar = 0
		$line = $_
		$indent = 0
		for ($i = 0; $i -lt $line.Length; $i++) {
			if ($line[$i] -eq '>') {
				$length = $i - $lastChar
				Write-Verbose "LastChar: $lastChar, length: $length"
				"`t" * $indent + $line.Substring($lastChar, $length + 1)
				$lastChar = $i + 1

				if ($line[$i - 1] -ne '/') {
					$indent = $indent + 1
				} else {
					$indent = $indent - 1
				}

			}
		}
		$length = $line.Length - $lastChar
		if ($length -ne 0) {
			$line.Substring($lastChar, $length)
		}
	}
}