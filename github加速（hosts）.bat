@echo off & setlocal enabledelayedexpansion & chcp 65001 >nul 2>&1
set "a=����a" & for /f "usebackq delims=" %%a in (`echo !a^:^~2^,1!`) do (if not "%%~a"=="a" chcp 936 >nul 2>&1) & set "a="







net session >nul 2>&1||(PowerShell -Command "Start-Process '%~f0' -Verb RunAs" && exit)
cd /d "%~dp0"



rem echo 20.200.245.247 github.com>"%SystemRoot%\System32\drivers\etc\hosts"
rem ipconfig /flushdns
rem exit


rem curl -s https://github-hosts.tinsfox.com/hosts >"%SystemRoot%\System32\drivers\etc\hosts"


set "a=  "web": ["
set "curl=https://api.github.com/meta"
:000
set "���ʱ��=999999"
set "���IP=0"
set "b=0"
for /f "usebackq delims=" %%a in (`curl -s !curl!`) do (
if "%%~a" == "  ]," set "b=0"
if "!b!" == "1" call :001 "%%~a"
if "%%~a" == "%a%" set "b=1"
)

echo.
echo ��Ḳ�����hosts
echo ������github.com ���IP:!���IP! ���ʱ��:!���ʱ��!
echo.



if not "!���IP!" == "0" (

echo !���IP! github.com>"%SystemRoot%\System32\drivers\etc\hosts"
ipconfig /flushdns

) else (
echo ��Ч�Ĳ���IP���������޷���meta��ȡIP��Դ���Ƿ�ʹ��kkgithub����������ʱʧЧ����

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











