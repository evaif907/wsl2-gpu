@echo off
setlocal enabledelayedexpansion
set "hasDedicatedGPU=0"

for /f "tokens=2 delims==" %%i in ('wmic path win32_videocontroller get name /value') do (
    set "gpuName=%%i"
    echo Found GPU: !gpuName!
    echo !gpuName! | findstr /i "NVIDIA AMD" >nul && (
        echo Detected dedicated GPU: !gpuName!
        set "hasDedicatedGPU=1"
        goto runTest
    )
)

echo No dedicated GPU detected.
exit /b 0

:runTest
if !hasDedicatedGPU! equ 1 (
    echo Running GPU test...
    lolMiner.exe /test=fur /width=800 /height=600 /full_screen=no /benchmark /benchmark_duration_ms=10000 | more
    exit /b 1
)

pause
