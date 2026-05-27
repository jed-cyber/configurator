@echo off
chcp 65001 >nul
cd /d "D:\01_artisemble\configurator"

set LOG=D:\01_artisemble\configurator\compress_splat_auto.log
set NODE_VER=v20.18.0
set NODE_DIR=D:\01_artisemble\configurator\.portable_node
set NODE_ZIP=%TEMP%\node_portable.zip

echo Auto splat compression at %date% %time% > "%LOG%"
echo. >> "%LOG%"

echo ============================================
echo  자동 Splat 압축 (Node.js portable 자동 다운로드)
echo  60MB -^> ~10MB 목표
echo ============================================
echo.

REM 원본 백업
if not exist "Immaculate Commercial Kitchen Space.spz.original" (
    echo [1/5] 원본 백업... >> "%LOG%"
    echo [1/5] 원본 백업 중...
    copy /Y "Immaculate Commercial Kitchen Space.spz" "Immaculate Commercial Kitchen Space.spz.original" >> "%LOG%" 2>&1
)

REM Portable Node 다운로드 (없으면)
if not exist "%NODE_DIR%\node.exe" (
    echo [2/5] Portable Node.js %NODE_VER% 다운로드 중 (^~30MB)... >> "%LOG%"
    echo [2/5] Portable Node.js 다운로드 중 (한 번만, ~30MB)...
    powershell -NoProfile -Command "& { ^
        $url = 'https://nodejs.org/dist/%NODE_VER%/node-%NODE_VER%-win-x64.zip'; ^
        $out = '%NODE_ZIP%'; ^
        Write-Host ('Download URL: ' + $url); ^
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing; ^
        Write-Host 'Downloaded.'; ^
        Expand-Archive -Path $out -DestinationPath 'D:\01_artisemble\configurator\.portable_node_tmp' -Force; ^
        $extracted = Get-ChildItem 'D:\01_artisemble\configurator\.portable_node_tmp' -Directory | Select-Object -First 1; ^
        Move-Item $extracted.FullName '%NODE_DIR%' -Force; ^
        Remove-Item 'D:\01_artisemble\configurator\.portable_node_tmp' -Recurse -Force -ErrorAction SilentlyContinue; ^
        Remove-Item $out -Force -ErrorAction SilentlyContinue; ^
        Write-Host 'Extracted to %NODE_DIR%'; ^
    }" >> "%LOG%" 2>&1
    if errorlevel 1 (
        echo [ERROR] Node 다운로드 실패. compress_splat_auto.log 확인. >> "%LOG%"
        echo [ERROR] Node.js 다운로드 실패. log 확인.
        pause
        exit /b 1
    )
)

set PATH=%NODE_DIR%;%PATH%

echo [3/5] splat-transform 설치 중... >> "%LOG%"
echo [3/5] splat-transform 설치 중 (1분 정도)...
call "%NODE_DIR%\npm.cmd" install -g @playcanvas/splat-transform --prefix "%NODE_DIR%" >> "%LOG%" 2>&1
if errorlevel 1 (
    echo [ERROR] splat-transform 설치 실패. >> "%LOG%"
    echo [ERROR] 설치 실패. log 확인.
    pause
    exit /b 1
)

echo [4/5] Splat 압축 중... >> "%LOG%"
echo [4/5] Splat 압축 중 (수십 초)...
REM v78.130 — 매우 공격적 압축 (사용자: 6MB 보다 더 줄여).
REM -sh 0 (색만), -i 20 (iterations), -d 0.2 (decimation 20% 유지 = 1.08M → ~216K, ~3MB 목표), -spz-version 3 (Spark 호환)
call "%NODE_DIR%\splat-transform.cmd" "Immaculate Commercial Kitchen Space.spz.original" "Immaculate Commercial Kitchen Space.compressed.spz" -sh 0 -i 20 -d 0.2 --spz-version 3 >> "%LOG%" 2>&1
if errorlevel 1 (
    echo [WARN] -d 0.2 옵션 실패. -d 0.3 재시도... >> "%LOG%"
    call "%NODE_DIR%\splat-transform.cmd" "Immaculate Commercial Kitchen Space.spz.original" "Immaculate Commercial Kitchen Space.compressed.spz" -sh 0 -i 20 -d 0.3 --spz-version 3 >> "%LOG%" 2>&1
    if errorlevel 1 (
        echo [WARN] -d 옵션 실패. -sh -i 만 시도... >> "%LOG%"
        call "%NODE_DIR%\splat-transform.cmd" "Immaculate Commercial Kitchen Space.spz.original" "Immaculate Commercial Kitchen Space.compressed.spz" -sh 0 -i 20 --spz-version 3 >> "%LOG%" 2>&1
        if errorlevel 1 (
            echo [ERROR] splat-transform 실행 실패. >> "%LOG%"
            echo [ERROR] 압축 실패. log 확인.
            pause
            exit /b 1
        )
    )
)

echo [5/5] 원본 교체 + 사이즈 비교... >> "%LOG%"
if exist "Immaculate Commercial Kitchen Space.compressed.spz" (
    move /Y "Immaculate Commercial Kitchen Space.compressed.spz" "Immaculate Commercial Kitchen Space.spz" >> "%LOG%" 2>&1
    echo. >> "%LOG%"
    echo [결과] 파일 크기: >> "%LOG%"
    dir "Immaculate Commercial Kitchen Space.spz*" >> "%LOG%" 2>&1
    powershell -NoProfile -Command "& { ^
        $orig = (Get-Item 'D:\01_artisemble\configurator\Immaculate Commercial Kitchen Space.spz.original').Length; ^
        $new = (Get-Item 'D:\01_artisemble\configurator\Immaculate Commercial Kitchen Space.spz').Length; ^
        Write-Host ('원본: ' + [math]::Round($orig/1MB, 2) + ' MB'); ^
        Write-Host ('압축: ' + [math]::Round($new/1MB, 2) + ' MB'); ^
        Write-Host ('절감: ' + [math]::Round((1 - $new/$orig) * 100, 1) + '%%'); ^
    }" >> "%LOG%" 2>&1

    echo.
    echo ============================================
    echo  완료! 결과:
    type "%LOG%" | findstr /R "원본 압축 절감"
    echo.
    echo  다음: GitHub Desktop -^> commit -^> push
    echo ============================================
) else (
    echo [ERROR] compressed.spz 파일 안 만들어짐 >> "%LOG%"
    echo [ERROR] 압축 실패. log 확인.
)
pause
