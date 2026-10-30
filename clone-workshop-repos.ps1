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

$repositories = [ordered]@{
    falling_block_puzzle      = ''
    webpage_demo              = 'https://github.com/kminemur/webpage_demo.git'
    research_assistant_demo   = 'https://github.com/kminemur/research_assistant_demo.git'
    chatbot_on_AIPC           = 'https://github.com/kminemur/chatbot_on_AIPC.git'
    speech_recognition_on_AIPC = 'https://github.com/kminemur/speech_recognition_on_AIPC.git'
    travel_agent_demo         = 'https://github.com/kminemur/travel_agent_demo.git'
}

Push-Location $repoRoot
try {
    Write-Log "Starting repository clone in $repoRoot."
    foreach ($entry in $repositories.GetEnumerator()) {
        $target = $entry.Key
        $url = $entry.Value

        if ([string]::IsNullOrWhiteSpace($url)) {
            Write-Log "Skipping '$target' because no repository URL is configured."
            continue
        }

        if (Test-Path -LiteralPath $target) {
            $existingItem = Get-Item -LiteralPath $target
            if (-not $existingItem.PSIsContainer) {
                Write-Log "Skipping '$target' because a file with that name already exists."
                continue
            }

            $hasContents = $null -ne (Get-ChildItem -LiteralPath $target -Force | Select-Object -First 1)
            if ($hasContents) {
                Write-Log "Skipping '$target' because the directory already contains files."
                continue
            }
        }

        if ($PSCmdlet.ShouldProcess($target, "git clone $url")) {
            Write-Log "Cloning $url into '$target'."
            & git clone $url $target
            $exitCode = $LASTEXITCODE
            if ($exitCode -ne 0) {
                throw "git clone failed for '$target' with exit code $exitCode."
            }

            Write-Log "Finished '$target' (git exit code: $exitCode)."
        }
    }

    Write-Log 'Repository clone process completed.'
}
finally {
    Pop-Location
}
