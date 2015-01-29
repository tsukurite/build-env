# build-env

build environment for frontend engineers

## how to setup

execute `setup.bat`.

## how to use

execute batch file.

### `compile.bat`

- compile jade
- compile sass
- minify image

### `develop.bat`

- start http server
- start livereload
- start watch files
  - compile jade
  - compile sass
  - minify image

### `compile-compass.bat`

it about same as `compile.bat`, but use compass for Sass.

### `develop-compass.bat`

it about same as `develop.bat`, but use compass for Sass.

## binaries

- [node.js](http://nodejs.org/)
  - [node ver.0.10.36 (x64)](http://nodejs.org/dist/v0.10.36/x64/node.exe)
    - [Downloads](http://nodejs.org/download/)
  - [npm ver.1.4.12](http://nodejs.org/dist/npm/npm-1.4.12.zip)
    - [Downloads](http://nodejs.org/download/)

- [Ruby](https://www.ruby-lang.org/)
  - [Ruby ver.2.1.5 (x64)](http://dl.bintray.com/oneclick/rubyinstaller/ruby-2.1.5-x64-mingw32.7z?direct)
    - [Ruby Installer for Windows](http://rubyinstaller.org/)
  - [AddTrustExternalCARoot-2048.pem](https://raw.githubusercontent.com/rubygems/rubygems/master/lib/rubygems/ssl_certs/AddTrustExternalCARoot-2048.pem)
    - [SSL upgrades on rubygems.org and RubyInstaller versions](https://gist.github.com/luislavena/f064211759ee0f806c88)
