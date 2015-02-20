viewDirectory    = '../views'
webrootDirectory = '../webroot'

jadeOutput  = '../views'
sassOutput  = '../webroot'
imageOutput = '../webroot'

jadeTarget  = './views/**/!(_)*.jade'
sassTarget  = './webroot/**/!(_)*.scss'
imageTarget = './webroot/**/*.{gif,jpg,jpeg,png}'

jadeBaseDir = './views'

jadeEncoding =
  from: 'utf-8'
  to: 'Shift_JIS'
sassEncoding =
  from: 'utf-8'
  to: 'Shift_JIS'

fs   = require 'fs'
exec = require('child_process').exec

gulp    = require 'gulp'
util    = require 'gulp-util'
jade    = require 'gulp-jade'
sass    = require 'gulp-sass'
image   = require 'gulp-imagemin'
watch   = require 'gulp-watch'
server  = require 'gulp-webserver'
cached  = require 'gulp-cached'
notify  = require 'gulp-notify'
plumber = require 'gulp-plumber'
convert = require 'gulp-convert-encoding'

serve = require 'serve-static'

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
else
  jadeOption =
    debug: false
    pretty: true
    basedir: jadeBaseDir
    data:
      production: false
  sassOption =
    outputStyle: 'nested'
    sourceComments: true

gulp.task 'jade', ->
  gulp
    .src(jadeTarget)
    .pipe(plumber(errorHandler: notify.onError('<%= error.message %>')))
    .pipe(cached('jade'))
    .pipe(jade(jadeOption))
    .pipe(convert(jadeEncoding))
    .pipe(gulp.dest(jadeOutput))

gulp.task 'sass', ->
  if util.env.compass
    command =
      if util.env.production
      then 'compass compile --config config.rb --environment production --force'
      else 'compass compile --config config.rb'
    command = "bundle exec #{command}" if try fs.statSync('./.bundle').isDirectory()
    p = exec(command, (err, stdout, stderr) ->
      util.log(err) if err
      util.log(stdout)
      util.log(stderr)
    )
    p.on('error', (err) -> util.log(err))
    p.stdout.pipe(process.stdout)
    p.stderr.pipe(process.stderr)
  else
    gulp
      .src(sassTarget)
      .pipe(plumber(errorHandler: notify.onError('<%= error.message %>')))
      .pipe(cached('sass'))
      .pipe(sass(sassOption))
      .pipe(convert(sassEncoding))
      .pipe(gulp.dest(sassOutput))

gulp.task 'image', ->
  gulp
    .src(imageTarget)
    .pipe(plumber(errorHandler: notify.onError('<%= error.message %>')))
    .pipe(cached('image'))
    .pipe(image(progressive: false))
    .pipe(gulp.dest(imageOutput))

gulp.task 'watch', ->
  if util.env.compass
    command = 'compass watch --config config.rb'
    command = "bundle exec #{command}" if try fs.statSync('./.bundle').isDirectory()
    p = exec(command, (err, stdout, stderr) ->
      util.log(err) if err
      util.log(stdout)
      util.log(stderr)
    )
    p.on('error', (err) -> util.log(err))
    p.stdout.pipe(process.stdout)
    p.stderr.pipe(process.stderr)
    process.on('exit', (code) -> p.kill('SIGINT'))
  else
    watch(sassTarget, -> gulp.start('sass'))

  watch(jadeTarget,  -> gulp.start('jade'))
  watch(imageTarget, -> gulp.start('image'))

  return

gulp.task 'server', ->
  gulp
    .src('.')
    .pipe(server(
      open: true
      livereload: false
      middleware: [
        serve(
          webrootDirectory,
          setHeaders: (res, path, stat) ->
            if /\.css$/.test(path)
              res.setHeader('Content-Type', "text/css; charset=#{sassEncoding.to}")
        )
        serve(
          viewDirectory,
          setHeaders: (res, path, stat) ->
            if /\.html?$/.test(path)
              res.setHeader('Content-Type', "text/html; charset=#{jadeEncoding.to}")
        )
      ]
    ))

gulp.task 'compile', ['jade', 'sass', 'image']
gulp.task 'develop', ['server', 'watch']
gulp.task 'default', ['server', 'watch']
