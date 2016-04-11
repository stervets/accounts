var gulp = require('gulp'),
    coffee = require('gulp-coffee'),
    stylus = require('gulp-stylus'),
    jade = require('gulp-jade'),
    //fs = require('fs'),
    exec = require('child_process').exec;

var paths = {
    serverScripts: [
        'src/server/**/*.coffee'
    ],

    publicScripts: [
        'src/public/**/*.coffee'
    ],

    styles: [
        'src/public/**/*.styl'
    ],

    jade: [
        'src/public/**/*.jade'
    ]
};

var ChildProcess = (function () {
    ChildProcess.prototype.process = null;

    ChildProcess.prototype.start = function () {
        this.process = exec(this.commandLine);
        this.process.stdout.pipe(process.stdout);
        this.process.stderr.pipe(process.stderr);
        process.stdin.pipe(this.process.stdin);
        if (!this.silent) {
            console.log("Process #" + this.process.pid + " started");
        }
    }

    ChildProcess.prototype.restart = function () {
        if (this.process != null) {
            exec("killall node");
            setTimeout(this.start.bind(this), 500);
        }else{
            this.start();
        }
    };

    function ChildProcess(commandLine, silent) {
        this.silent = !!silent;
        this.commandLine = commandLine
    }

    return ChildProcess;
})();

var serverProcess = new ChildProcess('node server/app.js');

gulp.task('buildServerScripts', function () {
    gulp.src(paths.serverScripts)
        .pipe(coffee({bare: true}).on('error', function (e) {
            console.log(e.toString());
        })
    )
        .pipe(gulp.dest('server'))
        .on('end', function () {
            serverProcess.restart();
        });
});

gulp.task('buildPublicScripts', function () {
    gulp.src(paths.publicScripts)
        .pipe(coffee({bare: true}).on('error', function (e) {
            console.log(e.toString());
        })
    )
        .pipe(gulp.dest('public'));
});

gulp.task('watchServerScripts', ['buildServerScripts'], function () {
    gulp.watch(paths.serverScripts, ['buildServerScripts']);
});

gulp.task('watchPublicScripts', ['buildPublicScripts'], function () {
    gulp.watch(paths.publicScripts, ['buildPublicScripts']);
});

// Styles tasks
gulp.task('buildStyles', function () {
    gulp.src(paths.styles)
        .pipe(stylus({
            compress: true,
            'include css': true
        }))
        .pipe(gulp.dest('public'));
});

gulp.task('watchStyles', ['buildStyles'], function () {
    gulp.watch(paths.styles, ['buildStyles']);
});

// Jade tasks
gulp.task('buildJade', function () {
    var jadePipe = jade({
        pretty: true
    });

    jadePipe.on('error', function (error) {
        console.log(error.message);
    });

    gulp.src(paths.jade)
        .pipe(jadePipe)
        .pipe(gulp.dest('public'));
});

gulp.task('watchJade', ['buildJade'], function () {
    gulp.watch(paths.jade, ['buildJade']);
});

gulp.task('devel', [
    'watchServerScripts',
    'watchPublicScripts',
    'watchStyles',
    'watchJade'
]);

gulp.task('build', [
    'buildServerScripts',
    'buildPublicScripts',
    'buildStyles',
    'buildJade'
]);

gulp.task('default', ['devel']);