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
	.when "/category/:category_id",
		templateUrl: "app/templates/views/category.html"
		controller: "CategoryController"
	.when "/category/:category_id/entry",
		templateUrl: "app/templates/views/category.html"
		controller: "CategoryController"
	.when "/category/:category_id/entry/:entry_id",
		templateUrl: "app/templates/views/entry.html"
		controller: "EntryController"
	.otherwise
		redirectTo: "/"

	# disable hash # in url
	$locationProvider.html5Mode true

	return
