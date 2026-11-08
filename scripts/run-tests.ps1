<#
.SYNOPSIS
    Runs Luacheck linting and Busted unit tests for wow-addons.

.DESCRIPTION
    Developer test runner for Windows. Dispatches execution into the WSL 2
    Ubuntu-24.04 environment (where Lua 5.1, Luacheck, and Busted are installed)
    or falls back to native Windows binaries if available.

.PARAMETER Addon
    Target specific addon under addons/ (e.g. "GoldFinder"). If omitted, runs
    across the entire monorepo.

.PARAMETER LintOnly
    Run Luacheck static analysis only.

.PARAMETER TestOnly
    Run Busted unit tests only.

.PARAMETER Strict
    Fail the build on any Luacheck warnings.

.EXAMPLE
    .\scripts\run-tests.ps1
    .\scripts\run-tests.ps1 -Addon GoldFinder
    .\scripts\run-tests.ps1 -TestOnly
#>

[CmdletBinding()]
param(
    [string]$Addon,

    [switch]$LintOnly,

    [switch]$TestOnly,

    [switch]$Strict
)

$repoRoot = Split-Path -Parent $PSScriptRoot

# Build arguments array
$argsList = @()
if ($Addon) { $argsList += $Addon }
if ($LintOnly) { $argsList += "--lint-only" }
if ($TestOnly) { $argsList += "--test-only" }
if ($Strict) { $argsList += "--strict" }

$argsString = $argsList -join " "

# Check if WSL is available
$hasWsl = $false
try {
    $null = Get-Command wsl -ErrorAction Stop
    $hasWsl = $true
} catch {
    $hasWsl = $false
}

if ($hasWsl) {
    # Convert Windows repo path to WSL mount path (e.g. D:\... -> /mnt/d/...)
    $wslRepoRoot = $repoRoot -replace '\\', '/'
    if ($wslRepoRoot -match '^([A-Za-z]):/(.*)$') {
        $drive = $Matches[1].ToLower()
        $rest = $Matches[2]
        $wslRepoRoot = "/mnt/$drive/$rest"
    }

    $bashCmd = "cd '$wslRepoRoot' && ./scripts/run-tests.sh $argsString"
    wsl -d Ubuntu-24.04 -- bash -c $bashCmd
    exit $LASTEXITCODE
} else {
    # Fallback to local Windows binaries
    Write-Host "WSL not found; attempting to run using local Windows binaries..." -ForegroundColor Yellow

    Set-Location $repoRoot
    $exitCode = 0

    if (-not $TestOnly) {
        if (Get-Command luacheck -ErrorAction SilentlyContinue) {
            $target = if ($Addon) { "addons/$Addon" } else { "addons" }
            Write-Host "Running Luacheck on $target..." -ForegroundColor Cyan
            & luacheck $target
            if ($LASTEXITCODE -ne 0 -and $Strict) {
                $exitCode = $LASTEXITCODE
            }
        } else {
            Write-Warning "Luacheck not found on Windows PATH."
        }
    }

    if (-not $LintOnly -and $exitCode -eq 0) {
        if (Get-Command busted -ErrorAction SilentlyContinue) {
            $target = if ($Addon) { "addons/$Addon" } else { "addons" }
            Write-Host "Running Busted on $target..." -ForegroundColor Cyan
            & busted $target
            if ($LASTEXITCODE -ne 0) {
                $exitCode = $LASTEXITCODE
            }
        } else {
            Write-Warning "Busted not found on Windows PATH."
        }
    }

    exit $exitCode
}
