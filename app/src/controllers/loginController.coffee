"use strict"

angular.module "app.controllers"

.controller "LoginController", (
		$scope,
		$location) ->
	console.log $location.path()
	return
