@echo off & setlocal enabledelayedexpansion & chcp 65001 >nul 2>&1
set "a=����a" & for /f "usebackq delims=" %%a in (`echo !a^:^~2^,1!`) do (if not "%%~a"=="a" chcp 936 >nul 2>&1) & set "a="







net session >nul 2>&1||(PowerShell -Command "Start-Process '%~f0' -Verb RunAs" && exit)
cd /d "%~dp0"



rem echo 20.200.245.247 github.com>"%SystemRoot%\System32\drivers\etc\hosts"
rem ipconfig /flushdns
rem exit


rem curl -s https://github-hosts.tinsfox.com/hosts >"%SystemRoot%\System32\drivers\etc\hosts"




set "a=  "web": ["


call :GitHub���� "!a!" "github.com"

pause
exit




:GitHub����
rem ����һ���жϿ�ʼ����

rem ������������


set "����=%~2"
set "b=0"
for /f "usebackq delims=" %%a in (`curl -s "https://api.github.com/meta" ^|^| curl -s "https://api.kkgithub.com/meta"`) do (
if "%%~a" == "  ]," set "b=0"
if "!b!" == "1" call :���� "%%~a"
if "%%~a" == "%~1" set "b=1"
)
echo.
echo ������!����! ���IP:!���IP! ���ʱ��:!���ʱ��!
echo.
if not "!���IP!" == "0" (
call :д��Hosts "!���IP!" "!����!"
)


exit /b
:д��Hosts
rem ������IP    ����
echo.>"%LOCALAPPDATA%\Temp\host.tmp"
for /f "usebackq delims=" %%a in ("%SystemRoot%\System32\drivers\etc\hosts") do (
(echo "%%~a" | findstr /i " %~2">nul)||echo "%%~a">>"%LOCALAPPDATA%\Temp\host.tmp"
)
echo %~1 %~2>>"%LOCALAPPDATA%\Temp\host.tmp"
type "%LOCALAPPDATA%\Temp\host.tmp">"%SystemRoot%\System32\drivers\etc\hosts"
ipconfig /flushdns
exit /b
:����
rem %~1�ǲ���IP��Χ
if "!���ʱ��!"=="" set "���ʱ��=999999"
if "!���IP!"=="" set "���IP=0"
set "c=%~1"
set "c=!c:"=!"
set "c=!c:,=!"
set "c=!c:/=!"
set "c=!c:~4,-2!"
for /f "usebackq tokens=5 delims= " %%a in (`ping -n 1 -w 200 !c! ^| findstr "ʱ��="`) do (
set "d=%%~a"
set "d=!d:~3,-2!"
echo ��ǰ����IP��!c!  ����ʱ�䣺!d!
set /a "d1=!d!-!���ʱ��!"


if "!d1:~0,1!" == "-" (
set "���ʱ��=!d!"
set "���IP=!c!"
)
)
exit /b











