"use strict"

angular.module "app.controllers"

.controller "LoginController", (LocationService) ->

	LocationService.logPath()
	LocationService.goToHome()

	return
