const gulp = require('gulp'),
    sassdoc = require('sassdoc'),
    jsdoc = require('gulp-jsdoc3')

gulp.task('sassdoc', () => {
    return gulp.src('./sass/custom/**/*.scss')
        .pipe(sassdoc({
            dest: './docs/custom/scss/'
        }))
})

gulp.task('jsdoc', cb => {
    let config = require('./jsdocConfig.json')

    gulp.src(['README.md', './js/custom.js'], {read: false})
        .pipe(jsdoc(config, cb))

})
    
gulp.task('default', ['sassdoc','jsdoc'])
