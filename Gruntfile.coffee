"use strict"
lrSnippet = require("grunt-contrib-livereload/lib/utils").livereloadSnippet
mountFolder = (connect, dir) ->
  connect.static require("path").resolve(dir)

module.exports = (grunt) ->
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  cfg =
    tmp: ".tmp"
    app: "app"
    dist: "dist"
    bootstrap_assets: "app/components/compass-twitter-bootstrap/vendor/assets"
    bootstrap_styles: "app/components/compass-twitter-bootstrap/stylesheets"

  grunt.initConfig
    config: cfg

    watch:
      coffee:
        files: ["<%= config.app %>/scripts/{,*/}*.coffee"]
        tasks: ["coffee:dist"]
      coffeeTest:
        files: ["test/spec/{,*/}*.coffee"]
        tasks: ["coffee:test"]
      compass:
        files: ["<%= config.app %>/styles/{,*/}*.{scss,sass}"]
        tasks: ["compass"]
      livereload:
        files: [
          "<%= config.app %>/{,*/}*.html",
          "{<%= config.tmp %>,<%= config.app %>}/styles/{,*/}*.css",
          "{<%= config.tmp %>,<%= config.app %>}/scripts/{,*/}*.js",
          "<%= config.app %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}"
        ]
        tasks: ["livereload"]

    connect:
      options:
        port: 9000
        hostname: "0.0.0.0"
      livereload:
        options:
          middleware: (connect) ->
            [
              lrSnippet
              mountFolder(connect, cfg.tmp)
              mountFolder(connect, cfg.app)
              mountFolder(connect, cfg.bootstrap_assets)
            ]
      test:
        options:
          middleware: (connect) ->
            [
              mountFolder(connect, cfg.tmp)
              mountFolder(connect, cfg.app)
              mountFolder(connect, cfg.bootstrap_assets)
              mountFolder(connect, "test")
            ]

    open:
      server:
        url: "http://localhost:<%= connect.options.port %>"

    clean:
      dist:
        files: [
          dot: true
          src: ["<%= config.tmp %>", ".sass-cache", "<%= config.dist %>/*"]
        ]
      server: ["<%= config.tmp %>", ".sass-cache"]

    jshint:
      options:
        jshintrc: ".jshintrc"
      all: ["<%= config.app %>/scripts/{,*/}*.js"]

    karma:
      options:
        configFile: "karma.conf.js"
        singleRun: true
      unit:
        browsers: ["PhantomJS"]
      dist: {}

    coffee:
      dist:
        files: [
          expand: true
          cwd: "<%= config.app %>/scripts"
          src: "{,*/}*.coffee"
          dest: "<%= config.tmp %>/scripts"
          ext: ".js"
        ]

      test:
        files: [
          expand: true
          cwd: "test/spec"
          src: "{,*/}*.coffee"
          dest: "<%= config.tmp %>/spec"
          ext: ".js"
        ]

    compass:
      options:
        sassDir: "<%= config.app %>/styles"
        cssDir: "<%= config.tmp %>/styles"
        imagesDir: [
          "<%= config.app %>/images",
          "<%= config.bootstrap_assets %>/images"
        ]
        javascriptsDir: [
          "<%= config.app %>/scripts",
          "<%= config.bootstrap_assets %>/scripts"
        ]
        fontsDir: [
          "<%= config.app %>/styles/fonts",
          "<%= config.bootstrap_assets %>/fonts"
        ]
        importPath: "<%= config.bootstrap_styles %>"
        debugInfo: false
        httpImagesPath: "/images"
      dist:
        options:
          environment: "production"
      server:
        options:
          relativeAssets: false

    concat:
      dist:
        nonull: true
        options:
          banner: ";(function(window,document,angular){'use strict';"
          footer: "}(window,document,window.angular));"
          process: (src, filepath) ->
            src.replace(/('use strict'|"use strict");/g, "")
        files:
          "<%= config.dist %>/scripts/scripts.js": [
            "<%= config.app %>/scripts/{,*/}*.js"
            "<%= config.tmp %>/scripts/templates.js"
          ]

    ngtemplates:
      myapp:
        options:
          prepend: 'views/'
          module: 'angustoApp'
          base: '<%= config.app %>/views'
        src: '<%= config.app %>/views/{,*/}*.html'
        dest: '<%= config.tmp %>/scripts/templates.js'

    usemin:
      html: ["<%= config.dist %>/{,*/}*.html"]
      css: ["<%= config.dist %>/styles/{,*/}*.css"]
      options:
        dirs: ["<%= config.dist %>"]

    imagemin:
      dist:
        files: [
          expand: true
          cwd: "<%= config.app %>/images"
          src: "{,*/}*.{png,jpg,jpeg}"
          dest: "<%= config.dist %>/images"
        ]

    cssmin:
      dist:
        files:
          "<%= config.dist %>/styles/main.css": [
            "<%= config.tmp %>/styles/{,*/}*.css"
          ]

    htmlmin:
      dist:
        options:
          removeCommentsFromCDATA: true
          removeCDATASectionsFromCDATA: true
          collapseBooleanAttributes: true
        files: [
          expand: true
          cwd: "<%= config.app %>"
          src: ["*.html"]
          dest: "<%= config.dist %>"
        ]

    cdnify:
      dist:
        html: ["<%= config.dist %>/index.html"]

    ngmin:
      dist:
        files: [
          expand: true
          cwd: "<%= config.dist %>/scripts"
          src: "*.js"
          dest: "<%= config.dist %>/scripts"
        ]

    uglify:
      dist:
        files:
          "<%= config.dist %>/scripts/scripts.js": [
            "<%= config.dist %>/scripts/scripts.js"
          ]

    rev:
      dist:
        files:
          src: [
            "<%= config.dist %>/scripts/{,*/}*.js"
            "<%= config.dist %>/styles/{,*/}*.css"
            "<%= config.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp,svg}"
          ]

    copy:
      server:
        files: [
          {
            expand: true
            flatten: true
            cwd: "<%= config.app %>"
            dest: "<%= config.tmp %>/scripts/ie"
            src: [
              "components/es5-shim/es5-shim.js"
              "components/json3/lib/json3.js"
            ]
          },
          {
            expand: true
            flatten: true
            dest: "<%= config.tmp %>/scripts/bootstrap"
            src: [
              "<%= config.bootstrap_assets %>/javascripts/*.js"
            ]
          },
          {
            expand: true
            flatten: true
            dest: "<%= config.tmp %>/fonts"
            src: [
              "<%= config.bootstrap_assets %>/fonts/*"
            ]
          },
          {
            expand: true
            flatten: true
            dest: "<%= config.tmp %>/images"
            src: [
              "<%= config.bootstrap_assets %>/images/*"
            ]
          }
        ]
      dist:
        files: [
          {
            expand: true
            dot: true
            cwd: "<%= config.app %>"
            dest: "<%= config.dist %>"
            src: [
              "*.{ico,txt}"
              "images/{,*/}*.{gif,webp}"
            ]
          },
          {
            expand: true
            dot: true
            cwd: "<%= config.tmp %>"
            dest: "<%= config.dist %>"
            src: "{fonts,images,scripts}/*/*.js"
          }
        ]

  grunt.renameTask "regarde", "watch"

  grunt.registerTask "server", [
    "clean:server"
    "copy:server"
    "coffee:dist"
    "compass:server"
    "livereload-start"
    "connect:livereload"
    "open"
    "watch"
  ]

  grunt.registerTask "test:prepare", [
    "clean:server"
    "copy:server"
    "coffee"
    "compass"
    "connect:test"
  ]
  grunt.registerTask "test",      ["test:prepare", "karma:unit"]
  grunt.registerTask "test:dist", ["test:prepare", "karma:dist"]

  grunt.registerTask "build", [
    "clean:dist"
    "copy"
    "jshint"
    "test:dist"
    "coffee"
    "compass:dist"
    "imagemin"
    "cssmin"
    "htmlmin"
    "ngtemplates"
    "concat:dist"
    "copy"
    "cdnify"
    "ngmin"
    "uglify"
    "rev"
    "usemin"
  ]

  grunt.registerTask "default", [
    "clean"
    "build"
  ]
