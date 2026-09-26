<#
.SYNOPSIS
    Symlinks every addon in ./addons into a local WoW Interface\AddOns folder.

.DESCRIPTION
    Creates one directory symlink per addon subfolder, pointing from the target
    game client's AddOns folder back into this repo. Editing files in the repo
    is immediately live in-game — no copy/build step. Safe to re-run; existing
    correct symlinks are left alone, and nothing in the repo is ever touched.

.PARAMETER WowPath
    Full path to the target client's AddOns folder, e.g.:
    "F:\World of Warcraft\_classic_era_\Interface\AddOns"

.PARAMETER WhatIf
    Preview changes without creating any symlinks.

.NOTES
    Creating symlinks on Windows requires either an elevated (Administrator)
    PowerShell session, or Developer Mode enabled (Settings > Privacy & Security
    > For developers). This script does not require WoW to be closed, but you
    should reload UI (/reload) or relaunch the client afterward.

    To remove a symlink later: Remove-Item "<AddOns>\<AddonName>" -Force
    (this deletes only the link, never the repo contents).
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [string]$WowPath
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $WowPath)) {
    throw "WowPath does not exist: $WowPath"
}

$repoRoot = Split-Path -Parent $PSScriptRoot
$addonsRoot = Join-Path $repoRoot "addons"

if (-not (Test-Path $addonsRoot)) {
    throw "No addons/ folder found at $addonsRoot"
}

$addonDirs = Get-ChildItem -Path $addonsRoot -Directory
if ($addonDirs.Count -eq 0) {
    Write-Warning "No addon folders found under $addonsRoot yet — nothing to link."
    return
}

foreach ($addon in $addonDirs) {
    $source = $addon.FullName
    $destination = Join-Path $WowPath $addon.Name

    if (Test-Path $destination) {
        $existing = Get-Item $destination -Force
        if ($existing.LinkType -eq "SymbolicLink" -and $existing.Target -eq $source) {
            Write-Host "OK      $($addon.Name) already linked" -ForegroundColor DarkGray
            continue
        }
        else {
            Write-Warning "SKIP    $destination already exists and is not a link to this repo. Remove it manually first if you want it replaced."
            continue
        }
    }

    if ($PSCmdlet.ShouldProcess($destination, "Create symlink to $source")) {
        New-Item -ItemType SymbolicLink -Path $destination -Target $source | Out-Null
        Write-Host "LINKED  $($addon.Name) -> $destination" -ForegroundColor Green
    }
}
