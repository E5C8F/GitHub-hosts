@echo off & setlocal enabledelayedexpansion
rem @echo off & setlocal enabledelayedexpansion & chcp 65001 >nul 2>&1
rem set "a=����a" & for /f "usebackq delims=" %%a in (`echo !a^:^~2^,1!`) do (if not "%%~a"=="a" chcp 936 >nul 2>&1) & set "a="

cd /d "%~dp0"

chcp 936 >nul 2>&1


net session >nul 2>&1||(PowerShell -Command "Start-Process '%~f0' -Verb RunAs" & exit)
cd /d "%~dp0"

rem echo.>"%SystemRoot%\System32\drivers\etc\hosts"


call :������ѯд�� "github.com"
call :������ѯд�� "raw.githubusercontent.com"
call :������ѯд�� "api.github.com"
rem call :������ѯд�� "github.io"
rem call :������ѯд�� "docs.github.com"




echo.
echo.
echo ��ǰHosts�������£�
type "%SystemRoot%\System32\drivers\etc\hosts"

pause
exit
:������ѯд��

set "������="
set "����="
set "����="
set "��ѯ="
set "�ж�="
set "IP="
set "��="
set "�ϴμ���="
set "a="
set "b="
set "c="
set "d="
set "e="
set "f="
set "���ʱ��="
set "���IP="
set /a "���²�ѯ����=0"
set /a "���²��ٴ���=0"




set "1=a.root-servers.net"
set "2=b.root-servers.net"
set "3=c.root-servers.net"
set "4=d.root-servers.net"
set "5=e.root-servers.net"
set "6=f.root-servers.net"
set "7=g.root-servers.net"
set "8=h.root-servers.net"
set "9=i.root-servers.net"
set "10=j.root-servers.net"
set "11=k.root-servers.net"
set "12=l.root-servers.net"
set "13=m.root-servers.net"
set /a "����=13"
set /a "��ѯ=%random% %% !����!+1"
call :������ѯ1 "!��ѯ!" "%~1"

exit /b
:������ѯ1
set "������=!%~1!"
rem set "������=!1!"
set "����=%~2"
set /a "�ϴμ���=!����!"
set "�ж�="
set /a "����=0"
set "��="

echo ��ѯĿ�꣺nslookup !����! !������!
(nslookup !����! !������!>"%LOCALAPPDATA%\Temp\��ѯ���.tmp")||(echo.>"%LOCALAPPDATA%\Temp\��ѯ���.tmp")


rem type "%LOCALAPPDATA%\Temp\��ѯ���.tmp"


for /f "usebackq delims=" %%a in ("%LOCALAPPDATA%\Temp\��ѯ���.tmp") do (
set "��=%%~a"
if "!��:~0,1!"=="-" (
echo %%~a
set "�ж�=������ѯ"
set /a "����=!����!+1"
set "!����!=!��:~2!"
) else if "!��!"=="Address:  127.0.0.1" (
set "�ж�=��ѯʧ��"
) else (

if "!��:~0,3!"=="����:" if "!�ж�!"=="" set "�ж�=��ѯ����"
)
)
if "!��:~0,3!"=="����:" set "�ж�=��ѯʧ��"


if "!�ж�!"=="" set "�ж�=��ѯʧ��"
echo !����! "!�ж�!"
if "!�ж�!"=="��ѯʧ��" (
if "!���²�ѯ����!"=="5" (
echo ��β�ѯʧ��,������ѯ��
) else (
set /a "���²�ѯ����=!���²�ѯ����!+1"
echo ��ѯʧ�ܣ��Զ��������������²�ѯ��
set "�ж�=������ѯ"
if "!����!"=="0" set "����=!�ϴμ���!"

)

)


if "!�ж�!"=="������ѯ" (
set /a "��ѯ=%random% %% !����!+1"
call :������ѯ1 "!��ѯ!" "!����!"
) else if "!�ж�!"=="��ѯ����" (
rem cls
echo.
echo.
echo !����!��ѯ�����
type "%LOCALAPPDATA%\Temp\��ѯ���.tmp"


call :��ѯ�������

)
exit /b


:��ѯ�������
set "���ʱ��=999999"
set "���IP=0"
set "IP="
set "�ж�="
set "��="

for /f "usebackq delims=" %%a in ("%LOCALAPPDATA%\Temp\��ѯ���.tmp") do (
set "��=%%~a"
if "!�ж�!"=="��ʼ��¼IP" (
if "!��:~0,10!"=="Addresses:" (
set "IP=!��:~12!"
) else if "!��:~0,8!"=="Address:" (
set "IP=!��:~10!"
) else (
set "IP=!��:~3!"
)
)

if "!��:~0,3!"=="����:" set "�ж�=��ʼ��¼IP"

if not "!IP!"=="" call :���� !IP!
)


if not "!���IP!" == "0" (
echo.
echo ������!����! ���IP:!���IP! ���ʱ��:!���ʱ��!
echo.
call :д��Hosts "!���IP!" "!����!"
) else (
if "!���²��ٴ���!"=="5" (
echo ��β���ʧ�ܣ��������²��١�
) else (
set /a "���²��ٴ���=!���²��ٴ���!+1"
call :��ѯ�������
)
)


exit /b
:����
set "c=%~1"

set "d=0"
for /f "usebackq tokens=5 delims= " %%a in (`ping -n 1 -w 500 !c! ^| findstr "ʱ��="`) do (
set "d=%%~a"
set "d=!d:~3,-2!"
echo ��ǰ����IP��!c!  ����ʱ�䣺!d!
set /a "d1=!d!-!���ʱ��!"
if "!d1:~0,1!" == "-" (
set "���ʱ��=!d!"
set "���IP=!c!"
)
)
if "!d!"=="0" echo !c!����ʧ��
exit /b



:д��Hosts
rem ������IP    ����
del /f/q "%LOCALAPPDATA%\Temp\host.tmp">nul
for /f "usebackq delims=" %%a in ("%SystemRoot%\System32\drivers\etc\hosts") do (
(echo "%%~a" | findstr /I /C:" %~2">nul)||((echo %%~a)>>"%LOCALAPPDATA%\Temp\host.tmp")
)


echo %~1 %~2>>"%LOCALAPPDATA%\Temp\host.tmp"
type "%LOCALAPPDATA%\Temp\host.tmp">"%SystemRoot%\System32\drivers\etc\hosts"
ipconfig /flushdns
exit /b















