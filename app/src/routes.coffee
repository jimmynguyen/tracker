"use strict"

angular.module "app.routes"

.constant "routes",

	login:
		templateUrl: "app/templates/views/login.html"
		controller: "LoginController"
	home:
		templateUrl: "app/templates/views/home.html"
		controller: "HomeController"
	category:
		templateUrl: "app/templates/views/home.html"
		controller: "HomeController"
	entry:
		templateUrl: "app/templates/views/entry.html"
		controller: "EntryController"
	default:
		redirectTo: "/"

.config (routes, $routeProvider) ->

	$routeProvider
		.when "/", routes.login
		.when "/login", routes.login
		.when "/home", routes.home
		.when "/category", routes.home
		.when "/category/:categoryId", routes.category
		.when "/category/:categoryId/entry", routes.category
		.when "/category/:categoryId/entry/:entryId", routes.entry
		.otherwise routes.default

	return
