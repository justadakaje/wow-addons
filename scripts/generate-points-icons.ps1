Add-Type -AssemblyName System.Drawing

$outDir = "d:\Code\GitHub\wow-addons\docs\media\twitch-channel-points"
if (!(Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }

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

function Render-PointsIcon {
    param([int]$Size)
    $bmp = [System.Drawing.Bitmap]::new($Size, $Size, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)

    $scale = $Size / 112.0
    $g.ScaleTransform($scale, $scale)

    $cx = 56.0
    $cy = 56.0

    # Outer Hexagon Path (Radius 50)
    $outerPath = Get-HexagonPath $cx $cy 50.0

    # Outer Rim - Deep Cyber Cyan gradient
    $brushOuter = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.PointF]::new(6, 6),
        [System.Drawing.PointF]::new(106, 106),
        [System.Drawing.Color]::FromArgb(255, 14, 165, 233),  # Sky cyan
        [System.Drawing.Color]::FromArgb(255, 3, 105, 161)    # Deep blue
    )
    $g.FillPath($brushOuter, $outerPath)
    $brushOuter.Dispose()

    # Outer Glow Border
    $penCyan = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 56, 189, 248), 4.0)
    $g.DrawPath($penCyan, $outerPath)
    $penCyan.Dispose()

    # Inner Hexagon Path (Radius 40) - Dark Obsidian Glass
    $innerPath = Get-HexagonPath $cx $cy 40.0
    $brushInner = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.PointF]::new(16, 16),
        [System.Drawing.PointF]::new(96, 96),
        [System.Drawing.Color]::FromArgb(255, 15, 23, 42),   # Slate 900
        [System.Drawing.Color]::FromArgb(255, 8, 47, 73)     # Cyan 950
    )
    $g.FillPath($brushInner, $innerPath)
    $brushInner.Dispose()

    # Gold Circuit Inset Border
    $penGold = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 245, 158, 11), 3.0)
    $g.DrawPath($penGold, $innerPath)
    $penGold.Dispose()

    # Glowing Circuit Cross Tracks (Gold & Cyan)
    $penGoldTrack = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 251, 191, 36), 2.5)
    $g.DrawLine($penGoldTrack, 56, 20, 56, 92)
    $g.DrawLine($penGoldTrack, 25, 38, 87, 74)
    $g.DrawLine($penGoldTrack, 25, 74, 87, 38)
    $penGoldTrack.Dispose()

    # Center Energy Core Hexagon (Radius 18)
    $corePath = Get-HexagonPath $cx $cy 18.0
    $brushCore = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238))
    $g.FillPath($brushCore, $corePath)
    $brushCore.Dispose()

    # Center Diamond Sparkle (Pure White Glow)
    $sparkPts = [System.Drawing.PointF[]]@(
        [System.Drawing.PointF]::new(56, 44),
        [System.Drawing.PointF]::new(64, 56),
        [System.Drawing.PointF]::new(56, 68),
        [System.Drawing.PointF]::new(48, 56)
    )
    $sparkPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $sparkPath.AddPolygon($sparkPts)
    $brushSpark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $g.FillPath($brushSpark, $sparkPath)
    $brushSpark.Dispose()
    $sparkPath.Dispose()

    # Bright center white microdot
    $brushDot = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
    $g.FillEllipse($brushDot, 53, 53, 6, 6)
    $brushDot.Dispose()

    $innerPath.Dispose()
    $outerPath.Dispose()
    $corePath.Dispose()
    $g.Dispose()

    $filePath = Join-Path $outDir "points-icon-$Size.png"
    $bmp.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    $fi = Get-Item $filePath
    Write-Host "Generated: $filePath ($($fi.Length) bytes)"
}

Write-Host "Rendering Channel Points Icons..."
Render-PointsIcon -Size 112
Render-PointsIcon -Size 56
Render-PointsIcon -Size 28
Write-Host "Complete!"
