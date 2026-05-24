@echo off
title Hacker78010 cr3w - Ultimate Toolkit
color 0A
mode con: cols=95 lines=32

:menu
cls
echo ===============================================================================================
echo                                 HACKER78010 CR3W ULTIMATE TOOLKIT
echo ===============================================================================================
echo.
echo   [SYSTEM DIAGNOSTICS]      [NETWORK / RECON]         [SYSTEM CLEANUP]       [AUDIT / HACKING]
echo   1. View Hardware          4. Get My IPs             7. Flush DNS Cache     10. WiFi Pass Extractor
echo   2. Battery Report         5. Quick Ping Test        8. Delete Temp Files   11. Netstat Active Conns
echo   3. Running Processes      6. Port Connection Check  9. Restart Explorer    12. DNS Lookup (NSLookup)
echo                                                                              13. LAN IP Scanner (ARP)
echo ===============================================================================================
echo   0. Exit Toolkit
echo ===============================================================================================
echo.
set /p ch="Choose an option (0-13): "

if "%ch%"=="1" goto hardware
if "%ch%"=="2" goto battery
if "%ch%"=="3" goto processes
if "%ch%"=="4" goto getip
if "%ch%"=="5" goto quickping
if "%ch%"=="6" goto portcheck
if "%ch%"=="7" goto flushdns
if "%ch%"=="8" goto tempclean
if "%ch%"=="9" goto restvertexp
if "%ch%"=="10" goto wifipass
if "%ch%"=="11" goto netstat
if "%ch%"=="12" goto nslookup
if "%ch%"=="13" goto arpscan
if "%ch%"=="0" exit
goto menu

:: --- SYSTEM DIAGNOSTICS ---
:hardware
cls
echo === HARDWARE INFORMATION ===
echo.
echo CPU:
wmic cpu get name | findstr /v "Name"
echo Video Card (GPU):
wmic path win32_VideoController get name | findstr /v "Name"
echo Total Memory (RAM):
wmic computersystem get totalphysicalmemory | findstr /v "TotalPhysicalMemory"
echo.
pause
goto menu

:battery
cls
echo === GENERATING BATTERY REPORT ===
echo.
powercfg /batteryreport /output "%USERPROFILE%\Desktop\battery_report.html"
echo Report saved to your Desktop as 'battery_report.html'.
echo.
pause
goto menu

:processes
cls
echo === RUNNING PROCESSES ===
echo.
tasklist | more
echo.
pause
goto menu

:: --- NETWORK TOOLS ---
:getip
cls
echo === IP ADDRESSES ===
echo.
echo [Local IP]:
ipconfig | findstr "IPv4"
echo.
echo [Public IP]:
powershell -Command "(Invoke-WebRequest -Uri 'https://api.ipify.org').Content"
echo.
pause
goto menu

:quickping
cls
echo === QUICK PING TEST (Cloudflare DNS) ===
echo.
ping 1.1.1.1 -n 4
echo.
pause
goto menu

:portcheck
cls
echo === PORT CONNECTION CHECK ===
echo.
set /p target_host="Enter Target IP/Domain: "
set /p target_port="Enter Port (e.g. 80, 443, 22): "
echo Testing connection...
powershell -Command "Test-NetConnection %target_host% -Port %target_port%"
echo.
pause
goto menu

:: --- SYSTEM CLEANUP ---
:flushdns
cls
echo === FLUSHING DNS CACHE ===
echo.
ipconfig /flushdns
echo.
pause
goto menu

:tempclean
cls
echo === CLEANING TEMPORARY FILES ===
echo.
echo Cleaning user temp...
del /q /f /s "%TEMP%\*.*" 2>nul
echo Cleaning system temp...
del /q /f /s "%SystemRoot%\Temp\*.*" 2>nul
echo.
echo Cleanup finished!
pause
goto menu

:restvertexp
cls
echo === RESTARTING WINDOWS EXPLORER ===
echo.
taskkill /f /im explorer.exe
start explorer.exe
echo.
echo Done!
pause
goto menu

:: --- AUDIT / HACKING TOOLS ---
:wifipass
cls
echo === WiFi PASSWORD EXTRACTOR ===
echo.
echo Listing saved WiFi profiles on this PC:
echo ----------------------------------------------------
netsh wlan show profiles | findstr "All User Profile"
echo ----------------------------------------------------
echo.
set /p wifi_name="Enter the exact WiFi profile name to target: "
echo.
echo Fetching password for: %wifi_name%
echo ----------------------------------------------------
netsh wlan show profile name="%wifi_name%" key=clear | findstr "Key Content"
if %ERRORLEVEL% NEQ 0 echo [!] Profile not found or password could not be extracted.
echo ----------------------------------------------------
echo.
pause
goto menu

:netstat
cls
echo === ACTIVE NETWORK CONNECTIONS (NETSTAT) ===
echo.
echo Showing all active TCP connections and listening ports...
echo [PID]       [Proto]   [Local Address]          [Foreign Address]        [State]
netstat -ano | findstr "ESTABLISHED LISTENING" | more
echo.
pause
goto menu

:nslookup
cls
echo === DNS LOOKUP (RECONNAISSANCE) ===
echo.
set /p target_domain="Enter Target Domain (e.g., target.com): "
echo.
echo Querying default DNS Server for A, AAAA, and MX records...
echo ----------------------------------------------------
nslookup %target_domain%
echo ----------------------------------------------------
echo.
pause
goto menu

:arpscan
cls
echo === LAN IP SCANNER (ARP TABLE SURVEY) ===
echo.
echo Scanning local network cache for active devices...
echo This shows local devices (Routers, Phones, PCs) connected to your subnet.
echo.
echo [IP Address]        [Physical/MAC Address]     [Type]
arp -a | findstr "dynamic"
echo.
pause
goto menu