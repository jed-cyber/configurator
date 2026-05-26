@echo off
chcp 65001 >nul
cd /d "D:\01_artisemble\configurator"

REM 모든 출력을 log 파일로 저장 (cmd 못 보더라도 결과 확인 가능)
set LOG=D:\01_artisemble\configurator\compress_splat.log
echo Splat compression run at %date% %time% > "%LOG%"
echo. >> "%LOG%"

echo ============================================
echo  Splat 압축 도구
echo  60MB ^-^> 15~20MB 목표
echo ============================================
echo.
echo (모든 로그는 compress_splat.log 에 저장됩니다)
echo.

REM 원본 백업
if not exist "Immaculate Commercial Kitchen Space.spz.original" (
    echo [백업] 원본을 .original 로 보관... >> "%LOG%"
    copy /Y "Immaculate Commercial Kitchen Space.spz" "Immaculate Commercial Kitchen Space.spz.original" >> "%LOG%" 2>&1
    echo [백업] 완료 >> "%LOG%"
)

echo [1/2] splat-transform 설치 중 (한 번만, 1~2분)... >> "%LOG%"
echo [1/2] splat-transform 설치 중 (한 번만, 1~2분)...
call npm install -g @playcanvas/splat-transform >> "%LOG%" 2>&1
echo NPM exit code: %errorlevel% >> "%LOG%"
if errorlevel 1 (
    echo. >> "%LOG%"
    echo [ERROR] npm install 실패. Node.js 가 설치돼있는지 확인 필요. >> "%LOG%"
    echo [ERROR] npm install 실패. compress_splat.log 확인.
    pause
    exit /b 1
)

echo [2/2] Splat 압축 중... >> "%LOG%"
echo [2/2] Splat 압축 중 (수십 초)...
call splat-transform "Immaculate Commercial Kitchen Space.spz" "Immaculate Commercial Kitchen Space.compressed.spz" >> "%LOG%" 2>&1
echo splat-transform exit code: %errorlevel% >> "%LOG%"
if errorlevel 1 (
    echo. >> "%LOG%"
    echo [ERROR] splat-transform 실패. compress_splat.log 확인. >> "%LOG%"
    echo [ERROR] splat-transform 실패.
    pause
    exit /b 1
)

REM 압축 결과 교체
if exist "Immaculate Commercial Kitchen Space.compressed.spz" (
    echo [교체] 원본 -^> compressed >> "%LOG%"
    move /Y "Immaculate Commercial Kitchen Space.compressed.spz" "Immaculate Commercial Kitchen Space.spz" >> "%LOG%" 2>&1
    echo. >> "%LOG%"
    echo [결과] 최종 파일 크기: >> "%LOG%"
    dir "Immaculate Commercial Kitchen Space.spz" >> "%LOG%" 2>&1
    echo.
    echo ============================================
    echo  완료!
    echo  결과: compress_splat.log 확인
    echo  다음: GitHub Desktop -^> commit -^> push
    echo ============================================
)
pause
