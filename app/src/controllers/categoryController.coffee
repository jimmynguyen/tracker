"use strict"

angular.module "app.controllers"

.controller "CategoryController", (LocationService) ->

	LocationService.logPath()

	return
