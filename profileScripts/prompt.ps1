function prompt {
    Write-Host "[" -NoNewLine
    Write-Host $(Get-Time) -NoNewLine -ForegroundColor Green
    Write-Host " $(Get-Path)" -NoNewLine -ForegroundColor Yellow
    Write-Host $(Format-GitStatus) -NoNewLine -ForegroundColor Magenta
    Write-Host "] " -NoNewLine
}

function Get-Time {
    Get-Date -Format "HH:mm:ss"
}

function Get-Path {
    if ($pwd.Path.Startswith($home)) {
        "~" + $pwd.Path.Substring($home.Length)
    } else {
        $pwd.Path
    }
}

function Format-GitStatus {
    # git rev-parse writes to error if you are in a repository, and nothing if you aren't.
    # redirect to stdout, and check for something on stdout.
    if (git rev-parse 2>&1) {
        ""
    } else {
        " ($(git rev-parse --abbrev-ref HEAD))"
    }
}
