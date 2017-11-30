module.exports = (grunt) ->

	grunt.initConfig

		pkg: grunt.file.readJSON "package.json"

		# lint .coffee
		coffee_jshint:
			options:
				jshintOptions: [
					"devel"
					"jasmine"
				]
				globals: [
					"angular"
					"firebase"
					"$"
				]
			source: [
				"app/src/**/*.coffee"
			]
			test: [
				"spec/**/*.coffee"
			]

		clean:
			production: [
				"build"
				"out"
			]
			development: [
				"build"
			]

		# compile .coffee to .js
		coffee:
			source:
				expand: true
				cwd: "app/src"
				src: ["**/*.coffee"]
				dest: "build/js"
				ext: ".js"
			test:
				expand: true
				cwd: "spec"
				src: ["**/*.coffee"]
				dest: "build/spec"
				ext: ".js"

		# concat .js files
		concat:
			options:
				stripBanners: true
				banner: "/*! <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today('yyyy-mm-dd') %> */"
				separator: ";"
				nonull: true
			dependencies:
				src: [
					"node_modules/firebase/firebase.js"
					"node_modules/jquery/dist/jquery.min.js"
					"node_modules/jquery-ui-dist/jquery-ui.min.js"
					"node_modules/angular/angular.min.js"
					"node_modules/angular-cookies/angular-cookies.min.js"
					"node_modules/angular-route/angular-route.min.js"
					"node_modules/angularfire/dist/angularfire.min.js"
					"node_modules/bootstrap/dist/js/bootstrap.min.js"
					"node_modules/angular-ui-bootstrap/dist/ui-bootstrap.js"
					"node_modules/angular-ui-sortable/dist/sortable.js"
					"node_modules/angular-local-storage/dist/angular-local-storage.min.js"
				]
				dest: "build/dependencies.js"

		# minify .js
		uglify:
			options:
				sourceMap: false
				mangle: false
			production:
				files:
					"out/app.min.js": [
						"<%= concat.dependencies.dest %>"
						"build/js/**/*.js"
					]

		# concat .css files
		concat_css:
			all:
				src: [
					"node_modules/bootstrap/dist/css/bootstrap.min.css"
					"node_modules/bootstrap/dist/css/bootstrap-theme.min.css"
					"node_modules/angular-ui-bootstrap/dist/ui-bootstrap.css"
					"node_modules/jquery-ui-dist/jquery-ui.min.css"
					"app/css/**/*.css"
				]
				dest: "build/app.min.css"


		# minify .css
		cssmin:
			all:
				files: [
					expand: true
					cwd: "build"
					src: ["app.min.css"]
					dest: "out"
					ext: ".min.css"
				]

		copy:
			index_html:
				files: [
					expand: true
					cwd: "app/templates"
					src: ["index.html"]
					dest: ""
				]
			jasmine_json:
				files: [
					expand: true
					cwd: "spec"
					src: ["jasmine.json"]
					dest: "build/spec"
				]

		replace:
			production:
				options:
					patterns: [
						match: /\t\t<script.+environment=\"development\".+><\/script>\n/g
						replacement: ""
					]
				files: [
					expand: true,
					src: [
						"index.html"
					]
					dest: ""
				]
			development:
				options:
					patterns: [
						match: /\t\t<script.+environment="production".+><\/script>\n/g
						replacement: ""
					]
				files: [
					expand: true,
					src: [
						"index.html"
					]
					dest: ""
				]

		jasmine:
			test:
				src: [
					"build/js/**/*.js"
				]
				options:
					specs: "build/spec/**/*Spec.js"
					vendor: [
						"<%= concat.dependencies.src %>"
						"node_modules/angular-mocks/angular-mocks.js"
					]

	# load css tasks
	grunt.loadNpmTasks "grunt-concat-css"
	grunt.loadNpmTasks "grunt-contrib-cssmin"

	# load coffee tasks
	grunt.loadNpmTasks "grunt-coffee-jshint"
	grunt.loadNpmTasks "grunt-contrib-coffee"

	# load js tasks
	grunt.loadNpmTasks "grunt-contrib-concat"
	grunt.loadNpmTasks "grunt-contrib-uglify"

	# load utility tasks
	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-copy"
	grunt.loadNpmTasks "grunt-contrib-jasmine"
	grunt.loadNpmTasks "grunt-replace"

	grunt.registerTask "css", [
		"concat_css:all"
		"cssmin:all"
	]

	grunt.registerTask "development", [
		"coffee_jshint:source"
		"coffee_jshint:test"
		"clean:development"
		"coffee:source"
		"coffee:test"
		"concat:dependencies"
		"copy:jasmine_json"
		"jasmine:test"
		"css"
		"copy:index_html"
		"replace:development"
	]

	grunt.registerTask "production", [
		"coffee_jshint:source"
		"coffee_jshint:test"
		"clean:production"
		"coffee:source"
		"coffee:test"
		"concat:dependencies"
		"copy:jasmine_json"
		"jasmine:test"
		"uglify:production"
		"css"
		"copy:index_html"
		"replace:production"
	]

	grunt.registerTask "default", [
		"development"
	]

	return
