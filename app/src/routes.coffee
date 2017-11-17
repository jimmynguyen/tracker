"use strict"

angular.module "app.routes"

.config ($routeProvider, $locationProvider) ->
	# NOTE: use curly brackets {} for $routeProvider or it won't work
	$routeProvider
		.when "/",
			templateUrl: "app/templates/views/login.html"
			controller: "LoginController"
		.when "/login",
			templateUrl: "app/templates/views/login.html"
			controller: "LoginController"
		.when "/home",
			templateUrl: "app/templates/views/home.html"
			controller: "HomeController"
		.when "/category",
			templateUrl: "app/templates/views/home.html"
			controller: "HomeController"
		.when "/category/:categoryId",
			templateUrl: "app/templates/views/category.html"
			controller: "CategoryController"
		.when "/category/:categoryId/entry",
			templateUrl: "app/templates/views/category.html"
			controller: "CategoryController"
		.when "/category/:categoryId/entry/:entryId",
			templateUrl: "app/templates/views/entry.html"
			controller: "EntryController"
		.otherwise
			redirectTo: "/"
	return
