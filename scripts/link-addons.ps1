<#
.SYNOPSIS
  Symlinks each addon folder under addons/ into the live WoW AddOns directory,
  so edits in this repo take effect in-game after /reload.

.PARAMETER AddOnsPath
  Path to the client's AddOns folder. Defaults to the Classic Era path used for this project.

.EXAMPLE
  .\scripts\link-addons.ps1
  .\scripts\link-addons.ps1 -AddOnsPath "F:\World of Warcraft\_retail_\Interface\AddOns"
#>
param(
    [string]$AddOnsPath = "F:\World of Warcraft\_classic_era_\Interface\AddOns"
)

$ErrorActionPreference = "Stop"
$repoRoot = Split-Path -Parent $PSScriptRoot
$addonsSrc = Join-Path $repoRoot "addons"

if (-not (Test-Path $AddOnsPath)) {
    throw "AddOns path not found: $AddOnsPath"
}

if (-not (Test-Path $addonsSrc)) {
    throw "No addons/ folder found in repo: $addonsSrc"
}

Get-ChildItem -Path $addonsSrc -Directory | ForEach-Object {
    $source = $_.FullName
    $linkPath = Join-Path $AddOnsPath $_.Name

    if (Test-Path $linkPath) {
        $existing = Get-Item $linkPath
        if ($existing.LinkType -eq "SymbolicLink") {
            Write-Host "Already linked: $($_.Name)"
            return
        } else {
            Write-Warning "Skipping $($_.Name): $linkPath exists and is not a symlink. Remove it manually first."
            return
        }
    }

    New-Item -ItemType SymbolicLink -Path $linkPath -Target $source | Out-Null
    Write-Host "Linked: $($_.Name) -> $linkPath"
}
