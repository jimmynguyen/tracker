"use strict"

angular.module "app.controllers"

.controller "HomeController", ($scope, $location) ->
	$scope.route = $location.path()

	return
