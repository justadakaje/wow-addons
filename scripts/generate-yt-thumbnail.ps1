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

Write-Host "Rendering 1280x720 YouTube Standard Thumbnail..."
$w = 1280
$h = 720
$bmp = [System.Drawing.Bitmap]::new($w, $h, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
$g = [System.Drawing.Graphics]::FromImage($bmp)
$g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$g.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::ClearTypeGridFit
$g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic

# Background Deep Cyber Gradient
$bgBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(0, 0),
    [System.Drawing.PointF]::new(1280, 720),
    [System.Drawing.Color]::FromArgb(255, 3, 7, 18),    # Deep obsidian
    [System.Drawing.Color]::FromArgb(255, 10, 25, 47)   # Deep cyan navy
)
$g.FillRectangle($bgBrush, 0, 0, $w, $h)
$bgBrush.Dispose()

# Grid Accent
$gridPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(18, 34, 211, 238), 1.0)
for ($x = 40; $x -lt $w; $x += 40) { $g.DrawLine($gridPen, $x, 0, $x, $h) }
for ($y = 40; $y -lt $h; $y += 40) { $g.DrawLine($gridPen, 0, $y, $w, $y) }
$gridPen.Dispose()

# Gold Ambient Glow on Bottom Right
$goldGlow = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(700, 200),
    [System.Drawing.PointF]::new(1280, 720),
    [System.Drawing.Color]::FromArgb(40, 245, 158, 11),
    [System.Drawing.Color]::FromArgb(0, 3, 7, 18)
)
$g.FillRectangle($goldGlow, 700, 200, 580, 520)
$goldGlow.Dispose()

# LIVE Pill Badge (Top Left)
$pillPath = Get-RoundRectPath 70 50 200 48 24
$pillBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 220, 38, 38)) # Red 600
$g.FillPath($pillBrush, $pillPath)
$pillBrush.Dispose()
$pillPath.Dispose()

$dotBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$g.FillEllipse($dotBrush, 92, 66, 16, 16)
$dotBrush.Dispose()

$fontLive = [System.Drawing.Font]::new("Segoe UI Black", 18, [System.Drawing.FontStyle]::Bold)
$brushLive = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$g.DrawString("LIVE DEV", $fontLive, $brushLive, 120, 58)
$fontLive.Dispose()
$brushLive.Dispose()

# Category Tag Pill (Next to Live)
$catPath = Get-RoundRectPath 290 50 330 48 12
$catBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(200, 15, 23, 42))
$g.FillPath($catBrush, $catPath)
$catBrush.Dispose()
$catBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238), 2.0)
$g.DrawPath($catBorder, $catPath)
$catBorder.Dispose()
$catPath.Dispose()

$fontCat = [System.Drawing.Font]::new("Consolas", 15, [System.Drawing.FontStyle]::Bold)
$brushCat = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238))
$g.DrawString("WoW: Forever · v0.6.0", $fontCat, $brushCat, 310, 62)
$fontCat.Dispose()
$brushCat.Dispose()

# Primary Hero Text: GOLDFINDER
$fontHero = [System.Drawing.Font]::new("Arial Black", 68, [System.Drawing.FontStyle]::Bold)
# Drop Shadow
$brushHeroShadow = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(200, 0, 0, 0))
$g.DrawString("GOLDFINDER", $fontHero, $brushHeroShadow, 74, 134)
$brushHeroShadow.Dispose()
# Gold Gradient Hero Text
$heroGrad = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(70, 130),
    [System.Drawing.PointF]::new(70, 230),
    [System.Drawing.Color]::FromArgb(255, 254, 240, 138), # Radiant pale gold
    [System.Drawing.Color]::FromArgb(255, 217, 119, 6)    # Deep amber gold
)
$g.DrawString("GOLDFINDER", $fontHero, $heroGrad, 70, 130)
$heroGrad.Dispose()
$fontHero.Dispose()

# Secondary Punchline: BUILDING A WOW ADDON WITH AI
$fontSub1 = [System.Drawing.Font]::new("Segoe UI Black", 32, [System.Drawing.FontStyle]::Bold)
$brushSub1 = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238))
$g.DrawString("BUILDING A WOW ADDON WITH AI", $fontSub1, $brushSub1, 74, 250)
$fontSub1.Dispose()
$brushSub1.Dispose()

# Feature Bullets Block (Glass Box)
$boxPath = Get-RoundRectPath 70 330 680 270 16
$boxBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(210, 15, 23, 42))
$g.FillPath($boxBrush, $boxPath)
$boxBrush.Dispose()
$boxBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 51, 65, 85), 2.0)
$g.DrawPath($boxBorder, $boxPath)
$boxBorder.Dispose()
$boxPath.Dispose()

$fontBullet = [System.Drawing.Font]::new("Segoe UI Semibold", 21)
$brushBullet = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 241, 245, 249))
$brushBulletGold = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 251, 191, 36))

$g.DrawString("⚡  Live Graphical Settings UI Testing", $fontBullet, $brushBullet, 100, 360)
$g.DrawString("📈  14-Day Price Sparklines & Trend Curves", $fontBullet, $brushBullet, 100, 420)
$g.DrawString("🤖  Google Antigravity AI Pair Programming", $fontBullet, $brushBullet, 100, 480)
$g.DrawString("💰  Real-Time AH Arbitrage & Net Profits", $fontBullet, $brushBulletGold, 100, 540)
$fontBullet.Dispose()
$brushBullet.Dispose()
$brushBulletGold.Dispose()

# Right Side Visual Anchor: Large Glowing KH Cyber-Shield
$cx = 1010.0
$cy = 380.0
$hexOuter = Get-HexagonPath $cx $cy 230.0
$brushHexOuter = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(800, 170),
    [System.Drawing.PointF]::new(1220, 590),
    [System.Drawing.Color]::FromArgb(255, 14, 165, 233),
    [System.Drawing.Color]::FromArgb(255, 245, 158, 11)
)
$g.FillPath($brushHexOuter, $hexOuter)
$brushHexOuter.Dispose()

$hexInner = Get-HexagonPath $cx $cy 210.0
$brushHexInner = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
    [System.Drawing.PointF]::new(800, 170),
    [System.Drawing.PointF]::new(1220, 590),
    [System.Drawing.Color]::FromArgb(255, 15, 23, 42),
    [System.Drawing.Color]::FromArgb(255, 8, 47, 73)
)
$g.FillPath($brushHexInner, $hexInner)
$brushHexInner.Dispose()

$penRim = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238), 5.0)
$g.DrawPath($penRim, $hexInner)
$penRim.Dispose()

# Monogram inside Shield
$fontShield = [System.Drawing.Font]::new("Arial Black", 80, [System.Drawing.FontStyle]::Bold)
$sfShield = [System.Drawing.StringFormat]::new()
$sfShield.Alignment = [System.Drawing.StringAlignment]::Center
$sfShield.LineAlignment = [System.Drawing.StringAlignment]::Center

# Glow
$brushShieldShadow = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(180, 14, 165, 233))
$g.DrawString("KH", $fontShield, $brushShieldShadow, ($cx + 4), ($cy + 4), $sfShield)
$brushShieldShadow.Dispose()

$brushShield = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
$g.DrawString("KH", $fontShield, $brushShield, $cx, $cy, $sfShield)
$brushShield.Dispose()
$fontShield.Dispose()
$sfShield.Dispose()

$hexInner.Dispose()
$hexOuter.Dispose()

# Bottom Footer Bar
$fontFoot = [System.Drawing.Font]::new("Consolas", 16, [System.Drawing.FontStyle]::Bold)
$brushFoot = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 148, 163, 184))
$g.DrawString("twitch.tv/kenhenchan  ·  youtube.com/@KenHenChan  ·  Indianapolis, IN", $fontFoot, $brushFoot, 74, 640)
$fontFoot.Dispose()
$brushFoot.Dispose()

$thumbFile = Join-Path $outDir "youtube-thumbnail-1280x720.png"
$bmp.Save($thumbFile, [System.Drawing.Imaging.ImageFormat]::Png)
$g.Dispose()
$bmp.Dispose()

$fi = Get-Item $thumbFile
Write-Host "Generated YouTube Thumbnail: $thumbFile ($($fi.Length) bytes)"
