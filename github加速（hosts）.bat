@echo off & setlocal enabledelayedexpansion & chcp 65001 >nul 2>&1
set "a=编码a" & for /f "usebackq delims=" %%a in (`echo !a^:^~2^,1!`) do (if not "%%~a"=="a" chcp 936 >nul 2>&1) & set "a="







net session >nul 2>&1||(PowerShell -Command "Start-Process '%~f0' -Verb RunAs" && exit)
cd /d "%~dp0"



rem echo 20.200.245.247 github.com>"%SystemRoot%\System32\drivers\etc\hosts"
rem ipconfig /flushdns
rem exit


rem curl -s https://github-hosts.tinsfox.com/hosts >"%SystemRoot%\System32\drivers\etc\hosts"




set "a=  "web": ["


call :GitHub加速 "!a!" "github.com"

pause
exit




:GitHub加速
rem 参数一是判断开始的行

rem 参数二是域名


set "域名=%~2"
set "b=0"
for /f "usebackq delims=" %%a in (`curl -s "https://api.github.com/meta" ^|^| curl -s "https://api.kkgithub.com/meta"`) do (
if "%%~a" == "  ]," set "b=0"
if "!b!" == "1" call :测速 "%%~a"
if "%%~a" == "%~1" set "b=1"
)
echo.
echo 域名：!域名! 最快IP:!最快IP! 最快时间:!最快时间!
echo.
if not "!最快IP!" == "0" (
call :写入Hosts "!最快IP!" "!域名!"
)


exit /b
:写入Hosts
rem 参数：IP    域名
echo.>"%LOCALAPPDATA%\Temp\host.tmp"
for /f "usebackq delims=" %%a in ("%SystemRoot%\System32\drivers\etc\hosts") do (
(echo "%%~a" | findstr /i " %~2">nul)||echo "%%~a">>"%LOCALAPPDATA%\Temp\host.tmp"
)
echo %~1 %~2>>"%LOCALAPPDATA%\Temp\host.tmp"
type "%LOCALAPPDATA%\Temp\host.tmp">"%SystemRoot%\System32\drivers\etc\hosts"
ipconfig /flushdns
exit /b
:测速
rem %~1是测速IP范围
if "!最快时间!"=="" set "最快时间=999999"
if "!最快IP!"=="" set "最快IP=0"
set "c=%~1"
set "c=!c:"=!"
set "c=!c:,=!"
set "c=!c:/=!"
set "c=!c:~4,-2!"
for /f "usebackq tokens=5 delims= " %%a in (`ping -n 1 -w 200 !c! ^| findstr "时间="`) do (
set "d=%%~a"
set "d=!d:~3,-2!"
echo 当前测速IP：!c!  测速时间：!d!
set /a "d1=!d!-!最快时间!"


if "!d1:~0,1!" == "-" (
set "最快时间=!d!"
set "最快IP=!c!"
)
)
exit /b











