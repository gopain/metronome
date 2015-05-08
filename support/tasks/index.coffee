gulp   = require 'gulp'
util   = require 'gulp-util'
sass   = require 'gulp-ruby-sass'
join   = require 'gulp-concat'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
{exec} = require 'child_process'

gulp.task 'coffee', ->
  gulp.src 'src/app/assets/javascripts/**/*.coffee'
    .pipe coffee({ bare: true }).on('error', util.log)
    .pipe gulp.dest 'static/assets/scripts'

gulp.task 'stylesheets', ->
  gulp.src 'src/app/assets/stylesheets/application.sass'
    .pipe sass({ loadPath: 'support/assets/stylesheets', style: 'compressed' }).on('error', util.log)
    .pipe gulp.dest 'static/assets/'

gulp.task 'javascripts', ->
  javascripts = [
    'support/assets/javascripts/jquery.js'
    'support/assets/javascripts/rails.js'
    'support/assets/javascripts/jquery.timeago.js'
    'support/assets/javascripts/codemirror.js'
    'support/assets/javascripts/markdown.js'
    'support/assets/javascripts/jquery.ui.widget.js'
    'support/assets/javascripts/jquery.iframe-transport.js'
    'support/assets/javascripts/jquery.fileupload.js'
    'static/assets/scripts/textarea.js'
    'static/assets/scripts/timeago.js'
    'static/assets/scripts/index.js'
  ]

  pipes = gulp.src javascripts
    .pipe join 'application.js'

  # pipes = pipes.pipe uglify()
  pipes.pipe gulp.dest 'static/assets/'

gulp.task 'watch', ->
  gulp.watch 'src/app/assets/stylesheets/**/*.sass', ['stylesheets']
  gulp.watch 'src/app/assets/javascripts/**/*.coffee', ['coffee', 'javascripts']

gulp.task 'default', ['watch']

# gulp.task 'prepare', ['coffee', 'stylesheets', 'javascripts']
