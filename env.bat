@echo off

set PATH="%~dp0\bin\node";%PATH%
set NODE_PATH="%~dp0\bin\node\node_modules\npm\node_modules;%~dp0\bin\node\node_modules\npm";%NODE_PATH%

set PATH="%~dp0\bin\ruby\bin";"%~dp0\bin\ruby\gem\bin";%PATH%
set FULLPATH=%~dp0
set GEM_HOME=%FULLPATH:\=/%/bin/ruby/gem
set GEM_PATH=%FULLPATH:\=/%/bin/ruby/gem

rem vim:ff=dos:
