@echo off

set PATH="%~dp0\bin";%PATH%
set NODE_PATH="%~dp0\bin\node_modules\npm\node_modules;%~dp0\bin\node_modules\npm";%NODE_PATH%

call npm.cmd install -g npm
call npm.cmd install

call gem.bat update --no-document --system
call gem.bat install compass --no-document --version 1.0.3

rem vim:ff=dos:
