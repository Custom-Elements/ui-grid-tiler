Build ui-grid-tiler from source into
build/ui-grid-tiler.html, all streamlined and ready to be included.

Having both the literate source, and the fully built output allows you to choose
if you want to have a fully `vulcanize` input, or to fully `vulcanize` your
entire project at the end.

    gulp = require 'gulp'
    less = require 'gulp-less'
    browserify = require 'gulp-browserify'
    rename = require 'gulp-rename'
    shell = require 'gulp-shell'
    express = require 'express'

And our custom elements.

    gulp.task 'elements', ['elements-code', 'elements-style', 'elements-static']
    gulp.task  'elements-code', ->
      src ='./src'
      dest = 'build/'
      gulp.src '*.litcoffee', {cwd: src, read: false}
        .pipe browserify
          transform: ['coffeeify', 'browserify-data']
          debug: false
        .pipe rename extname: '.js'
        .pipe gulp.dest dest
    gulp.task  'elements-style', ->
      src ='./src'
      dest = 'build/'
      gulp.src '*.less', {cwd: src}
        .pipe less()
        .pipe gulp.dest dest
    gulp.task  'elements-static', ->
      src ='./src'
      dest = 'build/'
      gulp.src '*.html', {cwd: src}
        .pipe gulp.dest dest
      gulp.src '*.svg', {cwd: src}
        .pipe gulp.dest dest

Vulcanize for the speed.

    gulp.task 'vulcanize', ['elements'], ->
      built = 'build/ui-grid-tiler.html'
      gulp.src ''
        .pipe shell([
          "vulcanize --inline --strip -o ui-grid-tiler.html #{built}"
          ])

    gulp.task 'build', ['vulcanize']

    gulp.task 'watch', ['vulcanize'], ->
      app = express()
      app.use(express.static(__dirname))
      app.listen(10000)
      console.log 'http://localhost:10000/demo.html'

      watcher = gulp.watch 'src/**/*.*', ['elements']
      watcher.on 'change', ->
        console.log 'rebuildling...'
