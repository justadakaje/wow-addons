Add-Type -AssemblyName System.Drawing

$outDir = "d:\Code\GitHub\wow-addons\docs\media\twitch-banners"
if (!(Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }

function Get-RoundRectPath {
    param([float]$x, [float]$y, [float]$w, [float]$h, [float]$r)
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $d = $r * 2
    $path.AddArc($x, $y, $d, $d, 180, 90)
    $path.AddArc($x + $w - $d, $y, $d, $d, 270, 90)
    $path.AddArc($x + $w - $d, $y + $h - $d, $d, $d, 0, 90)
    $path.AddArc($x, $y + $h - $d, $d, $d, 90, 90)
    $path.CloseFigure()
    return $path
}

function Get-HexagonPath {
    param([float]$cx, [float]$cy, [float]$r)
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $pts = [System.Drawing.PointF[]]::new(6)
    for ($i = 0; $i -lt 6; $i++) {
        $angle = ($i * 60 - 30) * [Math]::PI / 180.0
        $pts[$i] = [System.Drawing.PointF]::new($cx + $r * [Math]::Cos($angle), $cy + $r * [Math]::Sin($angle))
    }
    $path.AddPolygon($pts)
    return $path
}

# ==============================================================================
# 1. OFFLINE VIDEO PLAYER BANNER (1920x1080)
# ==============================================================================
Write-Host "Rendering 1920x1080 Offline Stream Placeholder..."
$w = 1920
$h = 1080
$bmp = [System.Drawing.Bitmap]::new($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Background Gradient
$bgBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(0, 0),
    [System.Drawing.PointF]::new(1920, 1080),
    [System.Drawing.Color]::FromArgb(255, 5, 7, 10),    # #05070a
    [System.Drawing.Color]::FromArgb(255, 10, 18, 24)   # #0a1218
)
$g.FillRectangle($bgBrush, 0, 0, $w, $h)
$bgBrush.Dispose()

# Subtle background grid lines
$gridPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(15, 34, 211, 238), 1.0)
for ($x = 60; $x -lt $w; $x += 60) { $g.DrawLine($gridPen, $x, 0, $x, $h) }
for ($y = 60; $y -lt $h; $y += 60) { $g.DrawLine($gridPen, 0, $y, $w, $y) }
$gridPen.Dispose()

# Top ambient glow line
$topGlow = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(0, 0),
    [System.Drawing.PointF]::new(1920, 0),
    [System.Drawing.Color]::FromArgb(0, 34, 211, 238),
    [System.Drawing.Color]::FromArgb(200, 34, 211, 238)
)
$penTop = [System.Drawing.Pen]::new($topGlow, 4.0)
$g.DrawLine($penTop, 0, 2, $w, 2)
$penTop.Dispose()
$topGlow.Dispose()

# Status Pill (Top Right)
$pillPath = Get-RoundRectPath 1420 40 440 44 22
$pillBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(200, 15, 23, 42))
$g.FillPath($pillBrush, $pillPath)
$pillBrush.Dispose()
$pillBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 51, 65, 85), 1.5)
$g.DrawPath($pillBorder, $pillPath)
$pillBorder.Dispose()
$pillPath.Dispose()

# Red Offline Dot
$dotBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 239, 68, 68))
$g.FillEllipse($dotBrush, 1445, 54, 16, 16)
$dotBrush.Dispose()

$fontPill = [System.Drawing.Font]::new("Segoe UI Semibold", 13)
$brushPillText = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 203, 213, 225))
$g.DrawString("SYSTEM OFFLINE · SCHEDULE BELOW", $fontPill, $brushPillText, 1475, 51)
$fontPill.Dispose()
$brushPillText.Dispose()

# Center Crest / Monogram (X=960, Y=140)
$hexOuter = Get-HexagonPath 960 140 50.0
$brushHex = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(910, 90),
    [System.Drawing.PointF]::new(1010, 190),
    [System.Drawing.Color]::FromArgb(255, 14, 165, 233),
    [System.Drawing.Color]::FromArgb(255, 245, 158, 11)
)
$g.FillPath($brushHex, $hexOuter)
$brushHex.Dispose()

$hexInner = Get-HexagonPath 960 140 42.0
$brushDark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 10, 18, 24))
$g.FillPath($brushDark, $hexInner)
$brushDark.Dispose()
$hexInner.Dispose()
$hexOuter.Dispose()

$fontMonogram = [System.Drawing.Font]::new("Arial Black", 24)
$brushGold = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 251, 191, 36))
$sfCenter = [System.Drawing.StringFormat]::new()
$sfCenter.Alignment = [System.Drawing.StringAlignment]::Center
$g.DrawString("KH", $fontMonogram, $brushGold, 960, 122, $sfCenter)
$fontMonogram.Dispose()
$brushGold.Dispose()

# Main Title: KENNETH HENSELER
$fontTitle = [System.Drawing.Font]::new("Segoe UI", 48, [System.Drawing.FontStyle]::Bold)
$brushTitle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$g.DrawString("KENNETH HENSELER", $fontTitle, $brushTitle, 960, 205, $sfCenter)
$fontTitle.Dispose()
$brushTitle.Dispose()

# Handle Badge: [ kenhenchan ]
$handlePath = Get-RoundRectPath 870 295 180 34 8
$handleBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(180, 8, 47, 73))
$g.FillPath($handleBrush, $handlePath)
$handleBrush.Dispose()
$handleBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238), 1.5)
$g.DrawPath($handleBorder, $handlePath)
$handleBorder.Dispose()
$handlePath.Dispose()

$fontHandle = [System.Drawing.Font]::new("Consolas", 15, [System.Drawing.FontStyle]::Bold)
$brushHandle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238))
$g.DrawString("kenhenchan", $fontHandle, $brushHandle, 960, 301, $sfCenter)
$fontHandle.Dispose()
$brushHandle.Dispose()

# Subtitle: Senior IT Infrastructure Manager · Live AddOn Dev · Autonomous AI
$fontSub = [System.Drawing.Font]::new("Segoe UI Semibold", 21)
$brushSub = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 148, 163, 184))
$g.DrawString("Senior IT Infrastructure Manager  ·  Live AddOn Dev  ·  Autonomous AI", $fontSub, $brushSub, 960, 350, $sfCenter)
$fontSub.Dispose()
$brushSub.Dispose()

# Helper to draw glass card
function Draw-Card {
    param($gx, $x, $y, $w, $h, $accentColor, $title, $subtitle, $bullets, $link)
    $cp = Get-RoundRectPath $x $y $w $h 16
    $cb = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(230, 15, 23, 42))
    $gx.FillPath($cb, $cp)
    $cb.Dispose()

    $cpBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 51, 65, 85), 1.5)
    $gx.DrawPath($cpBorder, $cp)
    $cpBorder.Dispose()
    $cp.Dispose()

    # Top accent line
    $penAccent = [System.Drawing.Pen]::new($accentColor, 4.0)
    $gx.DrawLine($penAccent, ($x + 20), ($y + 2), ($x + $w - 20), ($y + 2))
    $penAccent.Dispose()

    # Card Title
    $ft = [System.Drawing.Font]::new("Segoe UI", 20, [System.Drawing.FontStyle]::Bold)
    $bt = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $gx.DrawString($title, $ft, $bt, ($x + 28), ($y + 24))
    $ft.Dispose()
    $bt.Dispose()

    # Subtitle
    $fst = [System.Drawing.Font]::new("Segoe UI", 12, [System.Drawing.FontStyle]::Italic)
    $bst = [System.Drawing.SolidBrush]::new($accentColor)
    $gx.DrawString($subtitle, $fst, $bst, ($x + 28), ($y + 60))
    $fst.Dispose()
    $bst.Dispose()

    # Bullets
    $fb = [System.Drawing.Font]::new("Segoe UI", 13)
    $bb = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 203, 213, 225))
    $by = $y + 105
    foreach ($b in $bullets) {
        $gx.DrawString("•  $b", $fb, $bb, ($x + 28), $by)
        $by += 32
    }
    $fb.Dispose()
    $bb.Dispose()

    # Footer Link Pill
    $fl = [System.Drawing.Font]::new("Consolas", 12, [System.Drawing.FontStyle]::Bold)
    $bl = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 148, 163, 184))
    $gx.DrawString($link, $fl, $bl, ($x + 28), ($y + $h - 40))
    $fl.Dispose()
    $bl.Dispose()
}

# 3 Feature Cards
$cardY = 440
$cardW = 490
$cardH = 360

# Card 1: GoldFinder
Draw-Card -gx $g -x 140 -y $cardY -w $cardW -h $cardH `
    -accentColor ([System.Drawing.Color]::FromArgb(255, 251, 191, 36)) `
    -title "GoldFinder WoW AddOn" `
    -subtitle "Live AH Arbitrage & Profit Intelligence" `
    -bullets @(
        "Crafting reagent conversions & arbitrage",
        "Direct commodity Quick-Buy shortcut",
        "Historical median pricing & trend analytics",
        "Targeted shopping lists & quota tracker",
        "CurseForge v0.5.0  ·  WoW: Forever & Classic"
    ) `
    -link "github.com/justadakaje/wow-addons"

# Card 2: Antigravity AI
Draw-Card -gx $g -x 715 -y $cardY -w $cardW -h $cardH `
    -accentColor ([System.Drawing.Color]::FromArgb(255, 34, 211, 238)) `
    -title "Antigravity AI Pair Coding" `
    -subtitle "Autonomous Multi-Agent Engineering" `
    -bullets @(
        "Live Lua / FrameXML co-pilot & verification",
        "Direct Windows environment integration",
        "On-demand background build subagents",
        "Zero-guesswork wow-api MCP verification",
        "Stream Director, QA & Packaging automation"
    ) `
    -link "twitch.tv/kenhenchan"

# Card 3: Podcasts & Systems
Draw-Card -gx $g -x 1290 -y $cardY -w $cardW -h $cardH `
    -accentColor ([System.Drawing.Color]::FromArgb(255, 168, 85, 247)) `
    -title "Podcasts & Infrastructure" `
    -subtitle "Engineering Post-Mortems & History" `
    -bullets @(
        "Runtime Reality (Infrastructure deep dives)",
        "The Chronos Archive (History & Systems)",
        "Platform engineering & cloud automation",
        "now.log essays & architectural briefs",
        "Available on Apple Podcasts & Spotify"
    ) `
    -link "musingsofmy.today/podcasts"

# Bottom Hub Bar
$fontFooter = [System.Drawing.Font]::new("Segoe UI Semibold", 16)
$brushFooter = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 148, 163, 184))
$g.DrawString("musingsofmy.today   ·   twitch.tv/kenhenchan   ·   github.com/justadakaje", $fontFooter, $brushFooter, 960, 990, $sfCenter)
$fontFooter.Dispose()
$brushFooter.Dispose()
$sfCenter.Dispose()

$bannerFile = Join-Path $outDir "offline-player-banner-1920x1080.png"
$bmp.Save($bannerFile, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()
$fi = Get-Item $bannerFile
Write-Host "Generated: $bannerFile ($($fi.Length) bytes)"


# ==============================================================================
# 2. PROFILE HEADER BANNER (1200x480)
# ==============================================================================
Write-Host "Rendering 1200x480 Profile Header Banner..."
$bw = 1200
$bh = 480
$bmpH = [System.Drawing.Bitmap]::new($bw, $bh, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$gh = [System.Drawing.Graphics]::FromImage($bmpH)
$gh.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$gh.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit

# Background
$bgH = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(0, 0),
    [System.Drawing.PointF]::new(1200, 480),
    [System.Drawing.Color]::FromArgb(255, 5, 7, 10),
    [System.Drawing.Color]::FromArgb(255, 10, 18, 24)
)
$gh.FillRectangle($bgH, 0, 0, $bw, $bh)
$bgH.Dispose()

# Grid
$gridPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(12, 34, 211, 238), 1.0)
for ($x = 40; $x -lt $bw; $x += 40) { $gh.DrawLine($gridPen, $x, 0, $x, $bh) }
for ($y = 40; $y -lt $bh; $y += 40) { $gh.DrawLine($gridPen, 0, $y, $bw, $y) }
$gridPen.Dispose()

# Cyan Top Line
$penCyanTop = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238), 3.0)
$gh.DrawLine($penCyanTop, 0, 1, $bw, 1)
$penCyanTop.Dispose()

# Content on right 2/3 (left side is reserved for avatar/bio overlay on Twitch)
$fontHName = [System.Drawing.Font]::new("Segoe UI", 36, [System.Drawing.FontStyle]::Bold)
$brushWhite = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$gh.DrawString("KENNETH HENSELER", $fontHName, $brushWhite, 460, 95)
$fontHName.Dispose()

$fontHHandle = [System.Drawing.Font]::new("Consolas", 18, [System.Drawing.FontStyle]::Bold)
$brushCyan = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238))
$gh.DrawString("[ kenhenchan ]", $fontHHandle, $brushCyan, 460, 155)
$fontHHandle.Dispose()
$brushCyan.Dispose()

$fontHRole = [System.Drawing.Font]::new("Segoe UI Semibold", 18)
$brushGold = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 251, 191, 36))
$gh.DrawString("Senior IT Infrastructure Manager  ·  Platform & Systems", $fontHRole, $brushGold, 460, 195)
$fontHRole.Dispose()
$brushGold.Dispose()

$fontHDesc = [System.Drawing.Font]::new("Segoe UI", 14)
$brushSlate = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 203, 213, 225))
$gh.DrawString("•  World of Warcraft AddOn Development (Lua & FrameXML)", $fontHDesc, $brushSlate, 460, 245)
$gh.DrawString("•  Autonomous AI Pair Programming with Google Antigravity", $fontHDesc, $brushSlate, 460, 275)
$gh.DrawString("•  Host of Runtime Reality & The Chronos Archive Podcasts", $fontHDesc, $brushSlate, 460, 305)
$fontHDesc.Dispose()
$brushSlate.Dispose()

$fontHUrl = [System.Drawing.Font]::new("Consolas", 14, [System.Drawing.FontStyle]::Bold)
$brushHUrl = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238))
$gh.DrawString("musingsofmy.today  ·  github.com/justadakaje", $fontHUrl, $brushHUrl, 460, 365)
$fontHUrl.Dispose()
$brushHUrl.Dispose()
$brushWhite.Dispose()

$headerFile = Join-Path $outDir "profile-header-banner-1200x480.png"
$bmpH.Save($headerFile, [System.Drawing.Imaging.ImageFormat]::Png)
$gh.Dispose()
$bmpH.Dispose()
$fi = Get-Item $headerFile
Write-Host "Generated: $headerFile ($($fi.Length) bytes)"


# ==============================================================================
# 3. PROFILE AVATAR / ICON (800x800)
# ==============================================================================
Write-Host "Rendering 800x800 Profile Avatar..."
$aw = 800
$ah = 800
$bmpA = [System.Drawing.Bitmap]::new($aw, $ah, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$ga = [System.Drawing.Graphics]::FromImage($bmpA)
$ga.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$ga.Clear([System.Drawing.Color]::FromArgb(255, 5, 7, 10))

$acx = 400.0
$acy = 400.0

# Outer Hexagon Shield (Radius 360)
$aHexOuter = Get-HexagonPath $acx $acy 360.0
$aBrushOuter = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(100, 100),
    [System.Drawing.PointF]::new(700, 700),
    [System.Drawing.Color]::FromArgb(255, 14, 165, 233),
    [System.Drawing.Color]::FromArgb(255, 245, 158, 11)
)
$ga.FillPath($aBrushOuter, $aHexOuter)
$aBrushOuter.Dispose()

# Inner Hexagon Shield (Radius 335)
$aHexInner = Get-HexagonPath $acx $acy 335.0
$aBrushInner = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(100, 100),
    [System.Drawing.PointF]::new(700, 700),
    [System.Drawing.Color]::FromArgb(255, 15, 23, 42),
    [System.Drawing.Color]::FromArgb(255, 8, 47, 73)
)
$ga.FillPath($aBrushInner, $aHexInner)
$aBrushInner.Dispose()

# Cyan Glow Rim Pen
$penRim = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238), 6.0)
$ga.DrawPath($penRim, $aHexInner)
$penRim.Dispose()

# Runic Circuit Tracks
$penTr = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 251, 191, 36), 4.0)
$ga.DrawLine($penTr, 400, 90, 400, 240)
$ga.DrawLine($penTr, 400, 560, 400, 710)
$ga.DrawLine($penTr, 140, 250, 280, 320)
$ga.DrawLine($penTr, 660, 250, 520, 320)
$ga.DrawLine($penTr, 140, 550, 280, 480)
$ga.DrawLine($penTr, 660, 550, 520, 480)
$penTr.Dispose()

# Monogram KH
$fontA = [System.Drawing.Font]::new("Arial Black", 120, [System.Drawing.FontStyle]::Bold)
$sfA = [System.Drawing.StringFormat]::new()
$sfA.Alignment = [System.Drawing.StringAlignment]::Center
$sfA.LineAlignment = [System.Drawing.StringAlignment]::Center

# Glow shadow behind KH
$brushShadow = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(180, 14, 165, 233))
$ga.DrawString("KH", $fontA, $brushShadow, 404, 404, $sfA)
$brushShadow.Dispose()

# Foreground Crisp White / Gold
$brushKH = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$ga.DrawString("KH", $fontA, $brushKH, 400, 400, $sfA)
$brushKH.Dispose()
$fontA.Dispose()
$sfA.Dispose()

# Small cyan micro-core in center
$dot = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238))
$ga.FillEllipse($dot, 388, 388, 24, 24)
$dot.Dispose()

$avatarFile = Join-Path $outDir "profile-avatar-800x800.png"
$bmpA.Save($avatarFile, [System.Drawing.Imaging.ImageFormat]::Png)
$ga.Dispose()
$bmpA.Dispose()
$fi = Get-Item $avatarFile
Write-Host "Generated: $avatarFile ($($fi.Length) bytes)"

Write-Host "`nAll Twitch brand banners and avatars successfully generated!"
