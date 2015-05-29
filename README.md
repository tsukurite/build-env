# build-env

build environment on WindowsOS for frontend engineers

## セットアップ

### Windows

1. [releases](https://github.com/tsukurite/build-env/releases)から新しいバージョンのzipファイルをダウンロードする
2. ダウンロードしたzipファイルをリポジトリ内の任意の場所に展開する
3. `ignore.bat`を実行して一部のディレクトリをリポジトリの管理から除外する
4. `setup.bat`を実行して各種モジュール等をインストールする
5. 後述のバッチファイルを実行する

### OS X

1. [releases](https://github.com/tsukurite/build-env/releases)から新しいバージョンのzipファイルをダウンロードする
2. ダウンロードしたzipファイルをリポジトリ内の任意の場所に展開する
3. `$ npm install` needs **node.js ver.0.10.36 and npm ver.2.0 or later**
4. `$ rake install` needs **Ruby ver.2.1.5 and Bundler ver.1.8.2 or later**
5. `package.json`と`gulpfile.coffee`を見てなんとかする（`$ npm start -- develop`や`$ npm start -- compile`など）

## バッチファイル

### `compile.bat`

- 公開時に使用する
- `gulp-jade`によるJadeのコンパイル
- `gulp-sass`によるSassのコンパイル
- `gulp-imagemin`による画像の最適化

### `develop.bat`

- 開発時に使用する
- `gulp-webserver`によるローカルHTTPサーバ
- `gulp-watch`による保存時の自動コンパイル
  - `gulp-jade`によるJadeのコンパイル
  - `gulp-sass`によるSassのコンパイル
  - `gulp-imagemin`による画像の最適化

## included binaries

- [node.js](http://nodejs.org/)
  - [node ver.0.10.36 (x64)](http://nodejs.org/dist/v0.10.36/x64/node.exe)
    - [nodejs.org - Index of /dist/](http://nodejs.org/dist/)
  - [npm ver.1.4.12](http://nodejs.org/dist/npm/npm-1.4.12.zip)
    - [nodejs.org - Index of /dist/npm/](http://nodejs.org/dist/npm/)
