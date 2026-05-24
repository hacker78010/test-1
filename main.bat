@echo off
title Hacker78010 cr3w - Main Project
color 0A
mode con: cols=80 lines=25

:menu
cls
echo =======================================================================
echo                         Hacker78010 cr3w PROJECT                      
echo =======================================================================
echo.
echo  [1] Display System Information
echo  [2] Flush DNS Cache (Network Cleanup)
echo  [3] Open Project Folder in AppData
echo  [4] Exit
echo.
echo =======================================================================
set /p ch="Select an option (1-4): "

if "%ch%"=="1" goto sysinfo
if "%ch%"=="2" goto cleanup
if "%ch%"=="3" goto openfolder
if "%ch%"=="4" exit
goto menu

:sysinfo
cls
echo === System Info ===
echo.
echo Computer Name: %COMPUTERNAME%
echo Current User:  %USERNAME%
echo OS Platform:   %OS%
echo.
pause
goto menu

:cleanup
cls
echo === Network Cleanup ===
echo.
ipconfig /flushdns
echo.
echo DNS Cache cleared successfully!
pause
goto menu

:openfolder
cls
echo Opening directory: %~dp0...
start "" "%~dp0"
goto menu