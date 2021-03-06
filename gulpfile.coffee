'use strict'

gulp = require 'gulp'
$ = require('gulp-load-plugins')()
browserSync = require 'browser-sync'
wiredep = require('wiredep').stream

config = 
  src: './src'
  dest: './dist'

gulp.task 'browser-sync', ->
  browserSync
    watchOptions:
      debounceDelay: 0
    server:
      baseDir: config.dest
      routes:
        '/bower_components': 'bower_components'
    notify: false
    reloadDelay: 0

gulp.task 'html', ['jade'], ->
  assets = $.useref.assets()
  gulp.src config.dest + '/index.html'
    .pipe assets
    .pipe assets.restore()
    .pipe $.useref()
    .pipe gulp.dest config.dest

gulp.task 'wiredep', ->
  gulp.src config.src + '/index.jade'
    .pipe wiredep()
    .pipe gulp.dest config.src

  gulp.src config.src + '/styles/style.scss'
    .pipe wiredep
      devDependencies: true
    .pipe gulp.dest config.src + '/styles'

gulp.task 'jade', ->
  gulp.src config.src + '/index.jade'
    .pipe $.plumber()
    .pipe $.jade
      pretty: true
    .pipe gulp.dest config.dest
    .pipe browserSync.reload
      stream: true

gulp.task 'sass', ->
  gulp.src config.src + '/styles/**/*.scss'
    .pipe $.plumber()
    .pipe $.filter '**/style.scss'
    .pipe $.rubySass
      style: 'expanded'
    .pipe $.autoprefixer 'last 2 version', 'ie 9', 'ie 8'
    .pipe gulp.dest config.dest + '/styles'
    .pipe browserSync.reload
      stream: true

gulp.task 'coffee', ->
  gulp.src config.src + '/scripts/*.coffee'
    .pipe $.plumber()
    .pipe $.changed config.dest,
      extension: '.js'
    .pipe $.coffee()
    .pipe gulp.dest config.dest + '/scripts'
    .pipe browserSync.reload
      stream: true

gulp.task 'default', ['build', 'browser-sync'], ->
  gulp.watch config.src + '/index.jade', ['jade']
  gulp.watch config.src + '/styles/*.scss', ['sass']
  gulp.watch config.src + '/scripts/*.coffee', ['coffee']

gulp.task 'build', ['html', 'sass', 'coffee']
