viewDirectory    = '../views'
webrootDirectory = '../webroot'

jadeOutput  = '../views'
sassOutput  = '../webroot/css'
imageOutput = '../webroot/image'

jadeTarget  = './jade/**/!(_)*.jade'
sassTarget  = './scss/**/!(_)*.scss'
imageTarget = './image/**/*.{gif,jpg,jpeg,png}'

gulp   = require 'gulp'
jade   = require 'gulp-jade'
sass   = require 'gulp-sass'
image  = require 'gulp-imagemin'
watch  = require 'gulp-watch'
server = require 'gulp-webserver'
cached = require 'gulp-cached'

serve = require 'serve-static'

gulp.task 'jade', ->
  gulp
    .src(jadeTarget)
    .pipe(cached('jade'))
    .pipe(jade(pretty: true))
    .pipe(gulp.dest(jadeOutput))

gulp.task 'sass', ->
  gulp
    .src(sassTarget)
    .pipe(cached('sass'))
    .pipe(sass(outputStyle: 'nested'))
    .pipe(gulp.dest(sassOutput))

gulp.task 'image', ->
  gulp
    .src(imageTarget)
    .pipe(cached('image'))
    .pipe(image(progressive: false))
    .pipe(gulp.dest(imageOutput))

gulp.task 'watch', ->
  watch(jadeTarget,  -> gulp.start('jade'))
  watch(sassTarget,  -> gulp.start('sass'))
  watch(imageTarget, -> gulp.start('image'))
  return

gulp.task 'server', ->
  gulp
    .src('.')
    .pipe(server(
      livereload: true
      middleware: [
        serve(webrootDirectory)
        serve(viewDirectory)
      ]
    ))

gulp.task 'compile', ['jade', 'sass', 'image']
gulp.task 'develop', ['server', 'watch']
gulp.task 'default', ['server', 'watch']
