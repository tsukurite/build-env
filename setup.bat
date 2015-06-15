@echo off

cd "%~dp0"

call env.bat

call npm.cmd install -g npm
call npm.cmd install

rem vim:ff=dos:
