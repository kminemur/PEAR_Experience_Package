[CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'Medium')]
param()

$ErrorActionPreference = 'Stop'

$repoRoot = & git rev-parse --show-toplevel
if ($LASTEXITCODE -ne 0 -or -not $repoRoot) {
    throw 'Run this script from inside a Git repository.'
}

$targets = @(
    'falling_block_puzzle',
    'webpage_demo',
    'research_assistant_demo',
    'chatbot_on_AIPC',
    'speech_recognition_on_AIPC'
)
$cleanPaths = $targets | ForEach-Object { "$_/*" }

Push-Location $repoRoot
try {
    if ($PSCmdlet.ShouldProcess(($targets -join ', '), 'git clean -f')) {
        $existingTargets = @(
            $targets | Where-Object { Test-Path -LiteralPath $_ -PathType Container }
        )

        & git clean -f -- @cleanPaths
        if ($LASTEXITCODE -ne 0) {
            throw "git clean failed with exit code $LASTEXITCODE."
        }

        foreach ($target in $existingTargets) {
            if (-not (Test-Path -LiteralPath $target -PathType Container)) {
                New-Item -ItemType Directory -Path $target | Out-Null
            }
        }
    }
}
finally {
    Pop-Location
}
