@echo off
chcp 65001 >nul
cd /d "D:\01_artisemble\configurator\tex"

set LOG=D:\01_artisemble\configurator\compress_hdri.log
echo HDRI compression at %date% %time% > "%LOG%"
echo. >> "%LOG%"

echo ============================================
echo  HDRI 압축 도구 (29MB -^> ~5MB)
echo  PNG 해상도 1/2 + 압축 강화
echo ============================================
echo.

REM 원본 백업
if not exist "HDRI.png.original" (
    echo [백업] HDRI.png -^> HDRI.png.original >> "%LOG%"
    echo [백업] HDRI.png -^> HDRI.png.original
    copy /Y "HDRI.png" "HDRI.png.original" >> "%LOG%" 2>&1
    echo. >> "%LOG%"
)

echo [압축] PowerShell + .NET 으로 PNG 리사이즈 + 압축 중...
powershell -NoProfile -Command "& { ^
    Add-Type -AssemblyName System.Drawing; ^
    Add-Type -AssemblyName System.Drawing.Imaging; ^
    $src = 'D:\01_artisemble\configurator\tex\HDRI.png.original'; ^
    $dst = 'D:\01_artisemble\configurator\tex\HDRI.png'; ^
    $img = [System.Drawing.Image]::FromFile($src); ^
    Write-Host ('원본 해상도: ' + $img.Width + ' x ' + $img.Height); ^
    $newW = [int]($img.Width / 2); ^
    $newH = [int]($img.Height / 2); ^
    Write-Host ('새 해상도: ' + $newW + ' x ' + $newH); ^
    $resized = New-Object System.Drawing.Bitmap $newW, $newH; ^
    $g = [System.Drawing.Graphics]::FromImage($resized); ^
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic; ^
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality; ^
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality; ^
    $g.DrawImage($img, 0, 0, $newW, $newH); ^
    $resized.Save($dst, [System.Drawing.Imaging.ImageFormat]::Png); ^
    $g.Dispose(); $img.Dispose(); $resized.Dispose(); ^
    $orig = (Get-Item $src).Length; ^
    $new = (Get-Item $dst).Length; ^
    Write-Host ('원본: ' + [math]::Round($orig/1MB, 2) + ' MB'); ^
    Write-Host ('압축: ' + [math]::Round($new/1MB, 2) + ' MB'); ^
    Write-Host ('절감: ' + [math]::Round((1 - $new/$orig) * 100, 1) + '%%'); ^
}" >> "%LOG%" 2>&1

echo PowerShell exit code: %errorlevel% >> "%LOG%"
if errorlevel 1 (
    echo [ERROR] PowerShell 실패. compress_hdri.log 확인. >> "%LOG%"
    echo [ERROR] PowerShell 실패. log 확인.
    pause
    exit /b 1
)

echo. >> "%LOG%"
echo [결과] 파일 크기: >> "%LOG%"
dir "HDRI.png" >> "%LOG%" 2>&1

echo.
echo ============================================
echo  완료! log 확인: compress_hdri.log
echo ============================================
type "%LOG%" | findstr /R "원본 새 압축 절감"
pause
