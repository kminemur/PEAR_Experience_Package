[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param()

$ErrorActionPreference = 'Stop'

function Write-Log {
    param(
        [Parameter(Mandatory)]
        [string] $Message
    )

    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    Write-Host "[$timestamp] $Message"
}

$repoRoot = & git rev-parse --show-toplevel
if ($LASTEXITCODE -ne 0 -or -not $repoRoot) {
    throw 'Run this script from inside a Git repository.'
}

$targets = @(
    'falling_block_puzzle_demo',
    'webpage_demo',
    'research_assistant_demo',
    'chatbot_on_AIPC',
    'speech_recognition_on_AIPC'
)

Push-Location $repoRoot
try {
    Write-Log "Starting cleanup in $repoRoot."
    if ($PSCmdlet.ShouldProcess(($targets -join ', '), 'git clean -fdx')) {
        foreach ($target in $targets) {
            if (-not (Test-Path -LiteralPath $target -PathType Container)) {
                Write-Log "Skipping '$target' because the directory does not exist."
                continue
            }

            Write-Log "Cleaning '$target'."
            & git clean -fdx -- "$target/*"
            $exitCode = $LASTEXITCODE
            if ($exitCode -ne 0) {
                throw "git clean failed for '$target' with exit code $exitCode."
            }

            if (-not (Test-Path -LiteralPath $target -PathType Container)) {
                New-Item -ItemType Directory -Path $target | Out-Null
                Write-Log "Recreated empty directory '$target'."
            }

            Write-Log "Finished '$target' (git exit code: $exitCode)."
        }
        Write-Log 'Cleanup completed successfully.'
    }
    else {
        Write-Log 'Cleanup was not executed (WhatIf or confirmation declined).'
    }
}
finally {
    Pop-Location
}
