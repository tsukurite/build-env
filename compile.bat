@echo off

cd "%~dp0"

call env.bat

call npm.cmd start -- compile --production

rem vim:ff=dos:
