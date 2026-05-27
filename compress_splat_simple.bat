@echo off
cd /d "D:\01_artisemble\configurator"
setlocal

echo ============================================
echo  Splat compression (v78.130 aggressive)
echo  1.08M points -^> 216K (-d 0.2) ~3MB target
echo ============================================
echo.

REM === Step 1: backup original (once) ===
if not exist "Immaculate Commercial Kitchen Space.spz.original" (
    echo [1/4] Backing up original...
    copy /Y "Immaculate Commercial Kitchen Space.spz" "Immaculate Commercial Kitchen Space.spz.original"
)

REM === Step 2: ensure node ===
where node >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js not found in PATH.
    echo Install Node.js LTS from https://nodejs.org first, then re-run.
    pause
    exit /b 1
)
echo [2/4] Node.js OK.

REM === Step 3: ensure splat-transform installed (global) ===
where splat-transform >nul 2>&1
if errorlevel 1 (
    echo [3/4] Installing splat-transform globally...
    call npm install -g @playcanvas/splat-transform
    if errorlevel 1 (
        echo [ERROR] Install failed.
        pause
        exit /b 1
    )
) else (
    echo [3/4] splat-transform OK.
)

REM === Step 4: compress with long-form options (short -d/-sh not supported in current CLI) ===
echo [4/4] Listing available options first...
call splat-transform --help
echo.
echo [4/4] Trying compression: --filter-harmonics 0 --decimate 0.2 --spz-version 3 ...
call splat-transform "Immaculate Commercial Kitchen Space.spz.original" "Immaculate Commercial Kitchen Space.compressed.spz" --filter-harmonics 0 --decimate 0.2 --spz-version 3
if errorlevel 1 (
    echo [WARN] try 2: --prune 0.8 --filter-harmonics 0 --spz-version 3
    call splat-transform "Immaculate Commercial Kitchen Space.spz.original" "Immaculate Commercial Kitchen Space.compressed.spz" --prune 0.8 --filter-harmonics 0 --spz-version 3
    if errorlevel 1 (
        echo [WARN] try 3: --filter-harmonics 0 --spz-version 3 only
        call splat-transform "Immaculate Commercial Kitchen Space.spz.original" "Immaculate Commercial Kitchen Space.compressed.spz" --filter-harmonics 0 --spz-version 3
        if errorlevel 1 (
            echo [WARN] try 4: --spz-version 3 minimal
            call splat-transform "Immaculate Commercial Kitchen Space.spz.original" "Immaculate Commercial Kitchen Space.compressed.spz" --spz-version 3
        )
    )
)

REM === Replace original ===
if exist "Immaculate Commercial Kitchen Space.compressed.spz" (
    move /Y "Immaculate Commercial Kitchen Space.compressed.spz" "Immaculate Commercial Kitchen Space.spz"
    echo.
    echo ============================================
    echo  DONE. File sizes:
    powershell -NoProfile -Command "$o=(Get-Item 'D:\01_artisemble\configurator\Immaculate Commercial Kitchen Space.spz.original').Length; $n=(Get-Item 'D:\01_artisemble\configurator\Immaculate Commercial Kitchen Space.spz').Length; Write-Host ('  Original: ' + [math]::Round($o/1MB,2) + ' MB'); Write-Host ('  Compressed: ' + [math]::Round($n/1MB,2) + ' MB'); Write-Host ('  Saved: ' + [math]::Round((1-$n/$o)*100,1) + '%%')"
    echo ============================================
    echo  Next: GitHub Desktop commit + push the .spz file
) else (
    echo [ERROR] compressed.spz not created.
)
echo.
pause
endlocal
