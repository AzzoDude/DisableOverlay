@echo off
title Game Bar Removal Tool
echo --------------------------------------------------
echo Disabling Windows Gaming Overlay...
echo --------------------------------------------------

:: 1. Disable Game DVR and Game Bar in Registry
echo Modifying Registry keys...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "AppCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v "HistoricalCaptureEnabled" /t REG_DWORD /d 0 /f
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f

:: 2. Stop and Disable the Gaming Services (if running)
echo Stopping background services...
powershell -Command "Get-Service -Name GamingServices* | Stop-Service -Force" >nul 2>&1

:: 3. Uninstall the Game Bar AppX Package
echo Removing AppX Packages...
powershell -Command "Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage"
powershell -Command "Get-AppxProvisionedPackage -Online | Where-Object {$_.PackageName -like '*XboxGamingOverlay*'} | Remove-AppxProvisionedPackage -Online"

echo --------------------------------------------------
echo Done! Please restart your computer for changes to take effect.
echo --------------------------------------------------
pause