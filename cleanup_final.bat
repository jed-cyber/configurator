@echo off
cd /d "%~dp0"
echo.
echo === Cleanup Final - HK NEO+ Configurator ===
echo Working dir: %CD%
echo.

REM Step 1: rename HK -> _final
if exist "HK_3dconfigurator.html" (
    ren "HK_3dconfigurator.html" "HK_3dconfigurator_final.html"
    echo [OK]  HK_3dconfigurator.html -^> HK_3dconfigurator_final.html
) else (
    echo [SKIP] HK_3dconfigurator.html not found
)

REM Step 2: delete original splat (final already exists)
if exist "splat_configurator.html" (
    del /F /Q "splat_configurator.html"
    echo [OK]  splat_configurator.html deleted
)

REM Step 3: delete backup files (ASCII + Korean filename via wildcard)
if exist "lookdev_backup.html"          del /F /Q "lookdev_backup.html"          && echo [DEL] lookdev_backup.html
if exist "splat-demo_backup.html"       del /F /Q "splat-demo_backup.html"       && echo [DEL] splat-demo_backup.html
if exist "redesign_plan_backup.md"      del /F /Q "redesign_plan_backup.md"      && echo [DEL] redesign_plan_backup.md
if exist "HANDOFF_v77.581_backup.md"    del /F /Q "HANDOFF_v77.581_backup.md"    && echo [DEL] HANDOFF_v77.581_backup.md

REM Korean filename via wildcard pattern
for %%F in (*_v76.md) do (
    del /F /Q "%%F" && echo [DEL] %%F
)

REM Step 4: delete folders
if exist "captures"    rmdir /S /Q "captures"    && echo [DEL] captures\
if exist "screenshots" rmdir /S /Q "screenshots" && echo [DEL] screenshots\
if exist "_archive"    rmdir /S /Q "_archive"    && echo [DEL] _archive\

REM Step 5: delete other cleanup scripts
if exist "cleanup.bat"               del /F /Q "cleanup.bat"               && echo [DEL] cleanup.bat
if exist "cleanup2.bat"              del /F /Q "cleanup2.bat"              && echo [DEL] cleanup2.bat
if exist "backup_create_backup.bat"  del /F /Q "backup_create_backup.bat"  && echo [DEL] backup_create_backup.bat
if exist "rename_to_backup.bat"      del /F /Q "rename_to_backup.bat"      && echo [DEL] rename_to_backup.bat
if exist "start.bat"                 del /F /Q "start.bat"                 && echo [DEL] start.bat
if exist "cleanup_final.ps1"         del /F /Q "cleanup_final.ps1"         && echo [DEL] cleanup_final.ps1

REM Korean named bat via wildcard
for %%F in (*.bat) do (
    if not "%%F"=="cleanup_final.bat" (
        del /F /Q "%%F" 2>nul && echo [DEL] %%F
    )
)

echo.
echo === Cleanup Done ===
echo Entry point: splat_configurator_final.html
echo.
pause

REM self-delete
(goto) 2>nul & del "%~f0"
