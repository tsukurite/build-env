#-- requires -------------------------------------------------------------------

fs   = require 'fs'
path = require 'path'

gulp         = require 'gulp'
util         = require 'gulp-util'
jade         = require 'gulp-jade'
sass         = require 'gulp-sass'
watch        = require 'gulp-watch'
server       = require 'gulp-webserver'
cached       = require 'gulp-cached'
notify       = require 'gulp-notify'
plumber      = require 'gulp-plumber'
convert      = require 'gulp-convert-encoding'
imagemin     = require 'gulp-imagemin'
spritesmith  = require 'gulp.spritesmith'
autoprefixer = require 'gulp-autoprefixer'

serveStatic = require 'serve-static'
runSequence = require 'run-sequence'

#-- settings -------------------------------------------------------------------

# serve directories for gulp-webserver
viewDirectory    = '../views'
webrootDirectory = '../webroot'

# output directories
jadeOutput           = '../views'
sassOutput           = '../webroot'
imageminOutput       = '../webroot'
spritesmithCssOutput = './webroot/css'
spritesmithImgOutput = './webroot/images'

# jade basedir option
jadeBaseDir = './views'

# input targets
jadeTarget        = "#{jadeBaseDir}/**/*.jade"
sassTarget        = './webroot/**/*.scss'
imageminTarget    = './webroot/**/*.{gif,jpg,jpeg,png}'
spritesmithTarget = './sprites'

spritesmithTargetDir  = spritesmithTarget
spritesmithTargetFile = '/**/*.{gif,jpg,jpeg,png}'

# input/output encoding
jadeEncoding =
  from: 'utf-8'
  to: 'Shift_JIS'
sassEncoding =
  from: 'utf-8'
  to: 'Shift_JIS'

# imagemin option
imageminOption =
  progressive: false

# spritesmith option
spritesmithOption =
  imgNameSuffix: '.png'
  cssNameSuffix: '.scss'

# autoprefixer option
autoprefixerOption =
  # examples:
  #   'IE >= 8'
  #   'iOS >= 8'
  #   'Android >= 4'
  #   'ChromeAndroid >= 42'
  # more infomation:
  #   https://github.com/ai/browserslist#queries
  #   https://github.com/ai/browserslist#browsers
  browsers: [
    'last 2 versions'
  ]

# options for production
if util.env.production
  jadeOption =
    debug: false
    pretty: true
    basedir: jadeBaseDir
    data:
      production: true
  sassOption =
    outputStyle: 'compressed'
    sourceComments: false
# options for development
else
  jadeOption =
    debug: false
    pretty: true
    basedir: jadeBaseDir
    data:
      production: false
  sassOption =
    outputStyle: 'expanded'
    sourceComments: true

#-- tasks ----------------------------------------------------------------------

gulp.task 'jade', ->
  gulp
    .src(jadeTarget)
    .pipe(plumber(errorHandler: notify.onError('<%= error.message %>')))
    .pipe(cached('jade'))         # cache file
    .pipe(jade(jadeOption))       # execute jade
    .pipe(convert(jadeEncoding))  # convert encoding
    .pipe(gulp.dest(jadeOutput))  # output html

gulp.task 'sass', ->
  gulp
    .src(sassTarget)
    .pipe(plumber(errorHandler: notify.onError('<%= error.message %>')))
    .pipe(cached('sass'))                    # cache file
    .pipe(sass(sassOption))                  # execute sass
    .pipe(autoprefixer(autoprefixerOption))  # execute autoprefixer
    .pipe(convert(sassEncoding))             # convert encoding
    .pipe(gulp.dest(sassOutput))             # output css

gulp.task 'imagemin', ->
  gulp
    .src(imageminTarget)
    .pipe(plumber(errorHandler: notify.onError('<%= error.message %>')))
    .pipe(cached('imagemin'))         # cache file
    .pipe(imagemin(imageminOption))   # execute imagemin
    .pipe(gulp.dest(imageminOutput))  # output minimized image

gulp.task 'spritesmith', ->
  spriteDirs = fs.readdirSync("#{spritesmithTargetDir}")
  spriteDirs.map (entry) ->
    # entry path
    targetDir = "#{spritesmithTargetDir}/#{entry}"

    # return if entry is not a directory
    return null if not fs.statSync(targetDir).isDirectory()

    sprite =
      gulp
        .src("#{targetDir}/#{spritesmithTargetFile}")
        .pipe(plumber(errorHandler: notify.onError('<%= error.message %>')))
        .pipe(spritesmith(
          imgName: entry + spritesmithOption.imgNameSuffix
          cssName: entry + spritesmithOption.cssNameSuffix
        ))

    sprite.css.pipe(gulp.dest(spritesmithCssOutput))  # output sprite css
    sprite.img.pipe(gulp.dest(spritesmithImgOutput))  # output sprite image

    sprite

gulp.task 'watch', ->
  watch(jadeTarget,        -> gulp.start('jade'))
  watch(sassTarget,        -> gulp.start('sass'))
  watch(imageminTarget,    -> gulp.start('imagemin'))
  watch(spritesmithTarget, -> gulp.start('spritesmith'))
  return

gulp.task 'image', ->
  runSequence('spritesmith', 'imagemin')

gulp.task 'server', ->
  gulp
    .src('.')
    .pipe(server(
      port: 10293
      open: true
      livereload: false
      middleware: [
        serveStatic(
          webrootDirectory,
          setHeaders: (res, path, stat) ->
            if /\.css$/.test(path)
              res.setHeader('Content-Type', "text/css; charset=#{sassEncoding.to}")
        )
        serveStatic(
          viewDirectory,
          setHeaders: (res, path, stat) ->
            if /\.html?$/.test(path)
              res.setHeader('Content-Type', "text/html; charset=#{jadeEncoding.to}")
        )
      ]
    ))

# aliases
gulp.task 'compile', ['jade', 'sass', 'image']
gulp.task 'develop', ['server', 'watch']
gulp.task 'default', ['develop']
