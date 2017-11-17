"use strict"

angular.module "app.controllers"

.controller "LoginController", (
		$scope,
		NavigationService) ->
	NavigationService.goToHome()
	return
