<#
.SYNOPSIS
    Builds a release zip for one addon, ready to upload to CurseForge.

.DESCRIPTION
    Stages the addon into a temporary folder, drops development-only files,
    rewrites the .toc so it no longer references them, adds the repo LICENSE,
    and zips the result.

    The zip contains exactly one top-level folder named after the addon, which
    is what the game expects when a user extracts it into Interface\AddOns.

    Nothing in the repo is modified. The staging copy is thrown away.

.PARAMETER Addon
    Addon folder name under .\addons, e.g. "AdventurerPlates".

.PARAMETER OutDir
    Where to write the zip. Defaults to .\dist (gitignored).

.PARAMETER IncludeDevFiles
    Ship the development-only files too. Off by default -- see DEV_ONLY below
    for why the capability probe is not in a public release.

.EXAMPLE
    .\scripts\package-addon.ps1 -Addon AdventurerPlates
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$Addon,

    [string]$OutDir,

    [switch]$IncludeDevFiles
)

$ErrorActionPreference = "Stop"

# Files that exist for developing the addon, not for using it.
#
# Probe.lua carries /advplate risky, which calls undocumented globals and says
# plainly that it can crash the client. That is a reasonable thing for the
# author to run deliberately and a bad thing for a curious user to discover in
# a command list. Its findings are already recorded in the README, so shipping
# it buys nothing and costs a crash report we cannot reproduce.
$DEV_ONLY = @("Probe.lua")

$repoRoot = Split-Path -Parent $PSScriptRoot
$srcDir   = Join-Path $repoRoot "addons\$Addon"

if (-not (Test-Path -LiteralPath $srcDir)) {
    throw "No such addon: $srcDir"
}

$tocPath = Join-Path $srcDir "$Addon.toc"
if (-not (Test-Path -LiteralPath $tocPath)) {
    throw "No .toc found. Expected: $tocPath"
}

# Version comes from the .toc, so the zip name can never disagree with what
# the game reports.
$tocLines = Get-Content -LiteralPath $tocPath
$versionLine = $tocLines | Where-Object { $_ -match '^##\s*Version:\s*(.+)$' } | Select-Object -First 1
if (-not $versionLine) { throw "No '## Version:' line in $tocPath" }
$version = ($versionLine -replace '^##\s*Version:\s*', '').Trim()

if (-not $OutDir) { $OutDir = Join-Path $repoRoot "dist" }
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

# Stage under a unique temp folder so a stale run cannot contaminate this one.
$stageRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("addonpkg_" + [guid]::NewGuid().ToString("N"))
$stageAddon = Join-Path $stageRoot $Addon
New-Item -ItemType Directory -Force -Path $stageAddon | Out-Null

try {
    # -Path, not -LiteralPath. LiteralPath treats the wildcard as a literal
    # character, so the copy looks for a file actually named "*" and fails.
    Copy-Item -Path (Join-Path $srcDir "*") -Destination $stageAddon -Recurse -Force

    $dropped = @()
    if (-not $IncludeDevFiles) {
        foreach ($name in $DEV_ONLY) {
            $p = Join-Path $stageAddon $name
            if (Test-Path -LiteralPath $p) {
                Remove-Item -LiteralPath $p -Force
                $dropped += $name
            }
        }
    }

    # A .toc listing a file that is not in the package fails to load that file,
    # so the manifest has to agree with what actually shipped.
    if ($dropped.Count -gt 0) {
        $stagedToc = Join-Path $stageAddon "$Addon.toc"
        $kept = Get-Content -LiteralPath $stagedToc | Where-Object {
            $line = $_.Trim()
            -not ($dropped -contains $line)
        }
        Set-Content -LiteralPath $stagedToc -Value $kept -Encoding UTF8
    }

    # Ship the license with the addon; a zip that travels without one is a
    # zip whose terms nobody can find.
    $license = Join-Path $repoRoot "LICENSE"
    if (Test-Path -LiteralPath $license) {
        Copy-Item -LiteralPath $license -Destination (Join-Path $stageAddon "LICENSE") -Force
    }

    $zipPath = Join-Path $OutDir "$Addon-$version.zip"
    if (Test-Path -LiteralPath $zipPath) { Remove-Item -LiteralPath $zipPath -Force }

    Compress-Archive -Path $stageAddon -DestinationPath $zipPath -CompressionLevel Optimal

    $sizeKb = [math]::Round((Get-Item -LiteralPath $zipPath).Length / 1KB, 1)

    "Packaged $Addon $version"
    "  -> $zipPath  ($sizeKb KB)"
    if ($dropped.Count -gt 0) {
        "  excluded (development only): $($dropped -join ', ')"
    } else {
        "  excluded: nothing (-IncludeDevFiles was set)"
    }
    ""
    "Contents:"
    Get-ChildItem -LiteralPath $stageAddon | ForEach-Object { "  $Addon/$($_.Name)" }
}
finally {
    if (Test-Path -LiteralPath $stageRoot) {
        Remove-Item -LiteralPath $stageRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
}
