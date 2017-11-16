"use strict"

angular.module "app.routes"

.config ($routeProvider, $locationProvider) ->
	# NOTE: use curly brackets {} for $routeProvider or it won't work
	$routeProvider
	.when "/",
		templateUrl: "app/templates/views/home.html"
		controller: "HomeController"
	.otherwise
		redirectTo: "/"

	# disable hash # in url
	$locationProvider.html5Mode true

	return
