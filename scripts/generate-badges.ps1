Add-Type -AssemblyName System.Drawing

$outDir = "d:\Code\GitHub\wow-addons\docs\media\twitch-badges"
if (!(Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }

function Draw-Badge {
    param(
        [string]$Name,
        [int]$Size,
        [ScriptBlock]$DrawScript
    )
    $bmp = [System.Drawing.Bitmap]::new($Size, $Size, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.Clear([System.Drawing.Color]::Transparent)

    $scale = $Size / 72.0
    $g.ScaleTransform($scale, $scale)

    & $DrawScript $g

    $g.Dispose()
    $filePath = Join-Path $outDir "$Name-$Size.png"
    $bmp.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    return $filePath
}

# Helper to create rounded rectangle path
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

# Helper to create polygon/hexagon path
function Get-OctagonPath {
    param([float]$x, [float]$y, [float]$w, [float]$h, [float]$c)
    $path = [System.Drawing.Drawing2D.GraphicsPath]::new()
    $pts = [System.Drawing.PointF[]]@(
        [System.Drawing.PointF]::new($x + $c, $y),
        [System.Drawing.PointF]::new($x + $w - $c, $y),
        [System.Drawing.PointF]::new($x + $w, $y + $c),
        [System.Drawing.PointF]::new($x + $w, $y + $h - $c),
        [System.Drawing.PointF]::new($x + $w - $c, $y + $h),
        [System.Drawing.PointF]::new($x + $c, $y + $h),
        [System.Drawing.PointF]::new($x, $y + $h - $c),
        [System.Drawing.PointF]::new($x, $y + $c)
    )
    $path.AddPolygon($pts)
    return $path
}

$badges = @(
    @{
        Name = "badge-01-month" # 1 Month: Silicon Slate
        Draw = {
            param($g)
            # Base dark chip
            $path = Get-OctagonPath 4 4 64 64 12
            $brush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
                [System.Drawing.PointF]::new(4, 4),
                [System.Drawing.PointF]::new(68, 68),
                [System.Drawing.Color]::FromArgb(255, 30, 41, 59),
                [System.Drawing.Color]::FromArgb(255, 15, 23, 42)
            )
            $g.FillPath($brush, $path)
            $brush.Dispose()

            # Slate border
            $penBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 71, 85, 105), 2.5)
            $g.DrawPath($penBorder, $path)
            $penBorder.Dispose()

            # Cyan pinout circuit traces
            $penCyan = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238), 2.0)
            # Top-left to center
            $g.DrawLine($penCyan, 18, 18, 28, 28)
            $g.DrawLine($penCyan, 28, 28, 36, 28)
            # Bottom-right to center
            $g.DrawLine($penCyan, 54, 54, 44, 44)
            $g.DrawLine($penCyan, 44, 44, 36, 44)
            # Left & Right ticks
            $g.DrawLine($penCyan, 10, 36, 22, 36)
            $g.DrawLine($penCyan, 62, 36, 50, 36)
            $penCyan.Dispose()

            # Center square core
            $brushCore = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 14, 165, 233))
            $g.FillRectangle($brushCore, 30, 30, 12, 12)
            $brushCore.Dispose()

            $brushDot = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
            $g.FillEllipse($brushDot, 34, 34, 4, 4)
            $brushDot.Dispose()
        }
    },
    @{
        Name = "badge-02-month" # 2 Months: Clocked Core
        Draw = {
            param($g)
            $path = Get-OctagonPath 4 4 64 64 12
            $brush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
                [System.Drawing.PointF]::new(4, 4),
                [System.Drawing.PointF]::new(68, 68),
                [System.Drawing.Color]::FromArgb(255, 8, 47, 73),
                [System.Drawing.Color]::FromArgb(255, 3, 105, 161)
            )
            $g.FillPath($brush, $path)
            $brush.Dispose()

            # Neon Cyan glowing border
            $penBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 56, 189, 248), 3.0)
            $g.DrawPath($penBorder, $path)
            $penBorder.Dispose()

            # Concentric circuit ring
            $penRing = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238), 2.0)
            $g.DrawEllipse($penRing, 20, 20, 32, 32)
            $penRing.Dispose()

            # Neon traces
            $penTrace = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 186, 230, 253), 2.0)
            $g.DrawLine($penTrace, 36, 8, 36, 20)
            $g.DrawLine($penTrace, 36, 52, 36, 64)
            $g.DrawLine($penTrace, 8, 36, 20, 36)
            $g.DrawLine($penTrace, 52, 36, 64, 36)
            $penTrace.Dispose()

            # Central glowing diamond
            $brushCore = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 224, 242, 254))
            $g.FillPolygon($brushCore, @(
                [System.Drawing.PointF]::new(36, 26),
                [System.Drawing.PointF]::new(46, 36),
                [System.Drawing.PointF]::new(36, 46),
                [System.Drawing.PointF]::new(26, 36)
            ))
            $brushCore.Dispose()
        }
    },
    @{
        Name = "badge-03-month" # 3 Months: Overclocked Logic
        Draw = {
            param($g)
            $path = Get-OctagonPath 4 4 64 64 12
            $brush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
                [System.Drawing.PointF]::new(4, 4),
                [System.Drawing.PointF]::new(68, 68),
                [System.Drawing.Color]::FromArgb(255, 30, 27, 75),
                [System.Drawing.Color]::FromArgb(255, 67, 56, 202)
            )
            $g.FillPath($brush, $path)
            $brush.Dispose()

            # High voltage Cobalt Blue border
            $penBorder = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 129, 140, 248), 3.0)
            $g.DrawPath($penBorder, $path)
            $penBorder.Dispose()

            # Energy cross traces
            $penVolt = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 96, 165, 250), 2.5)
            $g.DrawLine($penVolt, 14, 14, 58, 58)
            $g.DrawLine($penVolt, 14, 58, 58, 14)
            $penVolt.Dispose()

            # Inner octagon
            $innerPath = Get-OctagonPath 22 22 28 28 6
            $brushInner = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 79, 70, 229))
            $g.FillPath($brushInner, $innerPath)
            $brushInner.Dispose()

            # Electric spark center
            $brushSpark = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
            $g.FillPolygon($brushSpark, @(
                [System.Drawing.PointF]::new(36, 24),
                [System.Drawing.PointF]::new(40, 34),
                [System.Drawing.PointF]::new(48, 36),
                [System.Drawing.PointF]::new(40, 38),
                [System.Drawing.PointF]::new(36, 48),
                [System.Drawing.PointF]::new(32, 38),
                [System.Drawing.PointF]::new(24, 36),
                [System.Drawing.PointF]::new(32, 34)
            ))
            $brushSpark.Dispose()
        }
    },
    @{
        Name = "badge-06-month" # 6 Months: Gilded Trace (Copper / Gold + Cyan)
        Draw = {
            param($g)
            $path = Get-OctagonPath 4 4 64 64 12
            $brush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
                [System.Drawing.PointF]::new(4, 4),
                [System.Drawing.PointF]::new(68, 68),
                [System.Drawing.Color]::FromArgb(255, 69, 26, 3),
                [System.Drawing.Color]::FromArgb(255, 180, 83, 9)
            )
            $g.FillPath($brush, $path)
            $brush.Dispose()

            # Burnished Gold Border
            $penGold = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 251, 191, 36), 3.0)
            $g.DrawPath($penGold, $path)
            $penGold.Dispose()

            # Integrated Cyan circuit nodes
            $penCyan = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238), 2.0)
            $g.DrawRectangle($penCyan, 16, 16, 40, 40)
            $penCyan.Dispose()

            # Gold cross diagonal connectors
            $penGoldLine = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 252, 211, 77), 2.0)
            $g.DrawLine($penGoldLine, 16, 16, 26, 26)
            $g.DrawLine($penGoldLine, 56, 16, 46, 26)
            $g.DrawLine($penGoldLine, 16, 56, 26, 46)
            $g.DrawLine($penGoldLine, 56, 56, 46, 46)
            $penGoldLine.Dispose()

            # Core Gold Node
            $brushGoldCore = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 245, 158, 11))
            $g.FillEllipse($brushGoldCore, 26, 26, 20, 20)
            $brushGoldCore.Dispose()

            $brushNode = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 254, 243, 199))
            $g.FillEllipse($brushNode, 31, 31, 10, 10)
            $brushNode.Dispose()
        }
    },
    @{
        Name = "badge-09-month" # 9 Months: Master Golem Plate
        Draw = {
            param($g)
            $path = Get-OctagonPath 4 4 64 64 12
            $brush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
                [System.Drawing.PointF]::new(4, 4),
                [System.Drawing.PointF]::new(68, 68),
                [System.Drawing.Color]::FromArgb(255, 217, 119, 6),
                [System.Drawing.Color]::FromArgb(255, 251, 191, 36)
            )
            $g.FillPath($brush, $path)
            $brush.Dispose()

            # Heavy ornate gold bevel border
            $penBevel = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 254, 240, 138), 3.5)
            $g.DrawPath($penBevel, $path)
            $penBevel.Dispose()

            # Inner runic plate
            $inner = Get-OctagonPath 14 14 44 44 8
            $brushInner = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 180, 83, 9))
            $g.FillPath($brushInner, $inner)
            $brushInner.Dispose()

            # Faceted Ruby Gem in center
            $rubyBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 220, 38, 38))
            $g.FillPolygon($rubyBrush, @(
                [System.Drawing.PointF]::new(36, 20),
                [System.Drawing.PointF]::new(48, 36),
                [System.Drawing.PointF]::new(36, 52),
                [System.Drawing.PointF]::new(24, 36)
            ))
            $rubyBrush.Dispose()

            # Ruby highlight facet
            $highlightBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 248, 113, 113))
            $g.FillPolygon($highlightBrush, @(
                [System.Drawing.PointF]::new(36, 20),
                [System.Drawing.PointF]::new(48, 36),
                [System.Drawing.PointF]::new(36, 36)
            ))
            $highlightBrush.Dispose()

            $sparkle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
            $g.FillEllipse($sparkle, 33, 27, 4, 4)
            $sparkle.Dispose()
        }
    },
    @{
        Name = "badge-12-month" # 12 Months: Singularity Prism
        Draw = {
            param($g)
            $path = Get-OctagonPath 4 4 64 64 12
            # Radiant celestial gradient
            $brush = [System.Drawing.Drawing2D.LinearGradientBrush]::new(
                [System.Drawing.PointF]::new(4, 4),
                [System.Drawing.PointF]::new(68, 68),
                [System.Drawing.Color]::FromArgb(255, 88, 28, 135),
                [System.Drawing.Color]::FromArgb(255, 219, 39, 119)
            )
            $g.FillPath($brush, $path)
            $brush.Dispose()

            # Holographic iridescent border (Cyan to Violet)
            $penPrism = [System.Drawing.Pen]::new([System.Drawing.Color]::FromArgb(255, 34, 211, 238), 3.5)
            $g.DrawPath($penPrism, $path)
            $penPrism.Dispose()

            # Prismatic starburst
            $starBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 244, 114, 182))
            $g.FillPolygon($starBrush, @(
                [System.Drawing.PointF]::new(36, 12),
                [System.Drawing.PointF]::new(42, 28),
                [System.Drawing.PointF]::new(60, 36),
                [System.Drawing.PointF]::new(42, 44),
                [System.Drawing.PointF]::new(36, 60),
                [System.Drawing.PointF]::new(30, 44),
                [System.Drawing.PointF]::new(12, 36),
                [System.Drawing.PointF]::new(30, 28)
            ))
            $starBrush.Dispose()

            # Singularity White/Cyan Core
            $coreBrush = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::FromArgb(255, 240, 253, 250))
            $g.FillPolygon($coreBrush, @(
                [System.Drawing.PointF]::new(36, 20),
                [System.Drawing.PointF]::new(46, 36),
                [System.Drawing.PointF]::new(36, 52),
                [System.Drawing.PointF]::new(26, 36)
            ))
            $coreBrush.Dispose()

            $sparkle = [System.Drawing.SolidBrush]::new([System.Drawing.Color]::White)
            $g.FillEllipse($sparkle, 34, 34, 4, 4)
            $sparkle.Dispose()
        }
    }
)

Write-Host "Rendering Twitch Subscriber Loyalty Badges..."
foreach ($b in $badges) {
    # Generate 72x72 (standard single-file upload), 36x36, and 18x18
    $f72 = Draw-Badge -Name $b.Name -Size 72 -DrawScript $b.Draw
    $f36 = Draw-Badge -Name $b.Name -Size 36 -DrawScript $b.Draw
    $f18 = Draw-Badge -Name $b.Name -Size 18 -DrawScript $b.Draw
    Write-Host "Generated: $($b.Name) [72px, 36px, 18px]"
}

Write-Host "`nAll 18 badge assets successfully generated in $outDir"
