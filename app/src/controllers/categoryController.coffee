"use strict"

angular.module "app.controllers"

.controller "CategoryController", (
		$scope,
		$location) ->
	console.log $location.path()
	return
