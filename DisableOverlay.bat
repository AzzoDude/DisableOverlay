@echo off
:: Check for administrative privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: Please run this script as an Administrator.
    pause
    exit /b
)

title Game Bar Removal Tool
echo --------------------------------------------------
echo Disabling Windows Gaming Overlay...
echo --------------------------------------------------

:: 1. Disable Game DVR and Game Bar in Registry
echo Modifying Registry keys...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /t REG_DWORD /d 0 /f >nul
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f >nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f >nul

:: 2. Stop and Disable Gaming Services
echo Stopping background services...
powershell -Command "Get-Service -Name 'GamingServices*' -ErrorAction SilentlyContinue | Stop-Service -Force" >
