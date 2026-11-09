@echo off
setlocal
cd /d "%~dp0"

set "JAVA_HOME=C:\Users\Acer Nitro\java\17.0.13+11"
set "JAVA_TOOL_OPTIONS=-Djava.rmi.server.hostname=127.0.0.1"

"%JAVA_HOME%\bin\java.exe" -cp "rmi-common\target\rmi-common-1.0.0.jar;rmi-server\target\rmi-server-1.0.0.jar" id.ac.kampus.rmi.server.ServerMain
