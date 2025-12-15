@echo off
setlocal ENABLEDELAYEDEXPANSION

REM ================================================================
REM  mping.bat
REM
REM  Description:
REM    Reads an input file containing a list of IP addresses and
REM    performs a ping test on each address. All addresses that
REM    respond are written to "passed_ips.txt". All addresses that
REM    do not respond are written to "failed_ips.txt".
REM
REM  Usage:
REM      mping.bat <input_file>
REM      Example: mping.bat input_list.txt
REM
REM ================================================================

REM Validate CLI parameter
if "%~1"=="" (
    echo ERROR: No input file specified.
    echo Usage: mping.bat ^<input_file^>
    exit /b 1
)

set "INPUT_FILE=%~1"

if not exist "%INPUT_FILE%" (
    echo ERROR: Input file "%INPUT_FILE%" not found.
    exit /b 1
)

set "PASSED_IPS=passed_ips.txt"
set "FAILED_IPS=failed_ips.txt"

REM Output files are recreated fresh
del %PASSED_IPS% 2>nul
del %FAILED_IPS% 2>nul

echo Processing IP addresses from %INPUT_FILE%...
echo.

REM Loop through each line of the input file
for /f "usebackq delims=" %%A in ("%INPUT_FILE%") do (
    set "IP=%%A"
    if "!IP!"=="" (
        REM skip empty lines
        continue
    )
    REM /n 1 = send 1 ping, /w 500 = 500 ms timeout (adjustable)
    ping -n 3 -w 500 !IP! >nul
	
    if !errorlevel! equ 0 (
        echo !IP! >> %PASSED_IPS%
        echo PASSED !IP! 
    ) else (
        echo !IP! >> %FAILED_IPS%
        echo FAILED !IP! 
    )
)
echo.
echo Task completed.
echo Passed IP Addresses: %PASSED_IPS%
echo Failed IP Addresses: %FAILED_IPS%

endlocal
