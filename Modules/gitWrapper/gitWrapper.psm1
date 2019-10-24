# TODO: Investigate options for Testing. Since Mock doesn't handle Applications, I'm not sure how to get tests to work.
$Script:GitCommand = Get-Command git -CommandType Application
$Script:SupportedCommands = @()

function Get-GitLog {
	param()

	$MergeRegex = [regex] "Merge:\s+([0-9a-f]+)\s+([0-9a-f]+)\s*$"
	$AuthorRegex = [regex] "Author:\s+(\w.*\w)\s*<(\w.*\w)>"
	$log = git log
	$i = 0
	while ($i -lt $log.Length) {
		$currentCommit = @{}
		$currentCommit['Commit'] = $log[$i].substring('commit '.Length)
		$offset = 1
		if ($log[$i + $offset].StartsWith('Merge')) {
			# Get the relevant information, out of the log statement
			$Match = $MergeRegex.match($log[$i + $offset])
			$currentCommit['Merge'] = $Match.Groups[1,2].Value
			$offset += 1
		}
		if ($log[$i + $offset].StartsWith('Author')) {
			$Match = $AuthorRegex.Match($log[$i + $offset])
			$currentCommit['AuthorName'] = $Match.Groups[1].Value
			$currentCommit['AuthorEmail'] = $Match.Groups[2].Value
			$offset += 1
		}
		if ($log[$i + $offset].StartsWith('Date')) {
			$DateString = $log[$i + $offset].substring('Date:   '.Length)
			$ParsedDate = [DateTimeOffset]::ParseExact($DateString, "ddd MMM d HH:mm:ss yyyy K",
				[cultureinfo]::InvariantCulture, [System.Globalization.DateTimeStyles]::None)

			$currentCommit['Date'] = $ParsedDate
			$offset += 1
		}
		while ($i + $offset -lt $log.Length -and
				-Not $log[$i + $offset].StartsWith('commit') ) {
			$currentCommit["Message"] += "$($log[$i + $offset].Trim())`n"
			$offset += 1
		}
		$i += $offset
		$currentCommit["Message"] = $currentCommit["Message"].Trim()
		New-Object PSObject -Property $currentCommit
	}
}

<#
function git {
	A small wrapper function. If the command provided is not one supported by Invoke-Git,
	It will pass the arguments to the git.exe Application
	if ($MyInvocation.UnboundArguments[0].ToLower() -eq 'log') {
		Invoke-GitLog
	}

	& $Script:GitCommand $($MyInvocation.UnboundArguments)
}
#>
