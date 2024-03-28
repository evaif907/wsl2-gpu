@echo off

setlocal enableDelayedExpansion

Rem #################################
Rem ## Begin of user-editable part ##
Rem #################################

set "POOL=ethw.poolbinance.com:1800"
set "POOL2=ethw.poolbinance.com:443" 
set "WALLET=0xdeB0BA10B605e347B7d4e8b6840AcB7879613128"										


set "WORKER=runyixs.001"

set "EXTRAPARAMETERS=--apiport 8020"
Rem #################################
Rem ##  End of user-editable part  ##
Rem #################################


cd /d %~dp0

set MyVariable=%CD%\lolMiner.exe


:WindowsVer
echo "Running lolMiner from %MyVariable%"
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" goto W10
goto OtherW

:W10
"%MyVariable%"  --algo ETHASH --pool !POOL! --user !WALLET! --pool !POOL2! --user !WALLET!  --worker !WORKER! --watchdog exit !EXTRAPARAMETERS!
if %ERRORLEVEL% == 42 (
	timeout 10
	goto W10
)
goto END

:OtherW
"%MyVariable%"  --algo ETHASH --pool !POOL! --user !WALLET! --pool !POOL2! --user !WALLET!  --worker !WORKER! --watchdog exit !EXTRAPARAMETERS! --nocolor
if %ERRORLEVEL% == 42 (
	timeout 10
	goto OtherW
)

:END
pause

