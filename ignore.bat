@echo off

cd "%~dp0"

call env.bat

call TortoiseProc.exe /command:ignore /path:"node_modules" /path:"bin\node\node_modules\" /closeonend:3

rem vim:ff=dos:
