@echo off & setlocal enabledelayedexpansion & chcp 65001 >nul 2>&1
set "a=编码a" & for /f "usebackq delims=" %%a in (`echo !a^:^~2^,1!`) do (if not "%%~a"=="a" chcp 936 >nul 2>&1) & set "a="







net session >nul 2>&1||(PowerShell -Command "Start-Process '%~f0' -Verb RunAs" && exit)
cd /d "%~dp0"



rem echo 20.200.245.247 github.com>"%SystemRoot%\System32\drivers\etc\hosts"
rem ipconfig /flushdns
rem exit


rem curl -s https://github-hosts.tinsfox.com/hosts >"%SystemRoot%\System32\drivers\etc\hosts"


set "a=  "web": ["
set "curl=https://api.github.com/meta"
:000
set "最快时间=999999"
set "最快IP=0"
set "b=0"
for /f "usebackq delims=" %%a in (`curl -s !curl!`) do (
if "%%~a" == "  ]," set "b=0"
if "!b!" == "1" call :001 "%%~a"
if "%%~a" == "%a%" set "b=1"
)

echo.
echo 这会覆盖你的hosts
echo 域名：github.com 最快IP:!最快IP! 最快时间:!最快时间!
echo.



if not "!最快IP!" == "0" (

echo !最快IP! github.com>"%SystemRoot%\System32\drivers\etc\hosts"
ipconfig /flushdns

) else (
echo 无效的测试IP，可能是无法从meta获取IP资源，是否使用kkgithub代理（可能随时失效）？

pause
set "curl=https://api.kkgithub.com/meta"
goto :000
)



pause
exit 

:001
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











