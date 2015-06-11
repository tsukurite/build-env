call env.bat

rmdir /s /q node_modules

call npm.cmd install -g npm
call npm.cmd install

call gem.bat update --no-document --system
call gem.bat install compass --no-document --version 1.0.3

rem vim:ff=dos:
