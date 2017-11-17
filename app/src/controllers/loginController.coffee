"use strict"

angular.module "app.controllers"

.controller "LoginController", (
		$scope,
		LocationService) ->
	LocationService.logPath()
	LocationService.goToHome()
	return
