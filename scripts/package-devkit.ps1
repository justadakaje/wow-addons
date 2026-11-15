<#
.SYNOPSIS
    Packages the WoW: Forever Addon Copilot & DevKit into a shareable zip.

.DESCRIPTION
    Bundles the self-contained developer toolkit for fellow WoW: Forever addon
    authors into dist/wow-forever-copilot-devkit-<version>-b<build>.zip:
      - mcp/               (wow-api MCP server source, package manifest, compiled dist/, smoke test)
      - reference/         (api.json, README.md, undocumented.md, api/*.md)
      - addons/ForeverProbe/
      - scripts/           (extract-api.js, check-toc.js, check-lua.js)
      - .luacheckrc
      - .claude/skills/wow-addon-partner/SKILL.md
      - SETUP.md, AGENTS.template.md, mcp.json.example, LICENSE

    By default node_modules/ is omitted so the zip stays lightweight (~1 MB);
    recipients run `cd mcp && npm install --omit=dev && node smoke.mjs`.
    Pass -IncludeNodeModules to include mcp/node_modules/ for offline setup.

.PARAMETER OutDir
    Destination directory for the zip. Defaults to .\dist.

.PARAMETER SkipBuild
    Skip running `npm run build` in .\mcp and copy existing mcp\dist\ files.

.PARAMETER IncludeNodeModules
    Include mcp\node_modules\ inside the bundle (larger zip, zero npm install step).

.EXAMPLE
    .\scripts\package-devkit.ps1
#>

[CmdletBinding()]
param(
    [string]$OutDir,

    [switch]$SkipBuild,

    [switch]$IncludeNodeModules
)

$ErrorActionPreference = "Stop"

$repoRoot = Split-Path -Parent $PSScriptRoot
$mcpDir = Join-Path $repoRoot "mcp"
$refDir = Join-Path $repoRoot "reference"
$apiJsonPath = Join-Path $refDir "api.json"

if (-not (Test-Path -LiteralPath $apiJsonPath)) {
    throw "Missing $apiJsonPath. Run scripts/extract-api.js first."
}

$apiMeta = Get-Content -LiteralPath $apiJsonPath -Raw | ConvertFrom-Json
$clientVer = if ($apiMeta.build.version) { [string]$apiMeta.build.version } else { "unknown" }
$clientBuild = if ($apiMeta.build.build) { [string]$apiMeta.build.build } else { "unknown" }

if (-not $SkipBuild) {
    Push-Location $mcpDir
    try {
        if (-not (Test-Path -LiteralPath (Join-Path $mcpDir "node_modules"))) {
            Write-Host "Installing mcp dependencies..." -ForegroundColor Cyan
            & npm install
            if ($LASTEXITCODE -ne 0) { throw "npm install failed in mcp/" }
        }
        Write-Host "Building mcp TypeScript server..." -ForegroundColor Cyan
        & npm run build
        if ($LASTEXITCODE -ne 0) { throw "npm run build failed in mcp/" }
    } finally {
        Pop-Location
    }
}

$mcpDistDir = Join-Path $mcpDir "dist"
if (-not (Test-Path -LiteralPath (Join-Path $mcpDistDir "index.js"))) {
    throw "Missing $mcpDistDir\index.js. Run without -SkipBuild or run 'npm run build' in mcp/."
}

if (-not $OutDir) { $OutDir = Join-Path $repoRoot "dist" }
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$bundleName = "wow-forever-copilot-devkit"
$stageRoot = Join-Path ([System.IO.Path]::GetTempPath()) ("devkitpkg_" + [guid]::NewGuid().ToString("N"))
$stageBundle = Join-Path $stageRoot $bundleName
New-Item -ItemType Directory -Force -Path $stageBundle | Out-Null

try {
    # 1. MCP server
    $dstMcp = Join-Path $stageBundle "mcp"
    New-Item -ItemType Directory -Force -Path $dstMcp | Out-Null
    foreach ($f in @("package.json", "package-lock.json", "tsconfig.json", "smoke.mjs", "README.md")) {
        $src = Join-Path $mcpDir $f
        if (Test-Path -LiteralPath $src) {
            Copy-Item -LiteralPath $src -Destination (Join-Path $dstMcp $f) -Force
        }
    }
    Copy-Item -Path $mcpDistDir -Destination (Join-Path $dstMcp "dist") -Recurse -Force
    Copy-Item -Path (Join-Path $mcpDir "src") -Destination (Join-Path $dstMcp "src") -Recurse -Force
    if ($IncludeNodeModules) {
        $nm = Join-Path $mcpDir "node_modules"
        if (-not (Test-Path -LiteralPath $nm)) {
            throw "-IncludeNodeModules was passed, but $nm does not exist."
        }
        Copy-Item -Path $nm -Destination (Join-Path $dstMcp "node_modules") -Recurse -Force
    }

    # 2. Generated live API reference (keep alongside mcp/ so ../../reference/api.json resolves automatically)
    $dstRef = Join-Path $stageBundle "reference"
    New-Item -ItemType Directory -Force -Path $dstRef | Out-Null
    foreach ($f in @("api.json", "README.md", "undocumented.md")) {
        $src = Join-Path $refDir $f
        if (Test-Path -LiteralPath $src) {
            Copy-Item -LiteralPath $src -Destination (Join-Path $dstRef $f) -Force
        }
    }
    $refApiDir = Join-Path $refDir "api"
    if (Test-Path -LiteralPath $refApiDir) {
        Copy-Item -Path $refApiDir -Destination (Join-Path $dstRef "api") -Recurse -Force
    }

    # 3. ForeverProbe harvester addon
    $dstProbe = Join-Path $stageBundle "addons\ForeverProbe"
    New-Item -ItemType Directory -Force -Path $dstProbe | Out-Null
    Copy-Item -Path (Join-Path $repoRoot "addons\ForeverProbe\*") -Destination $dstProbe -Recurse -Force

    # 4. Extractor & static QA validators
    $dstScripts = Join-Path $stageBundle "scripts"
    New-Item -ItemType Directory -Force -Path $dstScripts | Out-Null
    foreach ($s in @("extract-api.js", "check-toc.js", "check-lua.js")) {
        Copy-Item -LiteralPath (Join-Path $repoRoot "scripts\$s") -Destination (Join-Path $dstScripts $s) -Force
    }

    foreach ($rootFile in @(".luacheckrc", "LICENSE")) {
        $src = Join-Path $repoRoot $rootFile
        if (Test-Path -LiteralPath $src) {
            Copy-Item -LiteralPath $src -Destination (Join-Path $stageBundle $rootFile) -Force
        }
    }

    # 5. Copilot skill & starter configs
    $dstSkill = Join-Path $stageBundle ".claude\skills\wow-addon-partner"
    New-Item -ItemType Directory -Force -Path $dstSkill | Out-Null
    Copy-Item -LiteralPath (Join-Path $repoRoot ".claude\skills\wow-addon-partner\SKILL.md") -Destination (Join-Path $dstSkill "SKILL.md") -Force

    $setupDoc = Join-Path $repoRoot "docs\copilot-devkit.md"
    if (Test-Path -LiteralPath $setupDoc) {
        Copy-Item -LiteralPath $setupDoc -Destination (Join-Path $stageBundle "SETUP.md") -Force
    }

    $agentsTemplate = @"
# Project rules — WoW: Forever AddOn Development

- **Verify every API call before writing it.** Use the attached ``wow-api`` MCP server tools (``lookup_api``, ``search_api``, ``get_namespace``, ``get_widget_methods``, ``get_enum``, ``get_event``, ``list_deprecated``) rather than recalling signatures from memory.
- **Target game version explicitly.** Check every ``.toc`` file's ``## Interface:`` line. For **WoW: Forever** (1.60.1) the confirmed Interface number is **16001** (never ``11601``).
- **Avoid ``fn and fn(...)`` on multi-return Lua calls.** Guard optional multi-return APIs with explicit ``local a, b; if fn then a, b = fn(...) end``.
- **No ``OnUpdate`` polling.** Use events or a self-rescheduling ``C_Timer.After`` that stops when idle.
- **Missing data -> ``nil`` + explanation**, never a silent zero or guessed number.
- **Validate before launch.** Run ``node scripts/check-toc.js`` and ``node scripts/check-lua.js`` (requires ``luaparse``).
"@
    Set-Content -LiteralPath (Join-Path $stageBundle "AGENTS.template.md") -Value $agentsTemplate -Encoding UTF8

    $mcpExample = @"
{
  "mcpServers": {
    "wow-api": {
      "command": "node",
      "args": ["REPLACE_WITH_EXTRACTED_PATH/wow-forever-copilot-devkit/mcp/dist/index.js"]
    }
  }
}
"@
    Set-Content -LiteralPath (Join-Path $stageBundle "mcp.json.example") -Value $mcpExample -Encoding UTF8

    $zipPath = Join-Path $OutDir "wow-forever-copilot-devkit-$clientVer-b$clientBuild.zip"
    if (Test-Path -LiteralPath $zipPath) { Remove-Item -LiteralPath $zipPath -Force }

    Compress-Archive -Path $stageBundle -DestinationPath $zipPath -CompressionLevel Optimal
    $sizeKb = [math]::Round((Get-Item -LiteralPath $zipPath).Length / 1KB, 1)

    Write-Host "Packaged WoW: Forever Copilot DevKit ($clientVer build $clientBuild)" -ForegroundColor Green
    Write-Host "  -> $zipPath ($sizeKb KB)"
    Write-Host "  Includes: mcp/, reference/, addons/ForeverProbe/, scripts/{extract-api,check-toc,check-lua}.js, .luacheckrc, SKILL.md, SETUP.md, AGENTS.template.md, mcp.json.example"
    if (-not $IncludeNodeModules) {
        Write-Host "  Note: Recipient runs 'cd mcp && npm install --omit=dev && node smoke.mjs' (Node 20+)." -ForegroundColor Yellow
    }
} finally {
    if (Test-Path -LiteralPath $stageRoot) {
        Remove-Item -LiteralPath $stageRoot -Recurse -Force -ErrorAction SilentlyContinue
    }
}
