@echo off & setlocal enabledelayedexpansion
rem @echo off & setlocal enabledelayedexpansion & chcp 65001 >nul 2>&1
rem set "a=编码a" & for /f "usebackq delims=" %%a in (`echo !a^:^~2^,1!`) do (if not "%%~a"=="a" chcp 936 >nul 2>&1) & set "a="

cd /d "%~dp0"

chcp 936 >nul 2>&1


net session >nul 2>&1||(PowerShell -Command "Start-Process '%~f0' -Verb RunAs" & exit)
cd /d "%~dp0"

rem echo.>"%SystemRoot%\System32\drivers\etc\hosts"


call :域名查询写入 "github.com"
call :域名查询写入 "raw.githubusercontent.com"
call :域名查询写入 "api.github.com"
rem call :域名查询写入 "github.io"
rem call :域名查询写入 "docs.github.com"




echo.
echo.
echo 当前Hosts内容如下：
type "%SystemRoot%\System32\drivers\etc\hosts"

pause
exit
:域名查询写入

set "服务器="
set "域名="
set "计数="
set "查询="
set "判断="
set "IP="
set "行="
set "上次计数="
set "a="
set "b="
set "c="
set "d="
set "e="
set "f="
set "最快时间="
set "最快IP="
set /a "重新查询次数=0"
set /a "重新测速次数=0"




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
set /a "计数=13"
set /a "查询=%random% %% !计数!+1"
call :域名查询1 "!查询!" "%~1"

exit /b
:域名查询1
set "服务器=!%~1!"
rem set "服务器=!1!"
set "域名=%~2"
set /a "上次计数=!计数!"
set "判断="
set /a "计数=0"
set "行="

echo 查询目标：nslookup !域名! !服务器!
(nslookup !域名! !服务器!>"%LOCALAPPDATA%\Temp\查询结果.tmp")||(echo.>"%LOCALAPPDATA%\Temp\查询结果.tmp")


rem type "%LOCALAPPDATA%\Temp\查询结果.tmp"


for /f "usebackq delims=" %%a in ("%LOCALAPPDATA%\Temp\查询结果.tmp") do (
set "行=%%~a"
if "!行:~0,1!"=="-" (
echo %%~a
set "判断=继续查询"
set /a "计数=!计数!+1"
set "!计数!=!行:~2!"
) else if "!行!"=="Address:  127.0.0.1" (
set "判断=查询失败"
) else (

if "!行:~0,3!"=="名称:" if "!判断!"=="" set "判断=查询结束"
)
)
if "!行:~0,3!"=="名称:" set "判断=查询失败"


if "!判断!"=="" set "判断=查询失败"
echo !计数! "!判断!"
if "!判断!"=="查询失败" (
if "!重新查询次数!"=="5" (
echo 多次查询失败,跳过查询。
) else (
set /a "重新查询次数=!重新查询次数!+1"
echo 查询失败，自动更换服务器重新查询。
set "判断=继续查询"
if "!计数!"=="0" set "计数=!上次计数!"

)

)


if "!判断!"=="继续查询" (
set /a "查询=%random% %% !计数!+1"
call :域名查询1 "!查询!" "!域名!"
) else if "!判断!"=="查询结束" (
rem cls
echo.
echo.
echo !域名!查询结果：
type "%LOCALAPPDATA%\Temp\查询结果.tmp"


call :查询结果处理

)
exit /b


:查询结果处理
set "最快时间=999999"
set "最快IP=0"
set "IP="
set "判断="
set "行="

for /f "usebackq delims=" %%a in ("%LOCALAPPDATA%\Temp\查询结果.tmp") do (
set "行=%%~a"
if "!判断!"=="开始记录IP" (
if "!行:~0,10!"=="Addresses:" (
set "IP=!行:~12!"
) else if "!行:~0,8!"=="Address:" (
set "IP=!行:~10!"
) else (
set "IP=!行:~3!"
)
)

if "!行:~0,3!"=="名称:" set "判断=开始记录IP"

if not "!IP!"=="" call :测速 !IP!
)


if not "!最快IP!" == "0" (
echo.
echo 域名：!域名! 最快IP:!最快IP! 最快时间:!最快时间!
echo.
call :写入Hosts "!最快IP!" "!域名!"
) else (
if "!重新测速次数!"=="5" (
echo 多次测速失败，跳过重新测速。
) else (
set /a "重新测速次数=!重新测速次数!+1"
call :查询结果处理
)
)


exit /b
:测速
set "c=%~1"

set "d=0"
for /f "usebackq tokens=5 delims= " %%a in (`ping -n 1 -w 500 !c! ^| findstr "时间="`) do (
set "d=%%~a"
set "d=!d:~3,-2!"
echo 当前测速IP：!c!  测速时间：!d!
set /a "d1=!d!-!最快时间!"
if "!d1:~0,1!" == "-" (
set "最快时间=!d!"
set "最快IP=!c!"
)
)
if "!d!"=="0" echo !c!测速失败
exit /b



:写入Hosts
rem 参数：IP    域名
del /f/q "%LOCALAPPDATA%\Temp\host.tmp">nul
for /f "usebackq delims=" %%a in ("%SystemRoot%\System32\drivers\etc\hosts") do (
(echo "%%~a" | findstr /I /C:" %~2">nul)||((echo %%~a)>>"%LOCALAPPDATA%\Temp\host.tmp")
)


echo %~1 %~2>>"%LOCALAPPDATA%\Temp\host.tmp"
type "%LOCALAPPDATA%\Temp\host.tmp">"%SystemRoot%\System32\drivers\etc\hosts"
ipconfig /flushdns
exit /b















