@echo off
cd /d "D:\01_artisemble\configurator"
setlocal

echo ============================================
echo  Splat compression v78.133
echo  1.08M points -^> 216K (20%%) ~3MB target
echo ============================================
echo.

REM === Step 1: backup original (once) — keep extension as .spz.bak ===
if not exist "Immaculate Commercial Kitchen Space.spz.bak" (
    echo [1/5] Backing up original to .spz.bak ...
    if exist "Immaculate Commercial Kitchen Space.spz.original" (
        copy /Y "Immaculate Commercial Kitchen Space.spz.original" "Immaculate Commercial Kitchen Space.spz.bak"
    ) else (
        copy /Y "Immaculate Commercial Kitchen Space.spz" "Immaculate Commercial Kitchen Space.spz.bak"
    )
) else (
    echo [1/5] Backup already exists.
)

REM === Step 2: ensure node + tool ===
where node >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Node.js not found.
    pause & exit /b 1
)
echo [2/5] Node.js OK.

where splat-transform >nul 2>&1
if errorlevel 1 (
    echo [3/5] Installing splat-transform...
    call npm install -g @playcanvas/splat-transform
) else (
    echo [3/5] splat-transform OK.
)

REM === Step 3: prepare working input as proper .spz extension ===
echo [4/5] Preparing working input...
copy /Y "Immaculate Commercial Kitchen Space.spz.bak" "_work_input.spz" >nul

REM === Step 4: compress with correct options (-F 20%% -H 0 --spz-version 3) ===
echo [5/5] Compressing: -F 20%% (decimate to 20%%) -H 0 (no SH) --spz-version 3
call splat-transform "_work_input.spz" "_work_output.spz" -F 20%% -H 0 --spz-version 3
if errorlevel 1 (
    echo [WARN] -F 20%% failed, trying -F 30%%...
    call splat-transform "_work_input.spz" "_work_output.spz" -F 30%% -H 0 --spz-version 3
    if errorlevel 1 (
        echo [WARN] -F failed, trying -H 0 only...
        call splat-transform "_work_input.spz" "_work_output.spz" -H 0 --spz-version 3
    )
)

REM === Replace original ===
if exist "_work_output.spz" (
    move /Y "_work_output.spz" "Immaculate Commercial Kitchen Space.spz"
    del /Q "_work_input.spz"
    echo.
    echo ============================================
    echo  DONE. File sizes:
    powershell -NoProfile -Command "$o=(Get-Item 'D:\01_artisemble\configurator\Immaculate Commercial Kitchen Space.spz.bak').Length; $n=(Get-Item 'D:\01_artisemble\configurator\Immaculate Commercial Kitchen Space.spz').Length; Write-Host ('  Original: ' + [math]::Round($o/1MB,2) + ' MB'); Write-Host ('  Compressed: ' + [math]::Round($n/1MB,2) + ' MB'); Write-Host ('  Saved: ' + [math]::Round((1-$n/$o)*100,1) + '%%')"
    echo ============================================
    echo  Next: GitHub Desktop commit + push the .spz file
) else (
    echo [ERROR] _work_output.spz not created.
    if exist "_work_input.spz" del /Q "_work_input.spz"
)
echo.
pause
endlocal
