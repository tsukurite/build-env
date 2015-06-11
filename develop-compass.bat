@echo off

cd "%~dp0"

call env.bat

call npm.cmd start -- develop --compass

rem vim:ff=dos:
