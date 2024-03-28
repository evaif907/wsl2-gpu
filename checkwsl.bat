@echo off
wsl -l -q >nul 2>&1

if %errorlevel% equ 0 (
    echo WSL is installed. Listing installed distributions:
    wsl -l -v
) else (
    echo WSL is not installed. Please install WSL to proceed.
    echo Press Ctrl+C to exit.
    pause
)
pause