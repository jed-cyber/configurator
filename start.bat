@echo off
cd /d "%~dp0"
echo.
echo === HK NEO+ Configurator Local Server ===
echo.

REM LAN IP detect via PowerShell (Korean/English Windows compatible)
for /f "usebackq delims=" %%i in (`powershell -NoProfile -Command "(Get-NetIPAddress -AddressFamily IPv4 -PrefixOrigin Dhcp -ErrorAction SilentlyContinue | Select-Object -First 1).IPAddress"`) do set LAN_IP=%%i

if "%LAN_IP%"=="" (
    for /f "usebackq delims=" %%i in (`powershell -NoProfile -Command "(Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.IPAddress -match '^(192\.|10\.|172\.)' -and $_.IPAddress -notlike '169.*'} | Select-Object -First 1).IPAddress"`) do set LAN_IP=%%i
)

echo PC ACCESS    : http://localhost:8000/mobile_configurator_final.html
if "%LAN_IP%"=="" (
    echo MOBILE ACCESS: LAN IP not detected. Check ipconfig manually.
) else (
    echo MOBILE ACCESS: http://%LAN_IP%:8000/mobile_configurator_final.html
)
echo.
echo Phone must be on the same Wi-Fi network as this PC.
echo Close this window to stop the server.
echo.

REM Open PC browser — ✨ v78.042 사용자 요청: PC 도 mobile 버전으로 띄움 (mobile camera adjust 적용 환경)
start "" /B cmd /c "timeout /t 2 /nobreak >nul && start http://localhost:8000/mobile_configurator_final.html"

REM Try Python 3
python -m http.server 8000 --bind 0.0.0.0 2>nul
if errorlevel 1 (
    py -3 -m http.server 8000 --bind 0.0.0.0 2>nul
    if errorlevel 1 (
        echo.
        echo [ERROR] Python not found. Install Python 3 from https://python.org
        echo         Or try Node: npx http-server -p 8000
        echo.
        pause
    )
)

pause
