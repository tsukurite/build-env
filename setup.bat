@echo off

set PATH="%~dp0\bin";%PATH%
set NODE_PATH="%~dp0\bin\node_modules\npm\node_modules;%~dp0\bin\node_modules\npm";%NODE_PATH%

call npm.cmd install -g npm
call npm.cmd install

rem vim:ff=dos:
