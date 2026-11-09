@echo off
setlocal

set "JAVA_HOME=C:\Users\Acer Nitro\java\17.0.13+11"
set "RMI_HOST=127.0.0.1"
set "RMI_REGISTRY_PORT=1099"
set "APP_ADMIN_USER=admin"
set "APP_ADMIN_PASSWORD=adminpassword123"
set "CATALINA_HOME=C:\Users\Acer Nitro\Downloads\apache-tomcat-10.1.61-windows-x64\apache-tomcat-10.1.61"

if not exist "%~dp0web-app\target\web-app-1.0.0.war" (
    echo WAR aplikasi belum ditemukan. Jalankan build Maven terlebih dahulu.
    pause
    exit /b 1
)

copy /Y "%~dp0web-app\target\web-app-1.0.0.war" "%CATALINA_HOME%\webapps\web-app-1.0.0.war" >nul
if errorlevel 1 (
    echo Gagal menyalin WAR. Hentikan Tomcat lalu jalankan script ini kembali.
    pause
    exit /b 1
)

cd /d "%CATALINA_HOME%\bin"
call startup.bat
