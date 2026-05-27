@echo off
chcp 65001 >nul
cd /d "D:\01_artisemble\configurator"

set LOG=D:\01_artisemble\configurator\compress_splat.log
echo Splat compression at %date% %time% > "%LOG%"
echo. >> "%LOG%"

echo ============================================
echo  Splat 압축 도구 (60MB -^> ~10-15MB 목표)
echo  옵션: SH band 0, iterations 20
echo ============================================
echo.

REM 원본 백업
if not exist "Immaculate Commercial Kitchen Space.spz.original" (
    echo [1/3] 원본 백업... >> "%LOG%"
    echo [1/3] 원본 백업 중...
    copy /Y "Immaculate Commercial Kitchen Space.spz" "Immaculate Commercial Kitchen Space.spz.original" >> "%LOG%" 2>&1
)

echo [2/3] splat-transform 설치 중 (한 번만, 1-2분)... >> "%LOG%"
echo [2/3] splat-transform 설치 중 (한 번만)...
call npm install -g @playcanvas/splat-transform >> "%LOG%" 2>&1
echo NPM exit code: %errorlevel% >> "%LOG%"
if errorlevel 1 (
    echo [ERROR] npm 실행 실패. Node.js PATH 인식 안 됐을 수도. 새 cmd 창에서 재시도. >> "%LOG%"
    echo [ERROR] npm 실패. compress_splat.log 확인. PC 재시작 후 재시도 권장.
    pause
    exit /b 1
)

echo [3/3] Splat 압축 중... >> "%LOG%"
echo [3/3] Splat 압축 중 (수십 초)...
REM -sh 0 = SH band 0 (색만, 가장 작음)
REM -i 20 = 압축 iterations 20 (default 10, 더 강한 압축)
call splat-transform "Immaculate Commercial Kitchen Space.spz.original" "Immaculate Commercial Kitchen Space.compressed.spz" -sh 0 -i 20 >> "%LOG%" 2>&1
echo splat-transform exit code: %errorlevel% >> "%LOG%"
if errorlevel 1 (
    echo [WARN] -sh -i 옵션 실패. default 옵션으로 재시도... >> "%LOG%"
    call splat-transform "Immaculate Commercial Kitchen Space.spz.original" "Immaculate Commercial Kitchen Space.compressed.spz" >> "%LOG%" 2>&1
    if errorlevel 1 (
        echo [ERROR] splat-transform 실행 실패. >> "%LOG%"
        echo [ERROR] 압축 실패. log 확인.
        pause
        exit /b 1
    )
)

if exist "Immaculate Commercial Kitchen Space.compressed.spz" (
    echo [완료] 원본 -^> compressed 교체... >> "%LOG%"
    move /Y "Immaculate Commercial Kitchen Space.compressed.spz" "Immaculate Commercial Kitchen Space.spz" >> "%LOG%" 2>&1
    powershell -NoProfile -Command "& { ^
        $orig = (Get-Item 'D:\01_artisemble\configurator\Immaculate Commercial Kitchen Space.spz.original').Length; ^
        $new = (Get-Item 'D:\01_artisemble\configurator\Immaculate Commercial Kitchen Space.spz').Length; ^
        Write-Host ('원본: ' + [math]::Round($orig/1MB, 2) + ' MB'); ^
        Write-Host ('압축: ' + [math]::Round($new/1MB, 2) + ' MB'); ^
        Write-Host ('절감: ' + [math]::Round((1 - $new/$orig) * 100, 1) + '%%'); ^
    }" >> "%LOG%" 2>&1
    echo.
    echo ============================================
    echo  완료! 사이즈 비교:
    type "%LOG%" | findstr /R "원본 압축 절감"
    echo.
    echo  다음: Claude 에게 알려주면 자동 commit + push
    echo ============================================
)
pause
