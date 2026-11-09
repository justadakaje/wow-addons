Add-Type -AssemblyName System.Drawing

$assetsDir = "d:\Code\GitHub\wow-addons\addons\BiSGearFinder\assets"
if (!(Test-Path $assetsDir)) { New-Item -ItemType Directory -Force -Path $assetsDir | Out-Null }

function Draw-BGFLogo {
    param([int]$Size, [string]$OutPath)

    $bmp = [System.Drawing.Bitmap]::new($Size, $Size, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)

    $scale = $Size / 256.0
    $g.ScaleTransform($scale, $scale)

    # 1. Outer Dark Titanium Shield
    $shieldPts = [System.Drawing.PointF[]]@(
        [System.Drawing.PointF]::new(128, 10),
        [System.Drawing.PointF]::new(234, 70),
        [System.Drawing.PointF]::new(234, 184),
        [System.Drawing.PointF]::new(128, 246),
        [System.Drawing.PointF]::new(22, 184),
        [System.Drawing.PointF]::new(22, 70)
    )
    $shieldPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $shieldPath.AddPolygon($shieldPts)

    $bgBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.PointF]::new(22, 10),
        [System.Drawing.PointF]::new(234, 246),
        [System.Drawing.Color]::FromArgb(255, 36, 20, 56),
        [System.Drawing.Color]::FromArgb(255, 10, 8, 16)
    )
    $g.FillPath($bgBrush, $shieldPath)

    # Gold Shield Rim
    $goldPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 230, 185, 55), 6)
    $g.DrawPath($goldPen, $shieldPath)
    $innerGoldPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(160, 170, 130, 40), 2)
    $g.DrawEllipse($innerGoldPen, 38, 38, 180, 180)

    # 2. Scarcity Radar Grid & Crosshairs
    $radarPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(60, 180, 80, 255), 2)
    $radarPen.DashStyle = [System.Drawing.Drawing2D.DashStyle]::Dash
    $g.DrawEllipse($radarPen, 64, 64, 128, 128)
    $g.DrawEllipse($radarPen, 92, 92, 72, 72)

    $crossPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(90, 200, 120, 255), 1.5)
    $g.DrawLine($crossPen, 128, 42, 128, 214)
    $g.DrawLine($crossPen, 42, 128, 214, 128)

    # Radar Sweep Sector
    $sweepBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.PointF]::new(128, 128),
        [System.Drawing.PointF]::new(210, 60),
        [System.Drawing.Color]::FromArgb(70, 190, 90, 255),
        [System.Drawing.Color]::FromArgb(0, 190, 90, 255)
    )
    $g.FillPie($sweepBrush, 38, 38, 180, 180, 290, 55)

    # 3. Epic BiS Gemstone (Classic Purple Quality)
    $gemPts = [System.Drawing.PointF[]]@(
        [System.Drawing.PointF]::new(128, 60),
        [System.Drawing.PointF]::new(168, 92),
        [System.Drawing.PointF]::new(154, 150),
        [System.Drawing.PointF]::new(128, 184),
        [System.Drawing.PointF]::new(102, 150),
        [System.Drawing.PointF]::new(88, 92)
    )
    $gemPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $gemPath.AddPolygon($gemPts)

    $gemBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.PointF]::new(88, 60),
        [System.Drawing.PointF]::new(168, 184),
        [System.Drawing.Color]::FromArgb(255, 195, 85, 255),
        [System.Drawing.Color]::FromArgb(255, 95, 20, 160)
    )
    $g.FillPath($gemBrush, $gemPath)
    $gemBorderPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 255, 220, 100), 3.5)
    $g.DrawPath($gemBorderPen, $gemPath)

    # Gem Facets
    $facetPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(180, 255, 255, 255), 1.5)
    $g.DrawLine($facetPen, 128, 60, 128, 184)
    $g.DrawLine($facetPen, 88, 92, 168, 92)
    $g.DrawLine($facetPen, 102, 150, 154, 150)
    $g.DrawLine($facetPen, 128, 110, 88, 92)
    $g.DrawLine($facetPen, 128, 110, 168, 92)
    $g.DrawLine($facetPen, 128, 110, 102, 150)
    $g.DrawLine($facetPen, 128, 110, 154, 150)

    # 4. Golden Crown (Pre-Raid / Phase 1 BiS Crown)
    $crownPts = [System.Drawing.PointF[]]@(
        [System.Drawing.PointF]::new(96, 76),
        [System.Drawing.PointF]::new(104, 52),
        [System.Drawing.PointF]::new(118, 66),
        [System.Drawing.PointF]::new(128, 42),
        [System.Drawing.PointF]::new(138, 66),
        [System.Drawing.PointF]::new(152, 52),
        [System.Drawing.PointF]::new(160, 76)
    )
    $crownPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $crownPath.AddPolygon($crownPts)

    $crownBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.PointF]::new(96, 42),
        [System.Drawing.PointF]::new(160, 76),
        [System.Drawing.Color]::FromArgb(255, 255, 235, 140),
        [System.Drawing.Color]::FromArgb(255, 210, 150, 20)
    )
    $g.FillPath($crownBrush, $crownPath)
    $crownPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 130, 85, 10), 2)
    $g.DrawPath($crownPen, $crownPath)

    # 5. Bold "BiS" Gold Typography Badge at Bottom
    $bannerPts = [System.Drawing.PointF[]]@(
        [System.Drawing.PointF]::new(64, 194),
        [System.Drawing.PointF]::new(192, 194),
        [System.Drawing.PointF]::new(180, 226),
        [System.Drawing.PointF]::new(128, 236),
        [System.Drawing.PointF]::new(76, 226)
    )
    $bannerPath = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $bannerPath.AddPolygon($bannerPts)

    $bannerBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(245, 18, 12, 28))
    $g.FillPath($bannerBrush, $bannerPath)
    $bannerPen = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 235, 185, 60), 2)
    $g.DrawPath($bannerPen, $bannerPath)

    $fontFamily = [System.Drawing.FontFamily]::GenericSansSerif
    $font = [System.Drawing.Font]::new($fontFamily, 17, [System.Drawing.FontStyle]::Bold)
    $textBrush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
        [System.Drawing.PointF]::new(90, 194),
        [System.Drawing.PointF]::new(160, 226),
        [System.Drawing.Color]::FromArgb(255, 255, 240, 160),
        [System.Drawing.Color]::FromArgb(255, 225, 165, 30)
    )
    $sf = [System.Drawing.StringFormat]::new()
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
    $g.DrawString("BiS", $font, $textBrush, [System.Drawing.RectangleF]::new(64, 194, 128, 34), $sf)

    # Clean up resources
    $bgBrush.Dispose()
    $shieldPath.Dispose()
    $goldPen.Dispose()
    $innerGoldPen.Dispose()
    $radarPen.Dispose()
    $crossPen.Dispose()
    $sweepBrush.Dispose()
    $gemPath.Dispose()
    $gemBrush.Dispose()
    $gemBorderPen.Dispose()
    $facetPen.Dispose()
    $crownPath.Dispose()
    $crownBrush.Dispose()
    $crownPen.Dispose()
    $bannerPath.Dispose()
    $bannerBrush.Dispose()
    $bannerPen.Dispose()
    $font.Dispose()
    $textBrush.Dispose()
    $sf.Dispose()
    $g.Dispose()

    $bmp.Save($OutPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Created: $OutPath ($Size x $Size)"
}

$logo256 = Join-Path $assetsDir "BiSGearFinder-Logo.png"
Draw-BGFLogo -Size 256 -OutPath $logo256

$logo64 = Join-Path $assetsDir "icon.png"
Draw-BGFLogo -Size 64 -OutPath $logo64
