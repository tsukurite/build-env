@echo off

cd "%~dp0"

call env.bat

call npm.cmd start -- develop

rem vim:ff=dos:
