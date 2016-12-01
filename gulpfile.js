var gulp 		 = require( 'gulp' ),
    dest 		 = require( 'gulp-dest' ),
    fs           = require( 'fs' ),
    path         = require( 'path' ),
    rename       = require( 'gulp-rename' ),
    swig 		 = require( 'gulp-swig' ),
    prompt 		 = require( 'gulp-prompt' ),
    runSequence  = require( 'run-sequence' ),
    folders      = require( 'gulp-folders' ),
    gulpCopy     = require( 'gulp-file-copy' ),
    shell        = require( 'gulp-shell' ),
    argv         = require( 'yargs' ).argv,
    gulpFunction = require("gulp-function"),
    Q            = require("q")

String.prototype.toTitleCase = function(){
  return this.replace(/\b(\w+)/g, function(m,p){ return p[0].toUpperCase() + p.substr(1).toLowerCase() })
}

function getFolders(dir) {
    return fs.readdirSync(dir)
      .filter(function(file) {
        return fs.statSync(path.join(dir, file)).isDirectory();
      });
}

function getAllFolders(dir){
    var folders = getFolders(dir);
    folders.forEach(function(folder){
        var subFolders = getFolders(dir + '/' + folder)
        subFolders.forEach(function(subFolder){
            folders.push(folder + '/' + subFolder)
            var all = getAllFolders(dir + '/' + folder + '/' + subFolder)
            all.forEach(function(p){
                folders.push(folder + '/' + subFolder + '/' + p)
            })
        })
    })
    return folders;
}


gulp.task('make', function(){
    var folders = getFolders('src/tex')
    /*
    folders.forEach(function(value, index){
        folders[index] = 'tex/' + value
    })
    folders.push('src/assets/classes')
    folders.push('src/assets/macros')
    */

    gulp.src('src')
        .pipe(prompt.prompt([
            {
                type: "list",
                name: "project",
                message: "Please choose your project",
                choices: folders
            }], function(res){
                if (!res.project){
                    console.log('project missing')
                    return;
                }

                render(true);
                shell.task([ 'make -C src' ])();

                function render(callCompiler){
                    console.log("Rendering...")
                    var g = gulp.src( 'src/tex/' + res.project + '/**/*.tex' )
                        .pipe( swig() )
                        .pipe( dest( 'src/.render/' + res.project, { ext: '.tex' } ) )
                        .pipe( gulp.dest( './' ) )
                    if (callCompiler){
                        g.pipe( gulpFunction(compile, 'forFirst') )
                    }
                }

                function compile(){
                    var done = Q.defer()
                    console.log("Running watchers...")
                    gulp.task( 'latex', shell.task([ 'make -C src' ]))
                    gulp.task( 'renderAndCompile', function(){
                        render(false);
                    })
                    gulp.watch( 'src/assets/packages/*.sty', [ 'latex' ] )
                    gulp.watch( 'src/assets/classes/*.cls', [ 'latex' ] )
                    gulp.watch( 'src/tex/' + res.project + '/**/*.tex', [ 'latex', 'renderAndCompile' ] )

                    done.resolve()
                    return done.promise

                }
            }
        ))
})

gulp.task('create', function(){
    gulp.src('src')
        .pipe(prompt.prompt([
            {
                type: "list",
                name: "dest",
                message: 'Please choose the destination',
                choices: getAllFolders('src/tex')
            }, {
                type: 'text',
                name: 'documentName',
                message: 'Please enter document name'
            }, {
                type: 'list',
                name: 'template',
                message: 'What template would you like to setup?',
                choices: ['green', 'orange', 'gold', 'red', 'blue']
            }
        ], function(res){
            if (!res.dest || !res.documentName || !res.template){
                console.log('dest, documentName or template missing')
                return;
            }
            var template = 'template' + (res.template == 'green' ? '' : res.template.toTitleCase()) + '.tex'

            gulp.src('src/tex/templates/' + template)
                .pipe(rename(res.documentName + '.tex'))
                .pipe(gulp.dest('src/tex/' + res.dest));
        }))
})

gulp.task( 'render-sty', function(){
	gulp.src( 'src/assets/packages/**/*.sty' )
		.pipe( swig() )
		.pipe( dest( 'src/.render/', { ext: '.sty' } ) )
		.pipe( gulp.dest( './' ) );
});

gulp.task( 'render-cls', function(){
	gulp.src( 'src/assets/classes/**/*.cls' )
		.pipe( swig() )
		.pipe( dest( 'src/.render/', { ext: '.cls' } ) )
		.pipe( gulp.dest( './' ) );
});

gulp.task( 'render', [ 'render-sty', 'render-cls', 'render-tex' ]);
gulp.task( 'render-clean', shell.task([ 'make render-clean' ]));

gulp.task( 'swig', function(){
	gulp.src('src/tex/*.tex')
	    .pipe( swig() )
	    .pipe( dest('src/.render', {ext:'.tex'} ))
	    .pipe( gulp.dest( './' ) );
});

gulp.task( 'default', [ 'make' ]);
